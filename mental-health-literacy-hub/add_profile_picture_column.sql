-- Add profile_picture column to users table
-- Run this script to add profile picture support to existing database

USE mental_health_hub;

ALTER TABLE users 
ADD COLUMN profile_picture VARCHAR(255) NULL 
AFTER role;

