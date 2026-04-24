package dk.bilbase.backend.repository;

import dk.bilbase.backend.domain.view.CarListingAudit;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AuditRepository extends JpaRepository<CarListingAudit, Long> {

    List<CarListingAudit> findByListingIdOrderByChangedAtDesc(Long listingId);

    Page<CarListingAudit> findAllByOrderByChangedAtDesc(Pageable pageable);
}
