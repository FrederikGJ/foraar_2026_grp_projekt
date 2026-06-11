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

-- EXAMPLES (kun til manuel test — kør IKKE under init)
-- 1) Opret en test-listing:
--   CALL create_car_listing(2, 1, 'EventTestvej 999', '2999', 'EventBy', 1, 1, 123456.78, 2014, 98765, 'Lilla', 'EVENT TEST');
-- 2) Gør den ældre end 5 år:
--   UPDATE car_listing SET created_at = NOW() - INTERVAL 6 YEAR WHERE id = LAST_INSERT_ID();
-- 3) Kør event-body manuelt:
--   DELETE car_listing FROM car_listing LEFT JOIN car_sale ON car_sale.car_listing_id = car_listing.id WHERE car_listing.created_at < NOW() - INTERVAL 5 YEAR AND car_sale.id IS NULL;
-- 4) Tjek at den er slettet:
--   SELECT id, created_at FROM car_listing WHERE id = @created_car_listing_id;
