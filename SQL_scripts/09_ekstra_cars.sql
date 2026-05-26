-- =============================================================
-- 09_ekstra_cars.sql
-- 50 nye biler til salg — ingen er solgt
-- Bruger LAST_INSERT_ID() så IDs er auto increment-venlige
-- Fordeling: dealer 2 (10), dealer 3 (7), dealer 4 (14),
--            dealer 5 (5), dealer 6 (14)
-- =============================================================

-- ── 1. ADRESSER — én per forhandler ─────────────────────────
INSERT INTO address (street, postal_code, city, region_id) VALUES ('Automobilvej 4',   '2200', 'København N', 1);
SET @addr2 = LAST_INSERT_ID();

INSERT INTO address (street, postal_code, city, region_id) VALUES ('Bilcentervej 12',  '5000', 'Odense C',    3);
SET @addr3 = LAST_INSERT_ID();

INSERT INTO address (street, postal_code, city, region_id) VALUES ('Forhandlergade 7', '8000', 'Aarhus C',    4);
SET @addr4 = LAST_INSERT_ID();

INSERT INTO address (street, postal_code, city, region_id) VALUES ('Motorvejsalle 22', '6000', 'Kolding',     3);
SET @addr5 = LAST_INSERT_ID();

INSERT INTO address (street, postal_code, city, region_id) VALUES ('Industrivej 33',   '9000', 'Aalborg',     5);
SET @addr6 = LAST_INSERT_ID();


-- ── 2. BILER + LISTINGS ─────────────────────────────────────
-- Mønster: INSERT bil → LAST_INSERT_ID() bruges direkte i listing
-- Ingen hardkodede IDs — MySQL tildeler dem selv


