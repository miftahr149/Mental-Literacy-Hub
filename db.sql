CREATE DATABASE IF NOT EXISTS mentalhealth_db;
USE mentalhealth_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('student', 'mhp', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    enabled boolean DEFAULT 0x01
);

ALTER TABLE users 
ADD COLUMN profile_picture VARCHAR(255) NULL 
AFTER role;

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

INSERT INTO users (name, email, password, role, enabled) VALUES
('Student User', 'student@example.com', 'password', 'student', 0x01),
('Dr. Sarah Johnson', 'mhp@example.com', 'password', 'mhp', 0x01),
('Admin User', 'admin@example.com', 'password', 'admin', 0x01);

-- 1. Table for MentalHealthChallengeType
CREATE TABLE IF NOT EXISTS challenge_types (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    creator VARCHAR(255),
    total_days INT,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 2. Table for the ElementCollection (Activities)
CREATE TABLE IF NOT EXISTS challenge_activities (
    challenge_type_id INT NOT NULL,
    activity_name VARCHAR(255),
    CONSTRAINT fk_type_activities FOREIGN KEY (challenge_type_id) 
        REFERENCES challenge_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Table for MentalHealthChallenge
CREATE TABLE IF NOT EXISTS mental_health_challenges (
    id INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL,
    challenge_type_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_challenge_type FOREIGN KEY (challenge_type_id) 
        REFERENCES challenge_types(id)
) ENGINE=InnoDB;

-- 4. Table for DailyReflection
CREATE TABLE IF NOT EXISTS daily_reflections (
    id INT NOT NULL AUTO_INCREMENT,
    reflection VARCHAR(1000),
    feeling VARCHAR(50) NOT NULL, -- Enum stored as STRING
    date_created DATETIME NOT NULL,
    challenge_id INT,
    reflection_index INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_challenge_reflection FOREIGN KEY (challenge_id) 
        REFERENCES mental_health_challenges(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `audit_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(255) NOT NULL,
  `log_message` varchar(500) DEFAULT NULL,
  `performed_by` varchar(255) DEFAULT NULL,
  `target_entity` varchar(255) DEFAULT NULL,
  `target_id` int DEFAULT NULL,
  `timestamp` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
); 

-- 1. Insert MentalHealthChallengeType (Templates)
INSERT INTO challenge_types (id, title, description, creator, total_days) VALUES
(1, '30-Day Gratitude Journey', 'Develop a daily gratitude practice to improve mental well-being and positive thinking.', 'Dr. Sarah Johnson', 30),
(2, 'Mindful Breathing Challenge', 'Practice mindfulness through daily breathing exercises to reduce stress and anxiety.', 'Dr. Michael Chen', 21),
(3, 'Self-Compassion Practice', 'Learn to treat yourself with kindness and understanding through daily self-compassion exercises.', 'Dr. Sarah Johnson', 14),
(4, 'Stress Management Workshop', 'Learn effective techniques to manage stress and improve your mental resilience.', 'Dr. Emily Carter', 10);

-- 2. Insert Activities (Element Collection for Challenge Types)
-- Type ID 1
INSERT INTO challenge_activities (challenge_type_id, activity_name) VALUES
(1, 'Write a gratitude journal'), (1, 'Share gratitude with others'), (1, 'Reflect on positive moments');
-- Type ID 2
INSERT INTO challenge_activities (challenge_type_id, activity_name) VALUES
(2, 'Morning breathing exercise'), (2, 'Midday mindfulness'), (2, 'Evening relaxation');
-- Type ID 3
INSERT INTO challenge_activities (challenge_type_id, activity_name) VALUES
(3, 'Daily affirmations'), (3, 'Self-compassion meditation'), (3, 'Journaling self-kindness');
-- Type ID 4
INSERT INTO challenge_activities (challenge_type_id, activity_name) VALUES
(4, 'Identify stress triggers'), (4, 'Practice stress-relief techniques'), (4, 'Develop a stress management plan');

-- 3. Insert MentalHealthChallenges (Linking Users to a Type)
-- We create one challenge for each type for the user 'user'
INSERT INTO mental_health_challenges (user_name, challenge_type_id) VALUES
('Student User', 1), -- Challenge ID 1
('Student User', 2), -- Challenge ID 2
('Student User', 3), -- Challenge ID 3
('Student User', 4); -- Challenge ID 4

-- 4. Insert DailyReflections (linked to specific Challenges)
-- Reflections for Challenge ID 1
INSERT INTO daily_reflections (reflection, feeling, date_created, challenge_id, reflection_index) VALUES
('Feeling grateful', 'GOOD', DATE_SUB(NOW(), INTERVAL 1 DAY), 1, 0),
('Reflecting on positive moments', 'GREAT', NOW(), 1, 1);

-- Reflections for Challenge ID 2
INSERT INTO daily_reflections (reflection, feeling, date_created, challenge_id, reflection_index) VALUES
('Feeling calm', 'GOOD', DATE_SUB(NOW(), INTERVAL 1 DAY), 2, 0),
('Reflecting on positive moments', 'GREAT', NOW(), 2, 1);

-- Reflections for Challenge ID 3
INSERT INTO daily_reflections (reflection, feeling, date_created, challenge_id, reflection_index) VALUES
('Feeling grateful', 'GOOD', DATE_SUB(NOW(), INTERVAL 1 DAY), 3, 0),
('Reflecting on positive moments', 'GREAT', NOW(), 3, 1);

-- Reflections for Challenge ID 4
INSERT INTO daily_reflections (reflection, feeling, date_created, challenge_id, reflection_index) VALUES
('Feeling calm', 'GOOD', DATE_SUB(NOW(), INTERVAL 1 DAY), 4, 0),
('Reflecting on positive moments', 'GREAT', NOW(), 4, 1);