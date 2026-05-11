package dk.bilbase.neo4j.domain;

import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Relationship;

@Node
public class Message {

    @Id
    private Long id;
    private String content;
    private String sentAt;

    @Relationship(type = "SENT_BY", direction = Relationship.Direction.OUTGOING)
    private User sender;

    @Relationship(type = "RECEIVED_BY", direction = Relationship.Direction.OUTGOING)
    private User receiver;

    @Relationship(type = "ABOUT_LISTING", direction = Relationship.Direction.OUTGOING)
    private CarListing carListing;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getSentAt() { return sentAt; }
    public void setSentAt(String sentAt) { this.sentAt = sentAt; }
    public User getSender() { return sender; }
    public void setSender(User sender) { this.sender = sender; }
    public User getReceiver() { return receiver; }
    public void setReceiver(User receiver) { this.receiver = receiver; }
    public CarListing getCarListing() { return carListing; }
    public void setCarListing(CarListing carListing) { this.carListing = carListing; }
}
