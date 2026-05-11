package dk.bilbase.neo4j.dto;

public record ListingDetailDto(
        Long listingId,
        String description,
        String createdAt,
        String brandName,
        String modelName,
        Double price,
        Integer year,
        Integer mileage,
        String color,
        String fuelType,
        String sellerUsername,
        String sellerEmail,
        String street,
        String city,
        String postalCode,
        String regionName
) {}
