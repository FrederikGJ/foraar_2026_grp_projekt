package org.backend.web;

import org.backend.document.Listing;
import org.backend.dto.CreateListingRequest;
import org.backend.dto.UpdateListingRequest;
import org.backend.service.ListingService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/listings")
public class ListingController {

    private final ListingService listingService;

    public ListingController(ListingService listingService) {
        this.listingService = listingService;
    }

    // GET /api/listings
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
        return listingService.findActive(
                brand, model, fuelType, region,
                yearFrom, yearTo, priceFrom, priceTo, pageable);
    }

    // GET /api/listings/{id}
    @GetMapping("/{id}")
    public ResponseEntity<Listing> findById(@PathVariable(name = "id") String id) {
        return ResponseEntity.ok(listingService.findById(id));
    }

    // POST /api/listings
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Listing create(@RequestBody CreateListingRequest req) {
        return listingService.create(req);
    }

    // PUT /api/listings/{id}
    @PutMapping("/{id}")
    public Listing update(@PathVariable(name = "id") String id,
                          @RequestBody UpdateListingRequest req) {
        return listingService.update(id, req);
    }

    // DELETE /api/listings/{id}
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable(name = "id") String id) {
        listingService.delete(id);
    }
}
