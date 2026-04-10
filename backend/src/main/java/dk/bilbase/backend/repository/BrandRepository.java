package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.Brand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BrandRepository extends JpaRepository<Brand, Long> {
}
