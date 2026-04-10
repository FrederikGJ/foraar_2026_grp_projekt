package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.FuelType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FuelTypeRepository extends JpaRepository<FuelType, Long> {
}
