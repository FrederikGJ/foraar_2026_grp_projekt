-- ============================================
-- BILBASEN - INDEXES (renset og korrekt)
-- ============================================
--
-- UDELADT (dækkes allerede af eksisterende UNIQUE constraints):
--
--   app_user:    UNIQUE(username), UNIQUE(email)
--                → automatiske indexes, ingen ekstra nødvendige
--
--   brand:       UNIQUE(name)        → automatisk index
--   role:        UNIQUE(name)        → automatisk index
--   region:      UNIQUE(name)        → automatisk index
--   fuel_type:   UNIQUE(name)        → automatisk index
--
--   favorite:    UNIQUE(user_id, car_listing_id)
--                → komposit-index dækker venstre præfiks (user_id),
--                  så idx_favorite_user er REDUNDANT og udelades
--
--   car_sale:    UNIQUE(car_listing_id)
--                → automatisk index, idx_car_sale_listing udelades
--
-- ============================================

-- CAR: filtrering og sortering i søgning
CREATE INDEX idx_car_price      ON car(price);
CREATE INDEX idx_car_year       ON car(year);
CREATE INDEX idx_car_mileage    ON car(mileage_km);
CREATE INDEX idx_car_fuel_type  ON car(fuel_type_id);   -- FK + filter
CREATE INDEX idx_car_model      ON car(model_id);       -- FK + filter

-- CAR_LISTING: opslag på sælger, dato og bil
CREATE INDEX idx_listing_seller     ON car_listing(seller_id);    -- FK + "mine annoncer"
CREATE INDEX idx_listing_created_at ON car_listing(created_at);   -- sortering: nyeste først
CREATE INDEX idx_listing_car        ON car_listing(car_id);       -- FK (sjældent søgt isoleret, men god praksis)
CREATE INDEX idx_listing_address    ON car_listing(address_id);   -- FK + region-filter via JOIN

-- CAR_SALE: køber-historik og salgsdato
CREATE INDEX idx_car_sale_buyer   ON car_sale(buyer_id);   -- FK + "mine køb"
CREATE INDEX idx_car_sale_sold_at ON car_sale(sold_at);    -- sortering / statistik

-- FAVORITE: populære annoncer
-- NB: UNIQUE(user_id, car_listing_id) dækker allerede opslag på user_id (venstre præfiks)
CREATE INDEX idx_favorite_listing ON favorite(car_listing_id);  -- "hvor mange har favoriseret denne annonce?"

-- MESSAGE: indbakke, udbakke og annonce-tråd
CREATE INDEX idx_message_receiver ON message(receiver_id);     -- indbakke
CREATE INDEX idx_message_sender   ON message(sender_id);       -- udbakke
CREATE INDEX idx_message_listing  ON message(car_listing_id);  -- FK + tråd pr. annonce

-- MODEL: brand-søgning (FK uden UNIQUE)
CREATE INDEX idx_model_brand ON model(brand_id);

-- APP_USER: opslag på rolle (f.eks. alle admins)
CREATE INDEX idx_user_role ON app_user(role_id);

-- ADDRESS: opslag per region (FK uden UNIQUE)
CREATE INDEX idx_address_region ON address(region_id);
