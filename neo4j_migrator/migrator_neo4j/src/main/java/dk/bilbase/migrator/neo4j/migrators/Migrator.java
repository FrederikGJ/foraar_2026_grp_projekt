package dk.bilbase.migrator.neo4j.migrators;

import java.sql.Connection;
import org.neo4j.driver.Driver;

public interface Migrator {
    void migrate(Connection mysql, Driver neo4j);
}
