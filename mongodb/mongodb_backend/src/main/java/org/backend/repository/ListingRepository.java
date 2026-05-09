package org.backend.repository;

import org.backend.document.Listing;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

public interface ListingRepository extends MongoRepository<Listing, String> {

    // Only unsold listings
    Page<Listing> findBySoldAtIsNull(Pageable pageable);

    // Filter by brand (case-insensitive), unsold only
    @Query("{ 'car.brand': { $regex: ?0, $options: 'i' }, 'soldAt': null }")
    Page<Listing> findByBrand(String brand, Pageable pageable);

    // Filter by seller id
    Page<Listing> findBySellerId(String sellerId, Pageable pageable);
}
