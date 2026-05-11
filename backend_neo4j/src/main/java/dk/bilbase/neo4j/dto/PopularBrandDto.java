package dk.bilbase.neo4j.dto;

public record PopularBrandDto(
        String brandName,
        Long listingCount,
        Long favoriteCount
) {}
