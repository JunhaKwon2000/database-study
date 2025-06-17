/*
9. 서브쿼리 활용하기
9.1 서브쿼리란
*/
-- 서브쿼리: 쿼리 안에 포함된 또 다른 쿼리
-- 안쪽 서브쿼리의 실행 결과를 받아 바깥쪽 메인쿼리가 실행됨

-- 서브쿼리 예: 더움 햑생 중 성적이 평균보다 높은 학생은?
-- 서브쿼리 예: 다음 학생 중 성적이 평균보다 높은 학생은?
-- students
-- ----------------------
-- id  | name    | score
-- ----------------------
-- 1   | 엘리스    | 85
-- 2   | 밥       | 78
-- 3   | 찰리     | 92
-- 4   | 데이브    | 65
-- 5   | 이브     | 88

-- sub_query DB 생성 및 진입
CREATE DATABASE sub_query;
USE sub_query;

-- students 테이블 생성
CREATE TABLE students (
	id INTEGER AUTO_INCREMENT, 	-- 아이디(자동으로 1씩 증가)
	name VARCHAR(30), 			-- 이름
	score INTEGER, 				-- 성적
	PRIMARY KEY (id) 			-- 기본키 지정: id
);

-- students 데이터 삽입
INSERT INTO students (name, score)
VALUES
	('엘리스', 85),
	('밥', 78),
	('찰리', 92),
	('데이브', 65),
	('이브', 88);
    
-- 확인
SELECT * FROM students;

-- 평균 점수보다 더 높은 점수를 받은 학생 조회
SELECT name, score
FROM students
WHERE score >= (
	-- 서브쿼리: 평균 점수 계산
	SELECT AVG(score) FROM students
); -- () 괄호 안이 서브쿼리로 작성할 부분    

-- 서브쿼리의 특징 5가지
-- 1) 중첩 구조
-- 메인 쿼리 내부에 중첩하여 작성
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블명
-- WHERE 컬러명 연산자 (서브쿼라);

-- 2) 메인쿼리와는 독립적으로 실행됨
-- 서브쿼리 우선 실행 후
-- 그 결과를 받아 메인 쿼리가 수행됨

-- 3) 다양한 위치에서 사용 가능
-- SELECT
-- FROM/JOIN
-- WHERE/HAVING 등

-- 4) 단일 값 또는 다중 값을 반환
-- 단일 값 서브쿼리: 특정 값을 반환하는 서브쿼리(1행 1열)
-- 다중 값 서브쿼리: 여러 레코드를 반환하는 서브쿼리(N행 M열) - IN, ANY, ALL, EXISTS 연산자와 함께 사용됨

-- 5) 복잡하고 정교한 데이터 분석에 유용
-- 필터링 조건 추출
-- 데이터 집계 걸과 추출
-- => 이를 기준으로 메인쿼리를 수행

-- Quiz
-- 1. 다음 설명이 맞으면 O, 틀리면 X를 표시하세요.
-- ① 서브쿼리는 메인쿼리 내부에 중첩해 작성한다. (  )
-- ② 서브쿼리는 다양한 위치에서 사용할 수 있다. (  )
-- ③ 서브쿼리는 단일 값만 반환한다. (  )

-- 정답: O, O, X


/*
9.2 다양한 위치에서의 서브쿼리
*/
-- 8장에서 다루었던 마켓 DB를 기반으로 다양한 서브쿼리를 연습!
USE market;

-- 1. SELECT 절에서의 서브쿼리
-- 1X1 단일값만 반환하는 서브쿼리만 사용 가능
-- 여러 행 또는 여러 컬럼을 반환하면 SQL이 어떤 값을 선택해야 할 지 몰라 에러 발생

-- 모든 결제 정보에 대한 평균 결제 금액과의 차이는?
-- Quiz: 괄호안에 쿼리 작성하기
SELECT 
	payment_type AS '결제 유형', 
    amount AS '결제 금액', 
    amount - (SELECT AVG(amount) FROM payments) AS '평균 결제 금액과의 차이'
FROM payments;

-- 잘못된 SELECT
-- 1x1 이 아니므로 이건 안됨, SELECT 안에는 무조건 쿼리의 결과가 1x1인 쿼리만 들어와야함
SELECT 
	payment_type AS '결제 유형', 
    amount AS '결제 금액', 
    amount - (SELECT AVG(amount), '123' FROM payments) AS '평균 결제 금액과의 차이'
