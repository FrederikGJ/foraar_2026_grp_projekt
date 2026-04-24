package dk.bilbase.backend.dto;

import jakarta.validation.constraints.NotNull;

public record CreateFavoriteRequest(@NotNull Long carListingId) {}
