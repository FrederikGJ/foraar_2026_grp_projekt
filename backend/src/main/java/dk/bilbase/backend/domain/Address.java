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

@Entity
@Table(name = "address")
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "street", nullable = false, length = 100)
    private String street;

    @Column(name = "postal_code", nullable = false, length = 10)
    private String postalCode;

    @Column(name = "city", nullable = false, length = 50)
    private String city;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "region_id", nullable = false)
    private Region region;

    protected Address() {
    }

    public Address(String street, String postalCode, String city, Region region) {
        this.street = street;
        this.postalCode = postalCode;
        this.city = city;
        this.region = region;
    }

    public Long getId() { return id; }
    public String getStreet() { return street; }
    public String getPostalCode() { return postalCode; }
    public String getCity() { return city; }
    public Region getRegion() { return region; }

    public void setStreet(String street) { this.street = street; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }
    public void setCity(String city) { this.city = city; }
    public void setRegion(Region region) { this.region = region; }
}
