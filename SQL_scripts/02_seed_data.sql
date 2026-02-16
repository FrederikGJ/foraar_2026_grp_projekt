-- ============================================
-- BILBASEN CLONE - SEED DATA (OPDATERET)
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

INSERT INTO app_user (id, username, email, password_hash, first_name, last_name, phone, role_id, private_seller) VALUES
-- ADMINS (1-5)
(1,  'admin1',       'admin1@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lars',      'Hansen',      '20123456', 1, FALSE),
(2,  'admin2',       'admin2@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mette',     'Jensen',      '20234567', 1, FALSE),
(3,  'admin3',       'admin3@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Søren',     'Nielsen',     '20345678', 1, FALSE),
(4,  'admin4',       'admin4@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anne',      'Pedersen',    '20456789', 1, FALSE),
(5,  'admin5',       'admin5@bilbasen.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Peter',     'Andersen',    '20567890', 1, FALSE),

-- SELLERS (6-30) – blanding af private og professionelle
(6,  'autohandler_kbh',   'kbh@autohandler.dk',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Thomas',    'Møller',      '30123456', 2, FALSE),
(7,  'biler_aarhus',      'info@bileraarhus.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mikkel',    'Christensen', '30234567', 2, FALSE),
(8,  'privat_erik',       'erik.holm@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Erik',      'Holm',        '30345678', 2, TRUE),
(9,  'kvalitetsbiler',    'info@kvalitetsbiler.dk',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Camilla',   'Larsen',      '30456789', 2, FALSE),
(10, 'privat_jonas',      'jonas.wind@yahoo.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jonas',     'Wind',        '30567890', 2, TRUE),
(11, 'bilhuset_odense',   'salg@bilhuset.dk',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rasmus',    'Sørensen',    '31123456', 2, FALSE),
(12, 'privat_maria',      'maria.berg@hotmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Maria',     'Berg',        '31234567', 2, TRUE),
(13, 'nordjysk_auto',     'salg@nordjyskauto.dk',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Henrik',    'Dahl',        '31345678', 2, FALSE),
(14, 'privat_lise',       'lise.krogh@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lise',      'Krogh',       '31456789', 2, TRUE),
(15, 'tesla_specialist',  'info@teslaspec.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Frederik',  'Lund',        '31567890', 2, FALSE),
(16, 'privat_karsten',    'karsten.ny@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Karsten',   'Nygaard',     '32123456', 2, TRUE),
(17, 'premium_biler',     'info@premiumbiler.dk',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nikolaj',   'Friis',       '32234567', 2, FALSE),
(18, 'privat_susanne',    'susanne.bach@gmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Susanne',   'Bach',        '32345678', 2, TRUE),
(19, 'sjaelland_auto',    'salg@sjaellandauto.dk',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anders',    'Gram',        '32456789', 2, FALSE),
(20, 'privat_martin',     'martin.bak@outlook.dk',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Martin',    'Bak',         '32567890', 2, TRUE),
(21, 'elbil_center',      'info@elbilcenter.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jakob',     'Kjær',        '33123456', 2, FALSE),
(22, 'privat_line',       'line.frost@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Line',      'Frost',       '33234567', 2, TRUE),
(23, 'syd_autosalg',      'info@sydautosalg.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Christian', 'Bruun',       '33345678', 2, FALSE),
(24, 'privat_katrine',    'katrine.vig@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Katrine',   'Vig',         '33456789', 2, TRUE),
(25, 'bilpalads',         'salg@bilpalads.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jens',      'Storm',       '33567890', 2, FALSE),
(26, 'privat_brian',      'brian.voss@yahoo.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Brian',     'Voss',        '34123456', 2, TRUE),
(27, 'midtjylland_biler', 'salg@midtbiler.dk',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Torben',    'Rask',        '34234567', 2, FALSE),
(28, 'privat_helle',      'helle.lind@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Helle',     'Lind',        '34345678', 2, TRUE),
(29, 'familieauto',       'info@familieauto.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Kim',       'Skov',        '34456789', 2, FALSE),
(30, 'privat_ole',        'ole.park@outlook.dk',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ole',       'Park',        '34567890', 2, TRUE),

-- BUYERS (31-100)
(31, 'buyer_anna',     'anna.vik@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anna',       'Vik',         '40123456', 3, TRUE),
(32, 'buyer_peter',    'peter.due@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Peter',      'Due',         '40234567', 3, TRUE),
(33, 'buyer_sofie',    'sofie.blom@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sofie',      'Blom',        '40345678', 3, TRUE),
(34, 'buyer_mark',     'mark.sten@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mark',       'Sten',        '40456789', 3, TRUE),
(35, 'buyer_ida',      'ida.krog@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ida',        'Krog',        '40567890', 3, TRUE),
(36, 'buyer_kasper',   'kasper.dam@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Kasper',     'Dam',         '41123456', 3, TRUE),
(37, 'buyer_emma',     'emma.lund@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Emma',       'Lund',        '41234567', 3, TRUE),
(38, 'buyer_oliver',   'oliver.bech@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Oliver',     'Bech',        '41345678', 3, TRUE),
(39, 'buyer_freja',    'freja.kirk@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Freja',      'Kirk',        '41456789', 3, TRUE),
(40, 'buyer_noah',     'noah.noel@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Noah',       'Noel',        '41567890', 3, TRUE),
(41, 'buyer_ella',     'ella.hauge@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ella',       'Hauge',       '42123456', 3, TRUE),
(42, 'buyer_victor',   'victor.fly@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Victor',     'Fly',         '42234567', 3, TRUE),
(43, 'buyer_maja',     'maja.ravn@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Maja',       'Ravn',        '42345678', 3, TRUE),
(44, 'buyer_lucas',    'lucas.busk@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lucas',      'Busk',        '42456789', 3, TRUE),
(45, 'buyer_clara',    'clara.from@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Clara',      'From',        '42567890', 3, TRUE),
(46, 'buyer_oscar',    'oscar.birk@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Oscar',      'Birk',        '43123456', 3, TRUE),
(47, 'buyer_laura',    'laura.tang@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Laura',      'Tang',        '43234567', 3, TRUE),
(48, 'buyer_william',  'william.hald@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'William',    'Hald',        '43345678', 3, TRUE),
(49, 'buyer_alberte',  'alberte.gad@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alberte',    'Gad',         '43456789', 3, TRUE),
(50, 'buyer_carl',     'carl.nord@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Carl',       'Nord',        '43567890', 3, TRUE),
(51, 'buyer_nora',     'nora.sand@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Nora',       'Sand',        '44123456', 3, TRUE),
(52, 'buyer_august',   'august.elm@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'August',     'Elm',         '44234567', 3, TRUE),
(53, 'buyer_rosa',     'rosa.fjord@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rosa',       'Fjord',       '44345678', 3, TRUE),
(54, 'buyer_magnus',   'magnus.hav@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Magnus',     'Hav',         '44456789', 3, TRUE),
(55, 'buyer_astrid',   'astrid.sol@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Astrid',     'Sol',         '44567890', 3, TRUE),
(56, 'buyer_valdemar', 'valdemar.ege@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Valdemar',   'Ege',         '45123456', 3, TRUE),
(57, 'buyer_agnes',    'agnes.ask@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Agnes',      'Ask',         '45234567', 3, TRUE),
(58, 'buyer_malthe',   'malthe.ly@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Malthe',     'Ly',          '45345678', 3, TRUE),
(59, 'buyer_karla',    'karla.eng@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Karla',      'Eng',         '45456789', 3, TRUE),
(60, 'buyer_theodor',  'theodor.aa@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Theodor',    'Aa',          '45567890', 3, TRUE),
(61, 'buyer_vigga',    'vigga.mos@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Vigga',      'Mos',         '46123456', 3, TRUE),
(62, 'buyer_aksel',    'aksel.dal@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Aksel',      'Dal',         '46234567', 3, TRUE),
(63, 'buyer_filippa',  'filippa.ros@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Filippa',    'Ros',         '46345678', 3, TRUE),
(64, 'buyer_storm',    'storm.lys@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Storm',      'Lys',         '46456789', 3, TRUE),
(65, 'buyer_liv',      'liv.mark@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Liv',        'Mark',        '46567890', 3, TRUE),
(66, 'buyer_konrad',   'konrad.bro@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Konrad',     'Bro',         '47123456', 3, TRUE),
(67, 'buyer_frida',    'frida.holm@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Frida',      'Holm',        '47234567', 3, TRUE),
(68, 'buyer_vilhelm',  'vilhelm.soe@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Vilhelm',    'Sø',          '47345678', 3, TRUE),
(69, 'buyer_alma',     'alma.sky@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alma',       'Sky',         '47456789', 3, TRUE),
(70, 'buyer_elias',    'elias.vind@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Elias',      'Vind',        '47567890', 3, TRUE),
(71, 'buyer_johanne',  'johanne.ris@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Johanne',    'Ris',         '48123456', 3, TRUE),
(72, 'buyer_erik2',    'erik.bak@gmail.com',       '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Erik',       'Bak',         '48234567', 3, TRUE),
(73, 'buyer_mathilde', 'mathilde.rye@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mathilde',   'Rye',         '48345678', 3, TRUE),
(74, 'buyer_sigurd',   'sigurd.boe@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sigurd',     'Boe',         '48456789', 3, TRUE),
(75, 'buyer_ellen',    'ellen.graa@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Ellen',      'Graa',        '48567890', 3, TRUE),
(76, 'buyer_alfred',   'alfred.roe@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alfred',     'Roe',         '49123456', 3, TRUE),
(77, 'buyer_hannah',   'hannah.top@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Hannah',     'Top',         '49234567', 3, TRUE),
(78, 'buyer_felix',    'felix.fyr@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Felix',      'Fyr',         '49345678', 3, TRUE),
(79, 'buyer_isabella', 'isabella.bor@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Isabella',   'Bor',         '49456789', 3, TRUE),
(80, 'buyer_sebastian','sebastian.ko@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sebastian',  'Ko',          '49567890', 3, TRUE),
(81, 'buyer_marie',    'marie.fugl@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Marie',      'Fugl',        '50123456', 3, TRUE),
(82, 'buyer_tobias',   'tobias.kvist@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Tobias',     'Kvist',       '50234567', 3, TRUE),
(83, 'buyer_emilie',   'emilie.pil@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Emilie',     'Pil',         '50345678', 3, TRUE),
(84, 'buyer_mikkel2',  'mikkel.flod@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Mikkel',     'Flod',        '50456789', 3, TRUE),
(85, 'buyer_signe',    'signe.jord@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Signe',      'Jord',        '50567890', 3, TRUE),
(86, 'buyer_daniel',   'daniel.toft@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Daniel',     'Toft',        '51123456', 3, TRUE),
(87, 'buyer_josefine', 'josefine.lyn@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Josefine',   'Lyn',         '51234567', 3, TRUE),
(88, 'buyer_alexander','alexander.gul@gmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Alexander',  'Gul',         '51345678', 3, TRUE),
(89, 'buyer_victoria', 'victoria.dam@gmail.com',   '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Victoria',   'Dam',         '51456789', 3, TRUE),
(90, 'buyer_christian','christian.ild@gmail.com',  '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Christian',  'Ild',         '51567890', 3, TRUE),
(91, 'buyer_petra',    'petra.grus@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Petra',      'Grus',        '52123456', 3, TRUE),
(92, 'buyer_simon',    'simon.blaa@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Simon',      'Blaa',        '52234567', 3, TRUE),
(93, 'buyer_sara',     'sara.sten@gmail.com',      '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Sara',       'Sten',        '52345678', 3, TRUE),
(94, 'buyer_jakob',    'jakob.hede@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Jakob',      'Hede',        '52456789', 3, TRUE),
(95, 'buyer_thea',     'thea.fjeld@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Thea',       'Fjeld',       '52567890', 3, TRUE),
(96, 'buyer_rasmus2',  'rasmus.hav@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Rasmus',     'Hav',         '53123456', 3, TRUE),
(97, 'buyer_lea',      'lea.eng@gmail.com',        '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Lea',        'Eng',         '53234567', 3, TRUE),
(98, 'buyer_gustav',   'gustav.vig@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Gustav',     'Vig',         '53345678', 3, TRUE),
(99, 'buyer_olivia',   'olivia.dahl@gmail.com',    '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Olivia',     'Dahl',        '53456789', 3, TRUE),
(100,'buyer_anton',    'anton.skov@gmail.com',     '$2a$10$xJwL5v5Jz9UHxKQbXpIaOOJKdAIVxGZQ3v5pY5v6kEQD7J5j5j5j5', 'Anton',      'Skov',        '53567890', 3, TRUE);

-- ============================================
-- ADDRESSES (ca. 40 adresser - genbruges realistisk)
-- Forhandlere har samme adresse, private har forskellige
-- ============================================

INSERT INTO address (id, street, postal_code, city, region_id) VALUES
-- Hovedstaden forhandlere
(1,  'Østerbrogade 142',        '2100', 'København Ø',  5),  -- autohandler_kbh
(2,  'Valby Langgade 85',       '2500', 'Valby',         5),  -- tesla_specialist
(3,  'Lyngbyvej 234',           '2800', 'Lyngby',        5),  -- premium_biler
(4,  'Gladsaxe Møllevej 45',    '2860', 'Søborg',        5),  -- bilpalads

-- Midtjylland forhandlere
(5,  'Ringgaden 32',            '8000', 'Aarhus C',      2),  -- biler_aarhus
(6,  'Silkeborgvej 199',        '8000', 'Aarhus N',      2),  -- elbil_center
(7,  'Viborgvej 88',            '8210', 'Aarhus V',      2),  -- midtjylland_biler

-- Syddanmark forhandlere
(8,  'Hjallesevej 126',         '5230', 'Odense M',      3),  -- bilhuset_odense
(9,  'Fynsvej 45',              '5000', 'Odense C',      3),  -- kvalitetsbiler
(10, 'Tværvej 12',              '6000', 'Kolding',       3),  -- syd_autosalg

-- Nordjylland forhandlere
(11, 'Hobrovej 234',            '9000', 'Aalborg',       1),  -- nordjysk_auto

-- Sjælland forhandlere
(12, 'Køgevej 154',             '4000', 'Roskilde',      4),  -- sjaelland_auto
(13, 'Ringstedvej 76',          '4200', 'Slagelse',      4),  -- familieauto

-- Private sælgere - spredte adresser
(14, 'Søndergade 12',           '9000', 'Aalborg',       1),  -- privat_erik
(15, 'Lindholm Brygge 45',      '9400', 'Nørresundby',  1),  -- privat_karsten
(16, 'Kystvej 23',              '9300', 'Sæby',          1),  -- privat_katrine
(17, 'Frederiksberg Allé 89',   '1820', 'Frederiksberg', 5),  -- privat_maria
(18, 'Amagerbrogade 156',       '2300', 'København S',   5),  -- privat_helle
(19, 'Vallensbækvej 34',        '2625', 'Vallensbæk',    5),  -- privat_jonas (privatliste under Sjælland men bor i Hovedstaden)
(20, 'Tranegårdsvej 56',        '2900', 'Hellerup',      5),
(21, 'Søvang 23',               '8260', 'Viby J',        2),  -- privat_lise
(22, 'Stjernholm Allé 12',      '8381', 'Tilst',         2),  -- privat_martin
(23, 'Grenåvej 45',             '8500', 'Grenaa',        2),  -- privat_brian
(24, 'Boulevarden 67',          '5000', 'Odense C',      3),  -- privat_line
(25, 'Rosengårdcentret 8',      '5100', 'Odense C',      3),  -- privat_ole
(26, 'Vestergade 34',           '6700', 'Esbjerg',       3),
(27, 'Algade 156',              '4000', 'Roskilde',      4),  -- privat_susanne
(28, 'Ringsted Outlet 12',      '4100', 'Ringsted',      4),

-- Ekstra adresser for varieret distribution
(29, 'Nørregade 78',            '1165', 'København K',   5),
(30, 'Vesterbrogade 234',       '1620', 'København V',   5),
(31, 'Frederikssundsvej 165',   '2700', 'Brønshøj',     5),
(32, 'Åboulevarden 45',         '8000', 'Aarhus C',      2),
(33, 'Randersvej 234',          '8200', 'Aarhus N',      2),
(34, 'Møllevej 12',             '7400', 'Herning',       2),
(35, 'Nørregade 89',            '6100', 'Haderslev',     3),
(36, 'Kongevejen 45',           '6200', 'Aabenraa',      3),
(37, 'Nygade 23',               '7100', 'Vejle',         3),
(38, 'Algade 67',               '4700', 'Næstved',       4),
(39, 'Torvegade 34',            '4600', 'Køge',          4),
(40, 'Frederiksgade 12',        '4800', 'Nykøbing F',    4);

-- ============================================
-- CARS (100 biler - diverse modeller og brændstof)
-- ============================================

INSERT INTO car (id, model_id, fuel_type_id, price, year, mileage_km, color, description) VALUES
(1,  6,  1, 149900.00, 2019, 78000,  'Grå',      'Velholdt VW Golf 1.4 TSI. Servicebog medfølger. Nysynet.'),
(2,  11, 2, 229900.00, 2020, 55000,  'Sort',     'BMW 3-serie 320d. Lædersæder, navigation, adaptiv fartpilot.'),
(3,  51, 3, 279900.00, 2021, 32000,  'Hvid',     'Tesla Model 3 Long Range. Autopilot inkluderet. Fantastisk rækkevidde.'),
(4,  21, 1, 179900.00, 2020, 45000,  'Blå',      'Mercedes A-Klasse A200. Komfortabel bybil med premium udstyr.'),
(5,  1,  4, 169900.00, 2021, 38000,  'Sølv',     'Toyota Corolla Hybrid. Utrolig brændstoføkonomisk. Som ny.'),
(6,  43, 4, 219900.00, 2022, 25000,  'Rød',      'Hyundai Tucson Hybrid. Rummelig SUV med masser af udstyr.'),
(7,  55, 2, 139900.00, 2018, 92000,  'Grå',      'Skoda Octavia Combi 2.0 TDI. Perfekt familiebil. Stor bagagerum.'),
(8,  8,  2, 119900.00, 2017, 110000, 'Mørkblå',  'VW Passat 2.0 TDI. Veludstyret stationcar. El-sæder.'),
(9,  36, 1, 89900.00,  2016, 125000, 'Sort',     'Ford Focus 1.0 EcoBoost. Kører fantastisk. Ny kilerem.'),
(10, 60, 1, 69900.00,  2018, 68000,  'Hvid',     'Renault Clio 0.9 TCe. Billig i drift. Perfekt til studerende.'),
(11, 17, 2, 199900.00, 2019, 85000,  'Sort',     'Audi A4 Avant 2.0 TDI. S-line pakke. Virtual Cockpit.'),
(12, 22, 2, 259900.00, 2020, 62000,  'Hvid',     'Mercedes C-Klasse C220d. AMG-line. Panoramatag.'),
(13, 28, 5, 329900.00, 2021, 45000,  'Grøn',     'Volvo XC60 T6 Plug-in Hybrid. Inscription. Bowers & Wilkins.'),
(14, 47, 1, 189900.00, 2022, 28000,  'Grå',      'Kia Sportage 1.6 T-GDI. GT-Line. Panoramatag. Head-up display.'),
(15, 7,  1, 79900.00,  2017, 95000,  'Rød',      'VW Polo 1.2 TSI. God bybil. Parkeringssensor. Bluetooth.'),
(16, 41, 1, 59900.00,  2016, 88000,  'Blå',      'Hyundai i20 1.25. Billig forsikring. Velegnet som 1. bil.'),
(17, 32, 1, 159900.00, 2021, 35000,  'Grå',      'Peugeot 308 1.2 PureTech. Nyt design. Digital instrumentering.'),
(18, 65, 4, 209900.00, 2022, 22000,  'Sort',     'Nissan Qashqai e-POWER Hybrid. Automatik. ProPILOT.'),
(19, 46, 1, 129900.00, 2019, 72000,  'Hvid',     'Kia Ceed 1.4 T-GDI. Rigtig pæn. 7 års garanti.'),
(20, 69, 1, 99900.00,  2020, 42000,  'Gul',      'Opel Corsa 1.2 Turbo. Sporty lille bil. Apple CarPlay.'),
(21, 2,  4, 129900.00, 2020, 40000,  'Rød',      'Toyota Yaris Hybrid. Super økonomisk. Perfekt til København.'),
(22, 81, 1, 89900.00,  2019, 32000,  'Mint',     'Fiat 500 1.2 Lounge. Charmerende retro-stil. Panoramatag.'),
(23, 9,  2, 249900.00, 2021, 48000,  'Sort',     'VW Tiguan 2.0 TDI 4MOTION. R-Line. Elektrisk bagklap.'),
(24, 13, 2, 289900.00, 2020, 58000,  'Hvid',     'BMW X3 xDrive20d. M-Sport pakke. Harman Kardon.'),
(25, 3,  4, 279900.00, 2022, 18000,  'Sølv',     'Toyota RAV4 Hybrid AWD. Rummelig og driftssikker.'),
(26, 76, 2, 199900.00, 2019, 75000,  'Rød',      'Mazda CX-5 2.2 SkyActiv-D. Optimum udstyr. Skindinteriør.'),
(27, 84, 1, 69900.00,  2018, 55000,  'Blå',      'Suzuki Swift 1.2 Dualjet. Sjov at køre. Lavt brændstofforbrug.'),
(28, 31, 1, 109900.00, 2020, 38000,  'Orange',   'Peugeot 208 1.2 PureTech. Allure udstyr. Flot interiør.'),
(29, 51, 3, 319900.00, 2022, 15000,  'Sort',     'Tesla Model 3 Performance. 0-100 på 3.3 sek. Full Self-Driving.'),
(30, 52, 3, 379900.00, 2023, 12000,  'Hvid',     'Tesla Model Y Long Range. 7-personers. Autopilot.'),
(31, 53, 3, 499900.00, 2021, 35000,  'Rød',      'Tesla Model S Long Range. Premium interiør. Raven.'),
(32, 52, 3, 349900.00, 2022, 22000,  'Blå',      'Tesla Model Y Standard Range. RWD. Imponerende rækkevidde.'),
(33, 8,  2, 99900.00,  2016, 145000, 'Sølv',     'VW Passat 1.6 TDI. Comfortline. Fartpilot. Nysynet.'),
(34, 70, 1, 79900.00,  2017, 88000,  'Sort',     'Opel Astra 1.4 Turbo. Sports Tourer. Fin stand.'),
(35, 19, 3, 349900.00, 2021, 28000,  'Sort',     'Audi e-tron 55 quattro. S-line. Matrix LED. B&O.'),
(36, 15, 3, 419900.00, 2022, 18000,  'Grå',      'BMW i4 M50. 544 hk. M-Sport Pro. Fantastisk at køre.'),
(37, 29, 5, 449900.00, 2021, 38000,  'Hvid',     'Volvo XC90 T8 Plug-in Hybrid. Inscription. 7-sæder.'),
(38, 23, 2, 379900.00, 2021, 42000,  'Sort',     'Mercedes GLC 300d 4MATIC. AMG-Line. Burmester.'),
(39, 72, 1, 59900.00,  2017, 72000,  'Hvid',     'Citroën C3 1.2 PureTech. Aircross. Komfortabel.'),
(40, 62, 1, 109900.00, 2019, 55000,  'Orange',   'Renault Captur 1.3 TCe. Intens. Stort panoramatag.'),
(41, 27, 3, 259900.00, 2022, 20000,  'Blå',      'Volvo XC40 Recharge Pure Electric. Single Motor. Pixel LED.'),
(42, 44, 3, 199900.00, 2021, 30000,  'Hvid',     'Hyundai Kona Electric 64 kWh. Premium. Varmepumpe.'),
(43, 67, 3, 159900.00, 2020, 42000,  'Grå',      'Nissan Leaf e+ 62 kWh. Tekna. ProPILOT. Bose.'),
(44, 58, 3, 299900.00, 2023, 10000,  'Sort',     'Skoda Enyaq iV 80. Sportline. 77 kWh batteri.'),
(45, 75, 1, 149900.00, 2020, 48000,  'Rød',      'Mazda3 2.0 SkyActiv-G. Cosmo. Head-up display. Bose.'),
(46, 79, 1, 119900.00, 2019, 62000,  'Sort',     'Seat Leon 1.5 TSI. FR. Sportsundervogn. Virtual Cockpit.'),
(47, 10, 3, 279900.00, 2022, 25000,  'Hvid',     'VW ID.4 Pro Performance. 204 hk. Stort batteri.'),
(48, 45, 3, 349900.00, 2023, 8000,   'Grå',      'Hyundai Ioniq 5 Long Range AWD. 325 hk. V2L.'),
(49, 49, 3, 379900.00, 2023, 12000,  'Grøn',     'Kia EV6 Long Range AWD GT-Line. 800V lading.'),
(50, 48, 3, 229900.00, 2022, 18000,  'Blå',      'Kia Niro EV 64 kWh. Advance. Varmepumpe.'),
(51, 50, 1, 59900.00,  2019, 35000,  'Rød',      'Kia Picanto 1.0 MPI. Comfort. Perfekt bybil.'),
(52, 4,  1, 49900.00,  2018, 42000,  'Sort',     'Toyota Aygo 1.0. X-play. Billig at køre og forsikre.'),
(53, 26, 2, 239900.00, 2020, 65000,  'Sort',     'Volvo V60 D4. Inscription. Pilot Assist. Skindinteriør.'),
(54, 57, 2, 179900.00, 2019, 82000,  'Sølv',     'Skoda Superb Combi 2.0 TDI. Style. Columbus navigation.'),
(55, 35, 5, 199900.00, 2020, 55000,  'Grå',      'Peugeot 508 Hybrid. GT. Flot design. Night Vision.'),
(56, 16, 1, 169900.00, 2021, 32000,  'Hvid',     'Audi A3 Sportback 35 TFSI. S-line. Virtuel Cockpit Plus.'),
(57, 68, 1, 49900.00,  2016, 78000,  'Grøn',     'Nissan Micra 0.9 IG-T. Acenta. Fartpilot. Rygsensor.'),
(58, 37, 1, 59900.00,  2017, 65000,  'Blå',      'Ford Fiesta 1.0 EcoBoost. Titanium. Touchskærm.'),
(59, 20, 2, 299900.00, 2021, 40000,  'Sort',     'Audi Q5 40 TDI quattro. S-line. Matrix LED. B&O.'),
(60, 5,  4, 229900.00, 2022, 18000,  'Sølv',     'Toyota C-HR 2.0 Hybrid. GR Sport. JBL lyd.'),
(61, 14, 3, 319900.00, 2021, 32000,  'Hvid',     'BMW iX3 Impressive. 286 hk. Driving Assistant Pro.'),
(62, 24, 3, 289900.00, 2022, 22000,  'Sort',     'Mercedes EQA 250. AMG-Line. Navi Premium. MBUX.'),
(63, 33, 5, 249900.00, 2022, 20000,  'Blå',      'Peugeot 3008 Hybrid. GT. Focal lyd. Night Vision.'),
(64, 42, 1, 119900.00, 2019, 70000,  'Rød',      'Hyundai i30 1.4 T-GDI. Trend. Apple CarPlay. Rygsensor.'),
(65, 56, 1, 89900.00,  2020, 48000,  'Grå',      'Skoda Fabia 1.0 TSI. Style. Stort bagagerum for klassen.'),
(66, 38, 5, 239900.00, 2022, 28000,  'Grøn',     'Ford Kuga 2.5 PHEV. ST-Line X. 225 hk. AWD.'),
(67, 12, 2, 189900.00, 2020, 52000,  'Blå',      'BMW 1-serie 118d. M-Sport. Live Cockpit Plus.'),
(68, 18, 1, 219900.00, 2021, 38000,  'Sort',     'Audi Q3 35 TFSI. Advanced. Virtual Cockpit.'),
(69, 59, 1, 159900.00, 2021, 30000,  'Hvid',     'Skoda Kamiq 1.5 TSI. Style. Assistentpakke.'),
(70, 34, 3, 149900.00, 2021, 22000,  'Blå',      'Peugeot e-208 GT. 136 hk. 340 km rækkevidde. Sjov elbil.'),
(71, 82, 3, 159900.00, 2022, 15000,  'Hvid',     'Fiat 500e Icon. 42 kWh. Retro-charm med moderne teknik.'),
(72, 3,  4, 299900.00, 2022, 22000,  'Grå',      'Toyota RAV4 Plug-in Hybrid. Style. 306 hk. El-bagklap.'),
(73, 43, 4, 249900.00, 2023, 10000,  'Blå',      'Hyundai Tucson Hybrid. Advanced. Bluelink. Sædevarme.'),
(74, 9,  2, 219900.00, 2020, 58000,  'Sort',     'VW Tiguan 2.0 TDI. Elegance. Ergoactive sæder.'),
(75, 28, 5, 359900.00, 2022, 28000,  'Hvid',     'Volvo XC60 T6 Recharge. Ultimate. Air Suspension.'),
(76, 78, 1, 79900.00,  2018, 62000,  'Sort',     'Seat Ibiza 1.0 TSI. FR. Beats Audio. LED-forlygter.'),
(77, 61, 2, 99900.00,  2017, 95000,  'Sølv',     'Renault Megane 1.5 dCi. Bose Edition. Godt udstyr.'),
(78, 40, 3, 369900.00, 2022, 18000,  'Grå',      'Ford Mustang Mach-E Extended Range. Premium. AWD.'),
(79, 30, 3, 299900.00, 2024, 5000,   'Hvid',     'Volvo EX30 Single Motor Extended. Ultra design.'),
(80, 63, 3, 119900.00, 2020, 38000,  'Blå',      'Renault Zoe R135 Intens. 52 kWh. CCS-lading.'),
(81, 71, 3, 179900.00, 2022, 20000,  'Sort',     'Opel Mokka-e GS Line. 136 hk. IntelliLux Matrix.'),
(82, 64, 3, 249900.00, 2023, 12000,  'Grå',      'Renault Megane E-Tech EV60. Iconic. 450 km rækkevidde.'),
(83, 77, 3, 199900.00, 2022, 15000,  'Sølv',     'Mazda MX-30 e-SkyActiv. Edition R. Kork-interiør.'),
(84, 74, 3, 219900.00, 2023, 8000,   'Hvid',     'Citroën ë-C4 Shine. 50 kWh. Komfort-affjedring.'),
(85, 25, 3, 289900.00, 2021, 35000,  'Blå',      'Mercedes EQC 400 4MATIC. Electric Art. MBUX.'),
(86, 73, 2, 149900.00, 2021, 42000,  'Rød',      'Citroën C4 1.5 BlueHDi. Shine. Avancerede komfortsæder.'),
(87, 85, 4, 139900.00, 2021, 32000,  'Grøn',     'Suzuki Vitara 1.4 Boosterjet Hybrid. GL+. Allgrip.'),
(88, 83, 1, 109900.00, 2020, 48000,  'Sølv',     'Fiat Tipo 1.4 T-Jet. Lounge Kombi. God plads.'),
(89, 80, 1, 119900.00, 2020, 42000,  'Orange',   'Seat Arona 1.0 TSI. FR. Beats Audio. Fuld LED.'),
(90, 66, 1, 99900.00,  2019, 52000,  'Sort',     'Nissan Juke 1.0 DIG-T. N-Connecta. ProPILOT.'),
(91, 39, 4, 179900.00, 2022, 22000,  'Blå',      'Ford Puma 1.0 EcoBoost Hybrid. ST-Line X. MegaBox.'),
(92, 54, 3, 599900.00, 2020, 42000,  'Sort',     'Tesla Model X Long Range. 6-sæder. Premium. MCU2.'),
(93, 1,  4, 189900.00, 2022, 18000,  'Hvid',     'Toyota Corolla Touring Sports Hybrid. H3 Smartpakke.'),
(94, 6,  3, 239900.00, 2021, 28000,  'Grå',      'VW ID.3 Pro S. 77 kWh. Tech-pakke. Matrix LED.'),
(95, 27, 5, 299900.00, 2023, 8000,   'Sort',     'Volvo XC40 T5 Recharge. R-Design. Pilot Assist.'),
(96, 11, 5, 349900.00, 2022, 25000,  'Hvid',     'BMW 330e Touring. M-Sport. xDrive. Adaptiv undervogn.'),
(97, 22, 4, 289900.00, 2022, 30000,  'Sort',     'Mercedes C-Klasse C300e. AMG-Line. Energi. 100 km el.'),
(98, 16, 1, 189900.00, 2022, 18000,  'Rød',      'Audi A3 Sportback 40 TFSI e. S-line. Bang & Olufsen.'),
(99, 52, 3, 359900.00, 2023, 8000,   'Sølv',     'Tesla Model Y Performance. Track Mode. 20" hjul.'),
(100,47, 5, 269900.00, 2023, 15000,  'Grøn',     'Kia Sportage 1.6 T-GDI PHEV. GT-Line S. AWD.');

-- ============================================
-- CAR LISTINGS (100 listings - fordelt på sellers)
-- Forhandlere har mange listings på samme adresse
-- ============================================

INSERT INTO car_listing (id, car_id, seller_id, address_id, is_sold, created_at) VALUES
-- autohandler_kbh (seller 6) - 8 biler på adresse 1
(1,  1,  6,  1, FALSE, '2024-10-15 10:00:00'),
(2,  2,  6,  1, FALSE, '2024-10-18 11:30:00'),
(3,  3,  6,  1, FALSE, '2024-10-20 14:00:00'),
(4,  4,  6,  1, FALSE, '2024-10-22 09:15:00'),
(5,  78, 6,  1, FALSE, '2024-11-01 08:00:00'),
(6,  91, 6,  1, FALSE, '2024-11-05 10:30:00'),
(7,  94, 6,  1, FALSE, '2024-11-08 13:00:00'),
(8,  21, 6,  1, TRUE,  '2024-09-10 12:00:00'),

-- biler_aarhus (seller 7) - 6 biler på adresse 5
(9,  5,  7,  5, FALSE, '2024-10-16 09:00:00'),
(10, 6,  7,  5, FALSE, '2024-10-19 10:00:00'),
(11, 7,  7,  5, FALSE, '2024-10-21 11:00:00'),
(12, 8,  7,  5, FALSE, '2024-10-23 14:30:00'),
(13, 79, 7,  5, FALSE, '2024-11-02 09:00:00'),
(14, 92, 7,  5, FALSE, '2024-11-07 10:00:00'),

-- privat_erik (seller 8) - 2 biler på adresse 14
(15, 9,  8,  14, FALSE, '2024-10-17 10:00:00'),
(16, 10, 8,  14, FALSE, '2024-10-24 13:00:00'),

-- kvalitetsbiler (seller 9) - 7 biler på adresse 9
(17, 11, 9,  9, FALSE, '2024-10-18 12:00:00'),
(18, 12, 9,  9, FALSE, '2024-10-20 09:30:00'),
(19, 13, 9,  9, FALSE, '2024-10-22 10:00:00'),
(20, 14, 9,  9, FALSE, '2024-10-25 11:30:00'),
(21, 80, 9,  9, FALSE, '2024-11-03 12:00:00'),
(22, 93, 9,  9, FALSE, '2024-11-09 09:30:00'),
(23, 55, 9,  9, TRUE,  '2024-09-15 14:00:00'),

-- privat_jonas (seller 10) - 2 biler på adresse 19
(24, 15, 10, 19, FALSE, '2024-10-19 11:00:00'),
(25, 16, 10, 19, FALSE, '2024-10-26 12:30:00'),

-- bilhuset_odense (seller 11) - 6 biler på adresse 8
(26, 17, 11, 8, FALSE, '2024-10-20 10:00:00'),
(27, 18, 11, 8, FALSE, '2024-10-22 11:00:00'),
(28, 19, 11, 8, FALSE, '2024-10-24 09:00:00'),
(29, 20, 11, 8, FALSE, '2024-10-27 10:30:00'),
(30, 81, 11, 8, FALSE, '2024-11-04 11:00:00'),
(31, 94, 11, 8, FALSE, '2024-11-10 10:00:00'),

-- privat_maria (seller 12) - 2 biler på adresse 17
(32, 21, 12, 17, FALSE, '2024-10-21 12:00:00'),
(33, 22, 12, 17, FALSE, '2024-10-28 13:30:00'),

-- nordjysk_auto (seller 13) - 6 biler på adresse 11
(34, 23, 13, 11, FALSE, '2024-10-22 09:00:00'),
(35, 24, 13, 11, FALSE, '2024-10-23 10:00:00'),
(36, 25, 13, 11, FALSE, '2024-10-25 11:00:00'),
(37, 26, 13, 11, FALSE, '2024-10-29 12:00:00'),
(38, 82, 13, 11, FALSE, '2024-11-05 09:00:00'),
(39, 95, 13, 11, FALSE, '2024-11-11 10:00:00'),

-- privat_lise (seller 14) - 2 biler på adresse 21
(40, 27, 14, 21, FALSE, '2024-10-23 11:00:00'),
(41, 28, 14, 21, FALSE, '2024-10-30 12:00:00'),

-- tesla_specialist (seller 15) - 6 biler på adresse 2
(42, 29, 15, 2, FALSE, '2024-10-24 10:00:00'),
(43, 30, 15, 2, FALSE, '2024-10-25 11:00:00'),
(44, 31, 15, 2, FALSE, '2024-10-26 09:00:00'),
(45, 32, 15, 2, FALSE, '2024-10-31 10:30:00'),
(46, 83, 15, 2, FALSE, '2024-11-06 11:00:00'),
(47, 99, 15, 2, FALSE, '2024-11-12 09:00:00'),

-- privat_karsten (seller 16) - 2 biler på adresse 15
(48, 33, 16, 15, FALSE, '2024-10-25 12:00:00'),
(49, 34, 16, 15, FALSE, '2024-11-01 13:00:00'),

-- premium_biler (seller 17) - 6 biler på adresse 3
(50, 35, 17, 3, FALSE, '2024-10-26 09:00:00'),
(51, 36, 17, 3, FALSE, '2024-10-27 10:00:00'),
(52, 37, 17, 3, FALSE, '2024-10-28 11:00:00'),
(53, 38, 17, 3, FALSE, '2024-11-02 12:00:00'),
(54, 84, 17, 3, FALSE, '2024-11-07 09:00:00'),
(55, 96, 17, 3, FALSE, '2024-11-13 10:00:00'),

-- privat_susanne (seller 18) - 2 biler på adresse 27
(56, 39, 18, 27, FALSE, '2024-10-27 11:00:00'),
(57, 40, 18, 27, FALSE, '2024-11-03 12:00:00'),

-- sjaelland_auto (seller 19) - 5 biler på adresse 12
(58, 41, 19, 12, FALSE, '2024-10-28 10:00:00'),
(59, 42, 19, 12, FALSE, '2024-10-29 11:00:00'),
(60, 43, 19, 12, FALSE, '2024-10-30 09:00:00'),
(61, 44, 19, 12, FALSE, '2024-11-04 10:30:00'),
(62, 85, 19, 12, FALSE, '2024-11-08 11:00:00'),

-- privat_martin (seller 20) - 2 biler på adresse 22
(63, 45, 20, 22, FALSE, '2024-10-29 12:00:00'),
(64, 46, 20, 22, FALSE, '2024-11-05 13:00:00'),

-- elbil_center (seller 21) - 5 biler på adresse 6
(65, 47, 21, 6, FALSE, '2024-10-30 09:00:00'),
(66, 48, 21, 6, FALSE, '2024-10-31 10:00:00'),
(67, 49, 21, 6, FALSE, '2024-11-01 11:00:00'),
(68, 50, 21, 6, FALSE, '2024-11-06 12:00:00'),
(69, 86, 21, 6, FALSE, '2024-11-09 09:00:00'),

-- privat_line (seller 22) - 2 biler på adresse 24
(70, 51, 22, 24, FALSE, '2024-10-31 11:00:00'),
(71, 52, 22, 24, FALSE, '2024-11-07 12:00:00'),

-- syd_autosalg (seller 23) - 5 biler på adresse 10
(72, 53, 23, 10, FALSE, '2024-11-01 10:00:00'),
(73, 54, 23, 10, FALSE, '2024-11-02 11:00:00'),
(74, 55, 23, 10, TRUE,  '2024-10-05 09:00:00'),
(75, 56, 23, 10, FALSE, '2024-11-08 10:30:00'),
(76, 87, 23, 10, FALSE, '2024-11-10 11:00:00'),

-- privat_katrine (seller 24) - 2 biler på adresse 16
(77, 57, 24, 16, FALSE, '2024-11-02 12:00:00'),
(78, 58, 24, 16, FALSE, '2024-11-09 13:00:00'),

-- bilpalads (seller 25) - 6 biler på adresse 4
(79, 59, 25, 4, FALSE, '2024-11-03 09:00:00'),
(80, 60, 25, 4, FALSE, '2024-11-04 10:00:00'),
(81, 61, 25, 4, FALSE, '2024-11-05 11:00:00'),
(82, 62, 25, 4, FALSE, '2024-11-10 12:00:00'),
(83, 63, 25, 4, FALSE, '2024-11-11 09:00:00'),
(84, 88, 25, 4, FALSE, '2024-11-14 10:00:00'),

-- privat_brian (seller 26) - 2 biler på adresse 23
(85, 64, 26, 23, FALSE, '2024-11-04 11:00:00'),
(86, 65, 26, 23, FALSE, '2024-11-11 12:00:00'),

-- midtjylland_biler (seller 27) - 5 biler på adresse 7
(87, 66, 27, 7, FALSE, '2024-11-05 10:00:00'),
(88, 67, 27, 7, FALSE, '2024-11-06 11:00:00'),
(89, 68, 27, 7, FALSE, '2024-11-07 09:00:00'),
(90, 69, 27, 7, FALSE, '2024-11-12 10:30:00'),
(91, 89, 27, 7, FALSE, '2024-11-13 11:00:00'),

-- privat_helle (seller 28) - 2 biler på adresse 18
(92, 70, 28, 18, FALSE, '2024-11-06 12:00:00'),
(93, 71, 28, 18, FALSE, '2024-11-13 13:00:00'),

-- familieauto (seller 29) - 5 biler på adresse 13
(94, 72, 29, 13, FALSE, '2024-11-07 09:00:00'),
(95, 73, 29, 13, FALSE, '2024-11-08 10:00:00'),
(96, 74, 29, 13, FALSE, '2024-11-09 11:00:00'),
(97, 75, 29, 13, FALSE, '2024-11-14 12:00:00'),
(98, 90, 29, 13, FALSE, '2024-11-15 09:00:00'),
(99, 100,29, 13, FALSE, '2024-11-16 10:00:00'),

-- privat_ole (seller 30) - 2 biler på adresse 25
(100,76, 30, 25, FALSE, '2024-11-08 11:00:00'),
(101,77, 30, 25, FALSE, '2024-11-15 12:00:00');

-- ============================================
-- FAVORITES (diverse buyers har gemt biler)
-- ============================================

INSERT INTO favorite (user_id, car_listing_id) VALUES
(31, 3),  (31, 42), (31, 70),
(32, 9),  (32, 63), (32, 22),
(33, 15), (33, 16), (33, 78),
(34, 17), (34, 18), (34, 53),
(35, 32), (35, 33), (35, 92),
(36, 42), (36, 43), (36, 66),
(37, 65), (37, 67), (37, 68),
(38, 1),  (38, 10), (38, 28),
(39, 34), (39, 35), (39, 36),
(40, 50), (40, 51), (40, 52),
(41, 58), (41, 59), (41, 60),
(42, 72), (42, 73),
(43, 93), (43, 38),
(44, 24), (44, 40),
(45, 79), (45, 80),
(46, 94), (46, 95), (46, 97),
(47, 5),  (47, 14),
(48, 55), (48, 54),
(49, 61), (49, 78),
(50, 3),  (50, 47),
(51, 43), (51, 44),
(52, 9),  (52, 36),
(53, 21), (53, 46),
(54, 26), (54, 27),
(55, 81), (55, 82),
(56, 20), (56, 99),
(57, 11), (57, 73),
(58, 48), (58, 49),
(59, 56), (59, 57),
(60, 74), (60, 75),
(61, 83), (61, 87),
(62, 88), (62, 89),
(63, 54), (63, 62),
(64, 86), (64, 76),
(65, 84), (65, 91),
(66, 98), (66, 6),
(67, 1),  (67, 2),
(68, 30), (68, 39),
(69, 100),(69, 101),
(70, 64), (70, 85);

-- ============================================
-- MESSAGES (100 beskeder mellem buyers og sellers)
-- ============================================

INSERT INTO message (sender_id, receiver_id, car_listing_id, content, sent_at, is_read) VALUES
-- Buyer 31 spørger om Tesla Model 3 (listing 3)
(31, 6,  3,  'Hej! Er Tesla Model 3 stadig tilgængelig? Hvad er batteriets sundhedstilstand?', '2024-11-01 10:00:00', TRUE),
(6,  31, 3,  'Hej Anna! Ja, den er stadig til salg. Batteriet er i super stand - 96% kapacitet. Vil du komme forbi og prøvekøre?', '2024-11-01 11:30:00', TRUE),
(31, 6,  3,  'Det lyder godt! Kan jeg komme lørdag formiddag?', '2024-11-01 14:00:00', TRUE),
(6,  31, 3,  'Perfekt! Kom bare forbi kl. 10. Adressen er Østerbrogade 142.', '2024-11-01 14:30:00', TRUE),

-- Buyer 32 spørger om Toyota Corolla Hybrid (listing 9)
(32, 7,  9,  'Hej, jeg er interesseret i jeres Toyota Corolla Hybrid. Er prisen til forhandling?', '2024-11-02 09:15:00', TRUE),
(7,  32, 9,  'Hej Peter! Vi kan godt tale om prisen. Kom forbi og se den, så finder vi ud af det.', '2024-11-02 10:00:00', TRUE),

-- Buyer 36 spørger om Tesla Model Y (listing 43)
(36, 15, 43, 'Hej! Jeg overvejer Model Y til familien. Hvordan er pladsen i bagagerummet med 7 sæder oppe?', '2024-11-03 15:00:00', TRUE),
(15, 36, 43, 'Hej Kasper! Med 3. sæderække oppe er der stadig 350L bagagerum. Klapper man dem ned har du over 2000L. Rigtig god familiebil!', '2024-11-03 16:20:00', TRUE),
(36, 15, 43, 'Fedt! Hvad med vinterdæk - er de inkluderet?', '2024-11-03 17:00:00', FALSE),

-- Buyer 37 spørger om VW ID.4 (listing 65)
(37, 21, 65, 'Hej, hvilken ladehastighed kan ID.4 klare?', '2024-11-04 08:30:00', TRUE),
(21, 37, 65, 'Hej Emma! Den kan lade op til 135 kW DC. Fra 10-80% tager ca. 36 minutter.', '2024-11-04 09:00:00', TRUE),

-- Buyer 40 spørger om Audi e-tron (listing 50)
(40, 17, 50, 'Er det muligt at se bilen i weekenden?', '2024-11-05 12:00:00', TRUE),
(17, 40, 50, 'Hej Noah! Selvfølgelig. Vi har åbent lørdag 10-15. Du er velkommen!', '2024-11-05 13:00:00', TRUE),

-- Buyer 46 spørger om Toyota RAV4 PHEV (listing 94)
(46, 29, 94, 'Hej! Hvad er den reelle elforbrug på RAV4 PHEV i hverdagen?', '2024-11-06 11:00:00', TRUE),
(29, 46, 94, 'Hej Oscar! Med daglig opladning kører de fleste 60-70 km på ren el. Til daglig pendling er det fantastisk!', '2024-11-06 12:30:00', TRUE),
(46, 29, 94, 'Det er præcis min pendlerafstand. Kan I reservere den til næste uge?', '2024-11-06 13:00:00', FALSE),

-- Buyer 50 spørger om Tesla Model Y Performance (listing 47)
(50, 15, 47, 'Hej! Er Model Y Performance stadig tilgængelig? Hvad med Track Mode - virker det i DK?', '2024-11-07 09:00:00', TRUE),
(15, 50, 47, 'Ja, den er her! Track Mode virker fint - du kan bruge det på lukkede baner. Virkelig sjovt!', '2024-11-07 10:15:00', FALSE),

-- Buyer 34 prutte om Audi A4 (listing 17)
(34, 9,  17, 'Hej, jeg ser Audi A4 til 199.900. Ville I overveje 175.000?', '2024-11-08 14:00:00', TRUE),
(9,  34, 17, 'Hej Mark. 175.000 er lidt lavt ift. stand og udstyr. Vi kan mødes ved 189.900 - hvad siger du?', '2024-11-08 15:30:00', TRUE),
(34, 9,  17, 'Lad os sige 185.000 og vi har en deal?', '2024-11-08 16:00:00', FALSE),

-- Buyer 55 spørger om BMW iX3 (listing 81)
(55, 25, 81, 'Hej! Er der nogen ridser eller skader på BMW iX3?', '2024-11-09 10:00:00', TRUE),
(25, 55, 81, 'Hej Astrid! Bilen er i meget pæn stand. Der er en mindre parkeringsrids på højre bagskærm, men ellers perfekt. Jeg kan sende flere billeder.', '2024-11-09 11:00:00', TRUE),

-- Buyer 41 spørger om Volvo XC40 Recharge (listing 58)
(41, 19, 58, 'Hej, hvad er den reelle rækkevidde om vinteren på XC40 Recharge?', '2024-11-10 08:00:00', TRUE),
(19, 41, 58, 'Hej Ella! Realistisk set 280-320 km om vinteren. Om sommeren 380-420 km. Den har varmepumpe som hjælper meget.', '2024-11-10 09:30:00', FALSE),

-- Buyer 67 spørger om VW Golf (listing 1)
(67, 6,  1,  'Er servicebogen komplet på Golf?', '2024-11-11 13:00:00', TRUE),
(6,  67, 1,  'Hej Frida! Ja, alle services er udført hos autoriseret VW-værksted. Jeg kan sende kopi af servicebogen.', '2024-11-11 14:00:00', FALSE),

-- Buyer 38 spørger om Hyundai Tucson (listing 10)
(38, 7,  10, 'Hej! Kan man få prøvekørt Hyundai Tucson Hybrid i dag?', '2024-11-12 09:00:00', TRUE),
(7,  38, 10, 'Hej Oliver! Ja, kom endelig forbi. Vi er her til kl. 17.', '2024-11-12 09:30:00', TRUE),

-- Buyer 42 spørger om Volvo V60 (listing 72)
(42, 23, 72, 'Hej, er Volvo V60 stadig til salg?', '2024-11-13 10:00:00', TRUE),
(23, 42, 72, 'Hej Victor! Ja, den er stadig her. Fantastisk bil til familien!', '2024-11-13 10:45:00', TRUE),

-- Buyer 45 spørger om Audi Q5 (listing 79)
(45, 25, 79, 'Hvad er årsagen til salg af Q5?', '2024-11-14 11:00:00', TRUE),
(25, 45, 79, 'Hej Clara! Ejeren er gået over til en Model Y. Bilen er i perfekt stand.', '2024-11-14 11:30:00', TRUE),

-- Buyer 48 spørger om BMW i4 (listing 51)
(48, 17, 51, 'Hej! Er BMW i4 M50 stadig tilgængelig?', '2024-11-15 12:00:00', TRUE),
(17, 48, 51, 'Hej William! Ja, den er her. Vil du booke en prøvetur?', '2024-11-15 12:30:00', FALSE),

-- Buyer 52 spørger om Toyota RAV4 (listing 36)
(52, 13, 36, 'Hej, hvilken afgift ligger bilen i?', '2024-11-16 09:00:00', TRUE),
(13, 52, 36, 'Hej August! Den ligger i grøn afgift. Billig at forsikre og ejerafgift.', '2024-11-16 09:45:00', TRUE),

-- Buyer 54 spørger om Peugeot 308 (listing 26)
(54, 11, 26, 'Er der rustgaranti på Peugeot 308?', '2024-11-17 10:00:00', TRUE),
(11, 54, 26, 'Hej Magnus! Ja, der er 12 års rustgaranti fra fabrik.', '2024-11-17 10:30:00', TRUE),

-- Buyer 56 spørger om Kia Sportage PHEV (listing 99)
(56, 29, 99, 'Hej! Kan I hjælpe med finansiering?', '2024-11-18 11:00:00', TRUE),
(29, 56, 99, 'Hej Valdemar! Ja, vi samarbejder med flere banker. Kom forbi så finder vi den bedste løsning.', '2024-11-18 11:45:00', TRUE),

-- Buyer 58 spørger om VW Passat (listing 48)
(58, 16, 48, 'Hej Karsten, er der kvittering for ny kilerem?', '2024-11-19 12:00:00', TRUE),
(16, 58, 48, 'Hej Malthe! Ja, jeg har alle bilag. Skiftet for 6 måneder siden.', '2024-11-19 12:30:00', FALSE),

-- Buyer 60 spørger om Audi A3 (listing 75)
(60, 23, 75, 'Hvad er det årlige forbrug på A3?', '2024-11-20 09:00:00', TRUE),
(23, 60, 75, 'Hej Theodor! Realistisk omkring 15-16 km/l ved blandet kørsel.', '2024-11-20 09:45:00', TRUE),

-- Buyer 62 spørger om Ford Kuga PHEV (listing 87)
(62, 27, 87, 'Hej, har den anhængertræk?', '2024-11-21 10:00:00', TRUE),
(27, 62, 87, 'Hej Aksel! Nej, men det kan monteres. Vi kan hjælpe med det.', '2024-11-21 10:30:00', TRUE),

-- Buyer 64 spørger om Hyundai i30 (listing 85)
(64, 26, 85, 'Er der nogen mangler ved bilen?', '2024-11-22 11:00:00', TRUE),
(26, 64, 85, 'Hej Storm! Nej, den er i super stand. Lige synet.', '2024-11-22 11:30:00', TRUE),

-- Buyer 66 spørger om Ford Puma (listing 6)
(66, 6,  6,  'Hej! Hvad koster den årlige forsikring ca.?', '2024-11-23 12:00:00', TRUE),
(6,  66, 6,  'Hej Konrad! Det kommer an på din profil, men typisk 5-7.000 kr/år.', '2024-11-23 12:30:00', FALSE),

-- Buyer 68 spørger om Volvo EX30 (listing 13)
(68, 7,  13, 'Hvor lang er leveringstiden hvis jeg bestiller?', '2024-11-24 09:00:00', TRUE),
(7,  68, 13, 'Hej Vilhelm! Dette er en demobil, så den er klar til levering nu!', '2024-11-24 09:30:00', TRUE),

-- Buyer 70 spørger om Suzuki Swift (listing 40)
(70, 14, 40, 'Hej Lise, er Swift god til langture?', '2024-11-25 10:00:00', TRUE),
(14, 70, 40, 'Hej Elias! Ja, den er overraskende komfortabel. Jeg har selv kørt til Tyskland i den.', '2024-11-25 10:45:00', TRUE),

-- Buyer 72 spørger om BMW X3 (listing 35)
(72, 13, 35, 'Hvad er den reelle brændstoføkonomi?', '2024-11-26 11:00:00', TRUE),
(13, 72, 35, 'Hej Erik! Omkring 14-15 km/l på landevej, 11-12 i byen.', '2024-11-26 11:30:00', TRUE),

-- Buyer 74 spørger om Mazda CX-5 (listing 37)
(74, 13, 37, 'Hej, er der nogen skjulte fejl?', '2024-11-27 12:00:00', TRUE),
(13, 74, 37, 'Hej Sigurd! Nej, bilen er gennemgået og i perfekt stand. Kom og se den.', '2024-11-27 12:30:00', FALSE),

-- Buyer 76 spørger om Opel Corsa (listing 29)
(76, 11, 29, 'Er der Apple CarPlay?', '2024-11-28 09:00:00', TRUE),
(11, 76, 29, 'Hej Alfred! Ja, både Apple CarPlay og Android Auto.', '2024-11-28 09:30:00', TRUE),

-- Buyer 78 spørger om Ford Focus (listing 15)
(78, 8,  15, 'Hej Erik, hvornår kan jeg se bilen?', '2024-11-29 10:00:00', TRUE),
(8,  78, 15, 'Hej Felix! Jeg er hjemme i weekenden. Ring bare på 30345678.', '2024-11-29 10:30:00', TRUE),

-- Buyer 80 spørger om Peugeot 508 (listing 74)
(80, 23, 74, 'Er Night Vision effektivt om natten?', '2024-11-30 11:00:00', TRUE),
(23, 80, 74, 'Hej Sebastian! Ja, det er fantastisk. Giver stor sikkerhed i mørke.', '2024-11-30 11:30:00', TRUE),

-- Buyer 82 spørger om BMW 1-serie (listing 88)
(82, 27, 88, 'Hvad er årsagen til salg?', '2024-12-01 12:00:00', TRUE),
(27, 82, 88, 'Hej Tobias! Ejeren skal have større bil til familien.', '2024-12-01 12:30:00', TRUE),

-- Buyer 84 spørger om Skoda Fabia (listing 86)
(84, 26, 86, 'Er der nogen kendte problemer med modellen?', '2024-12-02 09:00:00', TRUE),
(26, 84, 86, 'Hej Mikkel! Nej, Fabia er kendt for at være meget pålidelig.', '2024-12-02 09:30:00', FALSE),

-- Buyer 86 spørger om Citroën C4 (listing 69)
(86, 21, 69, 'Hvad er rækkevidde på C4?', '2024-12-03 10:00:00', TRUE),
(21, 86, 69, 'Hej Daniel! Omkring 350 km WLTP, reelt 280-320 km.', '2024-12-03 10:30:00', TRUE),

-- Buyer 88 spørger om Fiat Tipo (listing 84)
(88, 25, 84, 'Er bagagerummet stort nok til barnevogn?', '2024-12-04 11:00:00', TRUE),
(25, 88, 84, 'Hej Alexander! Ja, der er massiv plads. 550L bagagerum.', '2024-12-04 11:30:00', TRUE),

-- Buyer 90 spørger om Nissan Juke (listing 98)
(90, 29, 98, 'Hej! Kan jeg komme og se den i morgen?', '2024-12-05 12:00:00', TRUE),
(29, 90, 98, 'Hej Christian! Ja, kom bare forbi kl. 10-16.', '2024-12-05 12:30:00', TRUE),

-- Buyer 91 spørger om Mercedes C-Klasse (listing 18)
(91, 9,  18, 'Hvor mange tidligere ejere?', '2024-12-06 09:00:00', TRUE),
(9,  91, 18, 'Hej Petra! Kun én ejer fra ny. Servicehistorik komplet.', '2024-12-06 09:30:00', TRUE),

-- Buyer 93 spørger om Renault Clio (listing 16)
(93, 8,  16, 'Er den god til nye bilister?', '2024-12-07 10:00:00', TRUE),
(8,  93, 16, 'Hej Sara! Ja, perfekt! Let at køre og økonomisk.', '2024-12-07 10:30:00', TRUE),

-- Buyer 95 spørger om Volvo XC60 PHEV (listing 97)
(95, 29, 97, 'Hvad er el-rækkevidden?', '2024-12-08 11:00:00', TRUE),
(29, 95, 97, 'Hej Thea! Omkring 45-50 km på ren el. Perfekt til daglig pendling.', '2024-12-08 11:30:00', FALSE),

-- Buyer 97 spørger om Seat Ibiza (listing 100)
(97, 30, 100,'Hej Ole, er prisen fast?', '2024-12-09 12:00:00', TRUE),
(30, 97, 100,'Hej Lea! Vi kan godt snakke om det. Kom og se den først.', '2024-12-09 12:30:00', TRUE),

-- Buyer 99 spørger om Mercedes EQA (listing 82)
(99, 25, 82, 'Hvilken ladehastighed kan den klare?', '2024-12-10 09:00:00', TRUE),
(25, 99, 82, 'Hej Olivia! Op til 100 kW DC. Fra 10-80% på ca. 32 minutter.', '2024-12-10 09:30:00', TRUE),

-- Ekstra beskeder for at nå 100
(35, 9,  19, 'Hej! Har Kia Ceed fuld garanti?', '2024-12-11 10:00:00', TRUE),
(9,  35, 19, 'Hej Ida! Ja, der er stadig 5 års garanti tilbage!', '2024-12-11 10:30:00', TRUE),
(44, 11, 28, 'Er der automatgear på Nissan Qashqai?', '2024-12-12 11:00:00', TRUE),
(11, 44, 28, 'Hej Lucas! Ja, e-POWER er altid automatgear.', '2024-12-12 11:30:00', TRUE),
(49, 17, 52, 'Hvad er 0-100 km/t på Volvo XC90?', '2024-12-13 12:00:00', TRUE),
(17, 49, 52, 'Hej Alberte! 5.5 sekunder med T8 motoren. Meget kraftfuld!', '2024-12-13 12:30:00', TRUE),
(57, 19, 59, 'Kan Hyundai Kona lade på AC?', '2024-12-14 09:00:00', TRUE),
(19, 57, 59, 'Hej Agnes! Ja, op til 11 kW AC. Perfekt til hjemmeladning.', '2024-12-14 09:30:00', FALSE),
(63, 23, 73, 'Hej! Er Skoda Superb god til langture?', '2024-12-15 10:00:00', TRUE),
(23, 63, 73, 'Hej Filippa! Fantastisk! Super komfortabel og romslig.', '2024-12-15 10:30:00', TRUE),
(69, 27, 89, 'Hvad koster årlig service på Seat Arona?', '2024-12-16 11:00:00', TRUE),
(27, 69, 89, 'Hej Alma! Omkring 2.500-3.000 kr afhængig af værksted.', '2024-12-16 11:30:00', TRUE),
(75, 29, 96, 'Er VW Tiguan god i sne?', '2024-12-17 12:00:00', TRUE),
(29, 75, 96, 'Hej Ellen! Ja, 4MOTION er fantastisk i dårligt vejr.', '2024-12-17 12:30:00', TRUE),
(81, 25, 80, 'Har Toyota C-HR head-up display?', '2024-12-18 09:00:00', TRUE),
(25, 81, 80, 'Hej Marie! Ja, det følger med GR Sport pakken.', '2024-12-18 09:30:00', TRUE),
(87, 21, 66, 'Hvad er levetiden på batteriet i Hyundai Ioniq 5?', '2024-12-19 10:00:00', TRUE),
(21, 87, 66, 'Hej Josefine! 8 års / 160.000 km garanti på batteriet.', '2024-12-19 10:30:00', TRUE),
(94, 27, 90, 'Er Skoda Kamiq praktisk til børnefamilie?', '2024-12-20 11:00:00', TRUE),
(27, 94, 90, 'Hej Jakob! Ja, god plads og høj sikkerhed. Perfekt familiebil.', '2024-12-20 11:30:00', FALSE);
