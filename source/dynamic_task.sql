CREATE TABLE product (
    product_no INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    product_price INT,
    product_category INT
);

INSERT INTO product (product_name, product_price, product_category)
VALUES 
('노트북', 1500000, 1),
('핸드폰', 1000000, 1),
('셔츠', 20000, 2),
('젤리', 1500, 3);
