package dk.bilbase.backend.domain.view;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Immutable
@Table(name = "car_listing_audit")
public class CarListingAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "listing_id")
    private Long listingId;

    private String action;

    @Column(name = "changed_at")
    private LocalDateTime changedAt;

    @Column(name = "changed_by")
    private Long changedBy;

    @Column(name = "old_price")
    private BigDecimal oldPrice;

    @Column(name = "new_price")
    private BigDecimal newPrice;

    protected CarListingAudit() {}

    public Long getId() { return id; }
    public Long getListingId() { return listingId; }
    public String getAction() { return action; }
    public LocalDateTime getChangedAt() { return changedAt; }
    public Long getChangedBy() { return changedBy; }
    public BigDecimal getOldPrice() { return oldPrice; }
    public BigDecimal getNewPrice() { return newPrice; }
}
