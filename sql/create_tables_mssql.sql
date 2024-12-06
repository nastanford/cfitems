CREATE TABLE test1234.items (
    [id] [int] IDENTITY(1,1) NOT NULL,
    name VARCHAR(255) NOT NULL,
    position INT NOT NULL
);

INSERT INTO test1234.items (name, position) VALUES 
('Item 1', 1),
('Item 2', 2),
('Item 3', 3),
('Item 4', 4),
('Item 5', 5),
('Item 6', 6),
('Item 7', 7),
('Item 8', 8),
('Item 9', 9),
('Item 10', 10);
