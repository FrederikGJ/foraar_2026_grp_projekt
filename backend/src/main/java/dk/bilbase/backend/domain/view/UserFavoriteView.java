package dk.bilbase.backend.domain.view;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.JdbcTypeCode;

import java.math.BigDecimal;
import java.sql.Types;

@Entity
@Immutable
@Table(name = "user_favorites")
@IdClass(UserFavoriteViewId.class)
public class UserFavoriteView {

    @Id
    @Column(name = "user_id")
    private Long userId;

    private String username;

    @Id
    @Column(name = "listing_id")
    private Long listingId;

    private String brand;
    private String model;
    private BigDecimal price;
    private Integer year;

    @Column(name = "mileage_km")
    private Integer mileageKm;

    // MySQL-viewet returnerer is_sold som INT (CASE WHEN ... THEN TRUE/FALSE),
    // så vi fortæller Hibernate eksplicit at JDBC-typen er INTEGER, ikke BOOLEAN/BIT.
    @Column(name = "is_sold")
    @JdbcTypeCode(Types.INTEGER)
    private Boolean isSold;

    protected UserFavoriteView() {}

    public Long getUserId() { return userId; }
    public String getUsername() { return username; }
    public Long getListingId() { return listingId; }
    public String getBrand() { return brand; }
    public String getModel() { return model; }
    public BigDecimal getPrice() { return price; }
    public Integer getYear() { return year; }
    public Integer getMileageKm() { return mileageKm; }
    public Boolean getIsSold() { return isSold; }
}
