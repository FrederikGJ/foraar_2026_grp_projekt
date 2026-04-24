package dk.bilbase.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record SendMessageRequest(
        @NotNull Long carListingId,
        @NotBlank String content
) {}
