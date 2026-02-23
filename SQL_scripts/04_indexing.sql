-- ============================================
-- BILBASEN - INDEXES
-- ============================================

-- CAR: filtrering på pris, år, km og brændstof
CREATE INDEX idx_car_price      ON car(price);
CREATE INDEX idx_car_year       ON car(year);
CREATE INDEX idx_car_mileage    ON car(mileage_km);
CREATE INDEX idx_car_fuel_type  ON car(fuel_type_id);
CREATE INDEX idx_car_model      ON car(model_id);

-- CAR_LISTING: aktive annoncer, sælger og sortering på dato
CREATE INDEX idx_listing_is_sold    ON car_listing(is_sold);
CREATE INDEX idx_listing_seller     ON car_listing(seller_id);
CREATE INDEX idx_listing_created_at ON car_listing(created_at);

-- MESSAGE: indbakke/udbakke per bruger og opslag per annonce
CREATE INDEX idx_message_receiver   ON message(receiver_id);
CREATE INDEX idx_message_sender     ON message(sender_id);
CREATE INDEX idx_message_listing    ON message(car_listing_id);

-- MODEL: brand-søgning går gennem model - altså man skal kunne søge hurtigt på et bestemt bilmærke
CREATE INDEX idx_model_brand ON model(brand_id);
