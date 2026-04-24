package dk.bilbase.migrator.neo4j;

import dk.bilbase.migrator.neo4j.migrators.*;
import java.sql.Connection;
import java.util.List;
import org.neo4j.driver.Driver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MigrationRunner {

    private static final Logger log = LoggerFactory.getLogger(MigrationRunner.class);

    public void run(Connection mysql, Driver neo4j) {
        List<Migrator> migrators = List.of(
            new RegionMigrator(),
            new BrandMigrator(),
            new FuelTypeMigrator(),
            new ModelMigrator(),
            new AddressMigrator(),
            new UserMigrator(),
            new CarMigrator(),
            new CarListingMigrator(),
            new SaleMigrator(),
            new FavoriteMigrator(),
            new MessageMigrator(),
            new AuditEventMigrator()
        );

        for (Migrator migrator : migrators) {
            String name = migrator.getClass().getSimpleName();
            log.info("Running {}", name);
            long start = System.currentTimeMillis();
            migrator.migrate(mysql, neo4j);
            long elapsed = System.currentTimeMillis() - start;
            log.info("{} completed in {} ms", name, elapsed);
        }
    }
}
