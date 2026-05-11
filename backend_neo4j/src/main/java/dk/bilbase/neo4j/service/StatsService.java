package dk.bilbase.neo4j.service;

import dk.bilbase.neo4j.dto.PopularBrandDto;
import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Service
public class StatsService {

    private final Neo4jClient neo4jClient;

    public StatsService(Neo4jClient neo4jClient) {
        this.neo4jClient = neo4jClient;
    }

    public List<PopularBrandDto> getPopularBrands() {
        Collection<PopularBrandDto> results = neo4jClient
                .query("""
                    MATCH (b:Brand)<-[:MADE_BY]-(m:Model)<-[:IS_MODEL]-(c:Car)<-[:LISTS_CAR]-(l:CarListing)
                    OPTIONAL MATCH (l)<-[f:FAVORITED]-()
                    WITH b, count(DISTINCT l) AS listingCount, count(DISTINCT f) AS favoriteCount
                    RETURN b.name AS brandName, listingCount, favoriteCount
                    ORDER BY favoriteCount DESC, listingCount DESC
                """)
                .fetchAs(PopularBrandDto.class)
                .mappedBy((typeSystem, record) -> new PopularBrandDto(
                        record.get("brandName").asString(null),
                        record.get("listingCount").asLong(),
                        record.get("favoriteCount").asLong()
                ))
                .all();
        return List.copyOf(results);
    }
}
