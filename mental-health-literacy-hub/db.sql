CREATE DATABASE IF NOT EXISTS mentalhealth_db;
USE mentalhealth_db;

-- 1. Table for MentalHealthChallengeType
CREATE TABLE challenge_types (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    creator VARCHAR(255),
    total_days INT,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- 2. Table for the ElementCollection (Activities)
CREATE TABLE challenge_activities (
    challenge_type_id INT NOT NULL,
    activity_name VARCHAR(255),
    CONSTRAINT fk_type_activities FOREIGN KEY (challenge_type_id) 
        REFERENCES challenge_types(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3. Table for MentalHealthChallenge
CREATE TABLE mental_health_challenges (
    id INT NOT NULL AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL,
    challenge_type_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_challenge_type FOREIGN KEY (challenge_type_id) 
        REFERENCES challenge_types(id)
) ENGINE=InnoDB;

-- 4. Table for DailyReflection
CREATE TABLE daily_reflections (
    id INT NOT NULL AUTO_INCREMENT,
    reflection VARCHAR(1000),
    feeling VARCHAR(50) NOT NULL, -- Enum stored as STRING
    date_created DATETIME NOT NULL,
    challenge_id INT,
    PRIMARY KEY (id),
    CONSTRAINT fk_challenge_reflection FOREIGN KEY (challenge_id) 
        REFERENCES mental_health_challenges(id) ON DELETE CASCADE
) ENGINE=InnoDB;