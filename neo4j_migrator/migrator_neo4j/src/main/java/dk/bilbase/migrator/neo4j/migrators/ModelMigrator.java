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

public class ModelMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(ModelMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, name, brand_id FROM model";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (m:Model {id: row.id}) SET m.name = row.name";
        String cypherRels = "UNWIND $rows AS row " +
            "MATCH (m:Model {id: row.id}), (b:Brand {id: row.brandId}) " +
            "MERGE (m)-[:MADE_BY]->(b)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("name", rs.getString("name"));
                row.put("brandId", rs.getLong("brand_id"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherRels, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherRels, batch);
            }
            log.info("Migrated {} Model nodes with MADE_BY relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("ModelMigrator failed", e);
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
