package dk.bilbase.neo4j.dto;

public record SimilarListingDto(
        Long listingId,
        String brandName,
        String modelName,
        Double price,
        Integer year,
        String regionName,
        Long commonAttributes
) {}
