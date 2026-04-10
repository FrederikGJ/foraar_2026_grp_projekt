package dk.bilbase.backend.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public record CreateListingRequest(
        @NotNull Long regionId,
        @NotBlank @Size(max = 100) String street,
        @NotBlank @Size(max = 10) String postalCode,
        @NotBlank @Size(max = 50) String city,
        @NotNull Long modelId,
        @NotNull Long fuelTypeId,
        @NotNull @DecimalMin("0.01") BigDecimal price,
        @NotNull @Min(1885) Integer year,
        @NotNull @Min(0) Integer mileageKm,
        @Size(max = 30) String color,
        String description
) {}
