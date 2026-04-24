package dk.bilbase.apitests;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.hamcrest.Matchers.instanceOf;

class MessagesTest extends ApiTestBase {

    private static String customerToken;
    private static String dealerToken;
    private static int listingId;

    @BeforeAll
    static void setup() {
        customerToken = loginAs("customer22");
        loginAs("admin");
        dealerToken = loginAs("dealer1");
        listingId = createListing(dealerToken, "Beskedvej 1", "9000", "Aalborg",
                80000, 2018, 70000, "Hvid", "Til besked-test");
    }

    @Test
    @DisplayName("GET /api/messages/inbox returns 200")
    void inbox() {
        authed(customerToken).get("/api/messages/inbox").then().statusCode(200);
    }

    @Test
    @DisplayName("GET /api/messages/outbox returns 200")
    void outbox() {
        authed(customerToken).get("/api/messages/outbox").then().statusCode(200);
    }

    @Test
    @DisplayName("POST /api/messages sends message to dealer (201)")
    void sendMessage() {
        authed(customerToken)
                .body(Map.of(
                        "carListingId", listingId,
                        "content", "Hej, er bilen stadig til salg?"
                ))
                .post("/api/messages")
                .then()
                .statusCode(201)
                .body("content", instanceOf(String.class));
    }

    @Test
    @DisplayName("POST /api/messages to self returns 400")
    void sendToSelf() {
        authed(dealerToken)
                .body(Map.of(
                        "carListingId", listingId,
                        "content", "Besked til mig selv"
                ))
                .post("/api/messages")
                .then()
                .statusCode(400);
    }
}
