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

public class AuditEventMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(AuditEventMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, listing_id, action, changed_at, changed_by, old_price, new_price FROM car_listing_audit";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (a:AuditEvent {id: row.id}) " +
            "SET a.action = row.action, a.changedAt = row.changedAt, " +
            "a.oldPrice = row.oldPrice, a.newPrice = row.newPrice";
        String cypherListingRel = "UNWIND $rows AS row " +
            "MATCH (a:AuditEvent {id: row.id}), (l:CarListing {id: row.listingId}) " +
            "MERGE (a)-[:AUDIT_OF]->(l)";
        String cypherUserRel = "UNWIND $rows AS row " +
            "WITH row WHERE row.changedBy IS NOT NULL " +
            "MATCH (a:AuditEvent {id: row.id}), (u:User {id: row.changedBy}) " +
            "MERGE (a)-[:PERFORMED_BY]->(u)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("listingId", rs.getLong("listing_id"));
                row.put("action", rs.getString("action"));
                row.put("changedAt", rs.getString("changed_at"));
                long changedBy = rs.getLong("changed_by");
                row.put("changedBy", rs.wasNull() ? null : changedBy);
                java.math.BigDecimal oldPrice = rs.getBigDecimal("old_price");
                row.put("oldPrice", oldPrice != null ? oldPrice.doubleValue() : null);
                java.math.BigDecimal newPrice = rs.getBigDecimal("new_price");
                row.put("newPrice", newPrice != null ? newPrice.doubleValue() : null);
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherListingRel, cypherUserRel, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherListingRel, cypherUserRel, batch);
            }
            log.info("Migrated {} AuditEvent nodes with relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("AuditEventMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherListingRel, String cypherUserRel,
                      List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherListingRel, Map.of("rows", batch)).consume();
            session.run(cypherUserRel, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