FROM payments;

-- 2. FROM 절에서의 서브쿼리
-- NxM 반환하는 행과 컬럼의 개수에 제한이 없음
-- 단, 서브쿼리에 별칭 지정 필수

-- 1회 주문 시 평균 상품 개수는? (장바구니 상품 포함)
-- 주문별(order_id)로 그룹화
SELECT AVG(total_count) AS '1회 주문 시 평균 상품 개수'
FROM (
	SELECT order_id, SUM(count) AS total_count -- alias 필수(col명이 아닌 계산된 값을 반환)
	FROM order_details
	GROUP BY order_id
) count; -- inline-view: alias 필수

-- 3. JOIN 절에서의 서브쿼리
-- NxM 반환하는 행과 컬럼의 개수에 제한이 없음
-- 단, 서브쿼리에 별칭 지정 필수

-- 상품별 주문 개수를 '배송 완료' 와 '장바구니'에 상관없이 상품명과 주문 개수를 조회한다면?
SELECT p.name AS 상품명, product_count.total_count AS 주문개수
FROM products p JOIN (
	SELECT product_id, SUM(count) AS total_count
	FROM order_details
	GROUP BY product_id
) product_count ON p.id = product_count.product_id;

SELECT p.name AS 상품명, SUM(count) AS 주문개수
FROM products p JOIN order_details od ON p.id = od.product_id
GROUP BY p.name;


-- 4. WHERE 절에서의 서브쿼리
-- 1x1, Nx1 반환하는 서브쿼리만 사용 가능
-- 필터링의 조건으로 값 또는 값의 목록을 사용하기 때문

-- 평균 가격보다 비싼 상품을 조회하려면?
SELECT name, price 
FROM products
WHERE price > (
	SELECT AVG(price)
    FROM products
);


-- 5. HAVING 절에서의 서브쿼리
-- 1x1, Nx1 반환하는 서브쿼리만 사용 가능
-- 필터링의 조건으로 값 또는 값의 목록을 사용하기 때문

-- 크림 치즈보다 매출이 높은 상품은? (장바구니 상품 포함)
SELECT name AS 상품명, SUM(od.count * p.price) AS 매출
FROM products p JOIN order_details od ON p.id = od.product_id
GROUP BY p.name
HAVING SUM(od.count * p.price) > (
	SELECT SUM(od.count * p.price)
	FROM products p JOIN order_details od ON p.id = od.product_id
    WHERE name = '크림 치즈'
);

-- Quiz
-- 2. 다음 설명이 맞으면 O, 틀리면 X를 표시하세요.
-- ① SELECT 절의 서브쿼리는 단일 값만 반환해야 한다. (  )
-- ② FROM 절과 J0IN 절의 서브쿼리는 별칭을 지정해야 한다. (  )
-- ③ WHERE 절과 HAVING 절의 서브쿼리는 단일 값 또는 다중 행의 단일 칼럼을 반환할 수 있다. (  )

-- 정답: O, O, O


/*
9.3 IN, ANY, ALL, EXISTS
*/
-- 주로 WHERE 절에서의 서브쿼리와 쓰임

-- 1. IN 연산자
-- 괄호 사이 목록에 포함되는 대상을 찾음

-- 형식
-- 1. col IN (?, ?, ?)
-- 상품명이 우유 식빵, 크림치즈인 대상읜 id 목록은?
SELECT id FROM products WHERE name IN ('우유 식빵', '크림 치즈');

-- 2. col IN (다중 행의 단일 컬럼을 반환하는 서브쿼리)
-- 우유 식빵, 크림 치즈를 포함하는 모든 주문의 상세 내역
SELECT * FROM order_details
WHERE product_id IN (
	SELECT id FROM products WHERE name IN ('우유 식빵', '크림 치즈')
);

-- 3. JOIN 이랑 같이 쓸 때
-- 우유 식빵, 크림 치즈를 주문한 사용자의 아이디와 닉네임
SELECT DISTINCT u.id , u.nickname FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN users u ON o.user_id = u.id 
WHERE od.product_id IN (
	SELECT id FROM products WHERE name IN ('우유 식빵', '크림 치즈')
);


