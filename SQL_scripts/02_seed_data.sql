-- ============================================
-- BILBASEN CLONE - SCHEMA
-- ============================================

DROP TABLE IF EXISTS message;
DROP TABLE IF EXISTS favorite;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS model;
DROP TABLE IF EXISTS brand;
DROP TABLE IF EXISTS fuel_type;
DROP TABLE IF EXISTS app_user;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS role;

-- ROLES
CREATE TABLE role (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(20) NOT NULL UNIQUE
);

-- REGIONS (danske regioner)
CREATE TABLE region (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL UNIQUE
);

-- USERS
CREATE TABLE app_user (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password_hash   VARCHAR(255) NOT NULL,
    first_name      VARCHAR(50)  NOT NULL,
    last_name       VARCHAR(50)  NOT NULL,
    phone           VARCHAR(20),
    role_id         BIGINT       NOT NULL,
    region_id       BIGINT       NOT NULL,
    private_seller  BOOLEAN      DEFAULT TRUE,
    created_at      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id)   REFERENCES role(id),
    FOREIGN KEY (region_id) REFERENCES region(id)
);

-- BRANDS
CREATE TABLE brand (
    id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(50) NOT NULL UNIQUE
);

-- MODELS
CREATE TABLE model (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    brand_id    BIGINT      NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(id)
);

-- FUEL TYPES
CREATE TABLE fuel_type (
    id      BIGINT AUTO_INCREMENT PRIMARY KEY,
    name    VARCHAR(30) NOT NULL UNIQUE
);

-- CARS
CREATE TABLE car (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    model_id        BIGINT          NOT NULL,
    fuel_type_id    BIGINT          NOT NULL,
    seller_id       BIGINT          NOT NULL,
    price           DECIMAL(10, 2)  NOT NULL,
    year            INT             NOT NULL,
    mileage_km      INT             NOT NULL,
    color           VARCHAR(30),
    description     TEXT,
    is_sold         BOOLEAN         DEFAULT FALSE,
    created_at      TIMESTAMP       DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (model_id)    REFERENCES model(id),
    FOREIGN KEY (fuel_type_id) REFERENCES fuel_type(id),
    FOREIGN KEY (seller_id)   REFERENCES app_user(id)
);

-- FAVORITES
CREATE TABLE favorite (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id     BIGINT NOT NULL,
    car_id      BIGINT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES app_user(id),
    FOREIGN KEY (car_id)  REFERENCES car(id),
    UNIQUE (user_id, car_id)
);

-- MESSAGES
CREATE TABLE message (
    id              BIGINT AUTO_INCREMENT PRIMARY KEY,
    sender_id       BIGINT NOT NULL,
    receiver_id     BIGINT NOT NULL,
    car_id          BIGINT NOT NULL,
    content         TEXT   NOT NULL,
    sent_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read         BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id)   REFERENCES app_user(id),
    FOREIGN KEY (receiver_id) REFERENCES app_user(id),
    FOREIGN KEY (car_id)      REFERENCES car(id)
);
