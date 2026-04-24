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

import java.time.LocalDateTime;

@Entity
@Table(name = "message")
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "sender_id", nullable = false)
    private AppUser sender;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "receiver_id", nullable = false)
    private AppUser receiver;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "car_listing_id", nullable = false)
    private CarListing carListing;

    @Column(name = "content", columnDefinition = "TEXT", nullable = false)
    private String content;

    @Column(name = "sent_at", insertable = false, updatable = false)
    private LocalDateTime sentAt;

    @Column(name = "is_read")
    private Boolean isRead = false;

    protected Message() {}

    public Message(AppUser sender, AppUser receiver, CarListing carListing, String content) {
        this.sender = sender;
        this.receiver = receiver;
        this.carListing = carListing;
        this.content = content;
    }

    public Long getId() { return id; }
    public AppUser getSender() { return sender; }
    public AppUser getReceiver() { return receiver; }
    public CarListing getCarListing() { return carListing; }
    public String getContent() { return content; }
    public LocalDateTime getSentAt() { return sentAt; }
    public Boolean getIsRead() { return isRead; }
    public void setIsRead(Boolean isRead) { this.isRead = isRead; }
}
