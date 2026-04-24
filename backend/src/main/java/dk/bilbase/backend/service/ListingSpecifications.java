package dk.bilbase.backend.service;

import dk.bilbase.backend.domain.Car;
import dk.bilbase.backend.domain.CarListing;
import dk.bilbase.backend.domain.CarSale;
import jakarta.persistence.criteria.Join;
import jakarta.persistence.criteria.Root;
import jakarta.persistence.criteria.Subquery;
import org.springframework.data.jpa.domain.Specification;

import java.math.BigDecimal;

public final class ListingSpecifications {

    private ListingSpecifications() {}

    public static Specification<CarListing> hasBrand(String brand) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            Join<?, ?> model = car.join("model");
            Join<?, ?> brandJoin = model.join("brand");
            return cb.equal(brandJoin.get("name"), brand);
        };
    }

    public static Specification<CarListing> hasModel(String model) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            Join<?, ?> modelJoin = car.join("model");
            return cb.equal(modelJoin.get("name"), model);
        };
    }

    public static Specification<CarListing> hasFuelType(String fuelType) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            Join<?, ?> ft = car.join("fuelType");
            return cb.equal(ft.get("name"), fuelType);
        };
    }

    public static Specification<CarListing> yearFrom(Integer yearFrom) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            return cb.greaterThanOrEqualTo(car.get("year"), yearFrom);
        };
    }

    public static Specification<CarListing> yearTo(Integer yearTo) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            return cb.lessThanOrEqualTo(car.get("year"), yearTo);
        };
    }

    public static Specification<CarListing> priceFrom(BigDecimal priceFrom) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            return cb.greaterThanOrEqualTo(car.get("price"), priceFrom);
        };
    }

    public static Specification<CarListing> priceTo(BigDecimal priceTo) {
        return (root, query, cb) -> {
            Join<?, ?> car = root.join("car");
            return cb.lessThanOrEqualTo(car.get("price"), priceTo);
        };
    }

    public static Specification<CarListing> isNotSold() {
        return (root, query, cb) -> {
            Subquery<Long> sub = query.subquery(Long.class);
            Root<CarSale> sale = sub.from(CarSale.class);
            sub.select(sale.get("id"))
               .where(cb.equal(sale.get("carListing"), root));
            return cb.not(cb.exists(sub));
        };
    }
}
