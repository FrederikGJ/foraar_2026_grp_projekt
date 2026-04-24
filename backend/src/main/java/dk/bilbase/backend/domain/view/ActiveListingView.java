package dk.bilbase.backend.domain.view;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Immutable
@Table(name = "active_listings")
public class ActiveListingView {

    @Id
    @Column(name = "listing_id")
    private Long listingId;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    private String description;
    private String brand;
    private String model;

    @Column(name = "fuel_type")
    private String fuelType;

    private Integer year;

    @Column(name = "mileage_km")
    private Integer mileageKm;

    private BigDecimal price;
    private String color;

    @Column(name = "seller_username")
    private String sellerUsername;

    @Column(name = "seller_phone")
    private String sellerPhone;

    protected ActiveListingView() {}

    public Long getListingId() { return listingId; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public String getDescription() { return description; }
    public String getBrand() { return brand; }
    public String getModel() { return model; }
    public String getFuelType() { return fuelType; }
    public Integer getYear() { return year; }
    public Integer getMileageKm() { return mileageKm; }
    public BigDecimal getPrice() { return price; }
    public String getColor() { return color; }
    public String getSellerUsername() { return sellerUsername; }
    public String getSellerPhone() { return sellerPhone; }
}
