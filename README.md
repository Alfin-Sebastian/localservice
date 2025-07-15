# localservice

📘 UrbanServe – Local Services Website (PHP + MySQL)
🔧 Project Overview
UrbanServe is a local services booking platform that allows:

✅ Customers to book trusted service providers

✅ Service Providers to register and manage bookings

✅ Admins to oversee all users and services

The platform uses:

PHP for backend

MySQL for the database

Static + dynamic HTML for the frontend (from index.php)

📂 Project Structure
All files are kept in the same folder (no subdirectories). Key files:

File	Description
index.php	Homepage (frontend + dynamic services/providers)
db.php	Database connection script
login.php	User login form + session handling
register.php	Registration form for customer/provider
logout.php	Destroys session and redirects
admin_dashboard.php	Admin-only dashboard
provider_dashboard.php	Dashboard for service providers
customer_dashboard.php	Dashboard for customers
book_service.php	Customers can book services
services.php	Public list of services
provider_bookings.php	View bookings for a provider
admin_users.php	Admin view of all users
add_service.php	Admin: Add services to system
urbanserve.sql	SQL file to set up database

🛠️ Setup Instructions
✅ Requirements:
XAMPP or any local server with PHP & MySQL

A browser (Chrome/Firefox)

📌 Steps:
Import the database

Open phpMyAdmin (usually at http://localhost/phpmyadmin)

Create a new DB named: urbanserve

Import urbanserve.sql from the folder

Set up the files

Copy all files to your local server folder:

Example: C:/xampp/htdocs/urbanserve/

Visit in browser:
http://localhost/urbanserve/index.php

Admin login (manually insert)

Use phpMyAdmin to insert an admin into the users table:

sql
Copy code
INSERT INTO users (name, email, password, role)
VALUES (
  'Admin User',
  'admin@urbanserve.com',
  '$2y$10$WzXKnNoOBD9akyaGbWxCKuQ.0nMLsMNGqPkoPYtxzHdAPlckTbSkq', -- password: admin123
  'admin'
);
Default credentials:
✉️ Email: admin@urbanserve.com
🔑 Password: admin123
👤 User Roles
Role	Description
Admin	Full control. Manages users, services, etc.
Service Provider	Registers services and views bookings
Customer	Can browse & book services

🚨 Notes
All pages use sessions for role-based access control

index.php dynamically pulls content from the database

You must log in to book services

Passwords are stored securely using password_hash()
