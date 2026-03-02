-- ============================================
-- BILBASEN - INDEXES (opdateret til nyt schema)
-- ============================================

-- CAR: filtrering på pris, år, km og brændstof
CREATE INDEX idx_car_price      ON car(price);
CREATE INDEX idx_car_year       ON car(year);
CREATE INDEX idx_car_mileage    ON car(mileage_km);
CREATE INDEX idx_car_fuel_type  ON car(fuel_type_id);
CREATE INDEX idx_car_model      ON car(model_id);

-- CAR_LISTING: sælger og sortering på dato
CREATE INDEX idx_listing_seller     ON car_listing(seller_id);
CREATE INDEX idx_listing_created_at ON car_listing(created_at);
CREATE INDEX idx_listing_car        ON car_listing(car_id);
CREATE INDEX idx_listing_address    ON car_listing(address_id);

-- CAR_SALE: køber-historik og sortering på salgsdato
-- idx_car_sale_listing er udeladt — dækkes allerede af UNIQUE(car_listing_id) i skemaet
CREATE INDEX idx_car_sale_buyer   ON car_sale(buyer_id);
CREATE INDEX idx_car_sale_sold_at ON car_sale(sold_at);

-- FAVORITE: brugerens favoritter + populære annoncer
CREATE INDEX idx_favorite_user    ON favorite(user_id);
CREATE INDEX idx_favorite_listing ON favorite(car_listing_id);

-- MESSAGE: indbakke/udbakke per bruger og opslag per annonce
CREATE INDEX idx_message_receiver ON message(receiver_id);
CREATE INDEX idx_message_sender   ON message(sender_id);
CREATE INDEX idx_message_listing  ON message(car_listing_id);

-- MODEL: brand-søgning
CREATE INDEX idx_model_brand ON model(brand_id);

-- APP_USER: opslag via role (f.eks. alle admins)
CREATE INDEX idx_user_role ON app_user(role_id);

-- ADDRESS: opslag per region
CREATE INDEX idx_address_region ON address(region_id);
