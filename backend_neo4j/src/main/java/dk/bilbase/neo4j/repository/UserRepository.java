package dk.bilbase.neo4j.repository;

import dk.bilbase.neo4j.domain.User;
import org.springframework.data.neo4j.repository.Neo4jRepository;

public interface UserRepository extends Neo4jRepository<User, Long> {
}
