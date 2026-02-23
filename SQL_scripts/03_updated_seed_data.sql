SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE message;
TRUNCATE TABLE favorite;
TRUNCATE TABLE car_listing;
TRUNCATE TABLE car;
TRUNCATE TABLE app_user;
TRUNCATE TABLE address;
TRUNCATE TABLE model;
TRUNCATE TABLE brand;
TRUNCATE TABLE fuel_type;
TRUNCATE TABLE region;
TRUNCATE TABLE role;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------
-- ROLE (3)
-- ---------------------------------
INSERT INTO role (id, name) VALUES
(1,'ADMIN'),
(2,'DEALER'),
(3,'CUSTOMER');

-- ---------------------------------
-- REGION (5)
-- ---------------------------------
INSERT INTO region (id, name) VALUES
(1,'Hovedstaden'),
(2,'Sjælland'),
(3,'Syddanmark'),
(4,'Midtjylland'),
(5,'Nordjylland');

-- ---------------------------------
-- FUEL TYPE (4)
-- ---------------------------------
INSERT INTO fuel_type (id, name) VALUES
(1,'Benzin'),
(2,'Diesel'),
(3,'Hybrid'),
(4,'El');

-- ---------------------------------
-- BRAND (8)
-- ---------------------------------
INSERT INTO brand (id, name) VALUES
(1,'BMW'),
(2,'Audi'),
(3,'Volkswagen'),
(4,'Mercedes-Benz'),
(5,'Toyota'),
(6,'Tesla'),
(7,'Volvo'),
(8,'Ford');

-- ---------------------------------
-- MODEL (16)
-- ---------------------------------
INSERT INTO model (id, name, brand_id) VALUES
(1,'3 Series',1),(2,'5 Series',1),
(3,'A3',2),(4,'A4',2),
(5,'Golf',3),(6,'Passat',3),
(7,'C-Class',4),(8,'E-Class',4),
(9,'Corolla',5),(10,'Yaris',5),
(11,'Model 3',6),(12,'Model Y',6),
(13,'XC60',7),(14,'V60',7),
(15,'Focus',8),(16,'Kuga',8);

-- ---------------------------------
-- ADDRESS (20)  (realistiske DK-adresser/byer)
-- ---------------------------------
INSERT INTO address (id, street, postal_code, city, region_id) VALUES
(1,'Nørrebrogade 58','2200','København N',1),
(2,'Østerbrogade 120','2100','København Ø',1),
(3,'Vesterbrogade 25','1620','København V',1),
(4,'Gammel Kongevej 74','1850','Frederiksberg C',1),
(5,'Slotsgade 10','3400','Hillerød',1),
(6,'Algade 33','4000','Roskilde',2),
(7,'Søndergade 12','4600','Køge',2),
(8,'Jernbanegade 6','4700','Næstved',2),
(9,'Havnegade 2','4800','Nykøbing F',2),
(10,'Bredgade 18','4180','Sorø',2),
(11,'Vestergade 41','5000','Odense C',3),
(12,'Nørregade 7','6000','Kolding',3),
(13,'Sct. Mathias Gade 9','8800','Viborg',4),
(14,'Banegårdspladsen 1','8000','Aarhus C',4),
(15,'Søndergade 22','7400','Herning',4),
(16,'Bispensgade 15','9000','Aalborg',5),
(17,'Sct. Laurentii Vej 3','9990','Skagen',5),
(18,'Havnevej 8','6700','Esbjerg',3),
(19,'Boulevarden 30','7100','Vejle',3),
(20,'Strandvejen 5','6000','Kolding',3);

-- ---------------------------------
-- APP_USER (25) = 1 admin + 4 dealers + 20 customers
-- ---------------------------------
INSERT INTO app_user (id, username, email, password_hash, first_name, last_name, phone, role_id, created_at) VALUES
(1,'admin','admin@bilbase.dk','hash_admin','Admin','System','11111111',1,NOW()),

(2,'nordicmotors','kontakt@nordicmotors.dk','hash_dealer1','Mads','Hansen','22113344',2,NOW()),
(3,'citycars','info@citycars.dk','hash_dealer2','Sara','Jensen','22334455',2,NOW()),
(4,'autohuset','salg@autohuset.dk','hash_dealer3','Jonas','Madsen','22445566',2,NOW()),
(5,'fjordbiler','hej@fjordbiler.dk','hash_dealer4','Line','Holm','22556677',2,NOW()),

