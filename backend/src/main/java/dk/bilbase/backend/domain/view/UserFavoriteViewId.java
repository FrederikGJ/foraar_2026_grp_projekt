package dk.bilbase.backend.domain.view;

import java.io.Serializable;
import java.util.Objects;

public class UserFavoriteViewId implements Serializable {

    private Long userId;
    private Long listingId;

    public UserFavoriteViewId() {}

    public UserFavoriteViewId(Long userId, Long listingId) {
        this.userId = userId;
        this.listingId = listingId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof UserFavoriteViewId that)) return false;
        return Objects.equals(userId, that.userId) && Objects.equals(listingId, that.listingId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, listingId);
    }
}
