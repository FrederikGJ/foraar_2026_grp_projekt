-- Use the correct database
USE bilbase_projekt;

-- Clean up old users if they already exist
DROP USER IF EXISTS 'bilbase_app'@'%';
DROP USER IF EXISTS 'bilbase_admin'@'%';
DROP USER IF EXISTS 'bilbase_readonly'@'%';
DROP USER IF EXISTS 'bilbase_restricted'@'%';

-- Create users
CREATE USER 'bilbase_app'@'%' IDENTIFIED BY 'app123';
CREATE USER 'bilbase_admin'@'%' IDENTIFIED BY 'admin123';
CREATE USER 'bilbase_readonly'@'%' IDENTIFIED BY 'readonly123';
CREATE USER 'bilbase_restricted'@'%' IDENTIFIED BY 'restricted123';

-- Application user: only what the backend typically needs
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON bilbase_projekt.* TO 'bilbase_app'@'%';

-- Admin user: full access
GRANT ALL PRIVILEGES
ON bilbase_projekt.* TO 'bilbase_admin'@'%';

-- Read-only user: can only read everything
GRANT SELECT
ON bilbase_projekt.* TO 'bilbase_readonly'@'%';

-- Restricted read user: can only read selected non-sensitive data
GRANT SELECT ON bilbase_projekt.brand TO 'bilbase_restricted'@'%';
GRANT SELECT ON bilbase_projekt.model TO 'bilbase_restricted'@'%';
GRANT SELECT ON bilbase_projekt.fuel_type TO 'bilbase_restricted'@'%';
GRANT SELECT ON bilbase_projekt.region TO 'bilbase_restricted'@'%';

-- If your view exists, allow restricted user to read active listings too
GRANT SELECT ON bilbase_projekt.active_listings TO 'bilbase_restricted'@'%';

FLUSH PRIVILEGES;
    
    