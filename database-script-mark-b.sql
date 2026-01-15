START TRANSACTION;

DROP TABLE IF EXISTS department, resources, courses, course_materials, checkout;

CREATE TABLE department(
id INT NOT NULL AUTO_INCREMENT,
department_name VARCHAR(40) NOT NULL
);

CREATE TABLE resources(
id INT NOT NULL AUTO_INCREMENT,
department_id INT NOT NULL,
title VARCHAR(50),
total_copies INT
);

CREATE TABLE courses(
id INT NOT NULL AUTO_INCREMENT,
department_id INT NOT NULL,
course_name VARCHAR(40),
course_code VARCHAR(40)
);

CREATE TABLE course_materials(
id INT NOT NULL AUTO_INCREMENT,
course_id INT NOT NULL,
course_code VARCHAR(40)
);

CREATE TABLE checkout(
id INT NOT NULL AUTO_INCREMENT,
course_materials_id INT NOT NULL,
borrower_name VARCHAR(80)
);

INSERT INTO departments (department_name) VALUES
('science'),
('history'),
('math');

INSERT INTO resources (department_id, title, total_copies) VALUES
(1, 'Intro to Science', 50), 
(1, 'Science Expert', 20),
(2, 'Into to History', 2),
(2, 'WW2', 3),
(3, 'Calculus', 5),
(3, 'Algebra', 10);