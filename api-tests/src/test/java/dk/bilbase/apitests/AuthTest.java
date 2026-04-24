package dk.bilbase.apitests;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.hamcrest.Matchers.instanceOf;
import static org.hamcrest.Matchers.equalTo;

class AuthTest extends ApiTestBase {

    @Test
    @DisplayName("Register (CUSTOMER) returns 201 with token and role")
    void registerCustomer() {
        long suffix = System.currentTimeMillis();
        client()
                .body(Map.of(
                        "username", "testcustomer_" + suffix,
                        "email", "testcustomer_" + suffix + "@example.com",
                        "password", "password123",
                        "firstName", "Test",
                        "lastName", "Customer",
                        "phone", "+4512345678"
                ))
                .post("/api/auth/register")
                .then()
                .statusCode(201)
                .body("token", instanceOf(String.class))
                .body("role", equalTo("CUSTOMER"));
    }

    @Test
    @DisplayName("Login (dealer1) returns 200 with token and DEALER role")
    void loginDealer() {
        client()
                .body(Map.of("username", "dealer1", "password", "password123"))
                .post("/api/auth/login")
                .then()
                .statusCode(200)
                .body("token", instanceOf(String.class))
                .body("role", equalTo("DEALER"));
    }

    @Test
    @DisplayName("Login (admin) returns 200 with token and ADMIN role")
    void loginAdmin() {
        client()
                .body(Map.of("username", "admin", "password", "password123"))
                .post("/api/auth/login")
                .then()
                .statusCode(200)
                .body("token", instanceOf(String.class))
                .body("role", equalTo("ADMIN"));
    }

    @Test
    @DisplayName("GET /me with valid token returns 200 with username")
    void meWithToken() {
        String token = loginAs("dealer1");
        authed(token)
                .get("/api/auth/me")
                .then()
                .statusCode(200)
                .body("username", instanceOf(String.class));
    }

    @Test
    @DisplayName("GET /me without token returns 403")
    void meWithoutToken() {
        client()
                .get("/api/auth/me")
                .then()
                .statusCode(403);
    }

    @Test
    @DisplayName("Logout returns 200")
    void logout() {
        String token = loginAs("dealer1");
        authed(token)
                .post("/api/auth/logout")
                .then()
                .statusCode(200);
    }
}
