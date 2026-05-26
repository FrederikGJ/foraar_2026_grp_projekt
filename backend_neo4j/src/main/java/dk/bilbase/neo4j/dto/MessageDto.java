package dk.bilbase.neo4j.dto;

public record MessageDto(
        Long messageId,
        String content,
        String sentAt,
        String senderUsername,
        String receiverUsername,
        Long listingId
) {}
