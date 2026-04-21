package org.migration.migrators;

import com.mongodb.client.MongoDatabase;
import org.migration.util.IdMapper;
import org.bson.Document;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MessageMigrator {

    private final Connection mysql;
    private final MongoDatabase mongo;
    private final IdMapper idMapper;

    public MessageMigrator(Connection mysql, MongoDatabase mongo, IdMapper idMapper) {
        this.mysql    = mysql;
        this.mongo    = mongo;
        this.idMapper = idMapper;
    }

    public void migrate() throws Exception {
        System.out.println("→ Migrating messages...");

        String sql = """
            SELECT id, sender_id, receiver_id, car_listing_id, content, sent_at, is_read
            FROM message
            ORDER BY id
        """;

        List<Document> docs = new ArrayList<>();

        try (Statement stmt = mysql.createStatement();
             ResultSet rs   = stmt.executeQuery(sql)) {

            while (rs.next()) {
                docs.add(new Document()
                        .append("_id",       "msg_" + rs.getLong("id"))
                        .append("listingId", idMapper.getListing(rs.getLong("car_listing_id")))
                        .append("senderId",  idMapper.getUser(rs.getLong("sender_id")))
                        .append("receiverId",idMapper.getUser(rs.getLong("receiver_id")))
                        .append("content",   rs.getString("content"))
                        .append("isRead",    rs.getBoolean("is_read"))
                        .append("sentAt",    rs.getTimestamp("sent_at")));
            }
        }

        if (!docs.isEmpty()) {
            mongo.getCollection("messages").insertMany(docs);
        }

        System.out.println("  ✓ " + docs.size() + " messages migrated");
    }
}
