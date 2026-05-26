package dk.bilbase.neo4j.dto;

public record FavoriteDto(
        Long listingId,
        String brandName,
        String modelName,
        Double price,
        Integer year,
        String favoritedAt
) {}
