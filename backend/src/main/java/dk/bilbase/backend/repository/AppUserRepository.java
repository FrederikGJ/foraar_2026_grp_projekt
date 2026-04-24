package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.AppUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

public interface AppUserRepository extends JpaRepository<AppUser, Long> {

    @Query("SELECT u FROM AppUser u JOIN FETCH u.role WHERE u.username = :username")
    Optional<AppUser> findByUsernameWithRole(@Param("username") String username);

    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Bruges af DevDataInitializer (kun dev-profil) til at fixe seed-passwords
    @Query(value = "SELECT COUNT(*) FROM app_user WHERE password_hash LIKE '$2a$10$dummy%'",
           nativeQuery = true)
    long countDummyPasswords();

    @Modifying
    @Transactional
    @Query(value = "UPDATE app_user SET password_hash = :hash WHERE password_hash LIKE '$2a$10$dummy%'",
           nativeQuery = true)
    int replaceDummyPasswords(@Param("hash") String hash);
}
