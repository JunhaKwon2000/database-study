-- 셀프체크
-- 8장에서 만든 market DB를 토대로 다음 1~4를 수행하는 쿼리를 작성하세요.
-- (ch08_09_market_db.png 참고)

USE market;

-- 1 다음은 모든 사용자 수를 세는 쿼리입니다. 
-- 이를 SELECT 절의 서브쿼리로 활용해 전체 사용자의 1인당 평균 결제 금액을 조회하세요.
SELECT COUNT(*)
FROM users;

-- ------------------
-- 1인당 평균 결제 금액
-- ------------------
-- 41790.0000

-- 정답: 
SELECT SUM(price * count) / (SELECT COUNT(*) FROM users) AS '1인당 평균 결제 금액'
FROM order_details od JOIN products p ON od.product_id = p.id
JOIN orders o ON od.order_id = o.id AND o.status = '배송 완료';


-- 2 다음은 사용자 아이디별로 총 결제 금액을 집계하는 쿼리입니다.
-- 이를 FROM 절의 서브쿼리로 활용해 전체 사용자의 1인당 평균 결제 금액을 조회하세요.
SELECT u.id AS user_id, SUM(amount) AS total_amount
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN payments p ON o.id = p.order_id
GROUP BY u.id;

-- ------------------
-- 1인당 평균 결제 금액
-- ------------------
-- 41790.0000

-- 정답:
SELECT AVG(total_amount) AS '1인당 평균 결제 금액'
FROM (
	SELECT u.id AS user_id, SUM(amount) AS total_amount
	FROM users u
	JOIN orders o ON u.id = o.user_id
	JOIN payments p ON o.id = p.order_id
	GROUP BY u.id
) sub;


-- 3 앞의 두 문제(1과 2)의 정답 쿼리를 실행하면 다음과 같이 동일한 결과가 나옵니다. 그 이유를 설명하세요.
-- ------------------
-- 1인당 평균 결제 금액
-- ------------------
-- 41790.0000

-- 정답: 
-- 첫번째 쿼리는 FROM 절에서 테이블을 모두 조인으로 연결한 다음 총액을 구하고 서브쿼리로 유저의 수를 가져옴
-- 두번쨰 쿼리는 FROM 절에서 서브 쿼리를 써서 미리 유저 아이디로 그룹화한 뷰를 썼고, 총액을 구하고 뷰의 행의 개수의 수 = 유저의 수를 이용함
-- 두 쿼리 모두 결과는 같은, 단지 어디에 서브쿼리를 두는지 차이가 날 뿐

-- 진짜 정답: 모든 사용자가 결제에 참여했기 때문
-- 1은 결제에 참여하지 않은 전체 인원으로 집계 (결제 총액을 전체 유저 수로 나눔, 이건 만약 결제를 안한 유저가 있다면 이슈가 됨)
-- 2는 애초에 결제한 사람들만 가지고 FROM 절로 들어옴
-- 모든 유저가 결제를 진행했기 때문에 값이 동일한 거임!

-- 4 다음은 최근에 배송받은 사용자의 아이디를 찾는 쿼리입니다.
-- 이를 WHERE 절의 서브쿼리로 활용해 해당 사용자의 총 결제 금액을 조회하세요.
SELECT user_id
FROM orders
WHERE status = '배송 완료'
ORDER BY created_at DESC
LIMIT 1;

-- 정답:
SELECT u.nickname AS '유저', SUM(p.amount) AS '총 결제 금액'
FROM users u JOIN orders o ON u.id = o.user_id
JOIN payments p ON p.order_id = o.id
WHERE u.id = (
	SELECT user_id
	FROM orders
	WHERE status = '배송 완료'
	ORDER BY created_at DESC
	LIMIT 1
)
GROUP BY u.nickname;