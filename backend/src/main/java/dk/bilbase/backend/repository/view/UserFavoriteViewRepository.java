package dk.bilbase.backend.repository.view;

import dk.bilbase.backend.domain.view.UserFavoriteView;
import dk.bilbase.backend.domain.view.UserFavoriteViewId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserFavoriteViewRepository extends JpaRepository<UserFavoriteView, UserFavoriteViewId> {

    List<UserFavoriteView> findByUserId(Long userId);
}
