package dk.bilbase.backend.web.auth;

public record AuthResponse(
        String token,
        String tokenType,
        long expiresInMs,
        Long userId,
        String username,
        String role
) {
    public static AuthResponse bearer(String token, long expiresInMs, Long userId, String username, String role) {
        return new AuthResponse(token, "Bearer", expiresInMs, userId, username, role);
    }
}
