package org.backend.web;

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

    // GET /api/sales?buyerId=user_5
    @GetMapping
    public List<Sale> byBuyer(@RequestParam(name = "buyerId") String buyerId) {
        return saleRepository.findByBuyerIdOrderBySoldAtDesc(buyerId);
    }

    // GET /api/sales/listing/listing_4
    @GetMapping("/listing/{listingId}")
    public ResponseEntity<Sale> byListing(@PathVariable(name = "listingId") String listingId) {
        return saleRepository.findByListingId(listingId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
