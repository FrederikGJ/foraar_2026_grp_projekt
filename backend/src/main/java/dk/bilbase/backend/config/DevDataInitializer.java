package dk.bilbase.backend.config;

import dk.bilbase.backend.repository.AppUserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Erstatter de "dummy" bcrypt-hashes i seed-data med rigtige BCrypt-hashes
 * af "password123" — så I kan logge ind som admin / dealer1 / customer1 osv. i dev.
 *
 * Kører kun i 'dev'-profilen og kun hvis dummy-hashes faktisk findes (idempotent).
 *
 *
 * It is a dev-only configuration class that runs on startup to update dummy user
 * passwords in the database from plain text to hashed passwords using PasswordEncoder,
 * in order to protect passwords if the database is exposed.
 * It only runs in the dev profile and only when needed.
 */
@Configuration
@Profile("dev")
public class DevDataInitializer {

    private static final Logger log = LoggerFactory.getLogger(DevDataInitializer.class);
    private static final String DEV_PASSWORD = "password123";

    @Bean
    public ApplicationRunner replaceDummyPasswords(AppUserRepository userRepository,
                                                   PasswordEncoder passwordEncoder) {
        return args -> initialize(userRepository, passwordEncoder);
    }

    void initialize(AppUserRepository userRepository, PasswordEncoder passwordEncoder) {
        long dummyCount = userRepository.countDummyPasswords();
        if (dummyCount == 0) {
            log.info("[dev] No dummy passwords found in app_user — skipping initializer");
            return;
        }
        String hash = passwordEncoder.encode(DEV_PASSWORD);
        int updated = userRepository.replaceDummyPasswords(hash);
        log.info("[dev] Replaced {} dummy passwords with bcrypt('{}')", updated, DEV_PASSWORD);
    }
}
