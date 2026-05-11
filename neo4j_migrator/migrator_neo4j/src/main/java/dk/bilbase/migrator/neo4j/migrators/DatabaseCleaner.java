package dk.bilbase.migrator.neo4j.migrators;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import org.neo4j.driver.Driver;
import org.neo4j.driver.Session;
import org.neo4j.driver.Result;
import org.neo4j.driver.Record;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DatabaseCleaner implements Migrator {

    private static final Logger log = LoggerFactory.getLogger(DatabaseCleaner.class);
    private static final String CONSTRAINTS_SCRIPT = "/neo4j/constraints.cypher";

    @Override
    public void migrate(Connection mysql, Driver neo4j) {
        try (Session session = neo4j.session()) {
            log.info("Sletter alle noder og relationer...");
            session.run("MATCH (n) DETACH DELETE n").consume();
            log.info("Alle noder og relationer slettet");

            log.info("Dropper alle constraints og indexes...");
            Result constraints = session.run("SHOW CONSTRAINTS");
            while (constraints.hasNext()) {
                Record record = constraints.next();
                String name = record.get("name").asString();
                session.run("DROP CONSTRAINT " + name + " IF EXISTS").consume();
            }
            Result indexes = session.run("SHOW INDEXES");
            while (indexes.hasNext()) {
                Record record = indexes.next();
                String name = record.get("name").asString();
                String type = record.get("type").asString();
                if (!"LOOKUP".equals(type)) {
                    session.run("DROP INDEX " + name + " IF EXISTS").consume();
                }
            }
            log.info("Alle constraints og indexes droppet");
        }

        log.info("Genopretter constraints og indexes fra {}...", CONSTRAINTS_SCRIPT);
        try (InputStream is = getClass().getResourceAsStream(CONSTRAINTS_SCRIPT)) {
            if (is == null) {
                log.warn("Constraints-script ikke fundet: {} — springer over", CONSTRAINTS_SCRIPT);
                return;
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
                        String cypher = statement.substring(0, statement.length() - 1);
                        session.run(cypher).consume();
                        count++;
                        statement.setLength(0);
                    }
                }
            }
            log.info("Oprettede {} constraints/indexes", count);
        } catch (Exception e) {
            throw new RuntimeException("DatabaseCleaner fejlede", e);
        }
    }
}
