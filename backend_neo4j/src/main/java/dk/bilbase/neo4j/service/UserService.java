package dk.bilbase.neo4j.service;

import dk.bilbase.neo4j.dto.FavoriteDto;
import dk.bilbase.neo4j.dto.MessageDto;
import dk.bilbase.neo4j.dto.RecommendationDto;
import org.neo4j.driver.types.MapAccessor;
import org.springframework.data.neo4j.core.Neo4jClient;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Service
public class UserService {

    private final Neo4jClient neo4jClient;

    public UserService(Neo4jClient neo4jClient) {
        this.neo4jClient = neo4jClient;
    }

    public List<FavoriteDto> getFavorites(Long userId) {
        Collection<FavoriteDto> results = neo4jClient
                .query("""
                    MATCH (u:User {id: $userId})-[f:FAVORITED]->(l:CarListing)-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand)
                    RETURN l.id AS listingId, b.name AS brandName, m.name AS modelName,
                           c.price AS price, c.year AS year, f.createdAt AS favoritedAt
                    ORDER BY f.createdAt DESC
                """)
                .bind(userId).to("userId")
                .fetchAs(FavoriteDto.class)
                .mappedBy((typeSystem, record) -> new FavoriteDto(
                        record.get("listingId").asLong(),
                        record.get("brandName").asString(null),
                        record.get("modelName").asString(null),
                        toDouble(record, "price"),
                        toInt(record, "year"),
                        record.get("favoritedAt").asString(null)
                ))
                .all();
        return List.copyOf(results);
    }

    public List<MessageDto> getMessages(Long userId) {
        Collection<MessageDto> results = neo4jClient
                .query("""
                    MATCH (msg:Message)-[:SENT_BY]->(sender:User),
                          (msg)-[:RECEIVED_BY]->(receiver:User),
                          (msg)-[:ABOUT_LISTING]->(l:CarListing)
                    WHERE sender.id = $userId OR receiver.id = $userId
                    RETURN msg.id AS messageId, msg.content AS content, msg.sentAt AS sentAt,
                           sender.username AS senderUsername, receiver.username AS receiverUsername,
                           l.id AS listingId
                    ORDER BY msg.sentAt DESC
                """)
                .bind(userId).to("userId")
                .fetchAs(MessageDto.class)
                .mappedBy((typeSystem, record) -> new MessageDto(
                        record.get("messageId").asLong(),
                        record.get("content").asString(null),
                        record.get("sentAt").asString(null),
                        record.get("senderUsername").asString(null),
                        record.get("receiverUsername").asString(null),
                        record.get("listingId").asLong()
                ))
                .all();
        return List.copyOf(results);
    }

    public List<RecommendationDto> getRecommendations(Long userId) {
        Collection<RecommendationDto> results = neo4jClient
                .query("""
                    MATCH (u:User {id: $userId})-[:FAVORITED]->(l:CarListing)<-[:FAVORITED]-(other:User)-[:FAVORITED]->(rec:CarListing)
                    WHERE NOT (u)-[:FAVORITED]->(rec)
                          AND rec <> l
                          AND NOT EXISTS { MATCH (s:Sale)-[:SALE_OF]->(rec) }
                    WITH rec, count(DISTINCT other) AS score
                    MATCH (rec)-[:LISTS_CAR]->(c:Car)-[:IS_MODEL]->(m:Model)-[:MADE_BY]->(b:Brand)
                    RETURN rec.id AS listingId, b.name AS brandName, m.name AS modelName,
                           c.price AS price, c.year AS year, score
                    ORDER BY score DESC, c.price ASC
                    LIMIT 10
                """)
                .bind(userId).to("userId")
                .fetchAs(RecommendationDto.class)
                .mappedBy((typeSystem, record) -> new RecommendationDto(
                        record.get("listingId").asLong(),
                        record.get("brandName").asString(null),
                        record.get("modelName").asString(null),
                        toDouble(record, "price"),
                        toInt(record, "year"),
                        record.get("score").asLong()
                ))
                .all();
        return List.copyOf(results);
    }

    private Double toDouble(MapAccessor record, String key) {
        return record.get(key).isNull() ? null : record.get(key).asDouble();
    }

    private Integer toInt(MapAccessor record, String key) {
        return record.get(key).isNull() ? null : record.get(key).asInt();
    }
}
