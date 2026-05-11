package dk.bilbase.neo4j.service;

import dk.bilbase.neo4j.dto.ListingDetailDto;
import dk.bilbase.neo4j.dto.ListingSummaryDto;
import dk.bilbase.neo4j.dto.SimilarListingDto;
import org.neo4j.driver.types.MapAccessor;
import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Optional;

@Service
public class ListingService {

    private final Neo4jClient neo4jClient;

    public ListingService(Neo4jClient neo4jClient) {
        this.neo4jClient = neo4jClient;
    }

    public List<ListingSummaryDto> getAllActiveListings() {
        Collection<ListingSummaryDto> results = neo4jClient
                .query("""
                    MATCH (l:CarListing)-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand),
                          (l)-[:POSTED_BY]->(u:User)
                    WHERE NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(l) }
                    RETURN l.id AS listingId, l.description AS description, l.createdAt AS createdAt,
                           b.name AS brandName, m.name AS modelName, c.price AS price,
                           c.year AS year, u.username AS sellerUsername
                    ORDER BY l.createdAt DESC
                """)
                .fetchAs(ListingSummaryDto.class)
                .mappedBy((typeSystem, record) -> new ListingSummaryDto(
                        record.get("listingId").asLong(),
                        record.get("description").asString(null),
                        record.get("createdAt").asString(null),
                        record.get("brandName").asString(null),
                        record.get("modelName").asString(null),
                        toDouble(record, "price"),
                        toInt(record, "year"),
                        record.get("sellerUsername").asString(null)
                ))
                .all();
        return List.copyOf(results);
    }

    public Optional<ListingDetailDto> getListingDetail(Long id) {
        return neo4jClient
                .query("""
                    MATCH (l:CarListing {id: $id})-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand),
                          (l)-[:POSTED_BY]->(u:User),
                          (l)-[:LOCATED_AT]->(a:Address)-[:IN_REGION]->(r:Region),
                          (c)-[:USES_FUEL]->(f:FuelType)
                    RETURN l.id AS listingId, l.description AS description, l.createdAt AS createdAt,
                           b.name AS brandName, m.name AS modelName,
                           c.price AS price, c.year AS year, c.mileage AS mileage, c.color AS color,
                           f.name AS fuelType,
                           u.username AS sellerUsername, u.email AS sellerEmail,
                           a.street AS street, a.city AS city, a.postalCode AS postalCode,
                           r.name AS regionName
                """)
                .bind(id).to("id")
                .fetchAs(ListingDetailDto.class)
                .mappedBy((typeSystem, record) -> new ListingDetailDto(
                        record.get("listingId").asLong(),
                        record.get("description").asString(null),
                        record.get("createdAt").asString(null),
                        record.get("brandName").asString(null),
                        record.get("modelName").asString(null),
                        toDouble(record, "price"),
                        toInt(record, "year"),
                        toInt(record, "mileage"),
                        record.get("color").asString(null),
                        record.get("fuelType").asString(null),
                        record.get("sellerUsername").asString(null),
                        record.get("sellerEmail").asString(null),
                        record.get("street").asString(null),
                        record.get("city").asString(null),
                        record.get("postalCode").asString(null),
                        record.get("regionName").asString(null)
                ))
                .one();
    }

    public List<ListingSummaryDto> getListingsByBrand(String brandName) {
        Collection<ListingSummaryDto> results = neo4jClient
                .query("""
                    MATCH (b:Brand {name: $brandName})<-[:MADE_BY]-(m:Model)<-[:IS_MODEL]-(c:Car)<-[:LISTS_CAR]-(l:CarListing)-[:POSTED_BY]->(u:User)
                    WHERE NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(l) }
                    RETURN l.id AS listingId, l.description AS description, l.createdAt AS createdAt,
                           b.name AS brandName, m.name AS modelName, c.price AS price,
                           c.year AS year, u.username AS sellerUsername
                    ORDER BY c.price ASC
                """)
                .bind(brandName).to("brandName")
                .fetchAs(ListingSummaryDto.class)
                .mappedBy((typeSystem, record) -> toSummaryDto(record))
                .all();
        return List.copyOf(results);
    }

    public List<ListingSummaryDto> getListingsByRegion(String regionName) {
        Collection<ListingSummaryDto> results = neo4jClient
                .query("""
                    MATCH (r:Region {name: $regionName})<-[:IN_REGION]-(a:Address)<-[:LOCATED_AT]-(l:CarListing)-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand),
                          (l)-[:POSTED_BY]->(u:User)
                    WHERE NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(l) }
                    RETURN l.id AS listingId, l.description AS description, l.createdAt AS createdAt,
                           b.name AS brandName, m.name AS modelName, c.price AS price,
                           c.year AS year, u.username AS sellerUsername
                    ORDER BY l.createdAt DESC
                """)
                .bind(regionName).to("regionName")
                .fetchAs(ListingSummaryDto.class)
                .mappedBy((typeSystem, record) -> toSummaryDto(record))
                .all();
        return List.copyOf(results);
    }

    public List<SimilarListingDto> getSimilarListings(Long id) {
        Collection<SimilarListingDto> results = neo4jClient
                .query("""
                    MATCH (l:CarListing {id: $id})-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand),
                          (l)-[:LOCATED_AT]->(a:Address)-[:IN_REGION]->(r:Region)
                    WITH l, b, m, r
                    MATCH (other:CarListing)-[:LISTS_CAR]->(oc:Car)-[:IS_MODEL]->(om:Model)-[:MADE_BY]->(ob:Brand),
                          (other)-[:LOCATED_AT]->(oa:Address)-[:IN_REGION]->(oRegion:Region)
                    WHERE other.id <> l.id
                          AND NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(other) }
                          AND (ob = b OR om = m OR oRegion = r)
                    WITH other, oc, om, ob, oRegion,
                         CASE WHEN ob = b THEN 1 ELSE 0 END +
                         CASE WHEN om = m THEN 1 ELSE 0 END +
                         CASE WHEN oRegion = r THEN 1 ELSE 0 END AS commonAttributes
                    RETURN other.id AS listingId, ob.name AS brandName, om.name AS modelName,
                           oc.price AS price, oc.year AS year, oRegion.name AS regionName,
                           commonAttributes
                    ORDER BY commonAttributes DESC, oc.price ASC
                    LIMIT 10
                """)
                .bind(id).to("id")
                .fetchAs(SimilarListingDto.class)
                .mappedBy((typeSystem, record) -> new SimilarListingDto(
                        record.get("listingId").asLong(),
                        record.get("brandName").asString(null),
                        record.get("modelName").asString(null),
                        toDouble(record, "price"),
                        toInt(record, "year"),
                        record.get("regionName").asString(null),
                        record.get("commonAttributes").asLong()
                ))
                .all();
        return List.copyOf(results);
    }

    private ListingSummaryDto toSummaryDto(MapAccessor record) {
        return new ListingSummaryDto(
                record.get("listingId").asLong(),
                record.get("description").asString(null),
                record.get("createdAt").asString(null),
                record.get("brandName").asString(null),
                record.get("modelName").asString(null),
                toDouble(record, "price"),
                toInt(record, "year"),
                record.get("sellerUsername").asString(null)
        );
    }

    private Double toDouble(MapAccessor record, String key) {
        return record.get(key).isNull() ? null : record.get(key).asDouble();
    }

    private Integer toInt(MapAccessor record, String key) {
        return record.get(key).isNull() ? null : record.get(key).asInt();
    }
}
