package org.backend.dto;

public record UpdateListingRequest(
        Double price,
        String description,
        String color,
        Integer mileageKm,

        // Address fields
        String street,
        String postalCode,
        String city,
        String region
) {}
