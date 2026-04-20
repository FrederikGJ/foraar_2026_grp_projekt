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
import jakarta.persistence.Transient;

import java.time.LocalDateTime;

/**
 * VIGTIGT: Der findes INGEN is_sold-kolonne på car_listing (3NF — udledes fra car_sale).
 * isSold() er en derived property baseret på @OneToOne CarSale-relationen.
 */
@Entity
@Table(name = "car_listing")
public class CarListing {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "car_id", nullable = false)
    private Car car;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "seller_id", nullable = false)
    private AppUser seller;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "address_id", nullable = false)
    private Address address;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    // DB-managed (DEFAULT CURRENT_TIMESTAMP)
    @Column(name = "created_at", insertable = false, updatable = false)
    private LocalDateTime createdAt;

    // Inverse side — CarSale ejer FK car_listing_id (UNIQUE → 1:1)
    @OneToOne(mappedBy = "carListing", fetch = FetchType.LAZY)
    private CarSale sale;

    @Column(name = "ai_flagged", nullable = false)
    private boolean aiFlagged;

    @Column(name = "ai_category", length = 50)
    private String aiCategory;

    @Column(name = "ai_moderation_note", columnDefinition = "TEXT")
    private String aiModerationNote;

    @Column(name = "ai_checked_at")
    private LocalDateTime aiCheckedAt;


    protected CarListing() {
    }

    public CarListing(Car car, AppUser seller, Address address, String description) {
        this.car = car;
        this.seller = seller;
        this.address = address;
        this.description = description;
    }

    /**
     * Afledt fra CarSale-relationen — der er ingen is_sold-kolonne i DB.
     */
    @Transient
    public boolean isSold() {
        return sale != null;
    }

    public Long getId() { return id; }
    public Car getCar() { return car; }
    public AppUser getSeller() { return seller; }
    public Address getAddress() { return address; }
    public String getDescription() { return description; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public CarSale getSale() { return sale; }

    public void setCar(Car car) { this.car = car; }
    public void setSeller(AppUser seller) { this.seller = seller; }
    public void setAddress(Address address) { this.address = address; }
    public void setDescription(String description) { this.description = description; }

    public boolean isAiFlagged() { return aiFlagged; }
    public String getAiCategory() { return aiCategory; }
    public String getAiModerationNote() { return aiModerationNote; }
    public LocalDateTime getAiCheckedAt() { return aiCheckedAt; }

    public void setAiFlagged(boolean aiFlagged) { this.aiFlagged = aiFlagged; }
    public void setAiCategory(String aiCategory) { this.aiCategory = aiCategory; }
    public void setAiModerationNote(String aiModerationNote) { this.aiModerationNote = aiModerationNote; }
    public void setAiCheckedAt(LocalDateTime aiCheckedAt) { this.aiCheckedAt = aiCheckedAt; }


}
