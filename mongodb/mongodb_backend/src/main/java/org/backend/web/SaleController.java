package org.backend.web;

import io.swagger.v3.oas.annotations.Parameter;
import org.backend.document.Sale;
import org.backend.repository.SaleRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/sales")
public class SaleController {

    private final SaleRepository saleRepository;

    public SaleController(SaleRepository saleRepository) {
        this.saleRepository = saleRepository;
    }

    @GetMapping
    public List<Sale> byBuyer(
            @Parameter(example = "user_22")
            @RequestParam(name = "buyerId") String buyerId) {
        return saleRepository.findByBuyerIdOrderBySoldAtDesc(buyerId);
    }

    @GetMapping("/listing/{listingId}")
    public ResponseEntity<Sale> byListing(
            @Parameter(example = "listing_1")
            @PathVariable(name = "listingId") String listingId) {
        return saleRepository.findByListingId(listingId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
