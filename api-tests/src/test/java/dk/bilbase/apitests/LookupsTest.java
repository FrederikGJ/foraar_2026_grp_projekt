package dk.bilbase.apitests;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

// SecurityConfig tillader GET /api/brands, /api/models, /api/fuel-types, /api/regions,
// men der er ingen controllers endnu → 404.
class LookupsTest extends ApiTestBase {

    @Test
    @DisplayName("GET /api/brands returns 404 (not yet implemented)")
    void brands() {
        client().get("/api/brands").then().statusCode(404);
    }

    @Test
    @DisplayName("GET /api/models returns 404 (not yet implemented)")
    void models() {
        client().get("/api/models").then().statusCode(404);
    }

    @Test
    @DisplayName("GET /api/fuel-types returns 404 (not yet implemented)")
    void fuelTypes() {
        client().get("/api/fuel-types").then().statusCode(404);
    }

    @Test
    @DisplayName("GET /api/regions returns 404 (not yet implemented)")
    void regions() {
        client().get("/api/regions").then().statusCode(404);
    }
}
