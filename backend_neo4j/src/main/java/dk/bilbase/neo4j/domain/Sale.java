package dk.bilbase.neo4j.domain;

import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

@Node
public class Sale {

    @Id
    private Long id;
    private String soldAt;

    @Relationship(type = "SALE_OF", direction = Relationship.Direction.OUTGOING)
    private CarListing carListing;

    @Relationship(type = "BOUGHT_BY", direction = Relationship.Direction.OUTGOING)
    private User buyer;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getSoldAt() { return soldAt; }
    public void setSoldAt(String soldAt) { this.soldAt = soldAt; }
    public CarListing getCarListing() { return carListing; }
    public void setCarListing(CarListing carListing) { this.carListing = carListing; }
    public User getBuyer() { return buyer; }
    public void setBuyer(User buyer) { this.buyer = buyer; }
}
