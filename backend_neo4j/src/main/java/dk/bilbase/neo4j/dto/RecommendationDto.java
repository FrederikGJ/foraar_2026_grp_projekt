package dk.bilbase.neo4j.dto;

public record RecommendationDto(
        Long listingId,
        String brandName,
        String modelName,
        Double price,
        Integer year,
        Long score
) {}
