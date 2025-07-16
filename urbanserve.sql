-- Database: urbanserve (Cash Payment Version)
CREATE DATABASE IF NOT EXISTS urbanserve;
USE urbanserve;

-- Users Table (for all user types)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'provider', 'customer') NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    pincode VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Providers Table (extends users with professional details)
CREATE TABLE IF NOT EXISTS providers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    service_category VARCHAR(100) NOT NULL,
    experience VARCHAR(50) NOT NULL,
    bio TEXT,
    id_proof VARCHAR(255), -- Path to uploaded ID document
    profile_image VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    availability ENUM('available', 'unavailable') DEFAULT 'available',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Services Table
CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    duration_minutes INT NOT NULL,
    image VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Provider Services (with provider-specific pricing)
CREATE TABLE IF NOT EXISTS provider_services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provider_id INT NOT NULL,
    service_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (provider_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE CASCADE,
    UNIQUE KEY unique_provider_service (provider_id, service_id)
);

-- Bookings Table (cash payment version)
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    provider_id INT NOT NULL,
    service_id INT NOT NULL,
    booking_date DATETIME NOT NULL,
    address TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'completed', 'cancelled', 'rejected') DEFAULT 'pending',
    payment_type ENUM('cash', 'later') NOT NULL DEFAULT 'cash',
    payment_status ENUM('pending', 'paid', 'unpaid') DEFAULT 'pending',
    admin_notes TEXT,
    customer_notes TEXT,
    provider_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (provider_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

-- Reviews Table
CREATE TABLE IF NOT EXISTS reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    user_id INT NOT NULL,
    provider_id INT NOT NULL,
    service_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (provider_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

-- Provider Availability Slots
CREATE TABLE IF NOT EXISTS provider_availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provider_id INT NOT NULL,
    day_of_week TINYINT NOT NULL CHECK (day_of_week BETWEEN 1 AND 7), -- 1=Monday, 7=Sunday
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (provider_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Service Areas (where providers operate)
CREATE TABLE IF NOT EXISTS service_areas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    provider_id INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    pincodes TEXT, -- Comma-separated pincodes or "all"
    FOREIGN KEY (provider_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Notifications Table
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Sample Data Insertion (Cash Payment System)

-- Insert admin user
INSERT INTO users (name, email, password, role, phone, address, city, pincode) VALUES 
('Admin User', 'admin@urbanserve.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', '9876543210', '123 Admin Street', 'Mumbai', '400001');

-- Insert sample services
INSERT INTO services (name, category, description, base_price, duration_minutes) VALUES
('Home Deep Cleaning', 'Cleaning', 'Complete home cleaning including kitchen, bathrooms, and living areas', 1999.00, 240),
('AC Repair', 'Appliance', 'AC gas refill and general servicing', 1299.00, 120),
('Plumbing Service', 'Repair', 'Fix leaking taps, pipes, and drainage issues', 599.00, 90),
('Salon at Home - Women', 'Beauty', 'Haircut, styling, and basic facial', 899.00, 90),
('Electrician Service', 'Repair', 'Wiring, switchboard repair, and installations', 499.00, 60);

-- Insert sample provider
INSERT INTO users (name, email, password, role, phone, address, city, pincode) VALUES 
('Rajesh Kumar', 'provider@urbanserve.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'provider', '9876543211', '456 Provider Lane', 'Mumbai', '400002');

INSERT INTO providers (user_id, service_category, experience, bio) VALUES
(2, 'Cleaning,Repair', '5 years', 'Professional cleaner and repair technician with 5 years experience');

-- Set provider services
INSERT INTO provider_services (provider_id, service_id, price) VALUES
(2, 1, 1799.00),  -- Home Cleaning at discounted rate
(2, 2, 1199.00),  -- AC Repair
(2, 3, 499.00);   -- Plumbing Service

-- Set provider availability (Mon-Fri 9am-6pm)
INSERT INTO provider_availability (provider_id, day_of_week, start_time, end_time) VALUES
(2, 1, '09:00:00', '18:00:00'), -- Monday
(2, 2, '09:00:00', '18:00:00'), -- Tuesday
(2, 3, '09:00:00', '18:00:00'), -- Wednesday
(2, 4, '09:00:00', '18:00:00'), -- Thursday
(2, 5, '09:00:00', '18:00:00'); -- Friday

-- Insert sample customer
INSERT INTO users (name, email, password, role, phone, address, city, pincode) VALUES 
('Priya Sharma', 'customer@urbanserve.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'customer', '9876543212', '789 Customer Road', 'Mumbai', '400003');

-- Sample booking (cash payment)
INSERT INTO bookings (user_id, provider_id, service_id, booking_date, address, amount, status, payment_type, payment_status) VALUES
(3, 2, 1, '2023-12-15 14:00:00', '789 Customer Road, Mumbai', 1799.00, 'confirmed', 'cash', 'pending');
