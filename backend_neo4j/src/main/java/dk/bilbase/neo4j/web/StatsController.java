package dk.bilbase.neo4j.web;

import dk.bilbase.neo4j.dto.PopularBrandDto;
import dk.bilbase.neo4j.service.StatsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/neo4j/stats")
public class StatsController {

    private final StatsService statsService;

    public StatsController(StatsService statsService) {
        this.statsService = statsService;
    }

    @GetMapping("/popular-brands")
    public List<PopularBrandDto> getPopularBrands() {
        return statsService.getPopularBrands();
    }
}
