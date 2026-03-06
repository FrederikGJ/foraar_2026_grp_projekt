-- ============================================
-- BILBASEN CLONE - KOMPLET SEED DATA
-- ============================================
-- Tilpasset til schema: 01_schema.sql
-- Passwords er bcrypt-hash af: password123
-- Kør dette script efter schema er oprettet
-- ============================================

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE message;
TRUNCATE TABLE favorite;
TRUNCATE TABLE car_listing;
TRUNCATE TABLE car;
TRUNCATE TABLE model;
TRUNCATE TABLE brand;
TRUNCATE TABLE fuel_type;
TRUNCATE TABLE address;
TRUNCATE TABLE app_user;
TRUNCATE TABLE region;
TRUNCATE TABLE role;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- ROLES (3 rækker)
-- ============================================
INSERT INTO role (id, name) VALUES
(1, 'ADMIN'),
(2, 'SELLER'),
(3, 'BUYER');

-- ============================================
-- REGIONS (5 rækker - danske regioner)
-- ============================================
INSERT INTO region (id, name) VALUES
(1, 'Nordjylland'),
(2, 'Midtjylland'),
(3, 'Syddanmark'),
(4, 'Sjælland'),
(5, 'Hovedstaden');

-- ============================================
-- FUEL TYPES (5 rækker)
-- ============================================
INSERT INTO fuel_type (id, name) VALUES
(1, 'Benzin'),
(2, 'Diesel'),
(3, 'El'),
(4, 'Hybrid'),
(5, 'Plug-in Hybrid');

-- ============================================
-- BRANDS (20 rækker)
-- ============================================
INSERT INTO brand (id, name) VALUES
(1, 'Toyota'), (2, 'Volkswagen'), (3, 'BMW'), (4, 'Audi'),
(5, 'Mercedes-Benz'), (6, 'Volvo'), (7, 'Peugeot'), (8, 'Ford'),
(9, 'Hyundai'), (10, 'Kia'), (11, 'Tesla'), (12, 'Skoda'),
(13, 'Renault'), (14, 'Nissan'), (15, 'Opel'), (16, 'Citroën'),
(17, 'Mazda'), (18, 'Seat'), (19, 'Fiat'), (20, 'Suzuki');

-- ============================================
-- MODELS (85 rækker)
-- ============================================
INSERT INTO model (id, name, brand_id) VALUES
-- Toyota
(1, 'Corolla', 1), (2, 'Yaris', 1), (3, 'RAV4', 1), (4, 'Aygo', 1), (5, 'C-HR', 1),
-- Volkswagen
(6, 'Golf', 2), (7, 'Polo', 2), (8, 'Passat', 2), (9, 'Tiguan', 2), (10, 'ID.4', 2),
-- BMW
(11, '3-serie', 3), (12, '1-serie', 3), (13, 'X3', 3), (14, 'iX3', 3), (15, 'i4', 3),
-- Audi
(16, 'A3', 4), (17, 'A4', 4), (18, 'Q3', 4), (19, 'e-tron', 4), (20, 'Q5', 4),
-- Mercedes
(21, 'A-Klasse', 5), (22, 'C-Klasse', 5), (23, 'GLC', 5), (24, 'EQA', 5), (25, 'EQC', 5),
-- Volvo
(26, 'V60', 6), (27, 'XC40', 6), (28, 'XC60', 6), (29, 'XC90', 6), (30, 'EX30', 6),
-- Peugeot
(31, '208', 7), (32, '308', 7), (33, '3008', 7), (34, 'e-208', 7), (35, '508', 7),
-- Ford
(36, 'Focus', 8), (37, 'Fiesta', 8), (38, 'Kuga', 8), (39, 'Puma', 8), (40, 'Mustang Mach-E', 8),
-- Hyundai
(41, 'i20', 9), (42, 'i30', 9), (43, 'Tucson', 9), (44, 'Kona Electric', 9), (45, 'Ioniq 5', 9),
-- Kia
(46, 'Ceed', 10), (47, 'Sportage', 10), (48, 'Niro EV', 10), (49, 'EV6', 10), (50, 'Picanto', 10),
-- Tesla
(51, 'Model 3', 11), (52, 'Model Y', 11), (53, 'Model S', 11), (54, 'Model X', 11),
-- Skoda
(55, 'Octavia', 12), (56, 'Fabia', 12), (57, 'Superb', 12), (58, 'Enyaq', 12), (59, 'Kamiq', 12),
-- Renault
(60, 'Clio', 13), (61, 'Megane', 13), (62, 'Captur', 13), (63, 'Zoe', 13), (64, 'Megane E-Tech', 13),
-- Nissan
(65, 'Qashqai', 14), (66, 'Juke', 14), (67, 'Leaf', 14), (68, 'Micra', 14),
-- Opel
(69, 'Corsa', 15), (70, 'Astra', 15), (71, 'Mokka-e', 15),
-- Citroën
(72, 'C3', 16), (73, 'C4', 16), (74, 'ë-C4', 16),
-- Mazda
(75, 'Mazda3', 17), (76, 'CX-5', 17), (77, 'MX-30', 17),
-- Seat
(78, 'Ibiza', 18), (79, 'Leon', 18), (80, 'Arona', 18),
-- Fiat
(81, '500', 19), (82, '500e', 19), (83, 'Tipo', 19),
-- Suzuki
(84, 'Swift', 20), (85, 'Vitara', 20);

