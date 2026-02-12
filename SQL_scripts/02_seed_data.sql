-- ============================================
-- BILBASEN CLONE - SEED DATA
-- ============================================

-- ROLES
INSERT INTO role (id, name) VALUES
(1, 'ADMIN'),
(2, 'SELLER'),
(3, 'BUYER');

-- REGIONS
INSERT INTO region (id, name) VALUES
(1, 'Nordjylland'),
(2, 'Midtjylland'),
(3, 'Syddanmark'),
(4, 'Sjælland'),
(5, 'Hovedstaden');

-- FUEL TYPES
INSERT INTO fuel_type (id, name) VALUES
(1, 'Benzin'),
(2, 'Diesel'),
(3, 'El'),
(4, 'Hybrid'),
(5, 'Plug-in Hybrid');

-- BRANDS
INSERT INTO brand (id, name) VALUES
(1, 'Toyota'), (2, 'Volkswagen'), (3, 'BMW'), (4, 'Audi'),
(5, 'Mercedes-Benz'), (6, 'Volvo'), (7, 'Peugeot'), (8, 'Ford'),
(9, 'Hyundai'), (10, 'Kia'), (11, 'Tesla'), (12, 'Skoda'),
(13, 'Renault'), (14, 'Nissan'), (15, 'Opel'), (16, 'Citroën'),
(17, 'Mazda'), (18, 'Seat'), (19, 'Fiat'), (20, 'Suzuki');

-- MODELS
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
-- USERS: 5 admin, 25 sellers, 70 buyers = 100
-- password_hash = bcrypt af 'password123'
-- ============================================

INSERT INTO app_user (id, username, email, password_hash, first_name, last_name, phone, role_id, region_id, private_seller) VALUES
-- ADMINS (1-5)
(1,  'admin1',       'admin1@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lars',      'Hansen',      '20123456', 1, 5, FALSE),
(2,  'admin2',       'admin2@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mette',     'Jensen',      '20234567', 1, 5, FALSE),
(3,  'admin3',       'admin3@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Søren',     'Nielsen',     '20345678', 1, 2, FALSE),
(4,  'admin4',       'admin4@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anne',      'Pedersen',    '20456789', 1, 4, FALSE),
(5,  'admin5',       'admin5@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Peter',     'Andersen',    '20567890', 1, 3, FALSE),

