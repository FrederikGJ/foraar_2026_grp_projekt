package dk.bilbase.neo4j.dto;

public record ListingSummaryDto(
        Long listingId,
        String description,
        String createdAt,
        String brandName,
        String modelName,
        Double price,
        Integer year,
        String sellerUsername
) {}
