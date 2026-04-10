package dk.bilbase.backend.dto;

import dk.bilbase.backend.domain.Message;

import java.time.LocalDateTime;

public record MessageResponse(
        Long id,
        String senderUsername,
        String receiverUsername,
        Long carListingId,
        String content,
        LocalDateTime sentAt,
        boolean read
) {
    public static MessageResponse from(Message msg) {
        return new MessageResponse(
                msg.getId(),
                msg.getSender().getUsername(),
                msg.getReceiver().getUsername(),
                msg.getCarListing().getId(),
                msg.getContent(),
                msg.getSentAt(),
                Boolean.TRUE.equals(msg.getIsRead())
        );
    }
}
