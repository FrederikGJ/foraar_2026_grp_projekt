package dk.bilbase.neo4j.web;

import dk.bilbase.neo4j.dto.FavoriteDto;
import dk.bilbase.neo4j.dto.MessageDto;
import dk.bilbase.neo4j.dto.RecommendationDto;
import dk.bilbase.neo4j.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/neo4j/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/{id}/favorites")
    public List<FavoriteDto> getFavorites(@PathVariable Long id) {
        return userService.getFavorites(id);
    }

    @GetMapping("/{id}/messages")
    public List<MessageDto> getMessages(@PathVariable Long id) {
        return userService.getMessages(id);
    }

    @GetMapping("/{id}/recommendations")
    public List<RecommendationDto> getRecommendations(@PathVariable Long id) {
        return userService.getRecommendations(id);
    }
}
