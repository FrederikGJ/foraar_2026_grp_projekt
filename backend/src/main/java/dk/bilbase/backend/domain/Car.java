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

import java.math.BigDecimal;

@Entity
@Table(name = "car")
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "model_id", nullable = false)
    private Model model;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "fuel_type_id", nullable = false)
    private FuelType fuelType;

    @Column(name = "price", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @Column(name = "year", nullable = false)
    private Integer year;

    @Column(name = "mileage_km", nullable = false)
    private Integer mileageKm;

    @Column(name = "color", length = 30)
    private String color;

    protected Car() {
    }

    public Car(Model model, FuelType fuelType, BigDecimal price,
               Integer year, Integer mileageKm, String color) {
        this.model = model;
        this.fuelType = fuelType;
        this.price = price;
        this.year = year;
        this.mileageKm = mileageKm;
        this.color = color;
    }

    public Long getId() { return id; }
    public Model getModel() { return model; }
    public FuelType getFuelType() { return fuelType; }
    public BigDecimal getPrice() { return price; }
    public Integer getYear() { return year; }
    public Integer getMileageKm() { return mileageKm; }
    public String getColor() { return color; }

    public void setModel(Model model) { this.model = model; }
    public void setFuelType(FuelType fuelType) { this.fuelType = fuelType; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public void setYear(Integer year) { this.year = year; }
    public void setMileageKm(Integer mileageKm) { this.mileageKm = mileageKm; }
    public void setColor(String color) { this.color = color; }
}
