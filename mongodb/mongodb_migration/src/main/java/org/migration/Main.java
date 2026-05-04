package org.migration;

import com.mongodb.client.MongoDatabase;
import org.migration.config.MongoConnection;
import org.migration.config.MySQLConnection;
import org.migration.migrators.*;
import org.migration.util.IdMapper;

import java.sql.Connection;

public class Main {

    public static void main(String[] args) {
        System.out.println("=== Bilbasen Migration: MySQL → MongoDB ===\n");

        try (Connection mysql = MySQLConnection.connect()) {
            MongoDatabase mongo = MongoConnection.connect();
            IdMapper idMapper   = new IdMapper();

            // Order matters — users before listings, listings before sales/messages
            new UserMigrator(mysql, mongo, idMapper).migrate();
            new ListingMigrator(mysql, mongo, idMapper).migrate();
            new SaleMigrator(mysql, mongo, idMapper).migrate();
            new MessageMigrator(mysql, mongo, idMapper).migrate();

            createIndexes(mongo);

            System.out.println("\n=== Migration complete ===");

        } catch (Exception e) {
            System.err.println("Migration failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void createIndexes(MongoDatabase mongo) {
        System.out.println("→ Creating indexes...");

        var listings = mongo.getCollection("listings");
        listings.createIndex(new org.bson.Document("car.brand",    1));
        listings.createIndex(new org.bson.Document("car.price",    1));
        listings.createIndex(new org.bson.Document("car.year",     1));
        listings.createIndex(new org.bson.Document("address.region", 1));
        listings.createIndex(new org.bson.Document("seller.id",    1));
        listings.createIndex(new org.bson.Document("soldAt",       1));

        var messages = mongo.getCollection("messages");
        messages.createIndex(new org.bson.Document("listingId", 1).append("senderId", 1));
        messages.createIndex(new org.bson.Document("receiverId", 1).append("isRead", 1));

        var sales = mongo.getCollection("sales");
        sales.createIndex(new org.bson.Document("buyerId",   1));
        sales.createIndex(new org.bson.Document("listingId", 1));

        // Replaces the MySQL scheduled event (delete_unsold_old_items)
        mongo.getCollection("listings").createIndex(
                new org.bson.Document("createdAt", 1),
                new com.mongodb.client.model.IndexOptions()
                        .expireAfter(1576800000L, java.util.concurrent.TimeUnit.SECONDS)
                        .partialFilterExpression(new org.bson.Document("soldAt", null))
        );

        System.out.println("  ✓ Indexes created");
    }
}