-- SELLERS (6-30) — blanding af private og professionelle
(6,  'autohandler_kbh',   'kbh@autohandler.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Thomas',    'Møller',      '30123456', 2, 5, FALSE),
(7,  'biler_aarhus',      'info@bileraarhus.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mikkel',    'Christensen', '30234567', 2, 2, FALSE),
(8,  'privat_erik',       'erik.holm@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Erik',      'Holm',        '30345678', 2, 1, TRUE),
(9,  'kvalitetsbiler',    'info@kvalitetsbiler.dk',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Camilla',   'Larsen',      '30456789', 2, 3, FALSE),
(10, 'privat_jonas',      'jonas.wind@yahoo.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jonas',     'Wind',        '30567890', 2, 4, TRUE),
(11, 'bilhuset_odense',   'salg@bilhuset.dk',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rasmus',    'Sørensen',    '31123456', 2, 3, FALSE),
(12, 'privat_maria',      'maria.berg@hotmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Maria',     'Berg',        '31234567', 2, 5, TRUE),
(13, 'nordjysk_auto',     'salg@nordjyskauto.dk',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Henrik',    'Dahl',        '31345678', 2, 1, FALSE),
(14, 'privat_lise',       'lise.krogh@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lise',      'Krogh',       '31456789', 2, 2, TRUE),
(15, 'tesla_specialist',  'info@teslaspec.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Frederik',  'Lund',        '31567890', 2, 5, FALSE),
(16, 'privat_karsten',    'karsten.ny@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Karsten',   'Nygaard',     '32123456', 2, 1, TRUE),
(17, 'premium_biler',     'info@premiumbiler.dk',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nikolaj',   'Friis',       '32234567', 2, 5, FALSE),
(18, 'privat_susanne',    'susanne.bach@gmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Susanne',   'Bach',        '32345678', 2, 4, TRUE),
(19, 'sjælland_auto',     'salg@sjaellandauto.dk',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anders',    'Gram',        '32456789', 2, 4, FALSE),
(20, 'privat_martin',     'martin.bak@outlook.dk',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Martin',    'Bak',         '32567890', 2, 2, TRUE),
(21, 'elbil_center',      'info@elbilcenter.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jakob',     'Kjær',        '33123456', 2, 2, FALSE),
(22, 'privat_line',       'line.frost@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Line',      'Frost',       '33234567', 2, 3, TRUE),
(23, 'syd_autosalg',      'info@sydautosalg.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Christian', 'Bruun',       '33345678', 2, 3, FALSE),
(24, 'privat_katrine',    'katrine.vig@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Katrine',   'Vig',         '33456789', 2, 1, TRUE),
(25, 'bilpalads',         'salg@bilpalads.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jens',      'Storm',       '33567890', 2, 5, FALSE),
(26, 'privat_brian',      'brian.voss@yahoo.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Brian',     'Voss',        '34123456', 2, 2, TRUE),
(27, 'midtjylland_biler', 'salg@midtbiler.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Torben',    'Rask',        '34234567', 2, 2, FALSE),
(28, 'privat_helle',      'helle.lind@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Helle',     'Lind',        '34345678', 2, 5, TRUE),
(29, 'familieauto',       'info@familieauto.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Kim',       'Skov',        '34456789', 2, 4, FALSE),
(30, 'privat_ole',        'ole.park@outlook.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ole',       'Park',        '34567890', 2, 3, TRUE),

-- BUYERS (31-100)
(31, 'buyer_anna',     'anna.vik@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anna',       'Vik',         '40123456', 3, 5, TRUE),
(32, 'buyer_peter',    'peter.due@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Peter',      'Due',         '40234567', 3, 2, TRUE),
(33, 'buyer_sofie',    'sofie.blom@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sofie',      'Blom',        '40345678', 3, 1, TRUE),
(34, 'buyer_mark',     'mark.sten@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mark',       'Sten',        '40456789', 3, 3, TRUE),
(35, 'buyer_ida',      'ida.krog@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ida',        'Krog',        '40567890', 3, 4, TRUE),
(36, 'buyer_kasper',   'kasper.dam@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Kasper',     'Dam',         '41123456', 3, 5, TRUE),
(37, 'buyer_emma',     'emma.lund@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Emma',       'Lund',        '41234567', 3, 2, TRUE),
(38, 'buyer_oliver',   'oliver.bech@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Oliver',     'Bech',        '41345678', 3, 1, TRUE),
(39, 'buyer_freja',    'freja.kirk@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Freja',      'Kirk',        '41456789', 3, 3, TRUE),
(40, 'buyer_noah',     'noah.noel@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Noah',       'Noel',        '41567890', 3, 4, TRUE),
(41, 'buyer_ella',     'ella.hauge@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ella',       'Hauge',       '42123456', 3, 5, TRUE),
(42, 'buyer_victor',   'victor.fly@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Victor',     'Fly',         '42234567', 3, 2, TRUE),
(43, 'buyer_maja',     'maja.ravn@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Maja',       'Ravn',        '42345678', 3, 1, TRUE),
(44, 'buyer_lucas',    'lucas.busk@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lucas',      'Busk',        '42456789', 3, 3, TRUE),
(45, 'buyer_clara',    'clara.from@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Clara',      'From',        '42567890', 3, 4, TRUE),
(46, 'buyer_oscar',    'oscar.birk@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Oscar',      'Birk',        '43123456', 3, 5, TRUE),
(47, 'buyer_laura',    'laura.tang@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Laura',      'Tang',        '43234567', 3, 2, TRUE),
(48, 'buyer_william',  'william.hald@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'William',    'Hald',        '43345678', 3, 1, TRUE),
(49, 'buyer_alberte',  'alberte.gad@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alberte',    'Gad',         '43456789', 3, 3, TRUE),
(50, 'buyer_carl',     'carl.nord@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Carl',       'Nord',        '43567890', 3, 4, TRUE),
(51, 'buyer_nora',     'nora.sand@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nora',       'Sand',        '44123456', 3, 5, TRUE),
(52, 'buyer_august',   'august.elm@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'August',     'Elm',         '44234567', 3, 2, TRUE),
(53, 'buyer_rosa',     'rosa.fjord@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rosa',       'Fjord',       '44345678', 3, 1, TRUE),
(54, 'buyer_magnus',   'magnus.hav@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Magnus',     'Hav',         '44456789', 3, 3, TRUE),
(55, 'buyer_astrid',   'astrid.sol@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Astrid',     'Sol',         '44567890', 3, 4, TRUE),
(56, 'buyer_valdemar', 'valdemar.ege@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Valdemar',   'Ege',         '45123456', 3, 5, TRUE),
(57, 'buyer_agnes',    'agnes.ask@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Agnes',      'Ask',         '45234567', 3, 2, TRUE),
(58, 'buyer_malthe',   'malthe.ly@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Malthe',     'Ly',          '45345678', 3, 1, TRUE),
(59, 'buyer_karla',    'karla.eng@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Karla',      'Eng',         '45456789', 3, 3, TRUE),
(60, 'buyer_theodor',  'theodor.aa@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Theodor',    'Aa',          '45567890', 3, 4, TRUE),
(61, 'buyer_vigga',    'vigga.mos@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Vigga',      'Mos',         '46123456', 3, 5, TRUE),
(62, 'buyer_aksel',    'aksel.dal@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Aksel',      'Dal',         '46234567', 3, 2, TRUE),
(63, 'buyer_filippa',  'filippa.ros@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Filippa',    'Ros',         '46345678', 3, 1, TRUE),
(64, 'buyer_storm',    'storm.lys@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Storm',      'Lys',         '46456789', 3, 3, TRUE),
(65, 'buyer_liv',      'liv.mark@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Liv',        'Mark',        '46567890', 3, 4, TRUE),
(66, 'buyer_konrad',   'konrad.bro@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Konrad',     'Bro',         '47123456', 3, 5, TRUE),
(67, 'buyer_frida',    'frida.holm@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Frida',      'Holm',        '47234567', 3, 2, TRUE),
(68, 'buyer_vilhelm',  'vilhelm.soe@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Vilhelm',    'Sø',          '47345678', 3, 1, TRUE),
(69, 'buyer_alma',     'alma.sky@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alma',       'Sky',         '47456789', 3, 3, TRUE),
(70, 'buyer_elias',    'elias.vind@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Elias',      'Vind',        '47567890', 3, 4, TRUE),
(71, 'buyer_johanne',  'johanne.ris@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Johanne',    'Ris',         '48123456', 3, 5, TRUE),
(72, 'buyer_erik2',    'erik.bak@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Erik',       'Bak',         '48234567', 3, 2, TRUE),
(73, 'buyer_mathilde', 'mathilde.rye@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mathilde',   'Rye',         '48345678', 3, 1, TRUE),
(74, 'buyer_sigurd',   'sigurd.boe@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sigurd',     'Boe',         '48456789', 3, 3, TRUE),
(75, 'buyer_ellen',    'ellen.graa@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ellen',      'Graa',        '48567890', 3, 4, TRUE),
(76, 'buyer_alfred',   'alfred.roe@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alfred',     'Roe',         '49123456', 3, 5, TRUE),
(77, 'buyer_hannah',   'hannah.top@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Hannah',     'Top',         '49234567', 3, 2, TRUE),
(78, 'buyer_felix',    'felix.fyr@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Felix',      'Fyr',         '49345678', 3, 1, TRUE),
(79, 'buyer_isabella', 'isabella.bor@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Isabella',   'Bor',         '49456789', 3, 3, TRUE),
(80, 'buyer_sebastian','sebastian.ko@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sebastian',  'Ko',          '49567890', 3, 4, TRUE),
(81, 'buyer_marie',    'marie.fugl@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Marie',      'Fugl',        '50123456', 3, 5, TRUE),
(82, 'buyer_tobias',   'tobias.kvist@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Tobias',     'Kvist',       '50234567', 3, 2, TRUE),
(83, 'buyer_emilie',   'emilie.pil@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Emilie',     'Pil',         '50345678', 3, 1, TRUE),
(84, 'buyer_mikkel2',  'mikkel.flod@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mikkel',     'Flod',        '50456789', 3, 3, TRUE),
(85, 'buyer_signe',    'signe.jord@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Signe',      'Jord',        '50567890', 3, 4, TRUE),
(86, 'buyer_daniel',   'daniel.toft@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Daniel',     'Toft',        '51123456', 3, 5, TRUE),
(87, 'buyer_josefine', 'josefine.lyn@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Josefine',   'Lyn',         '51234567', 3, 2, TRUE),
(88, 'buyer_alexander','alexander.gul@gmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alexander',  'Gul',         '51345678', 3, 1, TRUE),
(89, 'buyer_victoria', 'victoria.dam@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Victoria',   'Dam',         '51456789', 3, 3, TRUE),
(90, 'buyer_christian','christian.ild@gmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Christian',  'Ild',         '51567890', 3, 4, TRUE),
(91, 'buyer_petra',    'petra.grus@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Petra',      'Grus',        '52123456', 3, 5, TRUE),
(92, 'buyer_simon',    'simon.blaa@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Simon',      'Blaa',        '52234567', 3, 2, TRUE),
(93, 'buyer_sara',     'sara.sten@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sara',       'Sten',        '52345678', 3, 1, TRUE),
(94, 'buyer_jakob',    'jakob.hede@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jakob',      'Hede',        '52456789', 3, 3, TRUE),
(95, 'buyer_thea',     'thea.fjeld@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Thea',       'Fjeld',       '52567890', 3, 4, TRUE),
(96, 'buyer_rasmus2',  'rasmus.hav@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rasmus',     'Hav',         '53123456', 3, 5, TRUE),
(97, 'buyer_lea',      'lea.eng@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lea',        'Eng',         '53234567', 3, 2, TRUE),
(98, 'buyer_gustav',   'gustav.vig@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Gustav',     'Vig',         '53345678', 3, 1, TRUE),
(99, 'buyer_olivia',   'olivia.dahl@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Olivia',     'Dahl',        '53456789', 3, 3, TRUE),
(100,'buyer_anton',    'anton.skov@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anton',      'Skov',        '53567890', 3, 4, TRUE);

-- ============================================
-- CARS (100 biler - fordelt på sellers 6-30)
-- Blanding af benzin, diesel, el, hybrid
-- ============================================

INSERT INTO car (id, model_id, fuel_type_id, seller_id, price, year, mileage_km, color, description, is_sold) VALUES
-- Seller 6 (autohandler_kbh) - pro, Hovedstaden
(1,  6,  1, 6,  149900.00, 2019, 78000,  'Grå',    'Velholdt VW Golf 1.4 TSI. Servicebog medfølger. Nysynet.', FALSE),
(2,  11, 2, 6,  229900.00, 2020, 55000,  'Sort',   'BMW 3-serie 320d. Lædersæder, navigation, adaptiv fartpilot.', FALSE),
(3,  51, 3, 6,  279900.00, 2021, 32000,  'Hvid',   'Tesla Model 3 Long Range. Autopilot inkluderet. Fantastisk rækkevidde.', FALSE),
(4,  21, 1, 6,  179900.00, 2020, 45000,  'Blå',    'Mercedes A-Klasse A200. Komfortabel bybil med premium udstyr.', FALSE),

-- Seller 7 (biler_aarhus) - pro, Midtjylland
(5,  1,  4, 7,  169900.00, 2021, 38000,  'Sølv',   'Toyota Corolla Hybrid. Utrolig brændstoføkonomisk. Som ny.', FALSE),
(6,  43, 4, 7,  219900.00, 2022, 25000,  'Rød',    'Hyundai Tucson Hybrid. Rummelig SUV med masser af udstyr.', FALSE),
(7,  55, 2, 7,  139900.00, 2018, 92000,  'Grå',    'Skoda Octavia Combi 2.0 TDI. Perfekt familiebil. Stor bagagerum.', FALSE),
(8,  8,  2, 7,  119900.00, 2017, 110000, 'Mørkblå','VW Passat 2.0 TDI. Veludstyret stationcar. El-sæder.', FALSE),

-- Seller 8 (privat_erik) - privat, Nordjylland
(9,  36, 1, 8,  89900.00,  2016, 125000, 'Sort',   'Ford Focus 1.0 EcoBoost. Kører fantastisk. Ny kilerem.', FALSE),
(10, 60, 1, 8,  69900.00,  2018, 68000,  'Hvid',   'Renault Clio 0.9 TCe. Billig i drift. Perfekt til studerende.', FALSE),

-- Seller 9 (kvalitetsbiler) - pro, Syddanmark
(11, 17, 2, 9,  199900.00, 2019, 85000,  'Sort',   'Audi A4 Avant 2.0 TDI. S-line pakke. Virtual Cockpit.', FALSE),
(12, 22, 2, 9,  259900.00, 2020, 62000,  'Hvid',   'Mercedes C-Klasse C220d. AMG-line. Panoramatag.', FALSE),
(13, 28, 5, 9,  329900.00, 2021, 45000,  'Grøn',   'Volvo XC60 T6 Plug-in Hybrid. Inscription. Bowers & Wilkins.', FALSE),
(14, 47, 1, 9,  189900.00, 2022, 28000,  'Grå',    'Kia Sportage 1.6 T-GDI. GT-Line. Panoramatag. Head-up display.', FALSE),

-- Seller 10 (privat_jonas) - privat, Sjælland
(15, 7,  1, 10, 79900.00,  2017, 95000,  'Rød',    'VW Polo 1.2 TSI. God bybil. Parkeringssensor. Bluetooth.', FALSE),
(16, 41, 1, 10, 59900.00,  2016, 88000,  'Blå',    'Hyundai i20 1.25. Billig forsikring. Velegnet som 1. bil.', FALSE),

-- Seller 11 (bilhuset_odense) - pro, Syddanmark
(17, 32, 1, 11, 159900.00, 2021, 35000,  'Grå',    'Peugeot 308 1.2 PureTech. Nyt design. Digital instrumentering.', FALSE),
(18, 65, 4, 11, 209900.00, 2022, 22000,  'Sort',   'Nissan Qashqai e-POWER Hybrid. Automatik. ProPILOT.', FALSE),
(19, 46, 1, 11, 129900.00, 2019, 72000,  'Hvid',   'Kia Ceed 1.4 T-GDI. Rigtig pæn. 7 års garanti.', FALSE),
(20, 69, 1, 11, 99900.00,  2020, 42000,  'Gul',    'Opel Corsa 1.2 Turbo. Sporty lille bil. Apple CarPlay.', FALSE),

-- Seller 12 (privat_maria) - privat, Hovedstaden
(21, 2,  4, 12, 129900.00, 2020, 40000,  'Rød',    'Toyota Yaris Hybrid. Super økonomisk. Perfekt til København.', FALSE),
(22, 81, 1, 12, 89900.00,  2019, 32000,  'Mint',   'Fiat 500 1.2 Lounge. Charmerende retro-stil. Panoramatag.', FALSE),

-- Seller 13 (nordjysk_auto) - pro, Nordjylland
(23, 9,  2, 13, 249900.00, 2021, 48000,  'Sort',   'VW Tiguan 2.0 TDI 4MOTION. R-Line. Elektrisk bagklap.', FALSE),
(24, 13, 2, 13, 289900.00, 2020, 58000,  'Hvid',   'BMW X3 xDrive20d. M-Sport pakke. Harman Kardon.', FALSE),
(25, 3,  4, 13, 279900.00, 2022, 18000,  'Sølv',   'Toyota RAV4 Hybrid AWD. Rummelig og driftssikker.', FALSE),
(26, 76, 2, 13, 199900.00, 2019, 75000,  'Rød',    'Mazda CX-5 2.2 SkyActiv-D. Optimum udstyr. Skinninteriør.', FALSE),

-- Seller 14 (privat_lise) - privat, Midtjylland
(27, 84, 1, 14, 69900.00,  2018, 55000,  'Blå',    'Suzuki Swift 1.2 Dualjet. Sjov at køre. Lavt brændstofforbrug.', FALSE),
(28, 31, 1, 14, 109900.00, 2020, 38000,  'Orange', 'Peugeot 208 1.2 PureTech. Allure udstyr. Flot interiør.', FALSE),

-- Seller 15 (tesla_specialist) - pro, Hovedstaden
(29, 51, 3, 15, 319900.00, 2022, 15000,  'Sort',   'Tesla Model 3 Performance. 0-100 på 3.3 sek. Full Self-Driving.', FALSE),
(30, 52, 3, 15, 379900.00, 2023, 12000,  'Hvid',   'Tesla Model Y Long Range. 7-personers. Autopilot.', FALSE),
(31, 53, 3, 15, 499900.00, 2021, 35000,  'Rød',    'Tesla Model S Long Range. Premium interiør. Raven.', FALSE),
(32, 52, 3, 15, 349900.00, 2022, 22000,  'Blå',    'Tesla Model Y Standard Range. RWD. Imponerende rækkevidde.', FALSE),

-- Seller 16 (privat_karsten) - privat, Nordjylland
(33, 8,  2, 16, 99900.00,  2016, 145000, 'Sølv',   'VW Passat 1.6 TDI. Comfortline. Fartpilot. Nysynet.', FALSE),
(34, 70, 1, 16, 79900.00,  2017, 88000,  'Sort',   'Opel Astra 1.4 Turbo. Sports Tourer. Fin stand.', FALSE),

-- Seller 17 (premium_biler) - pro, Hovedstaden
(35, 19, 3, 17, 349900.00, 2021, 28000,  'Sort',   'Audi e-tron 55 quattro. S-line. Matrix LED. B&O.', FALSE),
(36, 15, 3, 17, 419900.00, 2022, 18000,  'Grå',    'BMW i4 M50. 544 hk. M-Sport Pro. Fantastisk at køre.', FALSE),
(37, 29, 5, 17, 449900.00, 2021, 38000,  'Hvid',   'Volvo XC90 T8 Plug-in Hybrid. Inscription. 7-sæder.', FALSE),
(38, 23, 2, 17, 379900.00, 2021, 42000,  'Sort',   'Mercedes GLC 300d 4MATIC. AMG-Line. Burmester.', FALSE),

-- Seller 18 (privat_susanne) - privat, Sjælland
(39, 72, 1, 18, 59900.00,  2017, 72000,  'Hvid',   'Citroën C3 1.2 PureTech. Aircross. Komfortabel.', FALSE),
(40, 62, 1, 18, 109900.00, 2019, 55000,  'Orange', 'Renault Captur 1.3 TCe. Intens. Stort panoramatag.', FALSE),

-- Seller 19 (sjælland_auto) - pro, Sjælland
(41, 27, 3, 19, 259900.00, 2022, 20000,  'Blå',    'Volvo XC40 Recharge Pure Electric. Single Motor. Pixel LED.', FALSE),
(42, 44, 3, 19, 199900.00, 2021, 30000,  'Hvid',   'Hyundai Kona Electric 64 kWh. Premium. Varmepumpe.', FALSE),
(43, 67, 3, 19, 159900.00, 2020, 42000,  'Grå',    'Nissan Leaf e+ 62 kWh. Tekna. ProPILOT. Bose.', FALSE),
(44, 58, 3, 19, 299900.00, 2023, 10000,  'Sort',   'Skoda Enyaq iV 80. Sportline. 77 kWh batteri.', FALSE),

-- Seller 20 (privat_martin) - privat, Midtjylland
(45, 75, 1, 20, 149900.00, 2020, 48000,  'Rød',    'Mazda3 2.0 SkyActiv-G. Cosmo. Head-up display. Bose.', FALSE),
(46, 79, 1, 20, 119900.00, 2019, 62000,  'Sort',   'Seat Leon 1.5 TSI. FR. Sportsundervogn. Virtual Cockpit.', FALSE),

-- Seller 21 (elbil_center) - pro, Midtjylland
(47, 10, 3, 21, 279900.00, 2022, 25000,  'Hvid',   'VW ID.4 Pro Performance. 204 hk. Stort batteri.', FALSE),
(48, 45, 3, 21, 349900.00, 2023, 8000,   'Grå',    'Hyundai Ioniq 5 Long Range AWD. 325 hk. V2L.', FALSE),
(49, 49, 3, 21, 379900.00, 2023, 12000,  'Grøn',   'Kia EV6 Long Range AWD GT-Line. 800V lading.', FALSE),
(50, 48, 3, 21, 229900.00, 2022, 18000,  'Blå',    'Kia Niro EV 64 kWh. Advance. Varmepumpe.', FALSE),

-- Seller 22 (privat_line) - privat, Syddanmark
(51, 50, 1, 22, 59900.00,  2019, 35000,  'Rød',    'Kia Picanto 1.0 MPI. Comfort. Perfekt bybil.', FALSE),
(52, 4,  1, 22, 49900.00,  2018, 42000,  'Sort',   'Toyota Aygo 1.0. X-play. Billig at køre og forsikre.', FALSE),

-- Seller 23 (syd_autosalg) - pro, Syddanmark
(53, 26, 2, 23, 239900.00, 2020, 65000,  'Sort',   'Volvo V60 D4. Inscription. Pilot Assist. Skindinteriør.', FALSE),
(54, 57, 2, 23, 179900.00, 2019, 82000,  'Sølv',   'Skoda Superb Combi 2.0 TDI. Style. Columbus navigation.', FALSE),
(55, 35, 5, 23, 199900.00, 2020, 55000,  'Grå',    'Peugeot 508 Hybrid. GT. Flot design. Night Vision.', FALSE),
(56, 16, 1, 23, 169900.00, 2021, 32000,  'Hvid',   'Audi A3 Sportback 35 TFSI. S-line. Virtuel Cockpit Plus.', FALSE),

-- Seller 24 (privat_katrine) - privat, Nordjylland
(57, 68, 1, 24, 49900.00,  2016, 78000,  'Grøn',   'Nissan Micra 0.9 IG-T. Acenta. Fartpilot. Rygsensor.', FALSE),
(58, 37, 1, 24, 59900.00,  2017, 65000,  'Blå',    'Ford Fiesta 1.0 EcoBoost. Titanium. Touchskærm.', FALSE),

-- Seller 25 (bilpalads) - pro, Hovedstaden
(59, 20, 2, 25, 299900.00, 2021, 40000,  'Sort',   'Audi Q5 40 TDI quattro. S-line. Matrix LED. B&O.', FALSE),
(60, 5,  4, 25, 229900.00, 2022, 18000,  'Sølv',   'Toyota C-HR 2.0 Hybrid. GR Sport. JBL lyd.', FALSE),
(61, 14, 3, 25, 319900.00, 2021, 32000,  'Hvid',   'BMW iX3 Impressive. 286 hk. Driving Assistant Pro.', FALSE),
(62, 24, 3, 25, 289900.00, 2022, 22000,  'Sort',   'Mercedes EQA 250. AMG-Line. Navi Premium. MBUX.', FALSE),
(63, 33, 5, 25, 249900.00, 2022, 20000,  'Blå',    'Peugeot 3008 Hybrid. GT. Focal lyd. Night Vision.', FALSE),

-- Seller 26 (privat_brian) - privat, Midtjylland
(64, 42, 1, 26, 119900.00, 2019, 70000,  'Rød',    'Hyundai i30 1.4 T-GDI. Trend. Apple CarPlay. Rygsensor.', FALSE),
(65, 56, 1, 26, 89900.00,  2020, 48000,  'Grå',    'Skoda Fabia 1.0 TSI. Style. Stort bagagerum for klassen.', FALSE),

-- Seller 27 (midtjylland_biler) - pro, Midtjylland
(66, 38, 5, 27, 239900.00, 2022, 28000,  'Grøn',   'Ford Kuga 2.5 PHEV. ST-Line X. 225 hk. AWD.', FALSE),
(67, 12, 2, 27, 189900.00, 2020, 52000,  'Blå',    'BMW 1-serie 118d. M-Sport. Live Cockpit Plus.', FALSE),
(68, 18, 1, 27, 219900.00, 2021, 38000,  'Sort',   'Audi Q3 35 TFSI. Advanced. Virtual Cockpit.', FALSE),
(69, 59, 1, 27, 159900.00, 2021, 30000,  'Hvid',   'Skoda Kamiq 1.5 TSI. Style. Assistentpakke.', FALSE),

-- Seller 28 (privat_helle) - privat, Hovedstaden
(70, 34, 3, 28, 149900.00, 2021, 22000,  'Blå',    'Peugeot e-208 GT. 136 hk. 340 km rækkevidde. Sjov elbil.', FALSE),
(71, 82, 3, 28, 159900.00, 2022, 15000,  'Hvid',   'Fiat 500e Icon. 42 kWh. Retro-charm med moderne teknik.', FALSE),

-- Seller 29 (familieauto) - pro, Sjælland
(72, 3,  4, 29, 299900.00, 2022, 22000,  'Grå',    'Toyota RAV4 Plug-in Hybrid. Style. 306 hk. El-bagklap.', FALSE),
(73, 43, 4, 29, 249900.00, 2023, 10000,  'Blå',    'Hyundai Tucson Hybrid. Advanced. Bluelink. Sædevarme.', FALSE),
(74, 9,  2, 29, 219900.00, 2020, 58000,  'Sort',   'VW Tiguan 2.0 TDI. Elegance. Ergoactive sæder.', FALSE),
(75, 28, 5, 29, 359900.00, 2022, 28000,  'Hvid',   'Volvo XC60 T6 Recharge. Ultimate. Air Suspension.', FALSE),

-- Seller 30 (privat_ole) - privat, Syddanmark
(76, 78, 1, 30, 79900.00,  2018, 62000,  'Sort',   'Seat Ibiza 1.0 TSI. FR. Beats Audio. LED-forlygter.', FALSE),
(77, 61, 2, 30, 99900.00,  2017, 95000,  'Sølv',   'Renault Megane 1.5 dCi. Bose Edition. Godt udstyr.', FALSE),

-- Ekstra biler for at nå 100 (fordelt på diverse sellers)
(78, 40, 3, 6,  369900.00, 2022, 18000,  'Grå',    'Ford Mustang Mach-E Extended Range. Premium. AWD.', FALSE),
(79, 30, 3, 7,  299900.00, 2024, 5000,   'Hvid',   'Volvo EX30 Single Motor Extended. Ultra design.', FALSE),
(80, 63, 3, 9,  119900.00, 2020, 38000,  'Blå',    'Renault Zoe R135 Intens. 52 kWh. CCS-lading.', FALSE),
(81, 71, 3, 11, 179900.00, 2022, 20000,  'Sort',   'Opel Mokka-e GS Line. 136 hk. IntelliLux Matrix.', FALSE),
(82, 64, 3, 13, 249900.00, 2023, 12000,  'Grå',    'Renault Megane E-Tech EV60. Iconic. 450 km rækkevidde.', FALSE),
(83, 77, 3, 15, 199900.00, 2022, 15000,  'Sølv',   'Mazda MX-30 e-SkyActiv. Edition R. Kork-interiør.', FALSE),
(84, 74, 3, 17, 219900.00, 2023, 8000,   'Hvid',   'Citroën ë-C4 Shine. 50 kWh. Komfort-affjedring.', FALSE),
(85, 25, 3, 19, 289900.00, 2021, 35000,  'Blå',    'Mercedes EQC 400 4MATIC. Electric Art. MBUX.', FALSE),
(86, 73, 2, 21, 149900.00, 2021, 42000,  'Rød',    'Citroën C4 1.5 BlueHDi. Shine. Avancerede komfortsæder.', FALSE),
(87, 85, 4, 23, 139900.00, 2021, 32000,  'Grøn',   'Suzuki Vitara 1.4 Boosterjet Hybrid. GL+. Allgrip.', FALSE),
(88, 83, 1, 25, 109900.00, 2020, 48000,  'Sølv',   'Fiat Tipo 1.4 T-Jet. Lounge Kombi. God plads.', FALSE),
(89, 80, 1, 27, 119900.00, 2020, 42000,  'Orange', 'Seat Arona 1.0 TSI. FR. Beats Audio. Fuld LED.', FALSE),
(90, 66, 1, 29, 99900.00,  2019, 52000,  'Sort',   'Nissan Juke 1.0 DIG-T. N-Connecta. ProPILOT.', FALSE),
(91, 39, 4, 6,  179900.00, 2022, 22000,  'Blå',    'Ford Puma 1.0 EcoBoost Hybrid. ST-Line X. MegaBox.', FALSE),
(92, 54, 3, 7,  599900.00, 2020, 42000,  'Sort',   'Tesla Model X Long Range. 6-sæder. Premium. MCU2.', FALSE),
(93, 1,  4, 9,  189900.00, 2022, 18000,  'Hvid',   'Toyota Corolla Touring Sports Hybrid. H3 Smartpakke.', FALSE),
(94, 6,  3, 11, 239900.00, 2021, 28000,  'Grå',    'VW ID.3 Pro S. 77 kWh. Tech-pakke. Matrix LED.', FALSE),
(95, 27, 5, 13, 299900.00, 2023, 8000,   'Sort',   'Volvo XC40 T5 Recharge. R-Design. Pilot Assist.', FALSE),
(96, 11, 5, 17, 349900.00, 2022, 25000,  'Hvid',   'BMW 330e Touring. M-Sport. xDrive. Adaptiv undervogn.', FALSE),
(97, 22, 4, 23, 289900.00, 2022, 30000,  'Sort',   'Mercedes C-Klasse C300e. AMG-Line. Energi. 100 km el.', FALSE),
(98, 16, 1, 25, 189900.00, 2022, 18000,  'Rød',    'Audi A3 Sportback 40 TFSI e. S-line. Bang & Olufsen.', FALSE),
(99, 52, 3, 15, 359900.00, 2023, 8000,   'Sølv',   'Tesla Model Y Performance. Track Mode. 20" hjul.', FALSE),
(100,47, 5, 29, 269900.00, 2023, 15000,  'Grøn',   'Kia Sportage 1.6 T-GDI PHEV. GT-Line S. AWD.', FALSE);

-- ============================================
-- FAVORITES (diverse buyers har gemt biler)
-- ============================================

INSERT INTO favorite (user_id, car_id) VALUES
(31, 3),  (31, 29), (31, 51),
(32, 5),  (32, 45), (32, 93),
(33, 9),  (33, 10), (33, 58),
(34, 11), (34, 12), (34, 38),
(35, 21), (35, 22), (35, 70),
(36, 29), (36, 30), (36, 48),
(37, 47), (37, 49), (37, 50),
(38, 1),  (38, 6),  (38, 19),
(39, 23), (39, 24), (39, 25),
(40, 35), (40, 36), (40, 37),
(41, 41), (41, 42), (41, 43),
(42, 53), (42, 54),
(43, 71), (43, 82),
(44, 15), (44, 27),
(45, 59), (45, 60),
(46, 72), (46, 73), (46, 75),
(47, 78), (47, 92),
(48, 96), (48, 97),
(49, 44), (49, 58),
(50, 3),  (50, 99),
(51, 30), (51, 31),
(52, 5),  (52, 25),
(53, 80), (53, 83),
(54, 17), (54, 18),
(55, 61), (55, 62),
(56, 14), (56, 100),
(57, 7),  (57, 54),
(58, 33), (58, 34),
(59, 39), (59, 40),
(60, 55), (60, 56),
(61, 63), (61, 66),
(62, 67), (62, 68),
(63, 84), (63, 85),
(64, 86), (64, 87),
(65, 88), (65, 89),
(66, 90), (66, 91),
(67, 1),  (67, 2),
(68, 94), (68, 95),
(69, 76), (69, 77),
(70, 46), (70, 64);

-- ============================================
-- MESSAGES (samtaler mellem buyers og sellers)
-- ============================================

INSERT INTO message (sender_id, receiver_id, car_id, content, sent_at, is_read) VALUES
-- Buyer 31 spørger om Tesla Model 3
(31, 6,  3,  'Hej! Er Tesla Model 3 stadig tilgængelig? Hvad er batteriets sundhedstilstand?', '2025-11-01 10:00:00', TRUE),
(6,  31, 3,  'Hej Anna! Ja, den er stadig til salg. Batteriet er i super stand - 96% kapacitet. Vil du komme forbi og prøvekøre?', '2025-11-01 11:30:00', TRUE),
(31, 6,  3,  'Det lyder godt! Kan jeg komme lørdag formiddag?', '2025-11-01 14:00:00', TRUE),
(6,  31, 3,  'Perfekt! Kom bare forbi kl. 10. Adressen er Østerbrogade 142.', '2025-11-01 14:30:00', TRUE),

-- Buyer 32 spørger om Toyota Corolla Hybrid
(32, 7,  5,  'Hej, jeg er interesseret i jeres Toyota Corolla Hybrid. Er prisen til forhandling?', '2025-11-02 09:15:00', TRUE),
(7,  32, 5,  'Hej Peter! Vi kan godt tale om prisen. Kom forbi og se den, så finder vi ud af det.', '2025-11-02 10:00:00', TRUE),

-- Buyer 36 spørger om Tesla Model Y
(36, 15, 30, 'Hej! Jeg overvejer Model Y til familien. Hvordan er pladsen i bagagerummet med 7 sæder oppe?', '2025-11-03 15:00:00', TRUE),
(15, 36, 30, 'Hej Kasper! Med 3. sæderække oppe er der stadig 350L bagagerum. Klapper man dem ned har du over 2000L. Rigtig god familiebil!', '2025-11-03 16:20:00', TRUE),
(36, 15, 30, 'Fedt! Hvad med vinterdæk - er de inkluderet?', '2025-11-03 17:00:00', FALSE),

-- Buyer 37 spørger om VW ID.4
(37, 21, 47, 'Hej, hvilken ladehastighed kan ID.4 klare?', '2025-11-04 08:30:00', TRUE),
(21, 37, 47, 'Hej Emma! Den kan lade op til 135 kW DC. Fra 10-80% tager ca. 36 minutter.', '2025-11-04 09:00:00', TRUE),

-- Buyer 40 spørger om Audi e-tron
(40, 17, 35, 'Er det muligt at se bilen i weekenden?', '2025-11-05 12:00:00', TRUE),
(17, 40, 35, 'Hej Noah! Selvfølgelig. Vi har åbent lørdag 10-15. Du er velkommen!', '2025-11-05 13:00:00', TRUE),

-- Buyer 46 spørger om Toyota RAV4
(46, 29, 72, 'Hej! Hvad er den reelle elforbrug på RAV4 PHEV i hverdagen?', '2025-11-06 11:00:00', TRUE),
(29, 46, 72, 'Hej Oscar! Med daglig opladning kører de fleste 60-70 km på ren el. Til daglig pendling er det fantastisk!', '2025-11-06 12:30:00', TRUE),
(46, 29, 72, 'Det er præcis min pendlerafstand. Kan I reservere den til næste uge?', '2025-11-06 13:00:00', FALSE),

-- Buyer 50 spørger om Tesla Model Y Performance
(50, 15, 99, 'Hej! Er Model Y Performance stadig tilgængelig? Hvad med Track Mode - virker det i DK?', '2025-11-07 09:00:00', TRUE),
(15, 50, 99, 'Ja, den er her! Track Mode virker fint - du kan bruge det på lukkede baner. Virkelig sjovt!', '2025-11-07 10:15:00', FALSE),

-- Buyer 34 prutte om Audi A4
(34, 9,  11, 'Hej, jeg ser Audi A4 til 199.900. Ville I overveje 175.000?', '2025-11-08 14:00:00', TRUE),
(9,  34, 11, 'Hej Mark. 175.000 er lidt lavt ift. stand og udstyr. Vi kan mødes ved 189.900 - hvad siger du?', '2025-11-08 15:30:00', TRUE),
(34, 9,  11, 'Lad os sige 185.000 og vi har en deal?', '2025-11-08 16:00:00', FALSE),

-- Buyer 55 spørger om BMW iX3
(55, 25, 61, 'Hej! Er der nogen ridser eller skader på BMW iX3?', '2025-11-09 10:00:00', TRUE),
(25, 55, 61, 'Hej Astrid! Bilen er i meget pæn stand. Der er en mindre parkeringsrids på højre bagskærm, men ellers perfekt. Jeg kan sende flere billeder.', '2025-11-09 11:00:00', TRUE),

-- Buyer 41 spørger om Volvo XC40 Recharge
(41, 19, 41, 'Hej, hvad er den reelle rækkevidde om vinteren på XC40 Recharge?', '2025-11-10 08:00:00', TRUE),
(19, 41, 41, 'Hej Ella! Realistisk set 280-320 km om vinteren. Om sommeren 380-420 km. Den har varmepumpe som hjælper meget.', '2025-11-10 09:30:00', FALSE),

-- Buyer 67 spørger om VW Golf
(67, 6,  1,  'Er servicebogen komplet på Golf?', '2025-11-11 13:00:00', TRUE),
(6,  67, 1,  'Hej Frida! Ja, alle services er udført hos autoriseret VW-værksted. Jeg kan sende kopi af servicebogen.', '2025-11-11 14:00:00', FALSE);
