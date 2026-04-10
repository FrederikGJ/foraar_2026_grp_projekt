package dk.bilbase.backend.service;

import dk.bilbase.backend.domain.Address;
import dk.bilbase.backend.domain.AppUser;
import dk.bilbase.backend.domain.Car;
import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.domain.CarSale;
import dk.bilbase.backend.domain.FuelType;
import dk.bilbase.backend.domain.Model;
import dk.bilbase.backend.domain.Region;
import dk.bilbase.backend.dto.CreateListingRequest;
import dk.bilbase.backend.dto.ListingResponse;
import dk.bilbase.backend.dto.UpdateListingRequest;
import dk.bilbase.backend.repository.AddressRepository;
import dk.bilbase.backend.repository.AppUserRepository;
import dk.bilbase.backend.repository.CarListingRepository;
import dk.bilbase.backend.repository.CarRepository;
import dk.bilbase.backend.repository.CarSaleRepository;
import dk.bilbase.backend.repository.FuelTypeRepository;
import dk.bilbase.backend.repository.ModelRepository;
import dk.bilbase.backend.repository.RegionRepository;
import dk.bilbase.backend.security.AppUserPrincipal;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;

@Service
public class ListingService {

    @PersistenceContext
    private EntityManager entityManager;

    private final CarListingRepository listingRepo;
    private final CarRepository carRepo;
    private final AddressRepository addressRepo;
    private final CarSaleRepository saleRepo;
    private final AppUserRepository userRepo;
    private final RegionRepository regionRepo;
    private final ModelRepository modelRepo;
    private final FuelTypeRepository fuelTypeRepo;

    public ListingService(CarListingRepository listingRepo,
                          CarRepository carRepo,
                          AddressRepository addressRepo,
                          CarSaleRepository saleRepo,
                          AppUserRepository userRepo,
                          RegionRepository regionRepo,
                          ModelRepository modelRepo,
                          FuelTypeRepository fuelTypeRepo) {
        this.listingRepo = listingRepo;
        this.carRepo = carRepo;
        this.addressRepo = addressRepo;
        this.saleRepo = saleRepo;
        this.userRepo = userRepo;
        this.regionRepo = regionRepo;
        this.modelRepo = modelRepo;
        this.fuelTypeRepo = fuelTypeRepo;
    }

    @Transactional(readOnly = true)
    public Page<ListingResponse> findAll(String brand, String model, String fuelType,
                                         Integer yearFrom, Integer yearTo,
                                         BigDecimal priceFrom, BigDecimal priceTo,
                                         Pageable pageable) {
        Specification<CarListing> spec = Specification.where(null);

        if (brand != null)     spec = spec.and(ListingSpecifications.hasBrand(brand));
        if (model != null)     spec = spec.and(ListingSpecifications.hasModel(model));
        if (fuelType != null)  spec = spec.and(ListingSpecifications.hasFuelType(fuelType));
        if (yearFrom != null)  spec = spec.and(ListingSpecifications.yearFrom(yearFrom));
        if (yearTo != null)    spec = spec.and(ListingSpecifications.yearTo(yearTo));
        if (priceFrom != null) spec = spec.and(ListingSpecifications.priceFrom(priceFrom));
        if (priceTo != null)   spec = spec.and(ListingSpecifications.priceTo(priceTo));

        return listingRepo.findAll(spec, pageable).map(ListingResponse::from);
    }

    @Transactional(readOnly = true)
    public ListingResponse findById(Long id) {
        CarListing listing = listingRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + id));
        return ListingResponse.from(listing);
    }

    @Transactional
    public ListingResponse create(CreateListingRequest req, Long sellerId) {
        Region region = regionRepo.findById(req.regionId())
                .orElseThrow(() -> new EntityNotFoundException("Region not found: " + req.regionId()));
        Model model = modelRepo.findById(req.modelId())
                .orElseThrow(() -> new EntityNotFoundException("Model not found: " + req.modelId()));
        FuelType fuelType = fuelTypeRepo.findById(req.fuelTypeId())
                .orElseThrow(() -> new EntityNotFoundException("FuelType not found: " + req.fuelTypeId()));
        AppUser seller = userRepo.findById(sellerId)
                .orElseThrow(() -> new EntityNotFoundException("User not found: " + sellerId));

        Address address = addressRepo.save(new Address(req.street(), req.postalCode(), req.city(), region));
        Car car = carRepo.save(new Car(model, fuelType, req.price(), req.year(), req.mileageKm(), req.color()));
        CarListing listing = listingRepo.save(new CarListing(car, seller, address, req.description()));

        return ListingResponse.from(listing);
    }

    @Transactional
    public ListingResponse update(Long id, UpdateListingRequest req, AppUserPrincipal principal) {
        CarListing listing = listingRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + id));

        checkOwnership(listing, principal);

        Car car = listing.getCar();
        if (req.price() != null)     car.setPrice(req.price());
        if (req.mileageKm() != null) car.setMileageKm(req.mileageKm());
        if (req.color() != null)     car.setColor(req.color());
        if (req.description() != null) listing.setDescription(req.description());

        carRepo.save(car);
        return ListingResponse.from(listingRepo.save(listing));
    }

    @Transactional
    public void delete(Long id, AppUserPrincipal principal) {
        CarListing listing = listingRepo.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + id));

        checkOwnership(listing, principal);

        if (saleRepo.existsByCarListingId(id)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT,
                    "Cannot delete listing — a sale record exists");
        }

        Car car = listing.getCar();
        Address address = listing.getAddress();
        listingRepo.delete(listing);
        carRepo.delete(car);
        addressRepo.delete(address);
    }

    @Transactional
    public ListingResponse createSale(Long listingId, Long buyerId) {
        CarListing listing = listingRepo.findById(listingId)
                .orElseThrow(() -> new EntityNotFoundException("Listing not found: " + listingId));

        if (listing.isSold()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "Listing is already sold");
        }

        if (listing.getSeller().getId().equals(buyerId)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Seller cannot buy own listing");
        }

        AppUser buyer = userRepo.findById(buyerId)
                .orElseThrow(() -> new EntityNotFoundException("User not found: " + buyerId));

        saleRepo.save(new CarSale(listing, buyer));

        // Refresh to pick up the new sale — first-level cache has listing with sale=null
        entityManager.refresh(listing);
        return ListingResponse.from(listing);
    }

    private void checkOwnership(CarListing listing, AppUserPrincipal principal) {
        boolean isOwner = listing.getSeller().getId().equals(principal.getId());
        boolean isAdmin = "ADMIN".equals(principal.getRoleName());
        if (!isOwner && !isAdmin) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Not owner of this listing");
        }
    }
}
