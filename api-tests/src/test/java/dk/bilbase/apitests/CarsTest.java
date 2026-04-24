package dk.bilbase.apitests;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class CarsTest extends ApiTestBase {

    @Test
    @DisplayName("GET /api/cars returns 200")
    void getCars() {
        client()
                .get("/api/cars")
                .then()
                .statusCode(200);
    }
}