(6,'amalie','amalie@mail.dk','hash_c1','Amalie','Nørgaard','40112233',3,NOW()),
(7,'oliver','oliver@mail.dk','hash_c2','Oliver','Kristensen','40223344',3,NOW()),
(8,'freja','freja@mail.dk','hash_c3','Freja','Larsen','40334455',3,NOW()),
(9,'noah','noah@mail.dk','hash_c4','Noah','Pedersen','40445566',3,NOW()),
(10,'emma','emma@mail.dk','hash_c5','Emma','Nielsen','40556677',3,NOW()),
(11,'victor','victor@mail.dk','hash_c6','Victor','Andersen','40667788',3,NOW()),
(12,'laura','laura@mail.dk','hash_c7','Laura','Møller','40778899',3,NOW()),
(13,'isabella','isabella@mail.dk','hash_c8','Isabella','Poulsen','40889900',3,NOW()),
(14,'william','william@mail.dk','hash_c9','William','Johansen','40990011',3,NOW()),
(15,'sofie','sofie@mail.dk','hash_c10','Sofie','Olsen','41112233',3,NOW()),
(16,'lucas','lucas@mail.dk','hash_c11','Lucas','Lund','41223344',3,NOW()),
(17,'mille','mille@mail.dk','hash_c12','Mille','Thomsen','41334455',3,NOW()),
(18,'oscar','oscar@mail.dk','hash_c13','Oscar','Schmidt','41445566',3,NOW()),
(19,'agnes','agnes@mail.dk','hash_c14','Agnes','Christensen','41556677',3,NOW()),
(20,'malthe','malthe@mail.dk','hash_c15','Malthe','Rasmussen','41667788',3,NOW()),
(21,'sara2','sara2@mail.dk','hash_c16','Sara','Berg','41778899',3,NOW()),
(22,'rasmus','rasmus@mail.dk','hash_c17','Rasmus','Svendsen','41889900',3,NOW()),
(23,'ida','ida@mail.dk','hash_c18','Ida','Jørgensen','41990011',3,NOW()),
(24,'mathias','mathias@mail.dk','hash_c19','Mathias','Lauridsen','42112233',3,NOW()),
(25,'nanna','nanna@mail.dk','hash_c20','Nanna','Haugaard','42223344',3,NOW());

-- ---------------------------------
-- CAR (50)  (realistiske priser/år/km/farver)
-- model_id: 1..16, fuel_type_id: 1..4
-- ---------------------------------
INSERT INTO car (id, model_id, fuel_type_id, price, year, mileage_km, color) VALUES
(1,1,1,189900,2017,85000,'Sort'),
(2,3,2,159900,2016,110000,'Grå'),
(3,5,1,129900,2015,140000,'Hvid'),
(4,7,2,219900,2018,90000,'Blå'),
(5,9,1,119900,2014,160000,'Rød'),
(6,11,4,269900,2019,60000,'Hvid'),
(7,12,4,319900,2021,25000,'Sort'),
(8,13,3,279900,2020,45000,'Sølv'),
(9,4,2,199900,2017,95000,'Sort'),
(10,6,2,149900,2016,125000,'Blå'),

(11,2,1,239900,2018,78000,'Grå'),
(12,8,2,289900,2019,65000,'Sort'),
(13,10,1,99900,2013,175000,'Hvid'),
(14,14,3,259900,2020,52000,'Blå'),
(15,15,1,89900,2012,190000,'Sølv'),
(16,16,3,199900,2019,70000,'Grå'),
(17,1,2,179900,2016,120000,'Sort'),
(18,3,1,169900,2017,98000,'Rød'),
(19,5,2,139900,2015,155000,'Grå'),
(20,7,2,229900,2018,88000,'Hvid'),

(21,9,1,109900,2014,170000,'Blå'),
(22,11,4,249900,2019,72000,'Sort'),
(23,12,4,339900,2022,18000,'Hvid'),
(24,13,3,289900,2021,40000,'Sort'),
(25,4,2,189900,2017,105000,'Sølv'),
(26,6,2,159900,2016,130000,'Sort'),
(27,2,1,259900,2019,69000,'Blå'),
(28,8,2,319900,2020,59000,'Grå'),
(29,10,1,109900,2014,165000,'Rød'),
(30,14,3,269900,2021,47000,'Hvid'),

(31,15,1,94900,2013,180000,'Sort'),
(32,16,3,209900,2020,65000,'Blå'),
(33,1,1,199900,2018,82000,'Hvid'),
(34,3,2,149900,2015,145000,'Grå'),
(35,5,1,119900,2014,175000,'Sølv'),
(36,7,2,214900,2017,110000,'Sort'),
(37,9,1,124900,2015,150000,'Hvid'),
(38,11,4,279900,2020,52000,'Blå'),
(39,12,4,359900,2023,9000,'Sort'),
(40,13,3,299900,2022,32000,'Sølv'),