-- ════════════════════════════════════════════════════════════
-- DEALER 2 · 10 biler · Automobilvej 4, København N
-- ════════════════════════════════════════════════════════════

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (1, 1, 114900.00, 2021, 21000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Toyota Corolla benzin med fuld servicebog, ét ejerskab og nysynet.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (7, 1, 134900.00, 2020, 29000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'VW Golf benzin med Android Auto, bakkamera og fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (15, 1, 94900.00, 2019, 44000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Ford Focus benzin med klimaanlæg, nyserviceret og lavt km-tal.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (22, 1, 199000.00, 2021, 17000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'BMW 3 Series benzin med Apple CarPlay, LED forlygter og 1 ejer.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (27, 2, 209000.00, 2020, 24000, 'Sølv');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Mercedes A-Class diesel med bakkamera, nysynet og isofix.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (33, 1, 184900.00, 2021, 19000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Audi A3 benzin med fuld servicebog, adaptiv fartpilot og lædersæder.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (38, 1, 129000.00, 2020, 31000, 'Rød');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Honda Civic benzin med fuld servicebog, nysynet og Apple CarPlay.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (43, 1, 59900.00, 2019, 57000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Hyundai i10 benzin – perfekt bybil med lavt forbrug og klimaanlæg.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (49, 1, 54900.00, 2018, 62000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Kia Picanto benzin – velholdt og ekonomisk med fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (55, 2, 134900.00, 2020, 27000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 2, @addr2, 'Nissan Micra diesel med LED forlygter, klimaanlæg og nysynet.', NOW());


-- ════════════════════════════════════════════════════════════
-- DEALER 3 · 7 biler · Bilcentervej 12, Odense C
-- ════════════════════════════════════════════════════════════

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (2, 1, 79900.00, 2020, 36000, 'Rød');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'Toyota Yaris benzin med bakkamera, lavt km-tal og 1 ejer.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (8, 1, 89900.00, 2021, 22000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'VW Polo benzin med isofix, klimaanlæg og nyserviceret.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (10, 2, 174900.00, 2021, 18000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'VW Tiguan diesel med panoramatag, 7 sæder og lædersæder.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (25, 2, 309000.00, 2022, 7000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'BMW X3 diesel med adaptiv fartpilot, LED forlygter og fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (44, 1, 84900.00, 2020, 33000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'Hyundai i20 benzin med bakkamera, isofix og 1 ejer.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (60, 1, 89900.00, 2020, 29000, 'Sølv');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'Renault Clio benzin med Apple CarPlay, klimaanlæg og nysynet.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (78, 1, 134900.00, 2020, 25000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 3, @addr3, 'Škoda Fabia benzin med fuld servicebog, 1 ejer og lavt km-tal.', NOW());


-- ════════════════════════════════════════════════════════════
-- DEALER 4 · 14 biler · Forhandlergade 7, Aarhus C
-- ════════════════════════════════════════════════════════════

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (4, 4, 229000.00, 2022, 9000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Toyota RAV4 hybrid med panoramatag, Apple CarPlay og varme i sæder.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (9, 2, 149900.00, 2019, 38000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'VW Passat diesel med træk, nysynet og vinterhjul medfølger.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (12, 3, 259000.00, 2022, 6000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'VW ID.3 elbil med 420 km rækkevidde, 1 ejer og hurtigoplader.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (13, 3, 299000.00, 2023, 4000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'VW ID.4 elbil med panoramatag, træk og varmepumpe.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (18, 4, 194900.00, 2022, 11000, 'Sølv');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Ford Kuga hybrid med Android Auto, panoramatag og lavt km-tal.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (23, 2, 294900.00, 2021, 14000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'BMW 5 Series diesel med adaptiv fartpilot, panoramatag og 1 ejer.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (28, 2, 279000.00, 2021, 13000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Mercedes C-Class diesel med automat gear, LED forlygter og bakkamera.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (31, 4, 299000.00, 2022, 8000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Mercedes GLC hybrid med lædersæder, adaptiv fartpilot og Apple CarPlay.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (35, 2, 294900.00, 2021, 16000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Audi A6 diesel med panoramatag, 1 ejer og fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (40, 2, 204900.00, 2021, 15000, 'Sølv');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Honda CR-V diesel med træk, panoramatag og fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (47, 4, 234900.00, 2022, 7000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Hyundai Kona hybrid med panoramatag, Apple CarPlay og LED forlygter.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (52, 2, 194900.00, 2022, 8000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Kia Sportage diesel med træk, panoramatag og Android Auto.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (72, 4, 174900.00, 2022, 10000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Citroën C5 Aircross hybrid med lædersæder, panoramatag og nysynet.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (87, 4, 299000.00, 2022, 6000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 4, @addr4, 'Volvo XC40 hybrid med Android Auto, lædersæder og fuld servicebog.', NOW());


-- ════════════════════════════════════════════════════════════
-- DEALER 5 · 5 biler · Motorvejsalle 22, Kolding
-- ════════════════════════════════════════════════════════════

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (6, 1, 69900.00, 2019, 53000, 'Rød');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 5, @addr5, 'Toyota Aygo benzin – ideel bybil med lavt forbrug og nysynet.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (16, 1, 74900.00, 2020, 41000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 5, @addr5, 'Ford Fiesta benzin med bakkamera, klimaanlæg og 1 ejer.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (50, 1, 79900.00, 2020, 38000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 5, @addr5, 'Kia Rio benzin med klimaanlæg, fuld servicebog og nysynet.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (65, 1, 84900.00, 2021, 26000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 5, @addr5, 'Peugeot 208 benzin med bakkamera, nysynet og lavt km-tal.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (74, 1, 79900.00, 2020, 35000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 5, @addr5, 'Opel Corsa benzin med Android Auto, klimaanlæg og isofix.', NOW());


-- ════════════════════════════════════════════════════════════
-- DEALER 6 · 14 biler · Industrivej 33, Aalborg
-- ════════════════════════════════════════════════════════════

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (26, 1, 459000.00, 2022, 5000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'BMW X5 benzin – topudstyret med lædersæder, isofix og lavt km-tal.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (29, 2, 184900.00, 2021, 16000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Mercedes GLA diesel med Apple CarPlay, LED forlygter og bakkamera.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (32, 2, 349000.00, 2022, 5000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Mercedes GLE diesel – stor SUV med fuld udrustning og panoramatag.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (36, 4, 224900.00, 2022, 9000, 'Sølv');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Audi Q3 hybrid med isofix, bakkamera og fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (37, 2, 234900.00, 2021, 11000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Audi Q5 diesel med adaptiv fartpilot, LED forlygter og lædersæder.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (46, 2, 204900.00, 2022, 9000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Hyundai Tucson diesel med adaptiv fartpilot, lædersæder og træk.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (48, 3, 379000.00, 2023, 3000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Hyundai Ioniq 5 elbil med 800V hurtigopladning og varmepumpe.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (53, 4, 224900.00, 2022, 7000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Kia Niro hybrid med adaptiv fartpilot, lavt forbrug og Apple CarPlay.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (54, 3, 359000.00, 2023, 2000, 'Rød');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Kia EV6 elbil med rækkevidde 528 km, 1 ejer og hurtigoplader.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (62, 4, 154900.00, 2022, 12000, 'Grå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Renault Captur hybrid med panoramatag, LED forlygter og Android Auto.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (67, 4, 184900.00, 2022, 9000, 'Hvid');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Peugeot 2008 hybrid med panoramatag, Apple CarPlay og isofix.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (80, 4, 174900.00, 2022, 11000, 'Sort');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Škoda Superb hybrid med panoramatag, lædersæder og isofix.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (88, 2, 184900.00, 2021, 18000, 'Sølv');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Volvo XC60 diesel med adaptiv fartpilot, panoramatag og fuld servicebog.', NOW());

INSERT INTO car (model_id, fuel_type_id, price, year, mileage_km, color) VALUES (92, 3, 669000.00, 2023, 2000, 'Blå');
INSERT INTO car_listing (car_id, seller_id, address_id, description, created_at) VALUES (LAST_INSERT_ID(), 6, @addr6, 'Tesla Model 3 med rækkevidde 576 km, Autopilot og 1 ejer.', NOW());
