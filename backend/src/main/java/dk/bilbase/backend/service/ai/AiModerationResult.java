package dk.bilbase.backend.service.ai;

public record AiModerationResult(
        boolean flagged,
        String category,
        String note
) {}