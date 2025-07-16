Here's the updated and comprehensive README.md file incorporating all your requirements:

# UrbanServe - Local Services Marketplace

![UrbanServe Logo](docs/urbanserve-logo.png)  
**Connecting customers with trusted local service providers**

## Table of Contents
1. [System Overview](#system-overview)
2. [User Roles](#user-roles)
   - [Service Provider](#service-provider)
   - [Customer](#customer)
   - [Administrator](#administrator)
3. [Key Features](#key-features)
4. [Security Features](#security-features)
5. [Technology Stack](#technology-stack)
6. [Database Schema](#database-schema)
7. [Installation Guide](#installation-guide)
8. [Default Credentials](#default-credentials)
9. [Payment System](#payment-system)
10. [Screenshots](#screenshots)
11. [API Endpoints](#api-endpoints)
12. [Contributing](#contributing)
13. [License](#license)

## System Overview

UrbanServe is a PHP-based platform that facilitates:
- Service discovery and booking
- Provider-customer connections
- Service management
- Role-based access control

All pages use PHP sessions for authentication and dynamically pull content from MySQL database.

## User Roles

### Service Provider
- Registers and manages services
- Views and manages bookings
- Sets availability schedule
- Updates service areas/pincodes
- Manages customer interactions

### Customer
- Browses available services
- Books services (login required)
- Views booking history
- Leaves reviews/ratings
- Manages personal profile

### Administrator
- Manages all user accounts
- Approves provider registrations
- Monitors all bookings
- Handles disputes
- Generates system reports

## Key Features

**Dynamic Content**
- `index.php` pulls services/providers from database
- Real-time availability checking
- Personalized dashboards based on role

**Booking System**
- Service selection with filters
- Booking request workflow
- Status tracking (Pending/Confirmed/Completed)

**Security**
- Role-based access control
- Session authentication
- Password hashing with `password_hash()`
- Input sanitization

## Security Features

- 🔒 Session-based authentication
- 🔑 Password hashing using PHP `password_hash()`
- 🛡️ SQL injection prevention with prepared statements
- 🔍 Input validation and sanitization
- 👮 Role-based access control for all pages
- 🚪 Automatic logout after inactivity

## Technology Stack

**Frontend**
- HTML5, CSS3, JavaScript
- Responsive design (Flexbox/Grid)
- Font Awesome 6 icons
- Google Fonts (Inter)

**Backend**
- PHP 7.4+
- MySQL 5.7+
- Apache/Nginx

**Security**
- Prepared statements
- Password hashing
- CSRF protection
- Output escaping

## Database Schema

Core Tables:
1. `users` - All user accounts
2. `providers` - Service provider details
3. `services` - Service catalog
4. `provider_services` - Provider-service mappings
5. `bookings` - Appointment records
6. `reviews` - Customer feedback
7. `notifications` - System alerts

![Database Schema](docs/db-schema.png)

## Installation Guide

### Requirements
- PHP 7.4+
- MySQL 5.7+
- Web server (Apache/Nginx)
- Composer (recommended)

### Setup Steps

1. Clone repository:
   ```bash
   git clone https://github.com/yourrepo/urbanserve.git
   cd urbanserve
   ```

2. Create database:
   ```sql
   CREATE DATABASE urbanserve;
   ```

3. Import schema:
   ```bash
   mysql -u username -p urbanserve < database/schema.sql
   ```

4. Configure environment:
   ```bash
   cp config.example.php config.php
   nano config.php
   ```

5. Launch application:
   ```bash
   php -S localhost:8000
   ```

## Default Credentials

Role | Email | Password
-----|-------|---------
Admin | admin@urbanserve.com | password
Provider | provider@example.com | provider123
Customer | customer@example.com | customer123

**Important:** Change default passwords immediately after installation.

## Payment System

UrbanServe uses offline payment model:
1. Customer books service online
2. Provider completes service
3. Payment handled in-person via:
   - Cash
   - UPI (direct between parties)
4. Provider marks payment as received in system

## Screenshots

![Homepage](docs/screenshots/homepage.png)
*Service listing from database*

![Customer Dashboard](docs/screenshots/customer-dash.png)
*Customer booking interface*

![Provider Dashboard](docs/screenshots/provider-dash.png)
*Provider service management*

## API Endpoints

Endpoint | Method | Description
--------|--------|------------
`/api/login` | POST | User authentication
`/api/services` | GET | List available services
`/api/bookings` | POST | Create new booking
`/api/bookings/{id}` | GET | Booking details

## Contributing

1. Fork the repository
2. Create feature branch:
   ```bash
   git checkout -b feature/new-feature
   ```
3. Commit changes:
   ```bash
   git commit -m 'Add new feature'
   ```
4. Push to branch:
   ```bash
   git push origin feature/new-feature
   ```
5. Open pull request

## License

MIT License - See [LICENSE](LICENSE) for details.

---

**Contact**: support@urbanserve.com  
**Live Demo**: [demo.urbanserve.com](https://demo.urbanserve.com)

*Note: All passwords in demo environment are reset hourly.*c
