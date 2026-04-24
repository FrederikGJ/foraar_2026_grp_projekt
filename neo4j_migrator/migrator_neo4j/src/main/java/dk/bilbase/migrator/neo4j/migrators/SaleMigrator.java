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

public class SaleMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(SaleMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, sold_at, car_listing_id, buyer_id FROM car_sale";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (s:Sale {id: row.id}) " +
            "SET s.soldAt = row.soldAt";
        String cypherListingRel = "UNWIND $rows AS row " +
            "MATCH (s:Sale {id: row.id}), (l:CarListing {id: row.carListingId}) " +
            "MERGE (s)-[:SALE_OF]->(l)";
        String cypherBuyerRel = "UNWIND $rows AS row " +
            "MATCH (s:Sale {id: row.id}), (u:User {id: row.buyerId}) " +
            "MERGE (s)-[:BOUGHT_BY]->(u)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("soldAt", rs.getString("sold_at"));
                row.put("carListingId", rs.getLong("car_listing_id"));
                row.put("buyerId", rs.getLong("buyer_id"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherListingRel, cypherBuyerRel, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherListingRel, cypherBuyerRel, batch);
            }
            log.info("Migrated {} Sale nodes with relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("SaleMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherListingRel, String cypherBuyerRel,
                      List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherListingRel, Map.of("rows", batch)).consume();
            session.run(cypherBuyerRel, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
