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

public class MessageMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(MessageMigrator.class);
    private static final int BATCH_SIZE = 1000;

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        String query = "SELECT id, content, sent_at, sender_id, receiver_id, car_listing_id FROM message";
        String cypherNodes = "UNWIND $rows AS row " +
            "MERGE (m:Message {id: row.id}) " +
            "SET m.content = row.content, m.sentAt = row.sentAt";
        String cypherSenderRel = "UNWIND $rows AS row " +
            "MATCH (m:Message {id: row.id}), (u:User {id: row.senderId}) " +
            "MERGE (m)-[:SENT_BY]->(u)";
        String cypherReceiverRel = "UNWIND $rows AS row " +
            "MATCH (m:Message {id: row.id}), (u:User {id: row.receiverId}) " +
            "MERGE (m)-[:RECEIVED_BY]->(u)";
        String cypherListingRel = "UNWIND $rows AS row " +
            "MATCH (m:Message {id: row.id}), (l:CarListing {id: row.carListingId}) " +
            "MERGE (m)-[:ABOUT_LISTING]->(l)";

        try (PreparedStatement stmt = mysql.prepareStatement(query)) {
            stmt.setFetchSize(BATCH_SIZE);
            ResultSet rs = stmt.executeQuery();
            List<Map<String, Object>> batch = new ArrayList<>();
            int total = 0;

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("id", rs.getLong("id"));
                row.put("content", rs.getString("content"));
                row.put("sentAt", rs.getString("sent_at"));
                row.put("senderId", rs.getLong("sender_id"));
                row.put("receiverId", rs.getLong("receiver_id"));
                row.put("carListingId", rs.getLong("car_listing_id"));
                batch.add(row);

                if (batch.size() >= BATCH_SIZE) {
                    total += flush(neo4j, cypherNodes, cypherSenderRel, cypherReceiverRel, cypherListingRel, batch);
                }
            }
            if (!batch.isEmpty()) {
                total += flush(neo4j, cypherNodes, cypherSenderRel, cypherReceiverRel, cypherListingRel, batch);
            }
            log.info("Migrated {} Message nodes with relationships", total);
        } catch (Exception e) {
            throw new RuntimeException("MessageMigrator failed", e);
        }
    }

    private int flush(Driver neo4j, String cypherNodes, String cypherSenderRel,
                      String cypherReceiverRel, String cypherListingRel,
                      List<Map<String, Object>> batch) {
        int size = batch.size();
        try (Session session = neo4j.session()) {
            session.run(cypherNodes, Map.of("rows", batch)).consume();
            session.run(cypherSenderRel, Map.of("rows", batch)).consume();
            session.run(cypherReceiverRel, Map.of("rows", batch)).consume();
            session.run(cypherListingRel, Map.of("rows", batch)).consume();
        }
        batch.clear();
        return size;
    }
}
