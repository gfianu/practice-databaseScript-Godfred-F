START TRANSACTION;

-- drop child tables first 
DROP TABLE IF EXISTS comments, posts, users;

-- 1) Parent table
CREATE TABLE users (
id INT NOT NULL AUTO_INCREMENT,
username VARCHAR(50) NOT NULL,
email VARCHAR(100) DEFAULT 'N/A',
password VARCHAR(255) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
) ENGINE=InnoDB; 

-- 2) Child table (FK -> users)
CREATE TABLE posts (
    id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_posts_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 3) Child table (FK -> posts, and FK -> users)
CREATE TABLE comments (
    id INT NOT NULL AUTO_INCREMENT,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_comments_posts
        FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_comments_users
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Insert users
INSERT INTO users (username, email, password) VALUES 
('alice', 'alice@test.com', 'password123'),
('bob', 'bob@test.com', 'password456'),
('charlie', 'charlie@test.com', 'password789');

-- Insert posts
INSERT INTO posts (user_id, title, content) VALUES
(1, 'First Post', 'This is the content of the first post'),
(2, 'Second Post', 'This is the content of the second post'),
(3, 'Third Post', 'This is the content of the third post'),
(1, 'Fourth Post', 'This is the content of the fourth post'),
(2, 'Fifth Post', 'This is the content of the fifth post');

-- Insert comments (each comment belongs to a post and a user)
INSERT INTO comments (post_id, user_id, content) VALUES
(1, 2, 'Nice first post!'),
(1, 3, 'Thanks for sharing.'),
(2, 1, 'Good one, Bob.'),
(4, 2, 'Fourth post is my favorite.'),
(5, 3, 'Interesting thoughts.');

COMMIT;

-- Test queries
SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM commentuserss;