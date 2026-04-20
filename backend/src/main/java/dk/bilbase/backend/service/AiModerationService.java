package dk.bilbase.backend.service;


import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.dto.ListingResponse;
import dk.bilbase.backend.repository.CarListingRepository;
import dk.bilbase.backend.security.AppUserPrincipal;
import dk.bilbase.backend.service.ai.AiModerationClient;
import dk.bilbase.backend.service.ai.AiModerationResult;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;

@Service
public class AiModerationService {

    private final CarListingRepository listingRepo;
    private final AiModerationClient aiModerationClient;

    public AiModerationService(CarListingRepository listingRepo,
                               AiModerationClient aiModerationClient) {
        this.listingRepo = listingRepo;
        this.aiModerationClient = aiModerationClient;
    }

    @Transactional
    public ListingResponse moderateListing(Long listingId, AppUserPrincipal principal) {
        CarListing listing = listingRepo.findById(listingId)
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + listingId));

        boolean isOwner = listing.getSeller().getId().equals(principal.getId());
        boolean isAdmin = "ADMIN".equals(principal.getRoleName());

        if (!isOwner && !isAdmin) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Not owner of this listing");
        }

        AiModerationResult result = aiModerationClient.moderateListing(listing);

        listing.setAiFlagged(result.flagged());
        listing.setAiCategory(result.category());
        listing.setAiModerationNote(result.note());
        listing.setAiCheckedAt(LocalDateTime.now());

        listing = listingRepo.save(listing);

        return ListingResponse.from(listing);
    }
}