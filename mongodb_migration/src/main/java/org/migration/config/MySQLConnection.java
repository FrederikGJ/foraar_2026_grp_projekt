package org.migration.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class MySQLConnection {

    public static Connection connect() throws Exception {
        Properties props = load();
        return DriverManager.getConnection(
                props.getProperty("mysql.url"),
                props.getProperty("mysql.username"),
                props.getProperty("mysql.password")
        );
    }

    private static Properties load() throws Exception {
        Properties props = new Properties();
        try (InputStream is = MySQLConnection.class
                .getClassLoader()
                .getResourceAsStream("migration.properties")) {
            props.load(is);
        }
        return props;
    }
}
