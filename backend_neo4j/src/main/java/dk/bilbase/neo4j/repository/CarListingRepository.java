package dk.bilbase.neo4j.repository;

import dk.bilbase.neo4j.domain.CarListing;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface CarListingRepository extends Neo4jRepository<CarListing, Long> {
}
