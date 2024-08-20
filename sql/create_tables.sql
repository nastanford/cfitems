create database cfitems;

use cfitems;


CREATE TABLE items (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    position INT NOT NULL
);

INSERT INTO items (name, position) VALUES 
('Item 1', 1),
('Item 2', 2),
('Item 3', 3),
('Item 4', 4),
('Item 5', 5);