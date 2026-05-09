package org.backend.web;

import org.backend.document.Listing;
import org.backend.service.ListingService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/listings")
public class ListingController {

    private final ListingService listingService;

    public ListingController(ListingService listingService) {
        this.listingService = listingService;
    }

    @GetMapping
    public Page<Listing> findActive(
            @RequestParam(name = "brand",     required = false) String  brand,
            @RequestParam(name = "model",     required = false) String  model,
            @RequestParam(name = "fuelType",  required = false) String  fuelType,
            @RequestParam(name = "region",    required = false) String  region,
            @RequestParam(name = "yearFrom",  required = false) Integer yearFrom,
            @RequestParam(name = "yearTo",    required = false) Integer yearTo,
            @RequestParam(name = "priceFrom", required = false) Double  priceFrom,
            @RequestParam(name = "priceTo",   required = false) Double  priceTo,
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable
    ) {
        return listingService.findActive(brand, model, fuelType, region, yearFrom, yearTo, priceFrom, priceTo, pageable);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Listing> findById(@PathVariable(name = "id") String id) {
        return ResponseEntity.ok(listingService.findById(id));
    }
}
