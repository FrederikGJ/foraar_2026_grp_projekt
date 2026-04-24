package dk.bilbase.apitests;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import org.junit.jupiter.api.BeforeAll;

import java.util.Map;

import static io.restassured.RestAssured.given;

public abstract class ApiTestBase {

    protected static final String BASE = System.getProperty("api.base.url", "http://localhost:8080");

    @BeforeAll
    static void setupRestAssured() {
        RestAssured.baseURI = BASE;
    }

    protected static RequestSpecification client() {
        return given().contentType(ContentType.JSON);
    }

    protected static RequestSpecification authed(String token) {
        return client().header("Authorization", "Bearer " + token);
    }

    protected static String loginAs(String username) {
        return loginAs(username, "password123");
    }

    protected static String loginAs(String username, String password) {
        return client()
                .body(Map.of("username", username, "password", password))
                .post("/api/auth/login")
                .then()
                .statusCode(200)
                .extract()
                .jsonPath()
                .getString("token");
    }

    protected static int createListing(String dealerToken, String street, String postalCode,
                                       String city, int price, int year, int mileageKm,
                                       String color, String description) {
        return authed(dealerToken)
                .body(Map.ofEntries(
                        Map.entry("regionId", 1),
                        Map.entry("street", street),
                        Map.entry("postalCode", postalCode),
                        Map.entry("city", city),
                        Map.entry("modelId", 1),
                        Map.entry("fuelTypeId", 1),
                        Map.entry("price", price),
                        Map.entry("year", year),
                        Map.entry("mileageKm", mileageKm),
                        Map.entry("color", color),
                        Map.entry("description", description)
                ))
                .post("/api/listings")
                .then()
                .statusCode(201)
                .extract()
                .jsonPath()
                .getInt("id");
    }
}
