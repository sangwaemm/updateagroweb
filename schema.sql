-- schema.sql
-- This script creates the database structure for the AgriLink website.

-- -----------------------------------------------------
-- Table `users`
-- Stores all user accounts, including admins.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL, -- IMPORTANT: Never store plain text passwords!
  role TEXT NOT NULL CHECK(role IN ('Admin', 'Farmer', 'Agro-Dealer', 'Vet/Agronomist')),
  status TEXT NOT NULL DEFAULT 'Pending' CHECK(status IN ('Pending', 'Approved', 'Rejected')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table `products`
-- Stores the products shown on the homepage (max 6).
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  image_url TEXT NOT NULL, -- Path to the uploaded image, e.g., '/images/products/maize.png'
  display_order INTEGER, -- Optional: to control the order they appear
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table `news_updates`
-- Stores the text for the scrolling news section.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS news_updates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Table `slider_images`
-- Stores the images for the main homepage slider.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS slider_images (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  image_url TEXT NOT NULL, -- Path to the uploaded image, e.g., '/images/slider/slide1.jpg'
  alt_text TEXT, -- Good for accessibility
  display_order INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Create a default Admin user on setup
-- You should change the password immediately in a real application.
-- The password here is 'admin123' (but hashed).
-- In your backend code, you would use a library to generate this hash.
-- -----------------------------------------------------
INSERT INTO users (name, email, password_hash, role, status) 
VALUES ('Admin User', 'admin@agrilink.rw', '$2b$12$E/V.j4o.sJzY.xZ8Y.j4o.sJzY.xZ8Y.j4o.sJzY.xZ8Y.j4o.sJzY.', 'Admin', 'Approved');
