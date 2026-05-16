package org.backend.service;

import org.backend.document.Listing;
import org.backend.dto.CreateListingRequest;
import org.backend.dto.UpdateListingRequest;
import org.backend.repository.ListingRepository;
import org.backend.repository.SaleRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.data.support.PageableExecutionUtils;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class ListingService {

    private final ListingRepository listingRepository;
    private final SaleRepository    saleRepository;
    private final MongoTemplate     mongoTemplate;

    public ListingService(ListingRepository listingRepository,
                          SaleRepository saleRepository,
                          MongoTemplate mongoTemplate) {
        this.listingRepository = listingRepository;
        this.saleRepository    = saleRepository;
        this.mongoTemplate     = mongoTemplate;
    }

    // ── READ ──────────────────────────────────────────────────────────────────

    public Listing findById(String id) {
        return listingRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(
                        HttpStatus.NOT_FOUND, "Listing not found: " + id));
    }

    public Page<Listing> findActive(
            String brand, String model, String fuelType, String region,
            Integer yearFrom, Integer yearTo, Double priceFrom, Double priceTo,
            Pageable pageable
    ) {
        List<Criteria> filters = new ArrayList<>();
        filters.add(Criteria.where("soldAt").isNull());

        if (brand     != null) filters.add(Criteria.where("car.brand").regex(brand, "i"));
        if (model     != null) filters.add(Criteria.where("car.model").regex(model, "i"));
        if (fuelType  != null) filters.add(Criteria.where("car.fuelType").regex(fuelType, "i"));
        if (region    != null) filters.add(Criteria.where("address.region").regex(region, "i"));
        if (yearFrom  != null) filters.add(Criteria.where("car.year").gte(yearFrom));
        if (yearTo    != null) filters.add(Criteria.where("car.year").lte(yearTo));
        if (priceFrom != null) filters.add(Criteria.where("car.price").gte(priceFrom));
        if (priceTo   != null) filters.add(Criteria.where("car.price").lte(priceTo));

        Criteria combined = new Criteria().andOperator(filters.toArray(new Criteria[0]));
        Query    query    = new Query(combined).with(pageable);

        List<Listing> results = mongoTemplate.find(query, Listing.class);
        long          count   = mongoTemplate.count(new Query(combined), Listing.class);

        return PageableExecutionUtils.getPage(results, pageable, () -> count);
    }

    // ── CREATE ────────────────────────────────────────────────────────────────

    /**
     * Mirrors the MySQL create_car_listing stored procedure.
     * In MySQL, three inserts (address, car, car_listing) were wrapped in a
     * transaction to ensure atomicity. Here, all three pieces of data are
     * embedded in one document — a single write is atomic by nature in MongoDB.
     */
    public Listing create(CreateListingRequest req) {
        String id = "listing_" + UUID.randomUUID().toString().substring(0, 8);

        Listing listing = new Listing(
                id,
                new Listing.Car(
                        req.brand(), req.model(), req.fuelType(),
                        req.year(), req.mileageKm(), req.color(), req.price()
                ),
                new Listing.Seller(req.sellerId(), req.sellerId(), null),
                new Listing.Address(
                        req.street(), req.postalCode(), req.city(), req.region()
                ),
                req.description(),
                null,        // soldAt — null means active
                new Date()   // createdAt
        );

        return listingRepository.save(listing);
    }

    // ── UPDATE ────────────────────────────────────────────────────────────────

    /**
     * Only fields that make sense to edit after listing:
     * price, description, color, mileageKm, address.
     * Brand/model/year are fixed — mirroring MySQL where those live on the car row.
     */
    public Listing update(String id, UpdateListingRequest req) {
        Listing existing = findById(id);

        if (existing.getSoldAt() != null) {
            throw new ResponseStatusException(
                    HttpStatus.CONFLICT, "Cannot update a sold listing.");
        }

        Query  query  = new Query(Criteria.where("_id").is(id));
        Update update = new Update();

        if (req.price()       != null) update.set("car.price",          req.price());
        if (req.color()       != null) update.set("car.color",          req.color());
        if (req.mileageKm()   != null) update.set("car.mileageKm",      req.mileageKm());
        if (req.description() != null) update.set("description",        req.description());
        if (req.street()      != null) update.set("address.street",     req.street());
        if (req.postalCode()  != null) update.set("address.postalCode", req.postalCode());
        if (req.city()        != null) update.set("address.city",       req.city());
        if (req.region()      != null) update.set("address.region",     req.region());

        mongoTemplate.updateFirst(query, update, Listing.class);

        return findById(id);
    }

    // ── DELETE ────────────────────────────────────────────────────────────────

    /**
     * Hard delete — mirrors MySQL behaviour.
     * Refused if a sale exists (mirrors ON DELETE RESTRICT on car_sale FK).
     */
    public void delete(String id) {
        findById(id); // throws 404 if not found

        saleRepository.findByListingId(id).ifPresent(sale -> {
            throw new ResponseStatusException(
                    HttpStatus.CONFLICT,
                    "Cannot delete listing " + id + ": a sale record exists.");
        });

        listingRepository.deleteById(id);
    }
}
