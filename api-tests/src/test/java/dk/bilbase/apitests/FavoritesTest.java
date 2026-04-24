package dk.bilbase.apitests;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.hamcrest.Matchers.instanceOf;

class FavoritesTest extends ApiTestBase {

    @Test
    @DisplayName("GET /api/favorites without token returns 401")
    void favoritesWithoutToken() {
        client().get("/api/favorites").then().statusCode(401);
    }

    @Nested
    @DisplayName("Authenticated favorites flow")
    class AuthenticatedFlow {

        private static String customerToken;
        private static String dealerToken;
        private static int listingId;

        @BeforeAll
        static void setup() {
            customerToken = loginAs("customer22");
            dealerToken = loginAs("dealer1");
            listingId = createListing(dealerToken, "Favoritvej 1", "5000", "Odense",
                    120000, 2020, 30000, "Grøn", "Til favorit-test");
        }

        @Test
        @DisplayName("GET /api/favorites returns 200")
        void listFavorites() {
            authed(customerToken).get("/api/favorites").then().statusCode(200);
        }

        @Test
        @DisplayName("POST /api/favorites adds favorite and returns 201 with id")
        void addFavorite() {
            authed(customerToken)
                    .body(Map.of("carListingId", listingId))
                    .post("/api/favorites")
                    .then()
                    .statusCode(201)
                    .body("id", instanceOf(Number.class));
        }

        @Test
        @DisplayName("DELETE /api/favorites/:id removes favorite and returns 204")
        void deleteFavorite() {
            // Nyt listing så vi ikke rammer UNIQUE(user_id, car_listing_id)
            int separate = createListing(dealerToken, "Favoritvej 2", "5000", "Odense",
                    120000, 2020, 30000, "Grøn", "Til favorit-test");
            int favoriteId = authed(customerToken)
                    .body(Map.of("carListingId", separate))
                    .post("/api/favorites")
                    .then()
                    .statusCode(201)
                    .extract()
                    .jsonPath()
                    .getInt("id");

            authed(customerToken)
                    .delete("/api/favorites/" + favoriteId)
                    .then()
                    .statusCode(204);
        }
    }
}
