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

public class CarMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(CarMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, year, mileage_km, price, color, model_id, fuel_type_id FROM car";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (c:Car {id: row.id}) " +
            "SET c.year = row.year, c.mileage = row.mileage, c.price = row.price, " +
            "c.color = row.color";
        String cypherModelRel = "UNWIND $rows AS row " +
            "MATCH (c:Car {id: row.id}), (m:Model {id: row.modelId}) " +
            "MERGE (c)-[:IS_MODEL]->(m)";
        String cypherFuelRel = "UNWIND $rows AS row " +
            "MATCH (c:Car {id: row.id}), (f:FuelType {id: row.fuelTypeId}) " +
            "MERGE (c)-[:USES_FUEL]->(f)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("year", rs.getInt("year"));
                row.put("mileage", rs.getInt("mileage_km"));
                row.put("price", rs.getDouble("price"));
                row.put("color", rs.getString("color"));
                row.put("modelId", rs.getLong("model_id"));
                row.put("fuelTypeId", rs.getLong("fuel_type_id"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherModelRel, cypherFuelRel, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherModelRel, cypherFuelRel, batch);
            }
            log.info("Migrated {} Car nodes with IS_MODEL and USES_FUEL relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("CarMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherModelRel, String cypherFuelRel,
                      List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherModelRel, Map.of("rows", batch)).consume();
            session.run(cypherFuelRel, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
