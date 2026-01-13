-- Mental Health Hub Database Schema
-- Run this script to create the database and tables

CREATE DATABASE IF NOT EXISTS mental_health_hub;
USE mental_health_hub;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('student', 'mhp', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Feedback table
CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    user_role VARCHAR(50) NOT NULL,
    message TEXT NOT NULL,
    status ENUM('pending', 'in-review', 'responded') DEFAULT 'pending',
    response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Mental Health Challenge Types table
CREATE TABLE IF NOT EXISTS mental_health_challenge_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    creator VARCHAR(255),
    total_days INT NOT NULL,
    activities TEXT
);

-- Insert default challenge types
INSERT INTO mental_health_challenge_types (title, description, creator, total_days, activities) VALUES
('30-Day Gratitude Journey', 'Develop a daily gratitude practice to improve mental well-being and positive thinking.', 'Dr. Sarah Johnson', 30, 'Write a gratitude journal,Share gratitude with others,Reflect on positive moments'),
('Mindful Breathing Challenge', 'Practice mindfulness through daily breathing exercises to reduce stress and anxiety.', 'Dr. Michael Chen', 21, 'Morning breathing exercise,Midday mindfulness,Evening relaxation'),
('Self-Compassion Practice', 'Learn to treat yourself with kindness and understanding through daily self-compassion exercises.', 'Dr. Sarah Johnson', 14, 'Daily affirmations,Self-compassion meditation,Journaling self-kindness'),
('Stress Management Workshop', 'Learn effective techniques to manage stress and improve your mental resilience.', 'Dr. Emily Carter', 10, 'Identify stress triggers,Practice stress-relief techniques,Develop a stress management plan');

-- Mental Health Challenges table (user challenges)
CREATE TABLE IF NOT EXISTS mental_health_challenges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    challenge_type_id INT NOT NULL,
    user VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (challenge_type_id) REFERENCES mental_health_challenge_types(id) ON DELETE CASCADE
);

-- Daily Reflections table
CREATE TABLE IF NOT EXISTS daily_reflections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mental_health_challenge_id INT NOT NULL,
    reflection TEXT NOT NULL,
    feeling VARCHAR(50) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mental_health_challenge_id) REFERENCES mental_health_challenges(id) ON DELETE CASCADE
);

-- Insert default users
INSERT INTO users (name, email, password, role) VALUES
('Student User', 'student@example.com', 'password', 'student'),
('Dr. Sarah Johnson', 'mhp@example.com', 'password', 'mhp'),
('Admin User', 'admin@example.com', 'password', 'admin');

