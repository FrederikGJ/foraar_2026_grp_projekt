package dk.bilbase.backend.web;

import dk.bilbase.backend.TestContainerConfig;
import dk.bilbase.backend.domain.Address;
import dk.bilbase.backend.domain.AppUser;
import dk.bilbase.backend.domain.Car;
import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.domain.CarSale;
import dk.bilbase.backend.domain.Favorite;
import dk.bilbase.backend.domain.Message;
import dk.bilbase.backend.repository.AddressRepository;
import dk.bilbase.backend.repository.AppUserRepository;
import dk.bilbase.backend.repository.CarListingRepository;
import dk.bilbase.backend.repository.CarRepository;
import dk.bilbase.backend.repository.CarSaleRepository;
import dk.bilbase.backend.repository.FavoriteRepository;
import dk.bilbase.backend.repository.FuelTypeRepository;
import dk.bilbase.backend.repository.MessageRepository;
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
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
@Import(TestContainerConfig.class)
@ActiveProfiles("test")
class TriggerViolationTest {

    @Autowired private RoleRepository roleRepo;
    @Autowired private RegionRepository regionRepo;
    @Autowired private AppUserRepository userRepo;
    @Autowired private ModelRepository modelRepo;
    @Autowired private FuelTypeRepository fuelTypeRepo;
    @Autowired private AddressRepository addressRepo;
    @Autowired private CarRepository carRepo;
    @Autowired private CarListingRepository listingRepo;
    @Autowired private CarSaleRepository saleRepo;
    @Autowired private FavoriteRepository favoriteRepo;
    @Autowired private MessageRepository messageRepo;

    @Test
    void favoriteOnSoldListingThrowsDataIntegrityViolation() {
        // Create seller + buyer
        var dealerRole = roleRepo.findByName("DEALER").orElseThrow();
        var customerRole = roleRepo.findByName("CUSTOMER").orElseThrow();
        var region = regionRepo.findById(1L).orElseThrow();

        var seller = userRepo.save(new AppUser("trig_seller", "trig_seller@ex.com",
                "$2a$10$dummy", "S", "E", null, dealerRole));
        var buyer = userRepo.save(new AppUser("trig_buyer", "trig_buyer@ex.com",
                "$2a$10$dummy", "B", "U", null, customerRole));

        var model = modelRepo.findById(1L).orElseThrow();
        var fuelType = fuelTypeRepo.findById(1L).orElseThrow();
        var address = addressRepo.save(new Address("Testvej 1", "2100", "KBH", region));
        var car = carRepo.save(new Car(model, fuelType, BigDecimal.valueOf(100000), 2020, 50000, "Red"));
        var listing = listingRepo.save(new CarListing(car, seller, address, "Test"));

        // Sell the listing
        saleRepo.save(new CarSale(listing, buyer));

        // Favorite on sold listing should trigger SIGNAL SQLSTATE 45000
        assertThrows(DataIntegrityViolationException.class, () -> {
            favoriteRepo.save(new Favorite(buyer, listing));
            favoriteRepo.flush();
        });
    }

    @Test
    void messageToSelfThrowsDataIntegrityViolation() {
        var dealerRole = roleRepo.findByName("DEALER").orElseThrow();
        var region = regionRepo.findById(1L).orElseThrow();

        var user = userRepo.save(new AppUser("trig_self", "trig_self@ex.com",
                "$2a$10$dummy", "S", "E", null, dealerRole));

        var model = modelRepo.findById(1L).orElseThrow();
        var fuelType = fuelTypeRepo.findById(1L).orElseThrow();
        var address = addressRepo.save(new Address("Selvvej 1", "2100", "KBH", region));
        var car = carRepo.save(new Car(model, fuelType, BigDecimal.valueOf(50000), 2021, 30000, "Blue"));
        var listing = listingRepo.save(new CarListing(car, user, address, "Self"));

        // Message to self should trigger SIGNAL SQLSTATE 45000
        assertThrows(DataIntegrityViolationException.class, () -> {
            messageRepo.save(new Message(user, user, listing, "Hello myself"));
            messageRepo.flush();
        });
    }

    @Test
    void carWithInvalidYearThrowsDataIntegrityViolation() {
        var model = modelRepo.findById(1L).orElseThrow();
        var fuelType = fuelTypeRepo.findById(1L).orElseThrow();

        // Year 1800 should trigger SIGNAL SQLSTATE 45000
        assertThrows(DataIntegrityViolationException.class, () -> {
            carRepo.save(new Car(model, fuelType, BigDecimal.valueOf(10000), 1800, 0, "Old"));
            carRepo.flush();
        });
    }
}
