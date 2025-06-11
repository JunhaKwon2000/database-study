-- 1. DB 생성
CREATE DATABASE starbuucks;

-- 1. DB 사용
USE starbuucks;

-- 2. 테이블 생성
CREATE TABLE coffees (
	id INT PRIMARY KEY,
    name VARCHAR(20),
    price INT
);

-- 3. 데이터 입력
INSERT INTO coffees (id, name, price) 
VALUES 
	(1, '아메리카노', 3800), 
    (2, '카페라떼', 4000), 
    (3, '콜드브루', 3500), 
    (4, '카페모카', 4500), 
    (5, '카푸치노', 5000);

-- 4. 모든 커피의 이름 조회
SELECT name FROM coffees; 

-- 5. 카푸치노의 가격 +200
UPDATE coffees SET price = price + 200 WHERE id = 5; 
-- UPDATE coffees SET price = price + 200 WHERE name = '카푸치노' LIMIT 1;

-- 6. 콜드 브루 삭제
DELETE FROM coffees WHERE id = 3;
-- DELETE FROM coffees WHERE name = '콜드브루' LIMIT 1;

-- 7. 모든 레코드 조회
SELECT * FROM coffees;