package dk.bilbase.backend;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.boot.testcontainers.service.connection.ServiceConnection;
import org.springframework.context.annotation.Bean;
import org.testcontainers.containers.MySQLContainer;

@TestConfiguration(proxyBeanMethods = false)
public class TestContainerConfig {

    @Bean
    @ServiceConnection
    static MySQLContainer<?> mysql() {
        return new MySQLContainer<>("mysql:8.0")
                .withInitScript("init.sql");
    }
}
