package org.backend.repository;

import org.backend.document.Sale;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.Optional;

public interface SaleRepository extends MongoRepository<Sale, String> {

    List<Sale>     findByBuyerIdOrderBySoldAtDesc(String buyerId);

    Optional<Sale> findByListingId(String listingId);
}
