-- 셀프체크
-- 5장에서 만든 orders(주문) 테이블을 이용해 다음 1~5를 수행하는 쿼리를 작성하세요.
SELECT * FROM  orders;

-- 1. 상품명이 '국내산'으로 시작하는 주문의 개수를 구하세요.
SELECT COUNT(*) FROM orders WHERE name LIKE '국내산%';

-- 2. 주문 수량이 2~4개인 상품의 평균 가격을 구하세요.
SELECT AVG(price) FROM orders WHERE quantity BETWEEN 2 AND 4;

-- 3. 11월 주문 중 11월 20일 이후에 들어온 주문의 개수를 구하세요.
SELECT COUNT(*) FROM orders WHERE MONTH(created_at) = 11 AND DAY(created_at) > 20;

-- 4. 상품명에 부피 단위인 'ml' 또는 'l'가 포함된 주문을 모두 조회하세요.
SELECT * FROM orders WHERE name LIKE '%ml%' OR name LIKE '%l%'; -- %l%가 이미 %ml%를 포함하기에 중복된 조건 

-- 5. 10월과 12월에 들어온 주문의 개수를 구하세요(주의: 11월은 포함하지 않습니다).
SELECT COUNT(*) FROM orders WHERE MONTH(created_at) = 10 OR MONTH(created_at) = 12;
SELECT COUNT(*) FROM orders WHERE MONTH(created_at) IN (10, 12);


SELECT CONCAT(MONTH(created_at), '월') AS '주문 날짜', CONCAT(COUNT(*), '개') AS '주문 수량' FROM orders
WHERE MONTH(created_at) = 10 OR MONTH(created_at) = 12
GROUP BY CONCAT(MONTH(created_at), '월');
