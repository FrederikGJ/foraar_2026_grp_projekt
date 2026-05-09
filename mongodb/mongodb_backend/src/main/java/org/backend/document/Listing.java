package org.backend.document;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Date;

@Document(collection = "listings")
public class Listing {

    @Id
    private String  id;
    private Car     car;
    private Seller  seller;
    private Address address;
    private String  description;
    private Date    soldAt;     // null = still for sale
    private Date    createdAt;

    // ── Embedded records ─────────────────────────────────────────────────────

    public record Car(
            String brand,
            String model,
            String fuelType,
            int    year,
            int    mileageKm,
            String color,
            double price
    ) {}

    public record Seller(
            String id,
            String username,
            String phone
    ) {}

    public record Address(
            String street,
            String postalCode,
            String city,
            String region
    ) {}

    // ── Getters ──────────────────────────────────────────────────────────────

    public String  getId()          { return id; }
    public Car     getCar()         { return car; }
    public Seller  getSeller()      { return seller; }
    public Address getAddress()     { return address; }
    public String  getDescription() { return description; }
    public Date    getSoldAt()      { return soldAt; }
    public Date    getCreatedAt()   { return createdAt; }
}
