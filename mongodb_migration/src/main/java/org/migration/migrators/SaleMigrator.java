package org.migration.migrators;

import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.migration.util.IdMapper;
import org.bson.Document;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class SaleMigrator {

    private final Connection mysql;
    private final MongoDatabase mongo;
    private final IdMapper idMapper;

    public SaleMigrator(Connection mysql, MongoDatabase mongo, IdMapper idMapper) {
        this.mysql    = mysql;
        this.mongo    = mongo;
        this.idMapper = idMapper;
    }

    public void migrate() throws Exception {
        System.out.println("→ Migrating sales...");

        String sql = """
            SELECT
                cs.id               AS sale_id,
                cs.car_listing_id,
                cs.buyer_id,
                cs.sold_at,
                c.price,
                b.name              AS brand_name,
                m.name              AS model_name,
                c.year,
                u.username          AS seller_username
            FROM car_sale cs
            JOIN car_listing cl ON cl.id = cs.car_listing_id
            JOIN car         c  ON c.id  = cl.car_id
            JOIN model       m  ON m.id  = c.model_id
            JOIN brand       b  ON b.id  = m.brand_id
            JOIN app_user    u  ON u.id  = cl.seller_id
            ORDER BY cs.id
        """;

        List<Document> saleDocs = new ArrayList<>();

        try (Statement stmt = mysql.createStatement();
             ResultSet rs   = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String listingMongoId = idMapper.getListing(rs.getLong("car_listing_id"));
                String buyerMongoId   = idMapper.getUser(rs.getLong("buyer_id"));
                var    soldAt         = rs.getTimestamp("sold_at");

                // 1. Insert the sale document
                Document snapshot = new Document()
                        .append("brand",          rs.getString("brand_name"))
                        .append("model",          rs.getString("model_name"))
                        .append("year",           rs.getInt("year"))
                        .append("price",          rs.getDouble("price"))
                        .append("sellerUsername", rs.getString("seller_username"));

                saleDocs.add(new Document()
                        .append("_id",       "sale_" + rs.getLong("sale_id"))
                        .append("listingId", listingMongoId)
                        .append("buyerId",   buyerMongoId)
                        .append("soldAt",    soldAt)
                        .append("snapshot",  snapshot));

                // 2. Stamp soldAt on the listing so we know it's no longer for sale
                mongo.getCollection("listings").updateOne(
                        Filters.eq("_id", listingMongoId),
                        Updates.set("soldAt", soldAt)
                );
            }
        }

        if (!saleDocs.isEmpty()) {
            mongo.getCollection("sales").insertMany(saleDocs);
        }

        System.out.println("  ✓ " + saleDocs.size() + " sales migrated");
    }
}
