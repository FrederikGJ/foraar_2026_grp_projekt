package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.CarListing;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CarListingRepository extends JpaRepository<CarListing, Long> {

    List<CarListing> findBySellerId(Long sellerId);
}