-- ============================================
-- USERS (100 rækker)
-- Passwords er bcrypt-hash af: password123
-- BEMÆRK: Kolonnen 'private_seller' er IKKE i schema
-- ============================================
INSERT INTO app_user (id, username, email, password_hash, first_name, last_name, phone, role_id) VALUES
-- ADMINS (1-5)
(1,  'admin1',         'admin1@bilbasen.dk',          '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lars',      'Hansen',      '20123456', 1),
(2,  'admin2',         'admin2@bilbasen.dk',          '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mette',     'Jensen',      '20234567', 1),
(3,  'admin3',         'admin3@bilbasen.dk',          '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Søren',     'Nielsen',     '20345678', 1),
(4,  'admin4',         'admin4@bilbasen.dk',          '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anne',      'Pedersen',    '20456789', 1),
(5,  'admin5',         'admin5@bilbasen.dk',          '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Peter',     'Andersen',    '20567890', 1),
-- SELLERS (6-30)
(6,  'autohandler_kbh',   'kbh@autohandler.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Thomas',    'Møller',      '30123456', 2),
(7,  'biler_aarhus',      'info@bileraarhus.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mikkel',    'Christensen', '30234567', 2),
(8,  'privat_erik',       'erik.holm@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Erik',      'Holm',        '30345678', 2),
(9,  'kvalitetsbiler',    'info@kvalitetsbiler.dk',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Camilla',   'Larsen',      '30456789', 2),
(10, 'privat_jonas',      'jonas.wind@yahoo.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jonas',     'Wind',        '30567890', 2),
(11, 'bilhuset_odense',   'salg@bilhuset.dk',         '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rasmus',    'Sørensen',    '31123456', 2),
(12, 'privat_maria',      'maria.berg@hotmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Maria',     'Berg',        '31234567', 2),
(13, 'nordjysk_auto',     'salg@nordjyskauto.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Henrik',    'Dahl',        '31345678', 2),
(14, 'privat_lise',       'lise.krogh@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lise',      'Krogh',       '31456789', 2),
(15, 'tesla_specialist',  'info@teslaspec.dk',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Frederik',  'Lund',        '31567890', 2),
(16, 'privat_karsten',    'karsten.ny@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Karsten',   'Nygaard',     '32123456', 2),
(17, 'premium_biler',     'info@premiumbiler.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nikolaj',   'Friis',       '32234567', 2),
(18, 'privat_susanne',    'susanne.bach@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Susanne',   'Bach',        '32345678', 2),
(19, 'sjaelland_auto',    'salg@sjaellandauto.dk',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anders',    'Gram',        '32456789', 2),
(20, 'privat_martin',     'martin.bak@outlook.dk',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Martin',    'Bak',         '32567890', 2),
(21, 'elbil_center',      'info@elbilcenter.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jakob',     'Kjær',        '33123456', 2),
(22, 'privat_line',       'line.frost@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Line',      'Frost',       '33234567', 2),
(23, 'syd_autosalg',      'info@sydautosalg.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Christian', 'Bruun',       '33345678', 2),
(24, 'privat_katrine',    'katrine.vig@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Katrine',   'Vig',         '33456789', 2),
(25, 'bilpalads',         'salg@bilpalads.dk',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jens',      'Storm',       '33567890', 2),
(26, 'privat_brian',      'brian.voss@yahoo.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Brian',     'Voss',        '34123456', 2),
(27, 'midtjylland_biler', 'salg@midtbiler.dk',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Torben',    'Rask',        '34234567', 2),
(28, 'privat_helle',      'helle.lind@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Helle',     'Lind',        '34345678', 2),
(29, 'familieauto',       'info@familieauto.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Kim',       'Skov',        '34456789', 2),
(30, 'privat_ole',        'ole.park@outlook.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ole',       'Park',        '34567890', 2),
-- BUYERS (31-100)
(31, 'buyer_anna',        'anna.vik@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anna',      'Vik',         '40123456', 3),
(32, 'buyer_peter',       'peter.due@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Peter',     'Due',         '40234567', 3),
(33, 'buyer_sofie',       'sofie.blom@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sofie',     'Blom',        '40345678', 3),
(34, 'buyer_mark',        'mark.sten@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mark',      'Sten',        '40456789', 3),
(35, 'buyer_ida',         'ida.krog@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ida',       'Krog',        '40567890', 3),
(36, 'buyer_kasper',      'kasper.dam@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Kasper',    'Dam',         '41123456', 3),
(37, 'buyer_emma',        'emma.lund@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Emma',      'Lund',        '41234567', 3),
(38, 'buyer_oliver',      'oliver.bech@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Oliver',    'Bech',        '41345678', 3),
(39, 'buyer_freja',       'freja.kirk@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Freja',     'Kirk',        '41456789', 3),
(40, 'buyer_noah',        'noah.noel@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Noah',      'Noel',        '41567890', 3),
(41, 'buyer_ella',        'ella.hauge@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ella',      'Hauge',       '42123456', 3),
(42, 'buyer_victor',      'victor.fly@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Victor',    'Fly',         '42234567', 3),
(43, 'buyer_maja',        'maja.ravn@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Maja',      'Ravn',        '42345678', 3),
(44, 'buyer_lucas',       'lucas.busk@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lucas',     'Busk',        '42456789', 3),
(45, 'buyer_clara',       'clara.from@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Clara',     'From',        '42567890', 3),
(46, 'buyer_oscar',       'oscar.birk@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Oscar',     'Birk',        '43123456', 3),
(47, 'buyer_laura',       'laura.tang@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Laura',     'Tang',        '43234567', 3),
(48, 'buyer_william',     'william.hald@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'William',   'Hald',        '43345678', 3),
(49, 'buyer_alberte',     'alberte.gad@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alberte',   'Gad',         '43456789', 3),
(50, 'buyer_carl',        'carl.nord@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Carl',      'Nord',        '43567890', 3),
(51, 'buyer_nora',        'nora.sand@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nora',      'Sand',        '44123456', 3),
(52, 'buyer_august',      'august.elm@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'August',    'Elm',         '44234567', 3),
(53, 'buyer_rosa',        'rosa.fjord@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rosa',      'Fjord',       '44345678', 3),
(54, 'buyer_magnus',      'magnus.hav@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Magnus',    'Hav',         '44456789', 3),
(55, 'buyer_astrid',      'astrid.sol@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Astrid',    'Sol',         '44567890', 3),
(56, 'buyer_valdemar',    'valdemar.ege@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Valdemar',  'Ege',         '45123456', 3),
(57, 'buyer_agnes',       'agnes.ask@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Agnes',     'Ask',         '45234567', 3),
(58, 'buyer_malthe',      'malthe.ly@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Malthe',    'Ly',          '45345678', 3),
(59, 'buyer_karla',       'karla.eng@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Karla',     'Eng',         '45456789', 3),
(60, 'buyer_theodor',     'theodor.aa@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Theodor',   'Aa',          '45567890', 3),
(61, 'buyer_vigga',       'vigga.mos@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Vigga',     'Mos',         '46123456', 3),
(62, 'buyer_aksel',       'aksel.dal@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Aksel',     'Dal',         '46234567', 3),
(63, 'buyer_filippa',     'filippa.ros@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Filippa',   'Ros',         '46345678', 3),
(64, 'buyer_storm',       'storm.lys@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Storm',     'Lys',         '46456789', 3),
(65, 'buyer_liv',         'liv.mark@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Liv',       'Mark',        '46567890', 3),
(66, 'buyer_konrad',      'konrad.bro@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Konrad',    'Bro',         '47123456', 3),
(67, 'buyer_frida',       'frida.holm@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Frida',     'Holm',        '47234567', 3),
(68, 'buyer_vilhelm',     'vilhelm.soe@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Vilhelm',   'Søe',         '47345678', 3),
(69, 'buyer_alma',        'alma.sky@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alma',      'Sky',         '47456789', 3),
(70, 'buyer_elias',       'elias.vind@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Elias',     'Vind',        '47567890', 3),
(71, 'buyer_johanne',     'johanne.ris@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Johanne',   'Ris',         '48123456', 3),
(72, 'buyer_erik2',       'erik.bak@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Erik',      'Bak',         '48234567', 3),
(73, 'buyer_mathilde',    'mathilde.rye@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mathilde',  'Rye',         '48345678', 3),
(74, 'buyer_sigurd',      'sigurd.boe@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sigurd',    'Boe',         '48456789', 3),
(75, 'buyer_ellen',       'ellen.graa@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ellen',     'Graa',        '48567890', 3),
(76, 'buyer_alfred',      'alfred.roe@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alfred',    'Roe',         '49123456', 3),
(77, 'buyer_hannah',      'hannah.top@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Hannah',    'Top',         '49234567', 3),
(78, 'buyer_felix',       'felix.fyr@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Felix',     'Fyr',         '49345678', 3),
(79, 'buyer_isabella',    'isabella.bor@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Isabella',  'Bor',         '49456789', 3),
(80, 'buyer_sebastian',   'sebastian.ko@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sebastian', 'Ko',          '49567890', 3),
(81, 'buyer_marie',       'marie.fugl@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Marie',     'Fugl',        '50123456', 3),
(82, 'buyer_tobias',      'tobias.kvist@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Tobias',    'Kvist',       '50234567', 3),
(83, 'buyer_emilie',      'emilie.pil@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Emilie',    'Pil',         '50345678', 3),
(84, 'buyer_mikkel2',     'mikkel.flod@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mikkel',    'Flod',        '50456789', 3),
(85, 'buyer_signe',       'signe.jord@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Signe',     'Jord',        '50567890', 3),
(86, 'buyer_daniel',      'daniel.toft@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Daniel',    'Toft',        '51123456', 3),
(87, 'buyer_josefine',    'josefine.lyn@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Josefine',  'Lyn',         '51234567', 3),
(88, 'buyer_alexander',   'alexander.gul@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alexander', 'Gul',         '51345678', 3),
(89, 'buyer_victoria',    'victoria.dam@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Victoria',  'Dam',         '51456789', 3),
(90, 'buyer_christian',   'christian.ege@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Christian', 'Ege',         '51567890', 3),
(91, 'buyer_petra',       'petra.lund@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Petra',     'Lund',        '52123456', 3),
(92, 'buyer_rasmus2',     'rasmus.brandt@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rasmus',    'Brandt',      '52234567', 3),
(93, 'buyer_sara',        'sara.dam@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sara',      'Dam',         '52345678', 3),
(94, 'buyer_jakob2',      'jakob.holt@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jakob',     'Holt',        '52456789', 3),
(95, 'buyer_thea',        'thea.vang@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Thea',      'Vang',        '52567890', 3),
(96, 'buyer_nikolaj2',    'nikolaj.brix@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nikolaj',   'Brix',        '53123456', 3),
(97, 'buyer_lea',         'lea.holm@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lea',       'Holm',        '53234567', 3),
(98, 'buyer_mads',        'mads.dahl@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mads',      'Dahl',        '53345678', 3),
(99, 'buyer_olivia',      'olivia.krog@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Olivia',    'Krog',        '53456789', 3),
(100,'buyer_simon',       'simon.west@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Simon',     'West',        '53567890', 3);

-- ============================================
-- ADDRESS (100 rækker)
-- ============================================
INSERT INTO address (id, street, postal_code, city, region_id) VALUES
-- Forhandlere (faste forretningsadresser)
(1,  'Østerbrogade 142',        '2100', 'København Ø',    5),
(2,  'Valby Langgade 85',       '2500', 'Valby',           5),
(3,  'Lyngbyvej 234',           '2800', 'Lyngby',          5),
(4,  'Gladsaxe Møllevej 45',    '2860', 'Søborg',          5),
(5,  'Ringgaden 32',            '8000', 'Aarhus C',        2),
(6,  'Silkeborgvej 199',        '8000', 'Aarhus N',        2),
(7,  'Viborgvej 88',            '8210', 'Aarhus V',        2),
(8,  'Hjallesevej 126',         '5230', 'Odense M',        3),
(9,  'Fynsvej 45',              '5000', 'Odense C',        3),
(10, 'Tværvej 12',              '6000', 'Kolding',         3),
(11, 'Hobrovej 234',            '9000', 'Aalborg',         1),
(12, 'Køgevej 154',             '4000', 'Roskilde',        4),
(13, 'Ringstedvej 76',          '4200', 'Slagelse',        4),
-- Private sælgere
(14, 'Søndergade 12',           '9000', 'Aalborg',         1),
(15, 'Lindholm Brygge 45',      '9400', 'Nørresundby',     1),
(16, 'Kystvej 23',              '9300', 'Sæby',            1),
(17, 'Frederiksberg Allé 89',   '1820', 'Frederiksberg',   5),
(18, 'Amagerbrogade 156',       '2300', 'København S',     5),
(19, 'Vallensbækvej 34',        '2625', 'Vallensbæk',      4),
(20, 'Tranegårdsvej 56',        '2900', 'Hellerup',        5),
(21, 'Søvang 23',               '8260', 'Viby J',          2),
(22, 'Stjernholm Allé 12',      '8381', 'Tilst',           2),
(23, 'Grenåvej 45',             '8500', 'Grenaa',          2),
(24, 'Boulevarden 67',          '5000', 'Odense C',        3),
(25, 'Rosengård Allé 8',        '5100', 'Odense',          3),
(26, 'Vestergade 34',           '6700', 'Esbjerg',         3),
(27, 'Algade 156',              '4000', 'Roskilde',        4),
(28, 'Ringstedvej 12',          '4100', 'Ringsted',        4),
-- Ekstra adresser for buyer-favoritlokationer og varieret dækning
(29, 'Nørregade 78',            '1165', 'København K',     5),
(30, 'Vesterbrogade 234',       '1620', 'København V',     5),
(31, 'Frederikssundsvej 165',   '2700', 'Brønshøj',        5),
(32, 'Åboulevarden 45',         '8000', 'Aarhus C',        2),
(33, 'Randersvej 234',          '8200', 'Aarhus N',        2),
(34, 'Møllevej 12',             '7400', 'Herning',         2),
(35, 'Nørregade 89',            '6100', 'Haderslev',       3),
(36, 'Kongevejen 45',           '6200', 'Aabenraa',        3),
(37, 'Nygade 23',               '7100', 'Vejle',           3),
(38, 'Algade 67',               '4700', 'Næstved',         4),
(39, 'Torvegade 34',            '4600', 'Køge',            4),
(40, 'Frederiksgade 12',        '4800', 'Nykøbing F',      4),
-- Buyer adresser (til fremtidig brug / adresselookup)
(41, 'Nørrebrogade 88',         '2200', 'København N',     5),
(42, 'Tagensvej 45',            '2200', 'København N',     5),
(43, 'Hillerødgade 23',         '2400', 'København NV',    5),
(44, 'Hvidovrevej 78',          '2650', 'Hvidovre',        5),
(45, 'Roskildevej 112',         '2620', 'Albertslund',     4),
(46, 'Jernbanegade 34',         '3400', 'Hillerød',        5),
(47, 'Frederiksvej 56',         '3000', 'Helsingør',       5),
(48, 'Strandvejen 89',          '3060', 'Espergærde',      5),
(49, 'Kongevej 12',             '3200', 'Helsinge',        5),
(50, 'Hovedgaden 45',           '3300', 'Frederiksværk',   5),
(51, 'Rådhusgade 23',           '4300', 'Holbæk',          4),
(52, 'Algade 78',               '4400', 'Kalundborg',      4),
(53, 'Stationsvej 34',          '4500', 'Nykøbing Sj',     4),
(54, 'Torvet 12',               '4800', 'Nykøbing F',      4),
(55, 'Langgade 56',             '4900', 'Nakskov',         4),
(56, 'Vestergade 23',           '5700', 'Svendborg',       3),
(57, 'Nørregade 45',            '5800', 'Nyborg',          3),
(58, 'Torvegade 78',            '5500', 'Middelfart',      3),
(59, 'Algade 34',               '5600', 'Faaborg',         3),
(60, 'Strandgade 12',           '5300', 'Kerteminde',      3),
(61, 'Jernbanegade 56',         '7000', 'Fredericia',      3),
(62, 'Kongevej 23',             '7200', 'Grindsted',       3),
(63, 'Skolegade 45',            '7300', 'Jelling',         3),
(64, 'Torvet 78',               '7500', 'Holstebro',       2),
(65, 'Nørregade 12',            '7600', 'Struer',          2),
(66, 'Stationsgade 34',         '7700', 'Thisted',         1),
(67, 'Vestergade 56',           '7800', 'Skive',           2),
(68, 'Algade 23',               '7900', 'Nykøbing M',      2),
(69, 'Torvet 45',               '8300', 'Odder',           2),
(70, 'Nørregade 78',            '8400', 'Ebeltoft',        2),
(71, 'Strandvej 12',            '8600', 'Silkeborg',       2),
(72, 'Jernbanegade 34',         '8700', 'Horsens',         2),
(73, 'Kongevej 56',             '8800', 'Viborg',          2),
(74, 'Skolegade 23',            '8900', 'Randers C',       2),
(75, 'Torvegade 45',            '9200', 'Aalborg SV',      1),
(76, 'Vestergade 78',           '9500', 'Hobro',           1),
(77, 'Nørregade 12',            '9600', 'Aars',            1),
(78, 'Algade 34',               '9700', 'Brønderslev',     1),
(79, 'Torvet 56',               '9800', 'Hjørring',        1),
(80, 'Strandgade 23',           '9900', 'Frederikshavn',   1),
(81, 'Havnegade 45',            '9990', 'Skagen',          1),
(82, 'Møllevej 78',             '9670', 'Løgstør',         1),
(83, 'Kirkegade 12',            '9560', 'Hadsund',         1),
(84, 'Byvej 34',                '9480', 'Løkken',          1),
(85, 'Engvej 56',               '9380', 'Vestbjerg',       1),
(86, 'Skovvej 23',              '9280', 'Storvorde',       1),
(87, 'Bakken 45',               '9230', 'Svenstrup J',     1),
(88, 'Dalvej 78',               '9220', 'Aalborg Ø',       1),
(89, 'Parkvej 12',              '9210', 'Aalborg SØ',      1),
(90, 'Boulevarden 34',          '9100', 'Aalborg',         1),
(91, 'Industrivej 56',          '8660', 'Skanderborg',     2),
(92, 'Søndergade 23',           '8620', 'Kjellerup',       2),
(93, 'Søvej 45',                '8550', 'Ryomgård',        2),
(94, 'Åvej 78',                 '8520', 'Lystrup',         2),
(95, 'Skovbrynet 12',           '8462', 'Harlev J',        2),
(96, 'Markvej 34',              '8450', 'Hammel',          2),
(97, 'Dalbyvej 56',             '8370', 'Hadsten',         2),
(98, 'Sønderalle 23',           '8320', 'Mårslet',         2),
(99, 'Hedevej 45',              '8310', 'Tranbjerg J',     2),
(100,'Nørre Allé 67',           '8270', 'Højbjerg',        2);

-- ============================================
-- CAR (100 rækker)
-- BEMÆRK: Kolonnen 'description' er ikke i schema
-- Description hører til car_listing
-- ============================================
INSERT INTO car (id, model_id, fuel_type_id, price, year, mileage_km, color) VALUES
(1,  36, 1, 89900.00,  2018, 78000,  'Rød'),
(2,  31, 1, 79900.00,  2019, 55000,  'Hvid'),
(3,  3,  1, 189900.00, 2020, 42000,  'Blå'),
(4,  4,  1, 49900.00,  2018, 42000,  'Sort'),
(5,  5,  4, 229900.00, 2022, 18000,  'Sølv'),
(6,  7,  1, 89900.00,  2019, 62000,  'Grå'),
(7,  8,  2, 149900.00, 2020, 55000,  'Sort'),
(8,  55, 2, 139900.00, 2019, 72000,  'Sølv'),
(9,  11, 1, 199900.00, 2021, 32000,  'Sort'),
(10, 60, 1, 69900.00,  2018, 68000,  'Rød'),
(11, 13, 2, 259900.00, 2020, 48000,  'Grå'),
(12, 22, 1, 279900.00, 2020, 38000,  'Sort'),
(13, 19, 3, 399900.00, 2022, 22000,  'Hvid'),
(14, 65, 1, 149900.00, 2021, 28000,  'Blå'),
(15, 36, 1, 99900.00,  2018, 85000,  'Sort'),
(16, 60, 1, 79900.00,  2020, 42000,  'Hvid'),
(17, 32, 1, 109900.00, 2019, 68000,  'Rød'),
(18, 22, 5, 349900.00, 2022, 18000,  'Sort'),
(19, 46, 1, 129900.00, 2021, 35000,  'Blå'),
(20, 41, 1, 69900.00,  2018, 72000,  'Hvid'),
(21, 21, 1, 129900.00, 2020, 48000,  'Sølv'),
(22, 23, 2, 289900.00, 2020, 52000,  'Sort'),
(23, 11, 1, 229900.00, 2021, 28000,  'Hvid'),
(24, 15, 3, 429900.00, 2022, 15000,  'Sort'),
(25, 29, 3, 499900.00, 2021, 28000,  'Grå'),
(26, 84, 1, 79900.00,  2020, 38000,  'Rød'),
(27, 76, 2, 199900.00, 2020, 48000,  'Sort'),
(28, 65, 4, 219900.00, 2022, 22000,  'Blå'),
(29, 51, 3, 279900.00, 2021, 35000,  'Hvid'),
(30, 52, 3, 319900.00, 2022, 18000,  'Rød'),
(31, 53, 3, 449900.00, 2020, 42000,  'Sort'),
(32, 51, 3, 249900.00, 2020, 48000,  'Grå'),
(33, 8,  2, 129900.00, 2018, 98000,  'Sølv'),
(34, 69, 1, 79900.00,  2019, 62000,  'Hvid'),
(35, 13, 2, 299900.00, 2021, 38000,  'Sort'),
(36, 17, 2, 239900.00, 2019, 68000,  'Grå'),
(37, 76, 2, 229900.00, 2021, 42000,  'Sort'),
(38, 23, 2, 379900.00, 2021, 42000,  'Sort'),
(39, 72, 1, 59900.00,  2017, 72000,  'Hvid'),
(40, 62, 1, 109900.00, 2019, 55000,  'Orange'),
(41, 27, 3, 259900.00, 2022, 20000,  'Blå'),
(42, 44, 3, 199900.00, 2021, 30000,  'Hvid'),
(43, 67, 3, 159900.00, 2020, 42000,  'Grå'),
(44, 58, 3, 299900.00, 2023, 10000,  'Sort'),
(45, 75, 1, 149900.00, 2020, 48000,  'Rød'),
(46, 79, 1, 119900.00, 2019, 62000,  'Sort'),
(47, 10, 3, 279900.00, 2022, 25000,  'Hvid'),
(48, 45, 3, 349900.00, 2023, 8000,   'Grå'),
(49, 49, 3, 379900.00, 2023, 12000,  'Grøn'),
(50, 48, 3, 229900.00, 2022, 18000,  'Blå'),
(51, 50, 1, 59900.00,  2019, 35000,  'Rød'),
(52, 4,  1, 49900.00,  2018, 42000,  'Sort'),
(53, 26, 2, 239900.00, 2020, 65000,  'Sort'),
(54, 57, 2, 179900.00, 2019, 82000,  'Sølv'),
(55, 35, 5, 199900.00, 2020, 55000,  'Grå'),
(56, 16, 1, 169900.00, 2021, 32000,  'Hvid'),
(57, 68, 1, 49900.00,  2016, 78000,  'Grøn'),
(58, 37, 1, 59900.00,  2017, 65000,  'Blå'),
(59, 20, 2, 299900.00, 2021, 40000,  'Sort'),
(60, 5,  4, 229900.00, 2022, 18000,  'Sølv'),
(61, 14, 3, 319900.00, 2021, 32000,  'Hvid'),
(62, 24, 3, 289900.00, 2022, 22000,  'Sort'),
(63, 33, 5, 249900.00, 2022, 20000,  'Blå'),
(64, 42, 1, 119900.00, 2019, 70000,  'Rød'),
(65, 56, 1, 89900.00,  2020, 48000,  'Grå'),
(66, 38, 5, 239900.00, 2022, 28000,  'Grøn'),
(67, 12, 2, 189900.00, 2020, 52000,  'Blå'),
(68, 18, 1, 219900.00, 2021, 38000,  'Sort'),
(69, 59, 1, 159900.00, 2021, 30000,  'Hvid'),
(70, 34, 3, 149900.00, 2021, 22000,  'Blå'),
(71, 82, 3, 159900.00, 2022, 15000,  'Hvid'),
(72, 3,  4, 299900.00, 2022, 22000,  'Grå'),
(73, 43, 4, 249900.00, 2023, 10000,  'Blå'),
(74, 9,  2, 219900.00, 2020, 58000,  'Sort'),
(75, 28, 5, 359900.00, 2022, 28000,  'Hvid'),
(76, 78, 1, 79900.00,  2018, 62000,  'Sort'),
(77, 61, 2, 99900.00,  2017, 95000,  'Sølv'),
(78, 40, 3, 369900.00, 2022, 18000,  'Grå'),
(79, 30, 3, 299900.00, 2024, 5000,   'Hvid'),
(80, 63, 3, 119900.00, 2020, 38000,  'Blå'),
(81, 71, 3, 179900.00, 2022, 20000,  'Sort'),
(82, 64, 3, 249900.00, 2023, 12000,  'Grå'),
(83, 77, 3, 199900.00, 2022, 15000,  'Sølv'),
(84, 74, 3, 219900.00, 2023, 8000,   'Hvid'),
(85, 25, 3, 289900.00, 2021, 35000,  'Blå'),
(86, 73, 2, 149900.00, 2021, 42000,  'Rød'),
(87, 85, 4, 139900.00, 2021, 32000,  'Grøn'),
(88, 83, 1, 109900.00, 2020, 48000,  'Sølv'),
(89, 80, 1, 119900.00, 2020, 42000,  'Orange'),
(90, 66, 1, 99900.00,  2019, 52000,  'Sort'),
(91, 39, 4, 179900.00, 2022, 22000,  'Blå'),
(92, 54, 3, 599900.00, 2020, 42000,  'Sort'),
(93, 1,  4, 189900.00, 2022, 18000,  'Hvid'),
(94, 6,  3, 239900.00, 2021, 28000,  'Grå'),
(95, 27, 5, 299900.00, 2023, 8000,   'Sort'),
(96, 11, 5, 349900.00, 2022, 25000,  'Hvid'),
(97, 22, 4, 289900.00, 2022, 30000,  'Sort'),
(98, 16, 1, 189900.00, 2022, 18000,  'Rød'),
(99, 52, 3, 359900.00, 2023, 8000,   'Sølv'),
(100,47, 5, 269900.00, 2023, 15000,  'Grøn');

-- ============================================
-- CAR LISTINGS (100 rækker)
-- description kolonnen er i car_listing i schema
-- ============================================
INSERT INTO car_listing (id, car_id, seller_id, address_id, is_sold, description, created_at) VALUES
-- autohandler_kbh (seller 6) - 8 biler
(1,  1,  6,  1, FALSE, 'Ford Focus 1.5 EcoBlue. ST-Line. Fuld servicehistorik. Parkeringssensorer.',      '2024-10-15 10:00:00'),
(2,  2,  6,  1, FALSE, 'Peugeot 208 1.2 PureTech. Allure. Panoramatag. Trykluftskontrol.',                '2024-10-18 11:30:00'),
(3,  3,  6,  1, FALSE, 'Toyota RAV4 2.5 Hybrid. Style. 218 hk. Adaptiv fartpilot.',                      '2024-10-20 14:00:00'),
(4,  4,  6,  1, FALSE, 'Toyota Aygo 1.0. X-play. Lav km. Billig i drift og forsikring.',                 '2024-10-22 09:15:00'),
(5,  78, 6,  1, FALSE, 'Ford Mustang Mach-E Extended Range. Premium. AWD. 351 km rækkevidde.',            '2024-11-01 08:00:00'),
(6,  91, 6,  1, FALSE, 'Ford Puma 1.0 EcoBoost Hybrid. ST-Line X. MegaBox. Køreklart.',                  '2024-11-05 10:30:00'),
(7,  94, 6,  1, FALSE, 'VW ID.3 Pro S. 77 kWh. Tech-pakke. Matrix LED. Ladeledning medfølger.',          '2024-11-08 13:00:00'),
(8,  21, 6,  1, TRUE,  'Mercedes A-Klasse 180 d. Progressive. SOLGT.',                                    '2024-09-10 12:00:00'),
-- biler_aarhus (seller 7) - 6 biler
(9,  5,  7,  5, FALSE, 'Toyota C-HR 2.0 Hybrid. GR Sport. JBL lyd. El-bagklap.',                        '2024-10-16 09:00:00'),
(10, 6,  7,  5, FALSE, 'VW Polo 1.0 TSI. Comfortline. Multiratsbacket. Rygsensor.',                      '2024-10-19 10:00:00'),
(11, 7,  7,  5, FALSE, 'VW Passat 2.0 TDI. Business. Digital Cockpit. 150 hk.',                          '2024-10-21 11:00:00'),
(12, 8,  7,  5, FALSE, 'Skoda Octavia 2.0 TDI. Ambition. Columbus navi. Full LED.',                      '2024-10-23 14:30:00'),
(13, 79, 7,  5, FALSE, 'Volvo EX30 Single Motor Extended Range. Ultra. B&W lyd.',                        '2024-11-02 09:00:00'),
(14, 92, 7,  5, FALSE, 'Tesla Model X Long Range. 6-sæder. Premium. Autopilot.',                         '2024-11-07 10:00:00'),
-- privat_erik (seller 8) - 2 biler
(15, 9,  8,  14, FALSE, 'BMW 3-serie 320i. Sport Line. Nybagt syn. Ingen rust. 1 ejer.',                 '2024-10-17 10:00:00'),
(16, 10, 8,  14, FALSE, 'Renault Clio 1.0 TCe. Zen. Tårnlamper. God bybil. Sælges pga. ny bil.',         '2024-10-24 13:00:00'),
-- kvalitetsbiler (seller 9) - 7 biler
(17, 11, 9,  9, FALSE, 'BMW X3 xDrive20d. M-Sport. Panoramatag. HeadUp Display.',                        '2024-10-18 12:00:00'),
(18, 12, 9,  9, FALSE, 'Mercedes C-Klasse 220d. AMG-Line. Burmester. Komplet udstyr.',                   '2024-10-20 09:30:00'),
(19, 13, 9,  9, FALSE, 'Audi e-tron 55 quattro. Advanced. Matrix LED. 300 km rækkevidde.',               '2024-10-22 10:00:00'),
(20, 14, 9,  9, FALSE, 'BMW iX3 Impressive. 286 hk. Driving Assistant Professional.',                    '2024-10-25 11:30:00'),
(21, 80, 9,  9, FALSE, 'Renault Zoe R135 Intens. 52 kWh. CCS-lading. Komplet serviceret.',               '2024-11-03 12:00:00'),
(22, 93, 9,  9, FALSE, 'Toyota Corolla TS 2.0 Hybrid. H3 Smart. Panoramatag. Lav km.',                  '2024-11-09 09:30:00'),
(23, 55, 9,  9, TRUE,  'Peugeot 508 SW Hybrid. GT. Solgt og afhentet.',                                  '2024-09-15 14:00:00'),
-- privat_jonas (seller 10) - 2 biler
(24, 15, 10, 19, FALSE, 'BMW 3-serie 318d. Advantage. Servicebog. 1 privat ejer fra ny.',                '2024-10-19 11:00:00'),
(25, 16, 10, 19, FALSE, 'Renault Clio 1.5 dCi. Expression. Diesel. God økonomi.',                        '2024-10-26 12:30:00'),
-- bilhuset_odense (seller 11) - 6 biler
(26, 17, 11, 8, FALSE, 'Peugeot 308 1.2 PureTech. Allure. Panoramatag. 12 års rustgaranti.',             '2024-10-20 10:00:00'),
(27, 18, 11, 8, FALSE, 'Mercedes C-Klasse C300e. AMG-Line. PHEV. 100 km el-rækkevidde.',                 '2024-10-22 11:00:00'),
(28, 19, 11, 8, FALSE, 'Kia Ceed 1.5 T-GDI. Advance. DCT. 5 års garanti.',                              '2024-10-24 09:00:00'),
(29, 20, 11, 8, FALSE, 'Hyundai i20 1.0 T-GDI. Tech. Lav km. Apple CarPlay. Android Auto.',             '2024-10-27 10:30:00'),
(30, 81, 11, 8, FALSE, 'Opel Mokka-e GS Line. 136 hk. IntelliLux Matrix LED.',                          '2024-11-04 11:00:00'),
(31, 94, 11, 8, FALSE, 'VW ID.3 Pro S. 77 kWh. Topudstyr. Ladeledning og taske medfølger.',             '2024-11-10 10:00:00'),
-- privat_maria (seller 12) - 2 biler
(32, 21, 12, 17, FALSE, 'Mercedes A-Klasse 200 d. Sport. Skindinteriør. Sælges pga. flytning.',          '2024-10-21 12:00:00'),
(33, 22, 12, 17, FALSE, 'Mercedes GLC 300. AMG-Line. Panoramatag. En ejer. Fuld historik.',              '2024-10-28 13:30:00'),
-- nordjysk_auto (seller 13) - 6 biler
(34, 23, 13, 11, FALSE, 'BMW 3-serie 330i. M-Sport. Adaptiv undervogn. xDrive.',                        '2024-10-22 09:00:00'),
(35, 24, 13, 11, FALSE, 'BMW i4 eDrive40. Gran Coupé. M-Sport. 340 hk.',                                '2024-10-23 10:00:00'),
(36, 25, 13, 11, FALSE, 'Volvo XC90 T8 Recharge. Ultimate. Air Suspension. 7-sæder.',                   '2024-10-25 11:00:00'),
(37, 26, 13, 11, FALSE, 'Suzuki Swift 1.2 Dualjet. GL+. Hybrid. Lav km og forbrug.',                   '2024-10-29 12:00:00'),
(38, 82, 13, 11, FALSE, 'Renault Megane E-Tech EV60. Iconic. 220 hk. V2G-lading.',                     '2024-11-05 09:00:00'),
(39, 95, 13, 11, FALSE, 'Volvo XC40 T5 Recharge. R-Design. Pilot Assist. AWD.',                        '2024-11-11 10:00:00'),
-- privat_lise (seller 14) - 2 biler
(40, 27, 14, 21, FALSE, 'Suzuki Swift 1.2. GL+. Dejlig lille bil. Altid garaeret. Ingen rust.',         '2024-10-23 11:00:00'),
(41, 28, 14, 21, FALSE, 'Nissan Qashqai 1.5 VC-Turbo e-Power. N-Connecta. Automatgear.',               '2024-10-30 12:00:00'),
-- tesla_specialist (seller 15) - 6 biler
(42, 29, 15, 2, FALSE, 'Tesla Model 3 Long Range AWD. Autopilot. Hvid interiør.',                       '2024-10-24 10:00:00'),
(43, 30, 15, 2, FALSE, 'Tesla Model Y Long Range. 7-sæder. Autopilot. Sommerbil.',                      '2024-10-25 11:00:00'),
(44, 31, 15, 2, FALSE, 'Tesla Model S Plaid. 1020 hk. 0-100 på 2,1 sek.',                              '2024-10-26 09:00:00'),
(45, 32, 15, 2, FALSE, 'Tesla Model 3 Standard Range RWD. Autopilot. Hvid.',                            '2024-10-31 10:30:00'),
(46, 83, 15, 2, FALSE, 'Mazda MX-30 e-SkyActiv. Edition R. Unik kork-interiør.',                       '2024-11-06 11:00:00'),
(47, 99, 15, 2, FALSE, 'Tesla Model Y Performance. Track Mode. 20" turbinehjul.',                       '2024-11-12 09:00:00'),
-- privat_karsten (seller 16) - 2 biler
(48, 33, 16, 15, FALSE, 'VW Passat 2.0 TDI. Highline. Ny kilerem. Bilag medfølger.',                   '2024-10-25 12:00:00'),
(49, 34, 16, 15, FALSE, 'Opel Corsa 1.2 Turbo. GS Line. Fin stand. Sælges billigt.',                   '2024-11-01 13:00:00'),
-- premium_biler (seller 17) - 6 biler
(50, 35, 17, 3, FALSE, 'BMW X3 xDrive30d. M-Sport. Panoramatag. Laserlight.',                           '2024-10-26 09:00:00'),
(51, 36, 17, 3, FALSE, 'Audi A4 Avant 2.0 TDI. S-Line. Virtual Cockpit. Matrix LED.',                  '2024-10-27 10:00:00'),
(52, 37, 17, 3, FALSE, 'Mazda CX-5 2.2 SkyActiv-D. Zenith. Lædersæder. BOSE.',                        '2024-10-28 11:00:00'),
(53, 38, 17, 3, FALSE, 'Mercedes GLC 300d 4MATIC. AMG-Line. Burmester. Panoramatag.',                   '2024-11-02 12:00:00'),
(54, 84, 17, 3, FALSE, 'Citroën ë-C4 Shine. 50 kWh. Komfort-affjedring. CCS-lader.',                   '2024-11-07 09:00:00'),
(55, 96, 17, 3, FALSE, 'BMW 330e Touring. M-Sport. xDrive. Adaptiv undervogn. 292 hk.',                '2024-11-13 10:00:00'),
-- privat_susanne (seller 18) - 2 biler
(56, 39, 18, 27, FALSE, 'Citroën C3 1.2 PureTech. Aircross. God familiebil. Sælges pga. ny bil.',      '2024-10-27 11:00:00'),
(57, 40, 18, 27, FALSE, 'Renault Captur 1.3 TCe. Intens. Panoramatag. Bakkamera.',                     '2024-11-03 12:00:00'),
-- sjaelland_auto (seller 19) - 5 biler
(58, 41, 19, 12, FALSE, 'Volvo XC40 Recharge Pure Electric. Single Motor. Pixel LED.',                  '2024-10-28 10:00:00'),
(59, 42, 19, 12, FALSE, 'Hyundai Kona Electric 64 kWh. Premium. Varmepumpe. CCS.',                     '2024-10-29 11:00:00'),
(60, 43, 19, 12, FALSE, 'Nissan Leaf e+ 62 kWh. Tekna. ProPILOT. Bose lyd.',                           '2024-10-30 09:00:00'),
(61, 44, 19, 12, FALSE, 'Skoda Enyaq iV 80. Sportline. 77 kWh batteri. Matrix LED.',                   '2024-11-04 10:30:00'),
(62, 85, 19, 12, FALSE, 'Mercedes EQC 400 4MATIC. Electric Art. MBUX. Panoramatag.',                    '2024-11-08 11:00:00'),
-- privat_martin (seller 20) - 2 biler
(63, 45, 20, 22, FALSE, 'Mazda3 2.0 SkyActiv-G. Cosmo. Head-up display. BOSE lyd.',                    '2024-10-29 12:00:00'),
(64, 46, 20, 22, FALSE, 'Seat Leon 1.5 TSI. FR. Virtual Cockpit. Sportsundervogn.',                     '2024-11-05 13:00:00'),
-- elbil_center (seller 21) - 5 biler
(65, 47, 21, 6, FALSE, 'VW ID.4 Pro Performance. 204 hk. 77 kWh batteri. Matrix LED.',                  '2024-10-30 09:00:00'),
(66, 48, 21, 6, FALSE, 'Hyundai Ioniq 5 Long Range AWD. 325 hk. V2L. Ultra.',                           '2024-10-31 10:00:00'),
(67, 49, 21, 6, FALSE, 'Kia EV6 Long Range AWD. GT-Line S. 800V lading. 22 min 10-80%.',               '2024-11-01 11:00:00'),
(68, 50, 21, 6, FALSE, 'Kia Niro EV 64 kWh. Advance. Varmepumpe. V2L.',                                '2024-11-06 12:00:00'),
(69, 86, 21, 6, FALSE, 'Citroën C4 1.5 BlueHDi. Shine. Avancerede komfortsæder.',                      '2024-11-09 09:00:00'),
-- privat_line (seller 22) - 2 biler
(70, 51, 22, 24, FALSE, 'Kia Picanto 1.0 MPI. Comfort. Perfekt bybil. Lav km.',                         '2024-10-31 11:00:00'),
(71, 52, 22, 24, FALSE, 'Toyota Aygo 1.0. X-play. Nysynet. Ingen rust. 1 ejer.',                        '2024-11-07 12:00:00'),
-- syd_autosalg (seller 23) - 5 biler
(72, 53, 23, 10, FALSE, 'Volvo V60 D4. Inscription. Pilot Assist. Skindinteriør.',                      '2024-11-01 10:00:00'),
(73, 54, 23, 10, FALSE, 'Skoda Superb Combi 2.0 TDI. Style. Columbus navi. 190 hk.',                    '2024-11-02 11:00:00'),
(74, 55, 23, 10, TRUE,  'Peugeot 508 Hybrid. GT. Night Vision. SOLGT.',                                 '2024-10-05 09:00:00'),
(75, 56, 23, 10, FALSE, 'Audi A3 Sportback 35 TFSI. S-Line. Virtuel Cockpit Plus.',                     '2024-11-08 10:30:00'),
(76, 87, 23, 10, FALSE, 'Suzuki Vitara 1.4 Boosterjet Hybrid. GL+. Allgrip AWD.',                       '2024-11-10 11:00:00'),
-- privat_katrine (seller 24) - 2 biler
(77, 57, 24, 16, FALSE, 'Nissan Micra 0.9 IG-T. Acenta. Fartpilot. Rygsensor. Sælges billigt.',         '2024-11-02 12:00:00'),
(78, 58, 24, 16, FALSE, 'Ford Fiesta 1.0 EcoBoost. Titanium. Touchskærm. Android Auto.',                '2024-11-09 13:00:00'),
-- bilpalads (seller 25) - 6 biler
(79, 59, 25, 4, FALSE, 'Audi Q5 40 TDI quattro. S-Line. Matrix LED. B&O lyd.',                         '2024-11-03 09:00:00'),
(80, 60, 25, 4, FALSE, 'Toyota C-HR 2.0 Hybrid. GR Sport. JBL lyd. El-bagklap.',                       '2024-11-04 10:00:00'),
(81, 61, 25, 4, FALSE, 'BMW iX3 Impressive. 286 hk. Driving Assistant Pro. Panoramatag.',               '2024-11-05 11:00:00'),
(82, 62, 25, 4, FALSE, 'Mercedes EQA 250. AMG-Line. Navi Premium. MBUX. Varmepumpe.',                   '2024-11-10 12:00:00'),
(83, 63, 25, 4, FALSE, 'Peugeot 3008 Hybrid. GT. Focal lyd. Night Vision. 225 hk.',                    '2024-11-11 09:00:00'),
(84, 88, 25, 4, FALSE, 'Fiat Tipo 1.4 T-Jet. Lounge. 550L bagagerum. God familiebil.',                 '2024-11-14 10:00:00'),
-- privat_brian (seller 26) - 2 biler
(85, 64, 26, 23, FALSE, 'Hyundai i30 1.4 T-GDI. Trend. Apple CarPlay. Rygsensor.',                     '2024-11-04 11:00:00'),
(86, 65, 26, 23, FALSE, 'Skoda Fabia 1.0 TSI. Style. Stor bagagerum for klassen.',                      '2024-11-11 12:00:00'),
-- midtjylland_biler (seller 27) - 5 biler
(87, 66, 27, 7, FALSE, 'Ford Kuga 2.5 PHEV. ST-Line X. 225 hk. AWD. Stor trækkraft.',                  '2024-11-05 10:00:00'),
(88, 67, 27, 7, FALSE, 'BMW 1-serie 118d. M-Sport. Live Cockpit Plus. Parkassistent.',                   '2024-11-06 11:00:00'),
(89, 68, 27, 7, FALSE, 'Audi Q3 35 TFSI. Advanced. Virtual Cockpit. Stort panoramatag.',                '2024-11-07 09:00:00'),
(90, 69, 27, 7, FALSE, 'Skoda Kamiq 1.5 TSI. Style. Assistentpakke. El-bagklap.',                       '2024-11-12 10:30:00'),
(91, 89, 27, 7, FALSE, 'Seat Arona 1.0 TSI. FR. Beats Audio. Fuld LED-forlygter.',                     '2024-11-13 11:00:00'),
-- privat_helle (seller 28) - 2 biler
(92, 70, 28, 18, FALSE, 'Peugeot e-208 GT. 136 hk. 340 km WLTP. Sjov elbil.',                          '2024-11-06 12:00:00'),
(93, 71, 28, 18, FALSE, 'Fiat 500e Icon. 42 kWh. Retro-charm med moderne teknik.',                      '2024-11-13 13:00:00'),
-- familieauto (seller 29) - 6 biler
(94, 72, 29, 13, FALSE, 'Toyota RAV4 Plug-in Hybrid. Style. 306 hk. El-bagklap.',                       '2024-11-07 09:00:00'),
(95, 73, 29, 13, FALSE, 'Hyundai Tucson Hybrid. Advanced. Bluelink. Sædevarme.',                        '2024-11-08 10:00:00'),
(96, 74, 29, 13, FALSE, 'VW Tiguan 2.0 TDI. Elegance. 4Motion. Ergoactive sæder.',                     '2024-11-09 11:00:00'),
(97, 75, 29, 13, FALSE, 'Volvo XC60 T6 Recharge. Ultimate. Air Suspension. 253 hk.',                    '2024-11-14 12:00:00'),
(98, 90, 29, 13, FALSE, 'Nissan Juke 1.0 DIG-T. N-Connecta. ProPILOT. Boseanlæg.',                     '2024-11-15 09:00:00'),
(99, 100,29, 13, FALSE, 'Kia Sportage 1.6 T-GDI PHEV. GT-Line S. AWD. 265 hk.',                        '2024-11-16 10:00:00'),
-- privat_ole (seller 30) - 2 biler
(100,76, 30, 25, FALSE, 'Seat Ibiza 1.0 TSI. FR. Beats Audio. LED-forlygter.',                          '2024-11-08 11:00:00');

-- ============================================
-- FAVORITES (100 rækker)
-- ============================================
INSERT INTO favorite (user_id, car_listing_id) VALUES
  (31, 3), (31, 42), (31, 70),
  (32, 9), (32, 63), (32, 22),
  (33, 15), (33, 16), (33, 78),
  (34, 17), (34, 18), (34, 53),
  (35, 32), (35, 33), (35, 92),
  (36, 42), (36, 43), (36, 66),
  (37, 65), (37, 67), (37, 68),
  (38, 1), (38, 10), (38, 28),
  (39, 34), (39, 35), (39, 36),
  (40, 50), (40, 51), (40, 52),
  (41, 58), (41, 59), (41, 60),
  (42, 72), (42, 73), (43, 93),
  (43, 38), (44, 24), (44, 40),
  (45, 79), (45, 80), (46, 94),
  (46, 95), (46, 97), (47, 5),
  (47, 14), (48, 55), (48, 54),
  (49, 61), (49, 78), (50, 3),
  (50, 47), (51, 43), (51, 44),
  (52, 9), (52, 36), (53, 21),
  (53, 46), (54, 26), (54, 27),
  (55, 81), (55, 82), (56, 20),
  (56, 99), (57, 11), (57, 73),
  (58, 48), (58, 49), (59, 56),
  (59, 57), (60, 74), (60, 75),
  (61, 83), (61, 87), (62, 88),
  (62, 89), (63, 54), (63, 62),
  (64, 86), (64, 76), (65, 84),
  (65, 91), (66, 98), (66, 6),
  (67, 1), (67, 2), (68, 30),
  (68, 39), (69, 100), (69, 13),
  (70, 64), (70, 85), (71, 7),
  (71, 12), (72, 19), (72, 25),
  (73, 29), (73, 45), (74, 31),
  (74, 37);

-- ============================================
-- MESSAGES (100 rækker)
-- sender_id → receiver_id om car_listing_id
-- ============================================
INSERT INTO message (sender_id, receiver_id, car_listing_id, content, sent_at, is_read) VALUES
-- Buyer 31 spørger om Toyota RAV4 (listing 3)
(31, 6,  3,  'Hej! Er Toyota RAV4 stadig til salg?', '2024-11-01 10:00:00', TRUE),
(6,  31, 3,  'Hej Anna! Ja, den er stadig ledig. Kom gerne forbi og prøvekør.', '2024-11-01 10:30:00', TRUE),
-- Buyer 32 spørger om Toyota C-HR (listing 9)
(32, 7,  9,  'Hvad er km-forbruget på C-HR?', '2024-11-02 09:00:00', TRUE),
(7,  32, 9,  'Hej Peter! Realistisk 20-22 km/l blandet. Hybrid er fantastisk i byen.', '2024-11-02 09:30:00', TRUE),
-- Buyer 33 spørger om BMW 3-serie (listing 15)
(33, 8,  15, 'Hej Erik, hvad er årsagen til salg?', '2024-11-03 10:00:00', TRUE),
(8,  33, 15, 'Hej Sofie! Køber større bil. BMW er i perfekt stand.', '2024-11-03 10:45:00', TRUE),
-- Buyer 34 spørger om BMW X3 (listing 17)
(34, 9,  17, 'Har den panoramatag?', '2024-11-04 11:00:00', TRUE),
(9,  34, 17, 'Hej Mark! Ja, kæmpe panoramatag. Kom og se den.', '2024-11-04 11:30:00', TRUE),
-- Buyer 35 spørger om Mercedes A-Klasse (listing 32)
(35, 12, 32, 'Er prisen til forhandling?', '2024-11-05 09:00:00', TRUE),
(12, 35, 32, 'Hej Ida! Vi kan godt tale om det. Kom og se bilen først.', '2024-11-05 09:45:00', FALSE),
-- Buyer 36 spørger om Tesla Model 3 (listing 42)
(36, 15, 42, 'Hvad er den reelle rækkevidde om vinteren?', '2024-11-06 10:00:00', TRUE),
(15, 36, 42, 'Hej Kasper! Realistisk 280-320 km ved -5 grader. God varmepumpe.', '2024-11-06 10:30:00', TRUE),
-- Buyer 37 spørger om VW ID.4 (listing 65)
(37, 21, 65, 'Kan den lade på 150 kW DC?', '2024-11-07 11:00:00', TRUE),
(21, 37, 65, 'Hej Emma! Ja, op til 135 kW DC. Fra 5-80% på ca. 36 min.', '2024-11-07 11:30:00', TRUE),
-- Buyer 38 spørger om Ford Focus (listing 1)
(38, 6,  1,  'Er der anhængertræk på Focus?', '2024-11-08 09:00:00', TRUE),
(6,  38, 1,  'Hej Oliver! Nej, men det kan monteres for ca. 3.000 kr.', '2024-11-08 09:30:00', TRUE),
-- Buyer 39 spørger om BMW 3-serie (listing 34)
(39, 13, 34, 'Hvad er kilometerstand?', '2024-11-09 10:00:00', TRUE),
(13, 39, 34, 'Hej Freja! 28.000 km. Næsten ny bil til prisen.', '2024-11-09 10:30:00', TRUE),
-- Buyer 40 spørger om BMW X3 (listing 50)
(40, 17, 50, 'Er der Laserlight på den?', '2024-11-10 11:00:00', TRUE),
(17, 40, 50, 'Hej Noah! Ja, fuld Laserlight. Det er en fornøjelse om natten.', '2024-11-10 11:45:00', TRUE),
-- Buyer 41 spørger om Volvo XC40 (listing 58)
(41, 19, 58, 'Hvad er rækkevidde på XC40 Electric?', '2024-11-11 09:00:00', TRUE),
(19, 41, 58, 'Hej Ella! 418 km WLTP. Realistisk 330-360 km.', '2024-11-11 09:30:00', TRUE),
-- Buyer 42 spørger om Volvo V60 (listing 72)
(42, 23, 72, 'Har den Pilot Assist?', '2024-11-12 10:00:00', TRUE),
(23, 42, 72, 'Hej Victor! Ja, fuld Pilot Assist inkl. adaptiv fartpilot.', '2024-11-12 10:30:00', TRUE),
-- Buyer 43 spørger om Toyota Corolla (listing 93)
(43, 9,  93, 'Er der stadig fabriksgaranti?', '2024-11-13 11:00:00', TRUE),
(9,  43, 93, 'Hej Maja! Ja, 3 år fra fabrik. Udløber om 14 måneder.', '2024-11-13 11:30:00', FALSE),
-- Buyer 44 spørger om BMW 3-serie (listing 24)
(44, 10, 24, 'Hvad er servicen lavet hos?', '2024-11-14 09:00:00', TRUE),
(10, 44, 24, 'Hej Lucas! Altid hos BMW-forhandler. Komplet servicebog.', '2024-11-14 09:30:00', TRUE),
-- Buyer 45 spørger om Audi Q5 (listing 79)
(45, 25, 79, 'Er det 4WD eller 2WD?', '2024-11-15 10:00:00', TRUE),
(25, 45, 79, 'Hej Clara! Quattro AWD. Fantastisk i dårligt vejr.', '2024-11-15 10:30:00', TRUE),
-- Buyer 46 spørger om Toyota RAV4 PHEV (listing 94)
(46, 29, 94, 'Hvad er el-rækkevidden?', '2024-11-16 11:00:00', TRUE),
(29, 46, 94, 'Hej Oscar! 75 km WLTP på ren el. Perfekt til pendling.', '2024-11-16 11:30:00', TRUE),
-- Buyer 47 spørger om Ford Mustang (listing 5)
(47, 6,  5,  'Hvad er hurtigste ladetid?', '2024-11-01 12:00:00', TRUE),
(6,  47, 5,  'Hej Laura! Op til 150 kW DC. Ca. 38 min fra 10-80%.', '2024-11-01 12:30:00', FALSE),
-- Buyer 48 spørger om BMW 330e (listing 55)
(48, 17, 55, 'Hvad er el-rækkevidden reelt?', '2024-11-02 13:00:00', TRUE),
(17, 48, 55, 'Hej William! Ca. 40-50 km i mildt vejr. Perfekt til pendling.', '2024-11-02 13:30:00', TRUE),
-- Buyer 49 spørger om Volvo XC90 (listing 36)
(49, 13, 36, 'Er det 7-sædet version?', '2024-11-03 09:00:00', TRUE),
(13, 49, 36, 'Hej Alberte! Ja, 7-sæder. Tredje række er lidt snæver, men god til børn.', '2024-11-03 09:45:00', TRUE),
-- Buyer 50 spørger om Tesla Model Y (listing 43)
(50, 15, 43, 'Har den 7-sæder?', '2024-11-04 10:00:00', TRUE),
(15, 50, 43, 'Hej Carl! Ja, 7-sæder tilkøbt. Tredje række foldes fladt ned.', '2024-11-04 10:30:00', TRUE),
-- Buyer 51 spørger om Hyundai Kona (listing 59)
(51, 19, 59, 'Kan Kona lade på CCS DC?', '2024-11-05 11:00:00', TRUE),
(19, 51, 59, 'Hej Nora! Ja, op til 75 kW DC. Fra 10-80% på ca. 47 min.', '2024-11-05 11:30:00', TRUE),
-- Buyer 52 spørger om VW Polo (listing 10)
(52, 7,  10, 'Er der automatgear?', '2024-11-06 12:00:00', TRUE),
(7,  52, 10, 'Hej August! Nej, manuelt 6-gear. Men kan skiftes hurtigt.', '2024-11-06 12:30:00', FALSE),
-- Buyer 53 spørger om Renault Zoe (listing 21)
(53, 9,  21, 'Hvad er rækkevidde om sommeren?', '2024-11-07 09:00:00', TRUE),
(9,  53, 21, 'Hej Rosa! Op til 395 km WLTP. Realistisk 310-350 km.', '2024-11-07 09:30:00', TRUE),
-- Buyer 54 spørger om Peugeot 308 (listing 26)
(54, 11, 26, 'Er der rustgaranti på Peugeot 308?', '2024-11-17 10:00:00', TRUE),
(11, 54, 26, 'Hej Magnus! Ja, 12 års rustgaranti fra fabrik.', '2024-11-17 10:30:00', TRUE),
-- Buyer 55 spørger om BMW iX3 (listing 81)
(55, 25, 81, 'Hvad er ladekapaciteten?', '2024-11-18 09:00:00', TRUE),
(25, 55, 81, 'Hej Astrid! Op til 150 kW DC. Meget hurtig lader.', '2024-11-18 09:30:00', TRUE),
-- Buyer 56 spørger om Kia Sportage (listing 99)
(56, 29, 99, 'Hej! Kan I hjælpe med finansiering?', '2024-11-18 11:00:00', TRUE),
(29, 56, 99, 'Hej Valdemar! Ja, vi samarbejder med flere banker.', '2024-11-18 11:45:00', TRUE),
-- Buyer 57 spørger om VW Passat (listing 11)
(57, 7,  11, 'Hvad er motorstørrelse og hk?', '2024-11-19 10:00:00', TRUE),
(7,  57, 11, 'Hej Agnes! 2.0 TDI 150 hk. Meget tærsomhed.', '2024-11-19 10:30:00', TRUE),
-- Buyer 58 spørger om VW Passat (listing 48)
(58, 16, 48, 'Hej Karsten, er der kvittering for ny kilerem?', '2024-11-19 12:00:00', TRUE),
(16, 58, 48, 'Hej Malthe! Ja, jeg har alle bilag. Skiftet for 6 måneder siden.', '2024-11-19 12:30:00', FALSE),
-- Buyer 59 spørger om Audi A3 (listing 56)
(59, 23, 75, 'Hvad er det årlige forbrug på A3?', '2024-11-20 09:00:00', TRUE),
(23, 59, 75, 'Hej Karla! Realistisk omkring 15-16 km/l ved blandet kørsel.', '2024-11-20 09:45:00', TRUE),
-- Buyer 60 spørger om VW Tiguan (listing 96)
(60, 29, 96, 'Er der 4WD på den?', '2024-11-20 11:00:00', TRUE),
(29, 60, 96, 'Hej Theodor! Ja, 4Motion. Fantastisk i sne og mudder.', '2024-11-20 11:30:00', TRUE),
-- Buyer 61 spørger om Peugeot 3008 (listing 83)
(61, 25, 83, 'Hvad er forbruget på 3008 Hybrid?', '2024-11-21 09:00:00', TRUE),
(25, 61, 83, 'Hej Vigga! Ca. 1.5L/100 km hvis du lader dagligt. Ellers 5-6 L.', '2024-11-21 09:30:00', TRUE),
-- Buyer 62 spørger om Ford Kuga (listing 87)
(62, 27, 87, 'Hej, har den anhængertræk?', '2024-11-21 10:00:00', TRUE),
(27, 62, 87, 'Hej Aksel! Nej, men det kan monteres. Vi kan hjælpe med det.', '2024-11-21 10:30:00', TRUE),
-- Buyer 63 spørger om Skoda Superb (listing 73)
(63, 23, 73, 'Hej! Er Skoda Superb god til langture?', '2024-12-15 10:00:00', TRUE),
(23, 63, 73, 'Hej Filippa! Fantastisk! Super komfortabel og romslig.', '2024-12-15 10:30:00', TRUE),
-- Buyer 64 spørger om Hyundai i30 (listing 85)
(64, 26, 85, 'Er der nogen mangler ved bilen?', '2024-11-22 11:00:00', TRUE),
(26, 64, 85, 'Hej Storm! Nej, den er i super stand. Lige synet.', '2024-11-22 11:30:00', TRUE),
-- Buyer 65 spørger om Citroën ë-C4 (listing 84)
(65, 17, 54, 'Hvad er rækkevidde på ë-C4?', '2024-11-23 09:00:00', TRUE),
(17, 65, 54, 'Hej Liv! 350 km WLTP, realistisk 280-310 km.', '2024-11-23 09:30:00', TRUE),
-- Buyer 66 spørger om Ford Puma (listing 6)
(66, 6,  6,  'Hej! Hvad koster den årlige forsikring ca.?', '2024-11-23 12:00:00', TRUE),
(6,  66, 6,  'Hej Konrad! Det kommer an på din profil, typisk 5-7.000 kr/år.', '2024-11-23 12:30:00', FALSE),
-- Buyer 67 spørger om Ford Focus (listing 1)
(67, 6,  1,  'Er der service på den?', '2024-11-24 08:00:00', TRUE),
(6,  67, 1,  'Hej Frida! Ja, fuld servicehistorik fra Ford-værksted.', '2024-11-24 08:30:00', TRUE),
-- Buyer 68 spørger om Volvo EX30 (listing 13)
(68, 7,  13, 'Hvor lang er leveringstiden hvis jeg bestiller?', '2024-11-24 09:00:00', TRUE),
(7,  68, 13, 'Hej Vilhelm! Dette er en demobil, klar til levering nu!', '2024-11-24 09:30:00', TRUE),
-- Buyer 69 spørger om Seat Arona (listing 91)
(69, 27, 91, 'Hvad koster årlig service på Seat Arona?', '2024-12-16 11:00:00', TRUE),
(27, 69, 91, 'Hej Alma! Omkring 2.500-3.000 kr afhængig af værksted.', '2024-12-16 11:30:00', TRUE),
-- Buyer 70 spørger om Suzuki Swift (listing 40)
(70, 14, 40, 'Hej Lise, er Swift god til langture?', '2024-11-25 10:00:00', TRUE),
(14, 70, 40, 'Hej Elias! Ja, overraskende komfortabel. Jeg har selv kørt til Tyskland.', '2024-11-25 10:45:00', TRUE),
-- Buyer 71 spørger om VW Passat (listing 7)
(71, 6,  7,  'Er VW ID.3 god til pendling?', '2024-11-26 09:00:00', TRUE),
(6,  71, 7,  'Hej Johanne! Perfekt til pendling! Op til 400 km rækkevidde.', '2024-11-26 09:30:00', TRUE),
-- Buyer 72 spørger om BMW X3 (listing 35)
(72, 13, 35, 'Hvad er den reelle brændstoføkonomi?', '2024-11-26 11:00:00', TRUE),
(13, 72, 35, 'Hej Erik! Omkring 14-15 km/l på landevej, 11-12 i byen.', '2024-11-26 11:30:00', TRUE),
-- Buyer 73 spørger om Mercedes C-Klasse (listing 27)
(73, 11, 27, 'Hvad er el-rækkevidden på C300e?', '2024-11-27 10:00:00', TRUE),
(11, 73, 27, 'Hej Mathilde! Omkring 95-100 km på ren el WLTP.', '2024-11-27 10:30:00', TRUE),
-- Buyer 74 spørger om Mazda CX-5 (listing 52)
(74, 17, 52, 'Hej, er der nogen skjulte fejl?', '2024-11-27 12:00:00', TRUE),
(17, 74, 52, 'Hej Sigurd! Nej, gennemgået og i perfekt stand. Kom og se den.', '2024-11-27 12:30:00', FALSE),
-- Buyer 75 spørger om VW Tiguan (listing 96)
(75, 29, 96, 'Er VW Tiguan god i sne?', '2024-12-17 12:00:00', TRUE),
(29, 75, 96, 'Hej Ellen! Ja, 4MOTION er fantastisk i dårligt vejr.', '2024-12-17 12:30:00', TRUE),
-- Buyer 76 spørger om Opel Corsa (listing 49)
(76, 16, 49, 'Er der Apple CarPlay?', '2024-11-28 09:00:00', TRUE),
(16, 76, 49, 'Hej Alfred! Ja, både Apple CarPlay og Android Auto.', '2024-11-28 09:30:00', TRUE),
-- Buyer 77 spørger om Toyota Aygo (listing 4)
(77, 6,  4,  'Hvad er forsikringsgruppen?', '2024-11-29 09:00:00', TRUE),
(6,  77, 4,  'Hej Hannah! Lav forsikringsgruppe. Perfekt for nye bilister.', '2024-11-29 09:30:00', TRUE),
-- Buyer 78 spørger om Ford Fiesta (listing 78)
(78, 24, 78, 'Hej Katrine, hvornår kan jeg se bilen?', '2024-11-29 10:00:00', TRUE),
(24, 78, 78, 'Hej Felix! Jeg er hjemme i weekenden. Ring på 33456789.', '2024-11-29 10:30:00', TRUE),
-- Buyer 79 spørger om BMW X3 (listing 17)
(79, 9,  17, 'Er der HeadUp Display?', '2024-11-30 10:00:00', TRUE),
(9,  79, 17, 'Hej Isabella! Ja, aktivt HeadUp Display. Meget praktisk.', '2024-11-30 10:30:00', TRUE),
-- Buyer 80 spørger om Peugeot 508 Hybrid (listing 55) - solgt, men spørger
(80, 23, 74, 'Er Night Vision effektivt om natten?', '2024-11-30 11:00:00', TRUE),
(23, 80, 74, 'Hej Sebastian! Ja, det er fantastisk. SOLGT desværre.', '2024-11-30 11:30:00', TRUE);