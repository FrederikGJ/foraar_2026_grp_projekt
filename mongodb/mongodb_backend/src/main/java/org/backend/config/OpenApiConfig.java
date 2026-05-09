package org.backend.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springdoc.core.configuration.SpringDocConfiguration;
import org.springdoc.core.properties.SpringDocConfigProperties;
import org.springdoc.core.providers.ObjectMapperProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI openAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("Bilbasen MongoDB API")
                        .description("Demo endpoints for the MongoDB backend")
                        .version("1.0.0"));
    }

    @Bean
    public org.springdoc.core.customizers.OpenApiCustomizer removePageableObjectParam() {
        return openApi -> openApi.getPaths().forEach((path, item) ->
                item.readOperations().forEach(op -> {
                    if (op.getParameters() == null) return;
                    op.getParameters().removeIf(p ->
                            "pageable".equalsIgnoreCase(p.getName()));
                }));
    }
}
