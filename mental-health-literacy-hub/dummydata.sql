-- 1. Insert MentalHealthChallengeType (Templates)
INSERT INTO challenge_types (title, description, creator, total_days) VALUES
('30-Day Gratitude Journey', 'Develop a daily gratitude practice to improve mental well-being and positive thinking.', 'Dr. Sarah Johnson', 30),
('Mindful Breathing Challenge', 'Practice mindfulness through daily breathing exercises to reduce stress and anxiety.', 'Dr. Michael Chen', 21),
('Self-Compassion Practice', 'Learn to treat yourself with kindness and understanding through daily self-compassion exercises.', 'Dr. Sarah Johnson', 14),
('Stress Management Workshop', 'Learn effective techniques to manage stress and improve your mental resilience.', 'Dr. Emily Carter', 10);

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
('user', 1), -- Challenge ID 1
('user', 2), -- Challenge ID 2
('user', 3), -- Challenge ID 3
('user', 4); -- Challenge ID 4

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