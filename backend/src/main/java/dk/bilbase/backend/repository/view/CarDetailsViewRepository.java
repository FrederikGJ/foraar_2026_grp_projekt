package dk.bilbase.backend.repository.view;

import dk.bilbase.backend.domain.view.CarDetailsView;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CarDetailsViewRepository extends JpaRepository<CarDetailsView, Long> {
}
