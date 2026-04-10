package dk.bilbase.backend.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public record UpdateListingRequest(
        @DecimalMin("0.01") BigDecimal price,
        @Min(0) Integer mileageKm,
        @Size(max = 30) String color,
        String description
) {}
