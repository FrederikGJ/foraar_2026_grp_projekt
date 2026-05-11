package dk.bilbase.neo4j.domain;

import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

@Node
public class Address {

    @Id
    private Long id;
    private String street;
    private String city;
    private String postalCode;

    @Relationship(type = "IN_REGION", direction = Relationship.Direction.OUTGOING)
    private Region region;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getStreet() { return street; }
    public void setStreet(String street) { this.street = street; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getPostalCode() { return postalCode; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }
    public Region getRegion() { return region; }
    public void setRegion(Region region) { this.region = region; }
}
