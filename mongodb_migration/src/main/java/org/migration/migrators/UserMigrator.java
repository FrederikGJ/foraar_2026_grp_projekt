package org.migration.migrators;

import com.mongodb.client.MongoDatabase;
import org.migration.util.IdMapper;
import org.bson.Document;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserMigrator {

    private final Connection mysql;
    private final MongoDatabase mongo;
    private final IdMapper idMapper;

    public UserMigrator(Connection mysql, MongoDatabase mongo, IdMapper idMapper) {
        this.mysql    = mysql;
        this.mongo    = mongo;
        this.idMapper = idMapper;
    }

    public void migrate() throws Exception {
        System.out.println("→ Migrating users...");

        // Fetch users with their role name in one query — no need for a second lookup
        String sql = """
            SELECT
                u.id,
                u.username,
                u.email,
                u.password_hash,
                u.first_name,
                u.last_name,
                u.phone,
                u.created_at,
                u.updated_at,
                r.name AS role_name
            FROM app_user u
            JOIN role r ON r.id = u.role_id
            ORDER BY u.id
        """;

        List<Document> docs = new ArrayList<>();

        try (Statement stmt = mysql.createStatement();
             ResultSet rs   = stmt.executeQuery(sql)) {

            while (rs.next()) {
                long   mysqlId  = rs.getLong("id");
                String mongoId  = "user_" + mysqlId;

                // Register in the map so other migrators can reference users
                idMapper.putUser(mysqlId, mongoId);

                Document doc = new Document()
                        .append("_id",          mongoId)
                        .append("username",     rs.getString("username"))
                        .append("email",        rs.getString("email"))
                        .append("passwordHash", rs.getString("password_hash"))
                        .append("firstName",    rs.getString("first_name"))
                        .append("lastName",     rs.getString("last_name"))
                        .append("phone",        rs.getString("phone"))
                        .append("role",         rs.getString("role_name"))  // "user" or "admin"
                        .append("favorites",    new ArrayList<>())          // populated later
                        .append("createdAt",    rs.getTimestamp("created_at"))
                        .append("updatedAt",    rs.getTimestamp("updated_at"));

                docs.add(doc);
            }
        }

        if (!docs.isEmpty()) {
            mongo.getCollection("users").insertMany(docs);
        }

        System.out.println("  ✓ " + docs.size() + " users migrated");
    }
}
