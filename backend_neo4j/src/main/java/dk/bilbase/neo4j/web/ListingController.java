package dk.bilbase.neo4j.web;

import dk.bilbase.neo4j.dto.ListingDetailDto;
import dk.bilbase.neo4j.dto.ListingSummaryDto;
import dk.bilbase.neo4j.dto.SimilarListingDto;
import dk.bilbase.neo4j.service.ListingService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/neo4j")
public class ListingController {

    private final ListingService listingService;

    public ListingController(ListingService listingService) {
        this.listingService = listingService;
    }

    @GetMapping("/listings")
    public List<ListingSummaryDto> getAllListings() {
        return listingService.getAllActiveListings();
    }

    @GetMapping("/listings/{id}")
    public ResponseEntity<ListingDetailDto> getListingById(@PathVariable Long id) {
        return listingService.getListingDetail(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/brands/{name}/listings")
    public List<ListingSummaryDto> getListingsByBrand(@PathVariable String name) {
        return listingService.getListingsByBrand(name);
    }

    @GetMapping("/regions/{name}/listings")
    public List<ListingSummaryDto> getListingsByRegion(@PathVariable String name) {
        return listingService.getListingsByRegion(name);
    }

    @GetMapping("/listings/{id}/similar")
    public List<SimilarListingDto> getSimilarListings(@PathVariable Long id) {
        return listingService.getSimilarListings(id);
    }
}
