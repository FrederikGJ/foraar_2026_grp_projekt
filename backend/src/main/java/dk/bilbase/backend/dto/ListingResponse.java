package dk.bilbase.backend.dto;

import dk.bilbase.backend.domain.CarListing;

import java.math.BigDecimal;
import java.time.LocalDateTime;

        public record ListingResponse(
                Long id,
                String brand,
                String model,
                String fuelType,
                BigDecimal price,
                Integer year,
                Integer mileageKm,
                String color,
                String description,
                String sellerUsername,
                boolean sold,
                LocalDateTime createdAt,
                boolean aiFlagged,
                String aiCategory,
                String aiModerationNote,
                LocalDateTime aiCheckedAt
        ) {
            public static ListingResponse from(CarListing listing) {
                return new ListingResponse(
                        listing.getId(),
                        listing.getCar().getModel().getBrand().getName(),
                        listing.getCar().getModel().getName(),
                        listing.getCar().getFuelType().getName(),
                        listing.getCar().getPrice(),
                        listing.getCar().getYear(),
                        listing.getCar().getMileageKm(),
                        listing.getCar().getColor(),
                        listing.getDescription(),
                        listing.getSeller().getUsername(),
                        listing.isSold(),
                        listing.getCreatedAt(),
                        listing.isAiFlagged(),
                        listing.getAiCategory(),
                        listing.getAiModerationNote(),
                        listing.getAiCheckedAt()
                );
            }
        }




