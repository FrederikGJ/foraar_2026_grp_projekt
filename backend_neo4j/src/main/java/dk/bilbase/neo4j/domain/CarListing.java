package dk.bilbase.neo4j.domain;

import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

@Node
public class CarListing {

    @Id
    private Long id;
    private String description;
    private String createdAt;

    @Relationship(type = "LISTS_CAR", direction = Relationship.Direction.OUTGOING)
    private Car car;

    @Relationship(type = "POSTED_BY", direction = Relationship.Direction.OUTGOING)
    private User seller;

    @Relationship(type = "LOCATED_AT", direction = Relationship.Direction.OUTGOING)
    private Address address;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    public Car getCar() { return car; }
    public void setCar(Car car) { this.car = car; }
    public User getSeller() { return seller; }
    public void setSeller(User seller) { this.seller = seller; }
    public Address getAddress() { return address; }
    public void setAddress(Address address) { this.address = address; }
}
