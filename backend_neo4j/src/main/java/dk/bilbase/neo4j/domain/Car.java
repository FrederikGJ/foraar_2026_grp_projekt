package dk.bilbase.neo4j.domain;

import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

@Node
public class Car {

    @Id
    private Long id;
    private Integer year;
    private Integer mileage;
    private Double price;
    private String color;

    @Relationship(type = "IS_MODEL", direction = Relationship.Direction.OUTGOING)
    private Model model;

    @Relationship(type = "USES_FUEL", direction = Relationship.Direction.OUTGOING)
    private FuelType fuelType;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Integer getYear() { return year; }
    public void setYear(Integer year) { this.year = year; }
    public Integer getMileage() { return mileage; }
    public void setMileage(Integer mileage) { this.mileage = mileage; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public Model getModel() { return model; }
    public void setModel(Model model) { this.model = model; }
    public FuelType getFuelType() { return fuelType; }
    public void setFuelType(FuelType fuelType) { this.fuelType = fuelType; }
}
