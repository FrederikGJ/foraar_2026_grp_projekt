package dk.bilbase.backend.domain.view;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

import java.math.BigDecimal;

@Entity
@Immutable
@Table(name = "car_details")
public class CarDetailsView {

    @Id
    private Long id;

    private String brand;
    private String model;

    @Column(name = "fuel_type")
    private String fuelType;

    private Integer year;

    @Column(name = "mileage_km")
    private Integer mileageKm;

    private BigDecimal price;
    private String color;

    protected CarDetailsView() {}

    public Long getId() { return id; }
    public String getBrand() { return brand; }
    public String getModel() { return model; }
    public String getFuelType() { return fuelType; }
    public Integer getYear() { return year; }
    public Integer getMileageKm() { return mileageKm; }
    public BigDecimal getPrice() { return price; }
    public String getColor() { return color; }
}
