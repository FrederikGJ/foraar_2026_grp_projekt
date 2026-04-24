package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.CarSale;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface CarSaleRepository extends JpaRepository<CarSale, Long> {

    Optional<CarSale> findByCarListingId(Long carListingId);

    boolean existsByCarListingId(Long carListingId);
}
