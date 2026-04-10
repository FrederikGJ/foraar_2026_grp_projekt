package dk.bilbase.backend.web;

import dk.bilbase.backend.TestContainerConfig;
import dk.bilbase.backend.domain.Address;
import dk.bilbase.backend.domain.AppUser;
import dk.bilbase.backend.domain.Car;
import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.domain.CarSale;
import dk.bilbase.backend.repository.AddressRepository;
import dk.bilbase.backend.repository.AppUserRepository;
import dk.bilbase.backend.repository.CarListingRepository;
import dk.bilbase.backend.repository.CarRepository;
import dk.bilbase.backend.repository.CarSaleRepository;
import dk.bilbase.backend.repository.FuelTypeRepository;
import dk.bilbase.backend.repository.ModelRepository;
import dk.bilbase.backend.repository.RegionRepository;
import dk.bilbase.backend.repository.RoleRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.test.context.ActiveProfiles;

import java.math.BigDecimal;

import static org.junit.jupiter.api.Assertions.assertThrows;

@SpringBootTest
@Import(TestContainerConfig.class)
@ActiveProfiles("test")
class FkRestrictTest {

    @Autowired private RoleRepository roleRepo;
    @Autowired private RegionRepository regionRepo;
    @Autowired private AppUserRepository userRepo;
    @Autowired private ModelRepository modelRepo;
    @Autowired private FuelTypeRepository fuelTypeRepo;
    @Autowired private AddressRepository addressRepo;
    @Autowired private CarRepository carRepo;
    @Autowired private CarListingRepository listingRepo;
    @Autowired private CarSaleRepository saleRepo;

    @Test
    void deleteListingWithSaleThrowsDataIntegrityViolation() {
        var dealerRole = roleRepo.findByName("DEALER").orElseThrow();
        var customerRole = roleRepo.findByName("CUSTOMER").orElseThrow();
        var region = regionRepo.findById(1L).orElseThrow();

        var seller = userRepo.save(new AppUser("fk_seller", "fk_seller@ex.com",
                "$2a$10$dummy", "S", "E", null, dealerRole));
        var buyer = userRepo.save(new AppUser("fk_buyer", "fk_buyer@ex.com",
                "$2a$10$dummy", "B", "U", null, customerRole));

        var model = modelRepo.findById(1L).orElseThrow();
        var fuelType = fuelTypeRepo.findById(1L).orElseThrow();
        var address = addressRepo.save(new Address("FKvej 1", "2100", "KBH", region));
        var car = carRepo.save(new Car(model, fuelType, BigDecimal.valueOf(200000), 2022, 10000, "White"));
        var listing = listingRepo.save(new CarListing(car, seller, address, "FK test"));

        // Create sale
        saleRepo.save(new CarSale(listing, buyer));

        // Delete listing should fail due to FK ON DELETE RESTRICT
        assertThrows(DataIntegrityViolationException.class, () -> {
            listingRepo.delete(listing);
            listingRepo.flush();
        });
    }
}
