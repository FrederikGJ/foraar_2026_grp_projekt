package dk.bilbase.apitests;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class AdminAuditTest extends ApiTestBase {

    private static String adminToken;
    private static String dealerToken;
    private static String customerToken;
    private static int listingId;

    @BeforeAll
    static void setup() {
        adminToken = loginAs("admin");
        dealerToken = loginAs("dealer1");
        customerToken = loginAs("customer22");
        listingId = createListing(dealerToken, "Auditvej 1", "7000", "Fredericia",
                110000, 2022, 15000, "Sølv", "Til audit-test");
    }

    @Test
    @DisplayName("GET /api/admin/audit as ADMIN returns 200")
    void auditAsAdmin() {
        authed(adminToken).get("/api/admin/audit").then().statusCode(200);
    }

    @Test
    @DisplayName("GET /api/admin/audit?listingId=:id as ADMIN returns 200")
    void auditByListingIdAsAdmin() {
        authed(adminToken)
                .queryParam("listingId", listingId)
                .get("/api/admin/audit")
                .then()
                .statusCode(200);
    }

    @Test
    @DisplayName("GET /api/admin/audit as CUSTOMER returns 403")
    void auditAsCustomerForbidden() {
        authed(customerToken).get("/api/admin/audit").then().statusCode(403);
    }

    @Test
    @DisplayName("GET /api/admin/audit as DEALER returns 403")
    void auditAsDealerForbidden() {
        authed(dealerToken).get("/api/admin/audit").then().statusCode(403);
    }
}
