package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.CarListing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.List;

public interface CarListingRepository extends JpaRepository<CarListing, Long>,
                                              JpaSpecificationExecutor<CarListing> {

    List<CarListing> findBySellerId(Long sellerId);



}
