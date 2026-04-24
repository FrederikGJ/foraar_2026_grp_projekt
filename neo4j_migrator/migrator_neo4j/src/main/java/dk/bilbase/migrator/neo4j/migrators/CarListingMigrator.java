package dk.bilbase.migrator.neo4j.migrators;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CarListingMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(CarListingMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, description, created_at, " +
            "car_id, seller_id, address_id FROM car_listing";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (l:CarListing {id: row.id}) " +
            "SET l.description = row.description, l.createdAt = row.createdAt";
        String cypherCarRel = "UNWIND $rows AS row " +
            "MATCH (l:CarListing {id: row.id}), (c:Car {id: row.carId}) " +
            "MERGE (l)-[:LISTS_CAR]->(c)";
        String cypherSellerRel = "UNWIND $rows AS row " +
            "MATCH (l:CarListing {id: row.id}), (u:User {id: row.sellerId}) " +
            "MERGE (l)-[:POSTED_BY]->(u)";
        String cypherAddressRel = "UNWIND $rows AS row " +
            "MATCH (l:CarListing {id: row.id}), (a:Address {id: row.addressId}) " +
            "MERGE (l)-[:LOCATED_AT]->(a)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("description", rs.getString("description"));
                row.put("createdAt", rs.getString("created_at"));
                row.put("carId", rs.getLong("car_id"));
                row.put("sellerId", rs.getLong("seller_id"));
                row.put("addressId", rs.getLong("address_id"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherCarRel, cypherSellerRel, cypherAddressRel, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherCarRel, cypherSellerRel, cypherAddressRel, batch);
            }
            log.info("Migrated {} CarListing nodes with relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("CarListingMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherCarRel,
                      String cypherSellerRel, String cypherAddressRel,
                      List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherCarRel, Map.of("rows", batch)).consume();
            session.run(cypherSellerRel, Map.of("rows", batch)).consume();
            session.run(cypherAddressRel, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
