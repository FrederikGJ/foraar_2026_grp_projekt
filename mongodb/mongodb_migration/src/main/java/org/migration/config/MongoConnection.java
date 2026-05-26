package org.migration.config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

import java.io.InputStream;
import java.util.Properties;

public class MongoConnection {

    public static MongoDatabase connect() throws Exception {
        Properties props = load();
        MongoClient client = MongoClients.create(props.getProperty("mongo.uri"));
        return client.getDatabase(props.getProperty("mongo.database"));
    }

    private static Properties load() throws Exception {
        Properties props = new Properties();
        try (InputStream is = MongoConnection.class
                .getClassLoader()
                .getResourceAsStream("migration.properties")) {
            props.load(is);
        }
        return props;
    }
}
