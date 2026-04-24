package dk.bilbase.backend.web;

import dk.bilbase.backend.dto.CreateFavoriteRequest;
import dk.bilbase.backend.dto.FavoriteResponse;
import dk.bilbase.backend.security.AppUserPrincipal;
import dk.bilbase.backend.service.FavoriteService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/favorites")
@PreAuthorize("isAuthenticated()")
public class FavoriteController {

    private final FavoriteService favoriteService;

    public FavoriteController(FavoriteService favoriteService) {
        this.favoriteService = favoriteService;
    }

    @GetMapping
    public List<FavoriteResponse> getFavorites(@AuthenticationPrincipal AppUserPrincipal principal) {
        return favoriteService.getFavorites(principal.getId());
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public FavoriteResponse addFavorite(@Valid @RequestBody CreateFavoriteRequest req,
                                        @AuthenticationPrincipal AppUserPrincipal principal) {
        return favoriteService.addFavorite(principal.getId(), req);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removeFavorite(@PathVariable Long id,
                               @AuthenticationPrincipal AppUserPrincipal principal) {
        favoriteService.removeFavorite(id, principal.getId());
    }
}
