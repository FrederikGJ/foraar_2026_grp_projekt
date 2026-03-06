DROP PROCEDURE IF EXISTS create_car_listing;

DELIMITER $$

CREATE PROCEDURE create_car_listing(
    IN input_seller_id BIGINT,
    IN input_region_id BIGINT,
    IN input_street VARCHAR(100),
    IN input_postal_code VARCHAR(10),
    IN input_city VARCHAR(50),
    IN input_model_id BIGINT,
    IN input_fuel_type_id BIGINT,
    IN input_price DECIMAL(10,2),
    IN input_year INT,
    IN input_mileage_km INT,
    IN input_color VARCHAR(30),
    IN input_description TEXT
)
BEGIN
    DECLARE created_address_id BIGINT;
    DECLARE created_car_id BIGINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaction failed: rolled back (no partial address/car/listing saved)';
    END;

    START TRANSACTION;

    INSERT INTO address (street, postal_code, city, region_id)
    VALUES (input_street, input_postal_code, input_city, input_region_id);
    SET created_address_id = LAST_INSERT_ID();

    INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color)
    VALUES (input_model_id, input_fuel_type_id, input_price, input_year, input_mileage_km, input_color);
    SET created_car_id = LAST_INSERT_ID();

    INSERT INTO car_listing (car_id, seller_id, address_id, description)
    VALUES (created_car_id, input_seller_id, created_address_id, input_description);

    COMMIT;
END$$

DELIMITER ;

-- EXAMPLES
-- Successful
CALL create_car_listing(
    2,
    1,
    'Testvej 123',
    '2100',
    'København Ø',
    11,
    4,
    279900.00,
    2020,
    52000,
    'Sort',
    'Tesla Model 3, velholdt, klar til levering.'
);

-- Fail (FK fails because seller_id does not exist in app_user)
CALL create_car_listing(
    999999,
    1,
    'Failvej 1',
    '2100',
    'København Ø',
    11,
    4,
    279900.00,
    2020,
    52000,
    'Sort',
    'This should fail because seller_id is invalid.'
);
