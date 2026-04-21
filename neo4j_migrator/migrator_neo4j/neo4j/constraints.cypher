// Unique constraints
CREATE CONSTRAINT user_id_unique        FOR (u:User)       REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT user_username_unique  FOR (u:User)       REQUIRE u.username IS UNIQUE;
CREATE CONSTRAINT user_email_unique     FOR (u:User)       REQUIRE u.email IS UNIQUE;
CREATE CONSTRAINT brand_id_unique       FOR (b:Brand)      REQUIRE b.id IS UNIQUE;
CREATE CONSTRAINT brand_name_unique     FOR (b:Brand)      REQUIRE b.name IS UNIQUE;
CREATE CONSTRAINT model_id_unique       FOR (m:Model)      REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT fuel_id_unique        FOR (f:FuelType)   REQUIRE f.id IS UNIQUE;
CREATE CONSTRAINT fuel_name_unique      FOR (f:FuelType)   REQUIRE f.name IS UNIQUE;
CREATE CONSTRAINT region_id_unique      FOR (r:Region)     REQUIRE r.id IS UNIQUE;
CREATE CONSTRAINT region_name_unique    FOR (r:Region)     REQUIRE r.name IS UNIQUE;
CREATE CONSTRAINT address_id_unique     FOR (a:Address)    REQUIRE a.id IS UNIQUE;
CREATE CONSTRAINT car_id_unique         FOR (c:Car)        REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT listing_id_unique     FOR (l:CarListing) REQUIRE l.id IS UNIQUE;
CREATE CONSTRAINT sale_id_unique        FOR (s:Sale)       REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT message_id_unique     FOR (m:Message)    REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT audit_id_unique       FOR (a:AuditEvent) REQUIRE a.id IS UNIQUE;

// Performance indexes
CREATE INDEX address_postal  FOR (a:Address)    ON (a.postalCode);
CREATE INDEX car_price       FOR (c:Car)        ON (c.price);
CREATE INDEX car_year        FOR (c:Car)        ON (c.year);
CREATE INDEX listing_created FOR (l:CarListing) ON (l.createdAt);
CREATE INDEX message_sent    FOR (m:Message)    ON (m.sentAt);
