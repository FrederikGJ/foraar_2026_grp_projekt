-- ============================================
-- BILBASEN CLONE - AUDIT TABLE & TRIGGERS
-- ============================================

-- AUDIT TABLE
DROP TABLE IF EXISTS car_listing_audit;
CREATE TABLE car_listing_audit (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    listing_id  BIGINT        NOT NULL,
    action      VARCHAR(10)   NOT NULL,        -- 'INSERT', 'UPDATE', 'DELETE'
    changed_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    changed_by  BIGINT        DEFAULT NULL,    -- seller_id at time of change
    old_is_sold BOOLEAN       DEFAULT NULL,
    new_is_sold BOOLEAN       DEFAULT NULL,
    old_price   DECIMAL(10,2) DEFAULT NULL,
    new_price   DECIMAL(10,2) DEFAULT NULL
);

-- ============================================
-- AUDIT TRIGGERS
-- Aktiveres AFTER en handling er gennemført.
-- Skriver automatisk til car_listing_audit
-- og skaber et historisk spor over ændringer.
-- ============================================

DELIMITER $$

-- Registrer når en ny annonce oprettes
DROP TRIGGER IF EXISTS trg_car_listing_after_insert$$
CREATE TRIGGER trg_car_listing_after_insert
AFTER INSERT ON car_listing
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit
        (listing_id, action, changed_by, new_is_sold)
    VALUES
        (NEW.id, 'INSERT', NEW.seller_id, NEW.is_sold);
END$$

-- Registrer når en annonce opdateres (kun hvis is_sold ændres)
DROP TRIGGER IF EXISTS trg_car_listing_after_update$$
CREATE TRIGGER trg_car_listing_after_update
AFTER UPDATE ON car_listing
FOR EACH ROW
BEGIN
    IF OLD.is_sold <> NEW.is_sold THEN
        INSERT INTO car_listing_audit
            (listing_id, action, changed_by, old_is_sold, new_is_sold)
        VALUES
            (NEW.id, 'UPDATE', NEW.seller_id, OLD.is_sold, NEW.is_sold);
    END IF;
END$$

-- Registrer når en annonce slettes
DROP TRIGGER IF EXISTS trg_car_listing_after_delete$$
CREATE TRIGGER trg_car_listing_after_delete
AFTER DELETE ON car_listing
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit
        (listing_id, action, changed_by, old_is_sold)
    VALUES
        (OLD.id, 'DELETE', OLD.seller_id, OLD.is_sold);
END$$

-- ============================================
-- VALIDATION TRIGGERS
-- Aktiveres BEFORE en handling gennemføres.
-- Afviser ugyldige handlinger med en fejlbesked
-- så ingen uønsket data gemmes i databasen.
-- ============================================

-- Forhindre besked på solgt bil + besked til sig selv
DROP TRIGGER IF EXISTS trg_message_before_insert$$
CREATE TRIGGER trg_message_before_insert
BEFORE INSERT ON message
FOR EACH ROW
BEGIN
    DECLARE v_is_sold BOOLEAN;

    -- Hent is_sold status for den pågældende annonce
    SELECT is_sold INTO v_is_sold
    FROM car_listing
    WHERE id = NEW.car_listing_id;

    -- Afvis hvis bilen er solgt
    IF v_is_sold = TRUE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke sende besked: bilen er allerede solgt.';
    END IF;

    -- Afvis hvis brugeren sender besked til sig selv
    IF NEW.sender_id = NEW.receiver_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke sende besked til dig selv.';
    END IF;
END$$

-- Forhindre favorit på solgt bil
DROP TRIGGER IF EXISTS trg_favorite_before_insert$$
CREATE TRIGGER trg_favorite_before_insert
BEFORE INSERT ON favorite
FOR EACH ROW
BEGIN
    DECLARE v_is_sold BOOLEAN;

    -- Hent is_sold status for den pågældende annonce
    SELECT is_sold INTO v_is_sold
    FROM car_listing
    WHERE id = NEW.car_listing_id;

    -- Afvis hvis bilen er solgt
    IF v_is_sold = TRUE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke tilføje til favoritter: bilen er allerede solgt.';
    END IF;
END$$

-- Forhindre ugyldige årstal på biler
DROP TRIGGER IF EXISTS trg_car_before_insert$$
CREATE TRIGGER trg_car_before_insert
BEFORE INSERT ON car
FOR EACH ROW
BEGIN
    -- Bilen må ikke være ældre end 1885 (første bil nogensinde)
    -- og ikke nyere end næste år
    IF NEW.year < 1885 OR NEW.year > YEAR(CURDATE()) + 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ugyldigt årstal: bilen skal være fra mellem 1885 og næste år.';
    END IF;
END$$

DELIMITER ;