-- 2. ANY 연산자
-- 지정된 집합의 모든 요소와 비교 연산을 수행하여 하나라도 만족하는 대상을 찾음
-- col 비교연산자 ANY (다중 행의 단일 컬럼을 반환하는 서브쿼리)
-- 우유 식빵이나 플레인 베이글보다 저렴한 상품 목록은?(결과적으로는 2900원 보다 가격이 낮은 상품들)
SELECT * 
FROM products
WHERE price < ANY(
	SELECT price 
    FROM products 
    WHERE name IN ('우유 식빵', '플레인 베이글')
);

-- ALL 연산자
-- 지정된 집합의 모든 요소와 비교 연산을 수행하여 모두를 만족하는 대상을 찾음
-- 우유 식빵이나 플레인 베이글보다 비싼 상품 목록은?(결과적으로는 2900원 보다 가격이 높은 상품들)
SELECT * 
FROM products
WHERE price > ALL(
	SELECT price 
    FROM products 
    WHERE name IN ('우유 식빵', '플레인 베이글')
);


-- 4. EXISTS 연산자
-- 입력받은 서브쿼리가 하나 이상의 행을 반환하는 경우 TRUE, 아니면 FALSE
-- SELECT col1, col2, ... FROM table WHERE EXISTS(서브쿼리);

-- 적어도 1번 이상 주문한 사용자를 조회하려면?
SELECT * 
FROM users u
WHERE EXISTS (
	SELECT 1 -- *: 굳이 모든 컬럼을 다 가져오는 것 보다 1만 써주는게 효율적
    FROM orders o
    WHERE o.user_id = u.id -- 이렇게 서브쿼리가 메인쿼리의 특정 값을 참조하는 쿼리를 상관 쿼리라고 함
);

-- (참고) 상관 쿼리의 동작 원리
-- users 테이블 1번 사용자의 주문이 있는지
-- orders 테이블을 반복하며 확인, 있으면 결과 테이블에 1을 반환
-- 같은 방식으로 2번 사용자, 3번 사용자도 확인
-- EXISTS 는 결과가 하나라도 존재하면 TRUE가 되기 때문에, 매칭되는 레코드를 찾으면 더 이상 검사하지 않음

-- (참고) 상관 쿼리의 특징
-- 1) 의존성: 서브쿼리는 메인쿼리의 값을 참조해 데이터 필터링을 수행
-- 2) 반복 실행: 서브쿼리는 메인쿼리의 각 행에 대해 반복적으로 실행됨
-- 3) 성능 저하: 메인쿼리의 각 행마다 서브쿼리를 실행하므로 쿼리 전체의 성능이 저하될 수 있음(특히 데이터 양이 많을 경우)

-- NOT EXISTS 연산자 실습
-- COCOA PAY로 결제하지 않은 사용자를 조회하려면?
SELECT * 
FROM users u
WHERE NOT EXISTS (
	SELECT 1
    FROM orders o JOIN payments p ON o.id = p.order_id
    WHERE u.id = o.user_id AND p.payment_type = 'COCOA PAY'
);
-- 의미: 주문과 결제 테이블에서 COCOA PAY를 사용한 사용자가 있다면 그 놈을 제외한 사용자를 뽑아줘

-- Quiz
-- 3. 다음 빈칸에 들어갈 용어를 고르세요.
-- ① __________: 지정된 집합에 포함되는 대상을 찾음
-- ② __________: 별칭을 지정하는 키워드로, 생략하고 사용할 수 있음
-- ③ __________: 지정된 집합의 모든 요소와 비교 연산을 수행해 하나라도 만족하는 대상을 찾음
-- ④ __________: 지정된 집합의 모든 요소와 비교 연산을 수행해 모두를 만족하는 대상을 찾음
-- ⑤ __________: 서브쿼리를 입력받아 서브쿼리가 하나 이상의 행을 반환할 경우 TRUE, 그렇지 않으면 FALSE 반환

-- (ㄱ) AS
-- (ㄴ) ANY
-- (ㄷ) IN
-- (ㄹ) ALL
-- (ㅁ) EXISTS

-- 정답: (1) IN, (2) AS, (3) ANY, (4) ALL (5) EXISTS