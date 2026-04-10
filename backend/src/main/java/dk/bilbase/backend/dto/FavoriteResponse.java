package dk.bilbase.backend.dto;

import dk.bilbase.backend.domain.Favorite;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record FavoriteResponse(
        Long id,
        Long carListingId,
        String brand,
        String model,
        BigDecimal price,
        LocalDateTime createdAt
) {
    public static FavoriteResponse from(Favorite fav) {
        return new FavoriteResponse(
                fav.getId(),
                fav.getCarListing().getId(),
                fav.getCarListing().getCar().getModel().getBrand().getName(),
                fav.getCarListing().getCar().getModel().getName(),
                fav.getCarListing().getCar().getPrice(),
                fav.getCreatedAt()
        );
    }
}
