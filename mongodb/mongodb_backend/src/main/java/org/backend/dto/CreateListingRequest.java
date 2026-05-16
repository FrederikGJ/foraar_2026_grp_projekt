package org.backend.dto;

public record CreateListingRequest(
        String sellerId,

        // Car details
        String brand,
        String model,
        String fuelType,
        int    year,
        int    mileageKm,
        String color,
        double price,

        // Address
        String street,
        String postalCode,
        String city,
        String region,

        String description
) {}
