package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.Car;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CarRepository extends JpaRepository<Car, Long> {
}
