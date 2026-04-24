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

public class AddressMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(AddressMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, street, city, postal_code, region_id FROM address";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (a:Address {id: row.id}) " +
            "SET a.street = row.street, a.city = row.city, a.postalCode = row.postalCode";
        String cypherRels = "UNWIND $rows AS row " +
            "MATCH (a:Address {id: row.id}), (r:Region {id: row.regionId}) " +
            "MERGE (a)-[:IN_REGION]->(r)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("street", rs.getString("street"));
                row.put("city", rs.getString("city"));
                row.put("postalCode", rs.getString("postal_code"));
                row.put("regionId", rs.getLong("region_id"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherRels, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherRels, batch);
            }
            log.info("Migrated {} Address nodes with IN_REGION relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("AddressMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherRels, List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherRels, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
