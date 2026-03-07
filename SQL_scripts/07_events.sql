SET GLOBAL event_scheduler = ON;

SHOW VARIABLES LIKE 'event_scheduler';

-- This event ensures that outdated, unsold listings are automatically cleaned up
-- to maintain database performance and prevent stale data accumulation.

DROP EVENT IF EXISTS delete_unsold_old_items;

CREATE EVENT delete_unsold_old_items
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
  DELETE car_listing
  FROM car_listing
  LEFT JOIN car_sale ON car_sale.car_listing_id = car_listing.id
  WHERE car_listing.created_at < NOW() - INTERVAL 5 YEAR
    AND car_sale.id IS NULL;

-- EXAMPLES
-- Example for delete_unsold_old_items
-- 1) Create new car listing
CALL create_car_listing(
    2,
    1,
    'EventTestvej 999',
    '2999',
    'EventBy',
    1,
    1,
    123456.78,
    2014,
    98765,
    'Lilla',
    'EVENT TEST: listing should be deleted when older than 5 years and has no car_sale record.'
);

-- Capture the new listing id
SET @created_car_listing_id = LAST_INSERT_ID();

-- Verify it exists right now
SELECT id, created_at
FROM car_listing
WHERE id = @created_car_listing_id;


-- 2) Make the car listing older than 5 years
UPDATE car_listing
SET created_at = NOW() - INTERVAL 6 YEAR
WHERE id = @created_car_listing_id;

-- Verify it's now old
SELECT id, created_at
FROM car_listing
WHERE id = @created_car_listing_id;


-- 3) "Manually trigger the event" (MySQL events can't be invoked directly, so we execute the event body)
DELETE car_listing
FROM car_listing
LEFT JOIN car_sale ON car_sale.car_listing_id = car_listing.id
WHERE car_listing.created_at < NOW() - INTERVAL 5 YEAR
  AND car_sale.id IS NULL;


-- 4) Show that listing was deleted (should return 0 rows)
SELECT id, created_at
FROM car_listing
WHERE id = @created_car_listing_id;
