package dk.bilbase.backend.web;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dk.bilbase.backend.TestContainerConfig;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Import(TestContainerConfig.class)
@AutoConfigureMockMvc
@ActiveProfiles("test")
class ListingControllerIntegrationTest {

    @Autowired private MockMvc mockMvc;
    @Autowired private ObjectMapper objectMapper;

    String dealerToken;
    private String customerToken;

    @BeforeEach
    void setUp() throws Exception {
        dealerToken = registerAndGetToken("dealer_test", "dealer_test@ex.com", "DEALER");
        customerToken = registerAndGetToken("customer_test", "customer_test@ex.com", "CUSTOMER");
    }

    private String registerAndGetToken(String username, String email, String role) throws Exception {
        // Register as CUSTOMER first (default role)
        String json = String.format("""
                {
                    "username": "%s_%d",
                    "email": "%s_%d",
                    "password": "pass123",
                    "firstName": "Test",
                    "lastName": "User",
                    "phone": null
                }
                """, username, System.nanoTime(), email, System.nanoTime());

        MvcResult result = mockMvc.perform(post("/api/auth/register")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(json))
                .andExpect(status().isCreated())
                .andReturn();

        return objectMapper.readTree(
                result.getResponse().getContentAsString()).get("token").asText();
    }

    @Test
    void customerCannotCreateListing() throws Exception {
        String listingJson = """
                {
                    "regionId": 1, "street": "Testvej 1", "postalCode": "2100",
                    "city": "København", "modelId": 1, "fuelTypeId": 1,
                    "price": 150000, "year": 2020, "mileageKm": 50000,
                    "color": "Red", "description": "Nice car"
                }
                """;

        mockMvc.perform(post("/api/listings")
                        .header("Authorization", "Bearer " + customerToken)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(listingJson))
                .andExpect(status().isForbidden());
    }

    @Test
    void publicCanReadListings() throws Exception {
        mockMvc.perform(get("/api/listings"))
                .andExpect(status().isOk());
    }

    @Test
    void publicCanReadActiveListings() throws Exception {
        mockMvc.perform(get("/api/listings/active"))
                .andExpect(status().isOk());
    }

    @Test
    void unauthenticatedCannotDeleteListing() throws Exception {
        mockMvc.perform(delete("/api/listings/1"))
                .andExpect(status().isUnauthorized());
    }
}
