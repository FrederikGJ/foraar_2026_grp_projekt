package dk.bilbase.backend.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

import java.time.LocalDateTime;

@Entity
@Table(name = "favorite",
       uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "car_listing_id"}))
public class Favorite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "user_id", nullable = false)
    private AppUser user;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "car_listing_id", nullable = false)
    private CarListing carListing;

    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    protected Favorite() {}

    public Favorite(AppUser user, CarListing carListing) {
        this.user = user;
        this.carListing = carListing;
    }

    public Long getId() { return id; }
    public AppUser getUser() { return user; }
    public CarListing getCarListing() { return carListing; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}
