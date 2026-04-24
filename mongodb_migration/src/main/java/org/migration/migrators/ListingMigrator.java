package org.migration.migrators;

import com.mongodb.client.MongoDatabase;
import org.migration.util.IdMapper;
import org.bson.Document;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ListingMigrator {

    private final Connection mysql;
    private final MongoDatabase mongo;
    private final IdMapper idMapper;

    public ListingMigrator(Connection mysql, MongoDatabase mongo, IdMapper idMapper) {
        this.mysql    = mysql;
        this.mongo    = mongo;
        this.idMapper = idMapper;
    }

    public void migrate() throws Exception {
        System.out.println("→ Migrating listings...");

        // One query joins everything we need:
        // car_listing → car → model → brand → fuel_type → address → region → app_user
        String sql = """
            SELECT
                cl.id               AS listing_id,
                cl.description,
                cl.created_at,

                u.id                AS seller_mysql_id,
                u.username          AS seller_username,
                u.phone             AS seller_phone,

                c.price,
                c.year,
                c.mileage_km,
                c.color,

                m.name              AS model_name,
                b.name              AS brand_name,
                ft.name             AS fuel_type_name,

                a.street,
                a.postal_code,
                a.city,
                r.name              AS region_name

            FROM car_listing cl
            JOIN app_user  u  ON u.id  = cl.seller_id
            JOIN car       c  ON c.id  = cl.car_id
            JOIN model     m  ON m.id  = c.model_id
            JOIN brand     b  ON b.id  = m.brand_id
            JOIN fuel_type ft ON ft.id = c.fuel_type_id
            JOIN address   a  ON a.id  = cl.address_id
            JOIN region    r  ON r.id  = a.region_id
            ORDER BY cl.id
        """;

        List<Document> docs = new ArrayList<>();

        try (Statement stmt = mysql.createStatement();
             ResultSet rs   = stmt.executeQuery(sql)) {

            while (rs.next()) {
                long   mysqlId  = rs.getLong("listing_id");
                String mongoId  = "listing_" + mysqlId;

                idMapper.putListing(mysqlId, mongoId);

                String sellerMongoId = idMapper.getUser(rs.getLong("seller_mysql_id"));

                Document car = new Document()
                        .append("brand",     rs.getString("brand_name"))
                        .append("model",     rs.getString("model_name"))
                        .append("fuelType",  rs.getString("fuel_type_name"))
                        .append("year",      rs.getInt("year"))
                        .append("mileageKm", rs.getInt("mileage_km"))
                        .append("color",     rs.getString("color"))
                        .append("price",     rs.getDouble("price"));

                Document seller = new Document()
                        .append("id",       sellerMongoId)
                        .append("username", rs.getString("seller_username"))
                        .append("phone",    rs.getString("seller_phone"));

                Document address = new Document()
                        .append("street",     rs.getString("street"))
                        .append("postalCode", rs.getString("postal_code"))
                        .append("city",       rs.getString("city"))
                        .append("region",     rs.getString("region_name"));

                Document doc = new Document()
                        .append("_id",         mongoId)
                        .append("seller",      seller)
                        .append("car",         car)
                        .append("address",     address)
                        .append("description", rs.getString("description"))
                        .append("soldAt",      null)   // updated later by SaleMigrator
                        .append("createdAt",   rs.getTimestamp("created_at"));

                docs.add(doc);
            }
        }

        if (!docs.isEmpty()) {
            mongo.getCollection("listings").insertMany(docs);
        }

        System.out.println("  ✓ " + docs.size() + " listings migrated");
    }
}
