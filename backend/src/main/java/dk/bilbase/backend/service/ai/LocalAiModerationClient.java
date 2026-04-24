package dk.bilbase.backend.service.ai;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import dk.bilbase.backend.domain.CarListing;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import org.springframework.web.server.ResponseStatusException;

import java.util.Map;

@Component
public class LocalAiModerationClient implements AiModerationClient {

    private final RestClient restClient;
    private final ObjectMapper objectMapper;

    public LocalAiModerationClient(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
        this.restClient = RestClient.builder()
                .baseUrl("http://localhost:11434")
                .build();
    }

    @Override
    public AiModerationResult moderateListing(CarListing listing) {
        String description = listing.getDescription() == null ? "" : listing.getDescription();

        String prompt = """
                Du er en moderation- og kvalitetskontrolmodel for en bilannonceplatform.

                Analyser annoncebeskrivelsen og returnér KUN gyldig JSON.
                Ingen forklaring.
                Ingen tekst før JSON.
                Ingen tekst efter JSON.
                Ingen markdown.
                Ingen kodeblokke.

                Format:
                {
                  "flagged": true,
                  "category": "SPAM",
                  "note": "kort forklaring på dansk"
                }

                Mulige værdier for category:
                OK, SPAM, LOW_QUALITY, INAPPROPRIATE, IRRELEVANT

                Beskrivelse:
                %s
                """.formatted(description);

        try {
            String rawResponse = restClient.post()
                    .uri("/api/generate")
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(Map.of(
                            "model", "llama3",
                            "prompt", prompt,
                            "stream", false
                    ))
                    .retrieve()
                    .body(String.class);

            JsonNode outer = objectMapper.readTree(rawResponse);
            String modelText = outer.path("response").asText().trim();

            JsonNode json;

            try {
                json = objectMapper.readTree(modelText);
            } catch (Exception firstParseError) {
                try {
                    String cleaned = modelText
                            .replace("\\n", "\n")
                            .replace("\\\"", "\"")
                            .trim();

                    int start = cleaned.indexOf('{');
                    int end = cleaned.lastIndexOf('}');

                    if (start == -1 || end == -1 || end <= start) {
                        throw new IllegalArgumentException("Ingen JSON fundet i AI-svar");
                    }

                    String jsonOnly = cleaned.substring(start, end + 1);
                    json = objectMapper.readTree(jsonOnly);
                } catch (Exception secondParseError) {
                    throw new ResponseStatusException(
                            HttpStatus.BAD_GATEWAY,
                            "AI returnerede ikke gyldig JSON. Råt svar: " + modelText
                    );
                }
            }

            boolean flagged = json.path("flagged").asBoolean(false);
            String category = json.path("category").asText("OK");
            String note = json.path("note").asText("Ingen note fra AI.");

            return new AiModerationResult(flagged, category, note);

        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(
                    HttpStatus.BAD_GATEWAY,
                    "Fejl ved kald til lokal AI-service: " + e.getMessage()
            );
        }
    }
}