package dk.bilbase.backend.web;

import dk.bilbase.backend.domain.view.ActiveListingView;
import dk.bilbase.backend.dto.CreateListingRequest;
import dk.bilbase.backend.dto.ListingResponse;
import dk.bilbase.backend.dto.UpdateListingRequest;
import dk.bilbase.backend.repository.view.ActiveListingViewRepository;
import dk.bilbase.backend.security.AppUserPrincipal;
import dk.bilbase.backend.service.AiModerationService;
import dk.bilbase.backend.service.ListingService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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

import java.math.BigDecimal;

@RestController
@RequestMapping("/api/listings")
public class ListingController {

    private final ListingService listingService;
    private final ActiveListingViewRepository activeListingRepo;
    private final AiModerationService aiModerationService;

    public ListingController(ListingService listingService,
                             ActiveListingViewRepository activeListingRepo,
                             AiModerationService aiModerationService) {
        this.listingService = listingService;
        this.activeListingRepo = activeListingRepo;
        this.aiModerationService = aiModerationService;
    }

    @GetMapping("/active")
    public Page<ActiveListingView> activeListings(
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        return activeListingRepo.findAll(pageable);
    }

    @GetMapping
    public Page<ListingResponse> findAll(
            @RequestParam(required = false) String brand,
            @RequestParam(required = false) String model,
            @RequestParam(required = false) String fuelType,
            @RequestParam(required = false) Integer yearFrom,
            @RequestParam(required = false) Integer yearTo,
            @RequestParam(required = false) BigDecimal priceFrom,
            @RequestParam(required = false) BigDecimal priceTo,
            @PageableDefault(size = 20, sort = "createdAt", direction = Sort.Direction.DESC) Pageable pageable) {
        return listingService.findAll(brand, model, fuelType, yearFrom, yearTo, priceFrom, priceTo, pageable);
    }

    @GetMapping("/{id}")
    public ListingResponse findById(@PathVariable Long id) {
        return listingService.findById(id);
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('DEALER','ADMIN')")
    @ResponseStatus(HttpStatus.CREATED)
    public ListingResponse create(@Valid @RequestBody CreateListingRequest req,
                                  @AuthenticationPrincipal AppUserPrincipal principal) {
        return listingService.create(req, principal.getId());
    }

    @PutMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    public ListingResponse update(@PathVariable Long id,
                                  @Valid @RequestBody UpdateListingRequest req,
                                  @AuthenticationPrincipal AppUserPrincipal principal) {
        return listingService.update(id, req, principal);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("isAuthenticated()")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id,
                       @AuthenticationPrincipal AppUserPrincipal principal) {
        listingService.delete(id, principal);
    }

    @PostMapping("/{id}/sale")
    @PreAuthorize("hasAnyRole('CUSTOMER','ADMIN')")
    public ListingResponse createSale(@PathVariable Long id,
                                      @AuthenticationPrincipal AppUserPrincipal principal) {
        return listingService.createSale(id, principal.getId());
    }

    @PostMapping("/{id}/moderate")
    @PreAuthorize("hasAnyRole('DEALER','ADMIN')")
    public ListingResponse moderateListing(@PathVariable Long id,
                                           @AuthenticationPrincipal AppUserPrincipal principal) {
        return aiModerationService.moderateListing(id, principal);
    }
}