-- urbanserve.sql

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255),
    role ENUM('admin', 'provider', 'customer') NOT NULL
);

CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100),
    description TEXT
);

CREATE TABLE providers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    service_id INT,
    availability VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    provider_id INT,
    service_id INT,
    date_requested DATETIME,
    status ENUM('pending', 'confirmed', 'completed', 'cancelled'),
    FOREIGN KEY (customer_id) REFERENCES users(id),
    FOREIGN KEY (provider_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);
INSERT INTO users (name, email, password, role)
VALUES (
  'Admin User',
  'admin@urbanserve.com',
  '$2y$10$WzXKnNoOBD9akyaGbWxCKuQ.0nMLsMNGqPkoPYtxzHdAPlckTbSkq', -- password: admin123
  'admin'
);
