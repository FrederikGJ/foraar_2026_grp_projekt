-- ============================================
-- BILBASEN CLONE - AUDIT TABLE & TRIGGERS
-- ============================================

DROP TABLE IF EXISTS car_listing_audit;
CREATE TABLE car_listing_audit (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    listing_id  BIGINT        NOT NULL,
    action      VARCHAR(10)   NOT NULL,        -- 'INSERT', 'SOLD', 'DELETE'
    changed_at  TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
    changed_by  BIGINT        DEFAULT NULL,
    old_price   DECIMAL(10,2) DEFAULT NULL,
    new_price   DECIMAL(10,2) DEFAULT NULL
);

-- ============================================
-- AUDIT TRIGGERS
-- ============================================

DELIMITER $$

-- Registrer når en ny annonce oprettes
DROP TRIGGER IF EXISTS trg_car_listing_after_insert$$
CREATE TRIGGER trg_car_listing_after_insert
AFTER INSERT ON car_listing
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit
        (listing_id, action, changed_by)
    VALUES
        (NEW.id, 'INSERT', NEW.seller_id);
END$$

-- Registrer når en annonce slettes
DROP TRIGGER IF EXISTS trg_car_listing_after_delete$$
CREATE TRIGGER trg_car_listing_after_delete
AFTER DELETE ON car_listing
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit
        (listing_id, action, changed_by)
    VALUES
        (OLD.id, 'DELETE', OLD.seller_id);
END$$

-- Registrer når en bil sælges (erstatning for UPDATE is_sold)
DROP TRIGGER IF EXISTS trg_car_sale_after_insert$$
CREATE TRIGGER trg_car_sale_after_insert
AFTER INSERT ON car_sale
FOR EACH ROW
BEGIN
    INSERT INTO car_listing_audit
        (listing_id, action, changed_by)
    VALUES
        (NEW.car_listing_id, 'SOLD', NEW.buyer_id);
END$$

-- Registrer prisændring på bil
DROP TRIGGER IF EXISTS trg_car_after_update$$
CREATE TRIGGER trg_car_after_update
AFTER UPDATE ON car
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        -- Find listing_id via car_id
        INSERT INTO car_listing_audit
            (listing_id, action, changed_by, old_price, new_price)
        SELECT
            cl.id,
            'UPDATE',
            cl.seller_id,
            OLD.price,
            NEW.price
        FROM car_listing cl
        WHERE cl.car_id = NEW.id;
    END IF;
END$$

-- ============================================
-- VALIDATION TRIGGERS
-- ============================================

-- Forhindre besked på solgt bil + besked til sig selv
DROP TRIGGER IF EXISTS trg_message_before_insert$$
CREATE TRIGGER trg_message_before_insert
BEFORE INSERT ON message
FOR EACH ROW
BEGIN
    DECLARE v_is_sold BOOLEAN;

    -- Udled salgsstatus fra car_sale (3NF)
    SELECT COUNT(*) > 0 INTO v_is_sold
    FROM car_sale
    WHERE car_listing_id = NEW.car_listing_id;

    IF v_is_sold = TRUE THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Kan ikke sende besked: bilen er allerede solgt.';
    END IF;

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

    -- Udled salgsstatus fra car_sale (3NF)
    SELECT COUNT(*) > 0 INTO v_is_sold
    FROM car_sale
    WHERE car_listing_id = NEW.car_listing_id;

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
    IF NEW.year < 1885 OR NEW.year > YEAR(CURDATE()) + 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ugyldigt årstal: bilen skal være fra mellem 1885 og næste år.';
    END IF;
END$$

DELIMITER ;
