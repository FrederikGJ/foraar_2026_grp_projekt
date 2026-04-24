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

public class UserMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(UserMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT u.id, u.username, u.email, u.first_name, u.last_name, " +
            "u.phone, r.name AS role_name, u.created_at " +
            "FROM app_user u JOIN role r ON u.role_id = r.id";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (u:User {id: row.id}) " +
            "SET u.username = row.username, u.email = row.email, " +
            "u.firstName = row.firstName, u.lastName = row.lastName, " +
            "u.phone = row.phone, u.role = row.role, u.createdAt = row.createdAt";
        String cypherAdminLabel = "UNWIND $rows AS row " +
            "WITH row WHERE row.role = 'ADMIN' " +
            "MATCH (u:User {id: row.id}) SET u:Admin";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("username", rs.getString("username"));
                row.put("email", rs.getString("email"));
                row.put("firstName", rs.getString("first_name"));
                row.put("lastName", rs.getString("last_name"));
                row.put("phone", rs.getString("phone"));
                row.put("role", rs.getString("role_name"));
                row.put("createdAt", rs.getString("created_at"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherAdminLabel, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherAdminLabel, batch);
            }
            log.info("Migrated {} User nodes (Admin label set by role)", total);
        } catch (Exception e) {
            throw new RuntimeException("UserMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherAdminLabel, List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherAdminLabel, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
