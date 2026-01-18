START TRANSACTION;

-- drop child tables first
DROP TABLE IF EXISTS checkouts;
DROP TABLE IF EXISTS course_materials;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS resources;
DROP TABLE IF EXISTS departments;

-- Parent table -> Departments
CREATE TABLE departments (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL
); 

-- Resources 
CREATE TABLE resources (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	department_id INT NULL, -- not every resource is assigned to a department 
    title VARCHAR(200) NOT NULL,
	total_copies INT NOT NULL,
	CONSTRAINT fk_resourses_departments
		FOREIGN KEY (department_id)
		REFERENCES departments(id)
		ON DELETE SET NULL
);

-- courses
CREATE TABLE courses (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    department_id INT NOT NULL,
    course_name VARCHAR(200) NOT NULL,
    course_code VARCHAR(40) NOT NULL,
        CONSTRAINT fk_courses_departments
        FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE RESTRICT
); 

-- course_materials
CREATE TABLE course_materials (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    resource_id INT NULL,
    CONSTRAINT fk_course_materials_courses
        FOREIGN KEY (course_id)
        REFERENCES courses(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course_materials_resources
        FOREIGN KEY (resource_id)
        REFERENCES resources(id)
        ON DELETE SET NULL
); 

-- checkouts
CREATE TABLE checkouts (
    id INT NOT NULL AUTO_INCREMENT,
    resource_id INT NOT NULL,
    borrower_name VARCHAR(200) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_checkouts_resources
        FOREIGN KEY (resource_id)
        REFERENCES resources(id)
        ON DELETE RESTRICT
);

-- Insert data
INSERT INTO departments (name) VALUES
('Chemistry'),
('History');

INSERT INTO resources (department_id, title, total_copies) VALUES
(1, 'Organic Chemistry (Klein)', 3),
(1, 'Intro to Analytical Chemistry', 2),
(2, 'World History Atlas', 2);

INSERT INTO courses (department_id, course_name, course_code) VALUES
(1, 'Organic Chemistry II', 'CHEM212'),
(2, 'World History I', 'HIST101');

INSERT INTO course_materials (course_id, resource_id) VALUES
(1, 1),
(1, 2),
(2, 3);

INSERT INTO checkouts (resource_id, borrower_name) VALUES
(1, 'Alice Chen'),
(3, 'Bob Rivera');

COMMIT;

-- Test queries
SELECT * FROM departments;
SELECT * FROM resources;
SELECT * FROM courses;
SELECT * FROM course_materials;
SELECT * FROM checkouts; 