(41,4,2,209900,2018,87000,'Hvid'),
(42,6,2,169900,2017,115000,'Blå'),
(43,2,1,279900,2020,54000,'Sort'),
(44,8,2,339900,2021,43000,'Sort'),
(45,10,1,114900,2015,155000,'Grå'),
(46,14,3,279900,2022,28000,'Hvid'),
(47,15,1,99900,2014,160000,'Rød'),
(48,16,3,219900,2021,52000,'Sølv'),
(49,1,2,169900,2015,135000,'Sort'),
(50,3,1,179900,2018,76000,'Hvid');

-- ---------------------------------
-- CAR_LISTING (50)
-- seller_id: dealers 2..5, address_id: 1..20
-- is_sold: nogle solgte
-- ---------------------------------
INSERT INTO car_listing (id, car_id, seller_id, address_id, is_sold, description, created_at) VALUES
(1,1,2,1,0,'BMW 3 Series i flot stand. Servicebog, to nøgler og pæn kabine.',NOW()),
(2,2,3,2,0,'Audi A3 diesel – økonomisk pendlerbil. Nysynet og klar til levering.',NOW()),
(3,3,4,6,0,'VW Golf benzin. God historik, fin undervogn og kører virkelig godt.',NOW()),
(4,4,5,14,0,'Mercedes C-Class diesel. Komfortpakke, klimaanlæg og pæn kilometertal.',NOW()),
(5,5,2,7,0,'Toyota Corolla. Driftssikker, billig i drift og god til hverdagskørsel.',NOW()),
(6,6,3,11,0,'Tesla Model 3. Hurtig levering, varmepumpe og flot rækkevidde.',NOW()),
(7,7,4,16,0,'Tesla Model Y. Rummelig familiebil, god plads og meget udstyr.',NOW()),
(8,8,5,13,0,'Volvo XC60 hybrid. Sikkerhed i top og komfort på lange ture.',NOW()),
(9,9,2,8,1,'Audi A4 diesel. Solgt – var populær pga. udstyr og velholdt stand.',NOW()),
(10,10,3,18,0,'VW Passat diesel. Perfekt til motorvej og lange strækninger.',NOW()),

(11,11,4,3,0,'BMW 5 Series benzin. Velkørende med god kabinekomfort.',NOW()),
(12,12,5,4,0,'Mercedes E-Class diesel. Udstyrspakke, adaptiv fartpilot.',NOW()),
(13,13,2,10,0,'Toyota Yaris benzin. Let at parkere, billig i drift, ideel bybil.',NOW()),
(14,14,3,19,0,'Volvo V60 hybrid. Stationcar med god plads og lavt forbrug.',NOW()),
(15,15,4,9,0,'Ford Focus benzin. Stabil og økonomisk. God som første bil.',NOW()),
(16,16,5,12,0,'Ford Kuga hybrid. Høj indstigning, rummelig og komfortabel.',NOW()),
(17,17,2,5,0,'BMW 3 Series diesel. Flot stand og godt træk. Klar til prøvetur.',NOW()),
(18,18,3,2,0,'Audi A3 benzin. Pæn stand, god lyd og sporty kørsel.',NOW()),
(19,19,4,6,0,'VW Golf diesel. God pendlerbil, lavt forbrug og fin komfort.',NOW()),
(20,20,5,14,1,'Mercedes C-Class. Solgt – stærk efterspørgsel og flot udstyrsniveau.',NOW()),

(21,21,2,7,0,'Toyota Corolla. Pålidelig, rummelig og nem at holde kørende.',NOW()),
(22,22,3,11,0,'Tesla Model 3. Elbil med god rækkevidde og lækker køreoplevelse.',NOW()),
(23,23,4,16,0,'Tesla Model Y. Næsten ny, lav km og meget ekstraudstyr.',NOW()),
(24,24,5,13,0,'Volvo XC60 hybrid. God til familien og sikkerhedspakke.',NOW()),
(25,25,2,8,0,'Audi A4 diesel. Fin stand og god til lange ture.',NOW()),
(26,26,3,18,0,'VW Passat diesel. Plads til hele familien og stabil på motorvej.',NOW()),
(27,27,4,3,0,'BMW 5 Series. Komfort og kraft – kører rigtig godt.',NOW()),
(28,28,5,4,0,'Mercedes E-Class. Lækker kabine og premium-feel.',NOW()),
(29,29,2,10,0,'Toyota Yaris. Økonomisk, nem og billig i service.',NOW()),
(30,30,3,19,1,'Volvo V60 hybrid. Solgt – god plads og attraktivt forbrug.',NOW()),

