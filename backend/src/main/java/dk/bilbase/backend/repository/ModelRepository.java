package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.Model;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ModelRepository extends JpaRepository<Model, Long> {

    List<Model> findByBrandId(Long brandId);
}
