-- ============================================
-- TEST INIT: Schema + Views + Triggers + Seed
-- ============================================

-- SCHEMA
CREATE TABLE role (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE region (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE app_user (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    phone           VARCHAR(20),
    role_id         BIGINT       NOT NULL,
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES role(id)
);

CREATE TABLE address (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    street      VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10)  NOT NULL,
    city        VARCHAR(50)  NOT NULL,
    region_id   BIGINT       NOT NULL,
    FOREIGN KEY (region_id) REFERENCES region(id)
);

CREATE TABLE brand (
    id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE model (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    brand_id    BIGINT      NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(id)
);

CREATE TABLE fuel_type (
    id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE car (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    model_id        BIGINT          NOT NULL,
    fuel_type_id    BIGINT          NOT NULL,
    price           DECIMAL(10, 2)  NOT NULL,
    year            INT             NOT NULL,
    mileage_km      INT             NOT NULL,
    color           VARCHAR(30),
    FOREIGN KEY (model_id)     REFERENCES model(id),
    FOREIGN KEY (fuel_type_id) REFERENCES fuel_type(id)
);

CREATE TABLE car_listing (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    car_id          BIGINT    NOT NULL,
    seller_id       BIGINT    NOT NULL,
    address_id      BIGINT    NOT NULL,
    description     TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (car_id)     REFERENCES car(id),
    FOREIGN KEY (seller_id)  REFERENCES app_user(id),
    FOREIGN KEY (address_id) REFERENCES address(id)
);

CREATE TABLE car_sale (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    car_listing_id  BIGINT NOT NULL,
    buyer_id        BIGINT NOT NULL,
    sold_at         TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_car_sale_listing
        FOREIGN KEY (car_listing_id) REFERENCES car_listing(id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_car_sale_buyer
        FOREIGN KEY (buyer_id) REFERENCES app_user(id),
    UNIQUE (car_listing_id)
);

CREATE TABLE favorite (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id         BIGINT NOT NULL,
    car_listing_id  BIGINT NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)        REFERENCES app_user(id),
    FOREIGN KEY (car_listing_id) REFERENCES car_listing(id),
    UNIQUE (user_id, car_listing_id)
);

CREATE TABLE message (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    sender_id       BIGINT NOT NULL,
    receiver_id     BIGINT NOT NULL,
    car_listing_id  BIGINT NOT NULL,
    content         TEXT   NOT NULL,
    sent_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read         BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id)      REFERENCES app_user(id),
    FOREIGN KEY (receiver_id)    REFERENCES app_user(id),
    FOREIGN KEY (car_listing_id) REFERENCES car_listing(id)
);

CREATE TABLE car_listing_audit (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    listing_id  BIGINT        NOT NULL,
    action      VARCHAR(10)   NOT NULL,
    changed_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    changed_by  BIGINT        DEFAULT NULL,
    old_price   DECIMAL(10,2) DEFAULT NULL,
    new_price   DECIMAL(10,2) DEFAULT NULL
);

-- VIEWS
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
WHERE NOT EXISTS (
    SELECT 1 FROM car_sale cs WHERE cs.car_listing_id = cl.id
);

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

CREATE VIEW user_favorites AS
SELECT
    f.user_id,
    u.username,
    cl.id               AS listing_id,
    b.name              AS brand,
    m.name              AS model,
    c.price,
    c.year,
    c.mileage_km,
    CASE WHEN cs.id IS NOT NULL THEN TRUE ELSE FALSE END AS is_sold
FROM favorite       f
JOIN app_user       u  ON u.id  = f.user_id
JOIN car_listing    cl ON cl.id = f.car_listing_id
JOIN car            c  ON c.id  = cl.car_id
JOIN model          m  ON m.id  = c.model_id
JOIN brand          b  ON b.id  = m.brand_id
LEFT JOIN car_sale  cs ON cs.car_listing_id = cl.id;

-- TRIGGERS

-- Audit triggers
CREATE TRIGGER trg_car_listing_after_insert
AFTER INSERT ON car_listing
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit (listing_id, action, changed_by)
    VALUES (NEW.id, 'INSERT', NEW.seller_id);
END;

CREATE TRIGGER trg_car_listing_after_delete
AFTER DELETE ON car_listing
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit (listing_id, action, changed_by)
    VALUES (OLD.id, 'DELETE', OLD.seller_id);
END;

CREATE TRIGGER trg_car_sale_after_insert
AFTER INSERT ON car_sale
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit (listing_id, action, changed_by)
    VALUES (NEW.car_listing_id, 'SOLD', NEW.buyer_id);
END;

CREATE TRIGGER trg_car_after_update
AFTER UPDATE ON car
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO car_listing_audit (listing_id, action, changed_by, old_price, new_price)
        SELECT cl.id, 'UPDATE', cl.seller_id, OLD.price, NEW.price
        FROM car_listing cl WHERE cl.car_id = NEW.id;
    END IF;
END;

-- Validation triggers
CREATE TRIGGER trg_message_before_insert
BEFORE INSERT ON message
FOR EACH ROW
BEGIN
    DECLARE v_is_sold BOOLEAN;
    SELECT COUNT(*) > 0 INTO v_is_sold
    FROM car_sale WHERE car_listing_id = NEW.car_listing_id;
    IF v_is_sold = TRUE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke sende besked: bilen er allerede solgt.';
    END IF;
    IF NEW.sender_id = NEW.receiver_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke sende besked til dig selv.';
    END IF;
END;

CREATE TRIGGER trg_favorite_before_insert
BEFORE INSERT ON favorite
FOR EACH ROW
BEGIN
    DECLARE v_is_sold BOOLEAN;
    SELECT COUNT(*) > 0 INTO v_is_sold
    FROM car_sale WHERE car_listing_id = NEW.car_listing_id;
    IF v_is_sold = TRUE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke tilføje til favoritter: bilen er allerede solgt.';
    END IF;
END;

CREATE TRIGGER trg_car_before_insert
BEFORE INSERT ON car
FOR EACH ROW
BEGIN
    IF NEW.year < 1885 OR NEW.year > YEAR(CURDATE()) + 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ugyldigt årstal: bilen skal være fra mellem 1885 og næste år.';
    END IF;
END;

-- SEED DATA (minimal for tests)
INSERT INTO role (name) VALUES ('ADMIN'), ('DEALER'), ('CUSTOMER');
INSERT INTO region (name) VALUES ('Hovedstaden'), ('Sjælland'), ('Syddanmark'), ('Midtjylland'), ('Nordjylland');
INSERT INTO fuel_type (name) VALUES ('Benzin'), ('Diesel'), ('El'), ('Hybrid');
INSERT INTO brand (name) VALUES ('Toyota'), ('Volkswagen'), ('BMW');
INSERT INTO model (name, brand_id) VALUES ('Corolla', 1), ('Golf', 2), ('3-serie', 3);