(31,31,4,9,0,'Ford Focus. Billig og velkørende, pæn indvendig.',NOW()),
(32,32,5,12,0,'Ford Kuga hybrid. God udsigt, god plads, og kører behageligt.',NOW()),
(33,33,2,1,0,'BMW 3 Series. Flot stand, velholdt og fin historik.',NOW()),
(34,34,3,2,0,'Audi A3 diesel. God pendlerbil, fin km og god komfort.',NOW()),
(35,35,4,6,0,'VW Golf benzin. Perfekt bybil, nem at køre og parkere.',NOW()),
(36,36,5,14,0,'Mercedes C-Class. Komfortabel og pæn stand.',NOW()),
(37,37,2,7,0,'Toyota Corolla. Driftssikker, rummelig og økonomisk.',NOW()),
(38,38,3,11,0,'Tesla Model 3. God rækkevidde, hurtig opladning.',NOW()),
(39,39,4,16,0,'Tesla Model Y. Meget lav km og i super stand.',NOW()),
(40,40,5,13,1,'Volvo XC60 hybrid. Solgt – høj efterspørgsel og flot udstyr.',NOW()),

(41,41,2,8,0,'Audi A4 diesel. God kørekomfort, fin stand.',NOW()),
(42,42,3,18,0,'VW Passat diesel. Ideel til lange ture og familiebrug.',NOW()),
(43,43,4,3,0,'BMW 5 Series. Velholdt og lækker at køre.',NOW()),
(44,44,5,4,0,'Mercedes E-Class. Flot kabine og masser af udstyr.',NOW()),
(45,45,2,10,0,'Toyota Yaris. Billig i drift og perfekt til hverdagen.',NOW()),
(46,46,3,19,0,'Volvo V60 hybrid. Flot stand og god plads.',NOW()),
(47,47,4,9,0,'Ford Focus. Stabil, billig og nem at køre.',NOW()),
(48,48,5,12,0,'Ford Kuga hybrid. Rummelig og komfortabel.',NOW()),
(49,49,2,5,0,'BMW 3 Series diesel. God til pendling og fin historik.',NOW()),
(50,50,3,2,1,'Audi A3 benzin. Solgt – sporty og populær model.',NOW());

-- ---------------------------------
-- FAVORITE (10)  (realistiske "customers" gemmer annoncer)
-- user_id: customers 6..15
-- listing_id: 1..10
-- ---------------------------------
INSERT INTO favorite (id, user_id, car_listing_id, created_at) VALUES
(1,6,1,NOW()),
(2,7,2,NOW()),
(3,8,3,NOW()),
(4,9,4,NOW()),
(5,10,5,NOW()),
(6,11,6,NOW()),
(7,12,7,NOW()),
(8,13,8,NOW()),
(9,14,9,NOW()),
(10,15,10,NOW());

-- ---------------------------------
-- MESSAGE (9)  (realistisk dialog)
-- ---------------------------------
INSERT INTO message (id, sender_id, receiver_id, car_listing_id, content, sent_at, is_read) VALUES
(1,6,2,1,'Hej! Er BMW’en stadig til salg, og kan den ses i weekenden?',NOW(),0),
(2,2,6,1,'Hej Amalie. Ja, den er ledig. Søndag kl. 12 eller 14 passer fint.',NOW(),1),
(3,7,3,2,'Hej! Har Audi A3 været i uheld? Jeg er interesseret.',NOW(),0),
(4,3,7,2,'Hej Oliver. Nej, ingen registrerede skader. Service er overholdt.',NOW(),0),
(5,8,4,3,'Hej! Kan du sende stelnummer eller servicehistorik på Golf’en?',NOW(),0),
(6,4,8,3,'Ja, jeg sender serviceoversigt og stelnummer i en ny besked senere i dag.',NOW(),1),
(7,9,5,4,'Hej! Kan jeg booke en prøvetur på C-Class fredag efter arbejde?',NOW(),0),
(8,10,2,5,'Hej! Er Corolla’en nysynet, og hvad er næste service?',NOW(),0),
(9,2,10,5,'Hej Emma. Den er nysynet i år, næste service om ca. 10.000 km.',NOW(),1);

-- ---------------------------------
-- VERIFY TOTAL = 200
-- ---------------------------------
SELECT
  (SELECT COUNT(*) FROM role) +
  (SELECT COUNT(*) FROM region) +
  (SELECT COUNT(*) FROM fuel_type) +
  (SELECT COUNT(*) FROM brand) +
  (SELECT COUNT(*) FROM model) +
  (SELECT COUNT(*) FROM address) +
  (SELECT COUNT(*) FROM app_user) +
  (SELECT COUNT(*) FROM car) +
  (SELECT COUNT(*) FROM car_listing) +
  (SELECT COUNT(*) FROM favorite) +
  (SELECT COUNT(*) FROM message) AS total_rows_should_be_200;
