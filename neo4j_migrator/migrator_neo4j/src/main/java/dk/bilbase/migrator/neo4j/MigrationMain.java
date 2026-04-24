package dk.bilbase.migrator.neo4j;

import java.sql.Connection;
import java.sql.DriverManager;
import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MigrationMain {

    private static final Logger log = LoggerFactory.getLogger(MigrationMain.class);

    public static void main(String[] args) {
        String mysqlUrl = env("MYSQL_URL", "jdbc:mysql://localhost:3306/bilbase");
        String mysqlUser = env("MYSQL_USER", "migrator_ro");
        String mysqlPassword = env("MYSQL_PASSWORD", "");
        String neo4jUri = env("NEO4J_URI", "bolt://localhost:7687");
        String neo4jUser = env("NEO4J_USER", "neo4j");
        String neo4jPassword = env("NEO4J_PASSWORD", "bilbasen");

        log.info("Starting MySQL -> Neo4j migration");
        log.info("MySQL: {}", mysqlUrl);
        log.info("Neo4j: {}", neo4jUri);

        try (
            Connection mysql = DriverManager.getConnection(mysqlUrl, mysqlUser, mysqlPassword);
            Driver neo4j = GraphDatabase.driver(neo4jUri, AuthTokens.basic(neo4jUser, neo4jPassword))
        ) {
            mysql.setReadOnly(true);
            neo4j.verifyConnectivity();

            new MigrationRunner().run(mysql, neo4j);

            log.info("Migration completed successfully");
        } catch (Exception e) {
            log.error("Migration failed", e);
            System.exit(1);
        }
    }

    private static String env(String key, String defaultValue) {
        String value = System.getenv(key);
        return value != null ? value : defaultValue;
    }
}
