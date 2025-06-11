/*
3, 데이터 필터링하기
3.1 데이터 필터링이란
*/
-- 무엇? 많은 데이터들 중에 원하는 데이터만 골라내는 작업
-- 주로 WHERE 절을 통해 특정 데이터를 추출

-- 예를 들어
-- (a) SELECT문: 데이터 조회
-- SELECT 컬럼명1, 컬럼명2, ...
-- FROM 테이블명
-- WHERE 조건;

-- (b) UPDATE문: 데이터 수정
-- UPDATE 테이블명
-- SET 컬럼명 = 입력값
-- WHERE 조건;

-- (c) DELETE문: 데이터 삭제
-- DELETE FORM 테이블명
-- WHERE 조건;

-- 실습 데이터 준비
-- 2장에서 만든 맵도날드 DB를 활용
-- DB 진입
USE mapdonalds;

-- burger 테이블 조회
SELECT * FROM burgers;

-- burgers 테이블 생성
CREATE TABLE burgers (
	id INTEGER, 		  -- 아이디(정수형 숫자)
	name VARCHAR(50), -- 이름(문자형: 최대 50자)
	price INTEGER, 		-- 가격(정수형 숫자)
	gram INTEGER, 		-- 그램(정수형 숫자)
	kcal INTEGER, 		-- 열량(정수형 숫자)
	protein INTEGER, 	-- 단백질량(정수형 숫자)
	PRIMARY KEY (id) 	-- 기본키 지정: id
);

-- burgers 데이터 삽입
INSERT INTO burgers (id, name, price, gram, kcal, protein)
VALUES
	(1, '빅맨', 5300, 223, 583, 27),
	(2, '베이컨 틈메이러 디럭스', 6200, 242, 545, 27),
	(3, '맨스파이시 상해 버거', 5300, 235, 494, 20),
	(4, '슈비두밥 버거', 6200, 269, 563, 21),
	(5, '더블 쿼터파운드 치즈', 7700, 275, 770, 50);
    
-- 모든 버거 조회
SELECT * FROM burgers;

-- 1) 비교 연산자
-- 두 값을 비교하는 연산 기호
-- WHERE 절에 사용하여 특정 데이터로 필터링 가능
-- 종류: =, !=, >, >=, <, <=

-- 가격이 5500원 보다 싼 버거 찾기
SELECT * FROM burgers WHERE price < 5500;

-- 가격이 5500원 보다 비싼 버거 찾기
SELECT * FROM burgers WHERE price > 5500;

-- 단백질량이 25g 보다 작은 버거 찾기
SELECT * FROM burgers WHERE protein < 25;

-- 2) 논리 연산자
-- 조건을 조합하거나 반전하여 새 조건을 만듦
-- 종류: AND, OR, NOT
-- 사용 예
-- 조건A AND 조건B: 조건A와 조건B를 동시에 만족하는 데이터 필터링(교집합)
-- 조건A OR 조건B: 조건A와 조건B 중 하나라도 만족하는 데이터 필터링(합집합)
-- NOT 조건A: 조건A를 만족하지 않는 데이터 필터링(여집합)

-- TRUE/FALSE의 논리 연산
-- TRUE(참: 1). FALSE(거짓: 0)
-- AND 연산: 둘 다 참이여야 참
SELECT TRUE AND TRUE; -- 1
SELECT TRUE AND FALSE; -- 0
SELECT FALSE AND TRUE; -- 0
SELECT FALSE AND FALSE; -- 0

-- OR 연산: 둘 중 하나만 참이면 참
SELECT TRUE OR TRUE; -- 1
SELECT TRUE OR FALSE; -- 1
SELECT FALSE OR TRUE; -- 1
SELECT FALSE OR FALSE; -- 0

-- 5500원 보다 싸고, 동시에 단백질량이 25g 보다 많은 버거
SELECT * FROM burgers 
WHERE price < 5500 AND protein > 25;

-- 5500원 보다 싸거나, 단백질량이 25g 보다 많은 버거
SELECT * FROM burgers 
WHERE price < 5500 OR protein > 25;

