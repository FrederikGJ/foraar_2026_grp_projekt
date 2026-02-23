-- ============================================
-- BILBASEN - VIEWS
-- ============================================

-- Alle aktive (ikke-solgte) annoncer med bil- og sælgerinfo
CREATE VIEW active_listings AS
SELECT
    cl.id           AS listing_id,
    cl.created_at,
    cl.description,
    b.name          AS brand,
    m.name          AS model,
    ft.name         AS fuel_type,
    c.year,
    c.mileage_km,
    c.price,
    c.color,
    u.username      AS seller_username,
    u.phone         AS seller_phone
FROM car_listing cl
JOIN car        c  ON c.id  = cl.car_id
JOIN model      m  ON m.id  = c.model_id
JOIN brand      b  ON b.id  = m.brand_id
JOIN fuel_type  ft ON ft.id = c.fuel_type_id
JOIN app_user   u  ON u.id  = cl.seller_id
WHERE cl.is_sold = FALSE;


-- Fuld bilinfo samlet (brand + model + brændstof)
CREATE VIEW car_details AS
SELECT
    c.id,
    b.name          AS brand,
    m.name          AS model,
    ft.name         AS fuel_type,
    c.year,
    c.mileage_km,
    c.price,
    c.color
FROM car        c
JOIN model      m  ON m.id  = c.model_id
JOIN brand      b  ON b.id  = m.brand_id
JOIN fuel_type  ft ON ft.id = c.fuel_type_id;


-- Indbakke: beskeder med afsender- og modtagernavne
CREATE VIEW user_messages AS
SELECT
    msg.id,
    msg.sent_at,
    msg.is_read,
    msg.content,
    s.username      AS sender,
    r.username      AS receiver,
    msg.car_listing_id
FROM message    msg
JOIN app_user   s  ON s.id = msg.sender_id
JOIN app_user   r  ON r.id = msg.receiver_id;


-- En brugers gemte favoritter med bilinfo
CREATE VIEW user_favorites AS
SELECT
    f.user_id,
    u.username,
    cl.id           AS listing_id,
    b.name          AS brand,
    m.name          AS model,
    c.price,
    c.year,
    c.mileage_km,
    cl.is_sold
FROM favorite   f
JOIN app_user   u  ON u.id  = f.user_id
JOIN car_listing cl ON cl.id = f.car_listing_id
JOIN car        c  ON c.id  = cl.car_id
JOIN model      m  ON m.id  = c.model_id
JOIN brand      b  ON b.id  = m.brand_id;
