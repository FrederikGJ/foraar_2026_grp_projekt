package dk.bilbase.backend.repository.view;

import dk.bilbase.backend.domain.view.ActiveListingView;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ActiveListingViewRepository extends JpaRepository<ActiveListingView, Long> {

    Page<ActiveListingView> findAll(Pageable pageable);
}
