package dk.bilbase.backend.domain.view;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import org.hibernate.annotations.Immutable;

import java.time.LocalDateTime;

@Entity
@Immutable
@Table(name = "user_messages")
public class UserMessageView {

    @Id
    private Long id;

    @Column(name = "sent_at")
    private LocalDateTime sentAt;

    @Column(name = "is_read")
    private Boolean isRead;

    private String content;
    private String sender;
    private String receiver;

    @Column(name = "car_listing_id")
    private Long carListingId;

    protected UserMessageView() {}

    public Long getId() { return id; }
    public LocalDateTime getSentAt() { return sentAt; }
    public Boolean getIsRead() { return isRead; }
    public String getContent() { return content; }
    public String getSender() { return sender; }
    public String getReceiver() { return receiver; }
    public Long getCarListingId() { return carListingId; }
}