-- 단백질량이 25g 보다 많지 않은 버거
SELECT * FROM burgers
WHERE NOT (protein > 25); -- 혼동 방지를 위해 괄호를 명시하는 것도 좋음
-- WHERE !(protein > 25); -- MySQL에서만 작동
-- 가독성과 이식성을 위해서는 NOT을 사용하는 것이 가장 안전

-- 3) 산술 연산자
-- 사칙 연산 등을 위한 수학적 연산 기호
-- WHERE 절과 SELECT 절에서 사용 가능
SELECT 100 + 20, 100 - 20, 100 * 20, 100 / 20, 100 % 20;

-- 산술 연산자 활용 예
-- SELECT 문에서의 산술 연산 예시
SELECT *, ROUND((price / gram) * 100) AS 'price/100g' FROM burgers; -- ALIAS 에 특수문자, 공백 등이 들어가면 '' 로 묶어주세요("", `` 도 가능)
-- 100g당 가격을 계산하여 price/100g 이라는 별칭(ALIAS)으로 반환함

-- WHERE 절에서 산술 연산 예시
-- 가격에 10%를 더한 값이 6500원을 넘는 버거만 조회
SELECT * FROM burgers
WHERE (1.1 * price) > 6500;

-- 짝수 id를 가진 버거만 조회
SELECT * FROM burgers
WHERE id % 2 = 0;

-- UPDATE 문에서 산술 연산 예시
-- id가 5인 버거의 가격을 500원 인하
UPDATE burgers SET price = price - 500 
WHERE id = 5;

-- 4) 연산자의 우선순위
-- 어떤 연산자를 먼저 수행할 것인가의 기준
-- 우선순위가 높은 것부터 낮은 순으로 수행
-- 임기X(쓰다 보면 자연스럽게 익혀짐)
-- 애매하면 최우선 순위 ()를 사용

-- Quiz: 다음 쿼리의 수행 결과는?
SELECT 3 + 5 * 2; -- 13
SELECT (3 + 5) * 2; -- 16
SELECT TRUE OR TRUE AND FALSE; -- 1
SELECT (TRUE OR TRUE) AND FALSE; -- 0

-- Quiz
-- 1. 다음 빈칸에 들어갈 용어는? (입력 예: ㄱㄴㄷㄹㅁ)
-- ① __________: 테이블 조회 시 필터링 조건을 작성하기 위해 사용하는 명령 
-- ② __________: 같지 않음을 비교하는 연산자
-- ③ __________: 두 조건을 동시에 만족하는 논리 연산자
-- ④ __________: 두 조건 중 하나라도 만족하는 논리 연산자
-- ⑤ __________: 특정 조건을 만족하지 않는 논리 연산자

-- (ㄱ) AND
-- (ᄂ) !=
-- (ᄃ) NOT
-- (ᄅ) WHERE
-- (ᄆ) OR

-- 정답: (1) WHERE, (2) !=, (3) AND, (4) OR, (5) !

/*
3.2 데이터 필터링 실습: 대학 DB
*/

-- Quiz: 대학 DB 만들기
-- university DB 생성 및 진입
CREATE DATABASE university;
USE university;

-- students 테이블 생성
-- id: 아이디(정수형 숫자)
-- nickname: 닉네임(문자형: 최대 50자)
-- math: 수학 성적(정수형 숫자)
-- english: 영어 성적(정수형 숫자)
-- programming: 프로그래밍 성적(정수형 숫자)
-- 기본키 지정: id
CREATE TABLE students (
	id INT PRIMARY KEY,
    nickname VARCHAR(50),
    math INT,
    english INT,
    programming INT
);

-- students 데이터 삽입
INSERT INTO students
VALUES
	(1, 'Sparkles', 98, 96, 93),
	(2, 'Soldier', 82, 66, 98),
	(3, 'Lapooheart', 84, 70, 82),
	(4, 'Slick', 87, 99, 98),
	(5, 'Smile', 75, 73, 70),
	(6, 'Jellyboo', 84, 82, 70),
	(7, 'Bagel', 97, 91, 87),
	(8, 'Queen', 99, 100, 88);

-- 확인
SELECT * FROM students;