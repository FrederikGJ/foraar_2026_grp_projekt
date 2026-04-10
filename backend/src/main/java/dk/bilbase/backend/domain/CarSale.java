package dk.bilbase.backend.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

import java.time.LocalDateTime;

/**
 * Et salg pr. listing (UNIQUE car_listing_id). FK er ON DELETE RESTRICT
 * → en listing der har et salg kan ikke slettes (returnér 409 i service-laget).
 */
@Entity
@Table(name = "car_sale")
public class CarSale {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "car_listing_id", nullable = false, unique = true)
    private CarListing carListing;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "buyer_id", nullable = false)
    private AppUser buyer;

    // DB-managed (DEFAULT CURRENT_TIMESTAMP)
    @Column(name = "sold_at", nullable = false, insertable = false, updatable = false)
    private LocalDateTime soldAt;

    protected CarSale() {
    }

    public CarSale(CarListing carListing, AppUser buyer) {
        this.carListing = carListing;
        this.buyer = buyer;
    }

    public Long getId() { return id; }
    public CarListing getCarListing() { return carListing; }
    public AppUser getBuyer() { return buyer; }
    public LocalDateTime getSoldAt() { return soldAt; }
}
