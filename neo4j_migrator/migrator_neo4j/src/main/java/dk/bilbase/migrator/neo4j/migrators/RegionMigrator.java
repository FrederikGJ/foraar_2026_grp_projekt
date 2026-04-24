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

public class RegionMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(RegionMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, name FROM region";
        String cypher = "UNWIND $rows AS row MERGE (r:Region {id: row.id}) SET r.name = row.name";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("name", rs.getString("name"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypher, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypher, batch);
            }
            log.info("Migrated {} Region nodes", total);
        } catch (Exception e) {
            throw new RuntimeException("RegionMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypher, List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypher, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
