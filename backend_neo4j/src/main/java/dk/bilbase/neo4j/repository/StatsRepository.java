package dk.bilbase.neo4j.repository;

import dk.bilbase.neo4j.domain.Brand;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface StatsRepository extends Neo4jRepository<Brand, Long> {
}
