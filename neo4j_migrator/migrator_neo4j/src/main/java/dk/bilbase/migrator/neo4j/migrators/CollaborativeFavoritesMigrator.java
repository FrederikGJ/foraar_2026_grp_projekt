package dk.bilbase.migrator.neo4j.migrators;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CollaborativeFavoritesMigrator implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(CollaborativeFavoritesMigrator.class);
    private static final String SCRIPT_PATH = "/neo4j/collaborative_favorites.cypher";

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        try (InputStream is = getClass().getResourceAsStream(SCRIPT_PATH)) {
            if (is == null) {
                throw new RuntimeException("Cypher-script ikke fundet: " + SCRIPT_PATH);
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
            int count = 0;

            try (Session session = neo4j.session()) {
                StringBuilder statement = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    String trimmed = line.trim();
                    if (trimmed.isEmpty() || trimmed.startsWith("//")) {
                        continue;
                    }
                    statement.append(trimmed);
                    if (trimmed.endsWith(";")) {
                        String cypher = statement.toString();
                        cypher = cypher.substring(0, cypher.length() - 1);
                        session.run(cypher).consume();
                        count++;
                        statement.setLength(0);
                    }
                }
            }

            log.info("Kørte {} collaborative filtering Cypher-statements", count);
        } catch (Exception e) {
            throw new RuntimeException("CollaborativeFavoritesMigrator fejlede", e);
        }
    }
}
