package dk.bilbase.backend.service;

import dk.bilbase.backend.domain.AppUser;
import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.domain.Favorite;
import dk.bilbase.backend.dto.CreateFavoriteRequest;
import dk.bilbase.backend.dto.FavoriteResponse;
import dk.bilbase.backend.repository.AppUserRepository;
import dk.bilbase.backend.repository.CarListingRepository;
import dk.bilbase.backend.repository.FavoriteRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class FavoriteService {

    private final FavoriteRepository favoriteRepo;
    private final CarListingRepository listingRepo;
    private final AppUserRepository userRepo;

    public FavoriteService(FavoriteRepository favoriteRepo,
                           CarListingRepository listingRepo,
                           AppUserRepository userRepo) {
        this.favoriteRepo = favoriteRepo;
        this.listingRepo = listingRepo;
        this.userRepo = userRepo;
    }

    public List<FavoriteResponse> getFavorites(Long userId) {
        return favoriteRepo.findByUserId(userId).stream()
                .map(FavoriteResponse::from)
                .toList();
    }

    @Transactional
    public FavoriteResponse addFavorite(Long userId, CreateFavoriteRequest req) {
        CarListing listing = listingRepo.findById(req.carListingId())
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + req.carListingId()));

        AppUser user = userRepo.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found: " + userId));

        // DB trigger validates listing not sold — DataIntegrityViolation → 400 via GlobalExceptionHandler
        Favorite fav = favoriteRepo.save(new Favorite(user, listing));
        return FavoriteResponse.from(fav);
    }

    @Transactional
    public void removeFavorite(Long favoriteId, Long userId) {
        Favorite fav = favoriteRepo.findById(favoriteId)
                .orElseThrow(() -> new EntityNotFoundException("Favorite not found: " + favoriteId));

        if (!fav.getUser().getId().equals(userId)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Not your favorite");
        }

        favoriteRepo.delete(fav);
    }
}
