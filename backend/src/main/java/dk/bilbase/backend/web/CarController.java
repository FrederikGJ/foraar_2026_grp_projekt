package dk.bilbase.backend.web;

import dk.bilbase.backend.domain.view.CarDetailsView;
import dk.bilbase.backend.repository.view.CarDetailsViewRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/cars")
public class CarController {

    private final CarDetailsViewRepository carDetailsRepo;

    public CarController(CarDetailsViewRepository carDetailsRepo) {
        this.carDetailsRepo = carDetailsRepo;
    }

    @GetMapping
    public Page<CarDetailsView> findAll(@PageableDefault(size = 20) Pageable pageable) {
        return carDetailsRepo.findAll(pageable);
    }
}
