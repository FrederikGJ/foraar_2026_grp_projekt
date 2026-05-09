package org.backend.service;

import org.backend.document.Listing;
import org.backend.repository.ListingRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.List;

@Service
public class ListingService {

    private final ListingRepository listingRepository;
    private final MongoTemplate     mongoTemplate;

    public ListingService(ListingRepository listingRepository, MongoTemplate mongoTemplate) {
        this.listingRepository = listingRepository;
        this.mongoTemplate     = mongoTemplate;
    }

    public Listing findById(String id) {
        return listingRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Listing not found: " + id));
    }

    /**
     * Browse active (unsold) listings with optional filters.
     * All filters are combined with AND. Unset filters are ignored.
     */
    public Page<Listing> findActive(
            String  brand,
            String  model,
            String  fuelType,
            String  region,
            Integer yearFrom,
            Integer yearTo,
            Double  priceFrom,
            Double  priceTo,
            Pageable pageable
    ) {
        List<Criteria> filters = new ArrayList<>();

        // Must be unsold
        filters.add(Criteria.where("soldAt").isNull());

        if (brand    != null) filters.add(Criteria.where("car.brand").regex(brand, "i"));
        if (model    != null) filters.add(Criteria.where("car.model").regex(model, "i"));
        if (fuelType != null) filters.add(Criteria.where("car.fuelType").regex(fuelType, "i"));
        if (region   != null) filters.add(Criteria.where("address.region").regex(region, "i"));

        if (yearFrom != null) filters.add(Criteria.where("car.year").gte(yearFrom));
        if (yearTo   != null) filters.add(Criteria.where("car.year").lte(yearTo));
        if (priceFrom != null) filters.add(Criteria.where("car.price").gte(priceFrom));
        if (priceTo   != null) filters.add(Criteria.where("car.price").lte(priceTo));

        Criteria combined = new Criteria().andOperator(filters.toArray(new Criteria[0]));
        Query    query    = new Query(combined).with(pageable);

        List<Listing> results = mongoTemplate.find(query, Listing.class);
        long          count   = mongoTemplate.count(new Query(combined), Listing.class);

        return PageableExecutionUtils.getPage(results, pageable, () -> count);
    }
}
