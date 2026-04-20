package dk.bilbase.backend.service.ai;

import dk.bilbase.backend.domain.CarListing;

public interface AiModerationClient {
    AiModerationResult moderateListing(CarListing listing);
}