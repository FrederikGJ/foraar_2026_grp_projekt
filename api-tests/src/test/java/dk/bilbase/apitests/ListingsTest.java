package dk.bilbase.apitests;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

import java.util.Map;

import static org.hamcrest.Matchers.equalTo;
import static org.hamcrest.Matchers.instanceOf;

class ListingsTest extends ApiTestBase {

    @Test
    @DisplayName("GET /api/listings returns 200 (public)")
    void listingsPublic() {
        client().get("/api/listings").then().statusCode(200);
    }

    @Test
    @DisplayName("GET /api/listings/active returns 200 (public)")
    void listingsActive() {
        client().get("/api/listings/active").then().statusCode(200);
    }

    @Test
    @DisplayName("GET /api/listings?brand=Toyota filters by brand")
    void listingsByBrand() {
        client().queryParam("brand", "Toyota").get("/api/listings").then().statusCode(200);
    }

    @Test
    @DisplayName("GET /api/listings?priceFrom=50000&priceTo=200000 filters by price")
    void listingsByPrice() {
        client()
                .queryParam("priceFrom", 50000)
                .queryParam("priceTo", 200000)
                .get("/api/listings")
                .then()
                .statusCode(200);
    }

    @Test
    @DisplayName("GET /api/listings?yearFrom=2018&fuelType=Benzin filters by year and fuel")
    void listingsByYearAndFuel() {
        client()
                .queryParam("yearFrom", 2018)
                .queryParam("fuelType", "Benzin")
                .get("/api/listings")
                .then()
                .statusCode(200);
    }

    @Test
    @DisplayName("DELETE /api/listings/1 without token returns 401")
    void deleteWithoutToken() {
        client().delete("/api/listings/1").then().statusCode(401);
    }

    @Nested
    @DisplayName("Authenticated listing flow (dealer)")
    class DealerFlow {

        private static String dealerToken;

        @BeforeAll
        static void setup() {
            dealerToken = loginAs("dealer1");
        }

        @Test
        @DisplayName("POST /api/listings as DEALER creates listing (201)")
        void createListing() {
            authed(dealerToken)
                    .body(Map.ofEntries(
                            Map.entry("regionId", 1),
                            Map.entry("street", "Nørrebrogade 42"),
                            Map.entry("postalCode", "2200"),
                            Map.entry("city", "København N"),
                            Map.entry("modelId", 1),
                            Map.entry("fuelTypeId", 1),
                            Map.entry("price", 149999.00),
                            Map.entry("year", 2021),
                            Map.entry("mileageKm", 45000),
                            Map.entry("color", "Rød"),
                            Map.entry("description", "Velholdt Toyota Corolla med servicehistorik")
                    ))
                    .post("/api/listings")
                    .then()
                    .statusCode(201)
                    .body("id", instanceOf(Number.class))
                    .body("brand", instanceOf(String.class));
        }

        @Test
        @DisplayName("PUT /api/listings/:id updates price (200)")
        void updatePrice() {
            int id = ApiTestBase.createListing(dealerToken, "Testvej 1", "1000", "KBH",
                    149999, 2021, 45000, "Blå", "Test listing");

            authed(dealerToken)
                    .body(Map.of("price", 139999.00, "description", "Pris sat ned!"))
                    .put("/api/listings/" + id)
                    .then()
                    .statusCode(200)
                    .body("price", equalTo(139999.0f));
        }

        @Test
        @DisplayName("POST /api/listings as CUSTOMER returns 403")
        void createAsCustomerForbidden() {
            String customerToken = loginAs("customer22");
            authed(customerToken)
                    .body(Map.ofEntries(
                            Map.entry("regionId", 1),
                            Map.entry("street", "Test"),
                            Map.entry("postalCode", "1000"),
                            Map.entry("city", "KBH"),
                            Map.entry("modelId", 1),
                            Map.entry("fuelTypeId", 1),
                            Map.entry("price", 100000),
                            Map.entry("year", 2020),
                            Map.entry("mileageKm", 10000),
                            Map.entry("color", "Blå"),
                            Map.entry("description", "Skal fejle")
                    ))
                    .post("/api/listings")
                    .then()
                    .statusCode(403);
        }

        @Test
        @DisplayName("DELETE /api/listings/:id with a sale returns 409")
        void deleteSoldListingConflict() {
            int id = ApiTestBase.createListing(dealerToken, "Salgsvej 1", "8000", "Aarhus",
                    99999, 2019, 60000, "Sort", "Til salg");

            String customerToken = loginAs("customer22");
            authed(customerToken)
                    .post("/api/listings/" + id + "/sale")
                    .then()
                    .statusCode(200)
                    .body("sold", equalTo(true));

            authed(dealerToken)
                    .delete("/api/listings/" + id)
                    .then()
                    .statusCode(409);
        }
    }
}
