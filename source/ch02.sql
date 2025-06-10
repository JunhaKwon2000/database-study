-- 주석
-- 쿼리 설명을 위한 코드(실행되지 않음)
-- 한 줄 주석
# 또 다른 한 줄 주석
/*
블록 주석
여러 줄 주석
*/

-- 쿼리(query)란? '문의하다', '질문하다'라는 뜻
-- 예: 데이터베이스에 사용자가 원하는 특정 데이터를 보여달라고 요청하는 것
-- 쿼리는 SQL을 이용해 하나의 명령문으로 작성
-- 하나의 쿼리는 하나의 ;(세미콜론)으로 구분
SELECT 'Hello Wordl!'; -- 쿼리문이라고 부름

/*
권장 SQL 작성
대문자: MySQL 키워드
소문자: 사용자가 직접 만든 변수
*/

/*
2. e데이터 생성, 조회, 수정, 삭제하기
2.1 데이터 CRUD
*/
-- CRUD란? DB가 제공하는 기본 동작으로
-- 생성(CREATE)
-- 조회(READ)
-- 수정(UPDATE)
-- 삭제(DELETE)

-- CRUD 실습
-- 맥도날드 DB 실습

/*
2.2 데이터베이스 만들기
*/
-- 데이터베이스 목록 조회
SHOW DATABASES;
-- MySQL 설치 시 기본적으로 깔려있는 시스템 데이터베이스
-- (MySQL 서버 운영 유지 관리에 중요한 역할, 우리가 건드릴 일 없음)

-- 데이터베이스 생성
-- CREATE DATABASE 데이터베이스이름;
CREATE DATABASE mapdonalds;

-- 데이터베이스 진입(접속)
-- USE 데이터베이스이름;
USE mapdonalds;

-- 현재 사용 중인 DB 조회;
SELECT DATABASE();

-- 데이터베이스 삭제
-- DROP DATABASE 데이터베이스이름;
DROP DATABASE mapdonalds;

-- Quiz
-- 1. 다음 설명 중 옳지 않은 것은?
-- ① 데이터 CRUD란 데이터를 생성(Create), 조회(Read), 수정(Update), 삭제(Delete)하는 것을 말한다. 
-- ② 쿼리란 데이터베이스에 내릴 명령을 SQL 문으로 작성한 것이다.
-- ③ 쿼리는 하나의 ;(세미콜론)으로 구분한다.
-- ④ MySQL은 쿼리의 대소문자를 구분한다.
-- ⑤ 주석은 쿼리 실행에 영향을 미치지 않는다.

-- 정답: 4


/*
2.3 데이터 삽입 및 조회하기
*/
-- 실습: 맥도날드 DB에 버거 테이블을 만들고, 다음 데이터를 삽임 및 조회

-- Quiz: 다시 mapdonalds DB 생성 및 진입
CREATE DATABASE mapdonalds;
USE mapdonalds;

-- 테이블 생성
-- CREATE TABLE 테이블명 (
-- 	컬럼명1 자료형1,
-- 	컬럼명2 자료형2,
-- 	...
-- 	PRIMARY KEY (컬럼명)
-- );
CREATE TABLE burgers (
	id INT, -- 아이디(정수: -1, 0, 1, 2, ...)
    name VARCHAR(50), -- 이름(최대 50글자의 문자: '빅맥', '상하이 치즈 버거', ...)
    -- VARCHAR(N): 문자를 최대 N자리까지 저장, 문법상 필수(가변 길이 타입이라 저장될 수 있는 최대 길이의 제한을 알아야 하기 때문)
    price INT, -- 가격(정수: 원)
    gram INT, -- 무게(정수: g)
    kcal INT, -- 열량(정수: kcal)
    protein INT, -- 단백질량(정수: g)
    PRIMARY KEY (id) -- 기본키 지정: id
);
-- 기본키: 레코드(row)를 대표하는 컬럼(예: 사람의 주민등록번호)
-- 테이블에 저장된 모든 버거를 구분하기 위한 컬럼
-- 중복되지 않은 값을 가짐

-- 테이블 구조 조회
-- DESC 테이블명;
DESC burgers; -- burgers 테이블의 구조를 설명해줘







-- 단일 데이터 삽입하기
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ...) 
-- VALUES (입력값1, 입력값2, ...);
-- 컬럼 순서에 맞게 값 입력