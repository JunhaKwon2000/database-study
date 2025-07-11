-- quiz DB 에 이거 테이블이 있어서 충돌나서 여기로 옴긺
USE university;

-- 1. 서브쿼리 확인 문제

-- 문제 1
-- 서브쿼리에 대한 설명으로 옳은 것은 무엇입니까?

-- ① 하나의 SQL 문에서 다른 SQL 문을 중첩하여 사용하는 것
-- ② 여러 테이블을 결합하여 하나의 결과를 반환하는 것
-- ③ 특정 조건을 기준으로 데이터를 필터링하는 명령
-- ④ 쿼리 실행 결과를 정렬하는 방식

-- 정답: 1


-- 문제 2
-- 다음 중 서브쿼리를 사용할 수 없는 절은 무엇입니까?

-- ① SELECT 절
-- ② WHERE 절
-- ③ JOIN 절
-- ④ LIMIT 절

-- 정답: 4


-- 문제 3
-- 서브쿼리와 JOIN의 차이에 대한 설명으로 옳은 것은 무엇입니까?

-- ① 서브쿼리는 데이터를 결합하고, JOIN은 데이터를 필터링한다.
-- ② 서브쿼리는 독립적으로 실행되며, JOIN은 두 테이블 간의 관계를 결합한다.
-- ③ JOIN은 두 테이블 간의 모든 데이터를 결합하고, 서브쿼리는 특정 데이터를 필터링한다.
-- ④ JOIN은 임시 테이블을 생성하고, 서브쿼리는 모든 데이터를 반환한다.

-- 정답: 2


-- 문제 4
-- 다음 쿼리에서 서브쿼리가 반환하는 데이터는 무엇입니까?

SELECT name
FROM members
WHERE id IN (
	SELECT member_id
	FROM borrow_records
);

-- ① 회원의 이름을 포함한 모든 정보
-- ② 대출 기록에서 조회된 회원의 이름
-- ③ 대출 기록에서 조회된 회원 ID
-- ④ 대출 기록에서 조회된 도서 ID

-- 정답: 3


-- 문제 5
-- 다음 중 서브쿼리가 특정 절에서 사용되는 이유와 그 역할로 가장 적절한 것은 무엇입니까?

-- ① SELECT 절: 서브쿼리의 결과를 메인쿼리의 출력 값으로 계산하여 제공한다.
-- ② FROM 절: 서브쿼리의 결과를 임시 테이블처럼 활용하여 메인쿼리에서 참조한다.
-- ③ WHERE 절: 서브쿼리의 결과를 조건으로 사용하여 메인쿼리의 데이터를 필터링한다.
-- ④ HAVING 절: 그룹화된 데이터의 집계 결과를 조건으로 제한한다.
-- ⑤ 모두 맞다.

-- 정답: 5


-- 2. 서브쿼리 연습 문제

-- 회사 데이터베이스를 보고 문제에 답하세요.

-- 부서 테이블
CREATE TABLE departments (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(50) NOT NULL, -- 부서명
	location VARCHAR(50), -- 위치
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 직원 테이블
CREATE TABLE employees (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(50) NOT NULL, -- 직원명
	hire_date DATE NOT NULL, -- 입사 날짜
	salary INTEGER NOT NULL, -- 급여
	department_id INTEGER, -- 부서 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (departmen
    t_id) REFERENCES departments(id) -- 외래키 지정: department_id
);

-- 프로젝트 테이블
CREATE TABLE projects (
	id INTEGER AUTO_INCREMENT, -- id
	name VARCHAR(100) NOT NULL, -- 프로젝트명
	start_date DATE NOT NULL, -- 시작 날짜
	end_date DATE, -- 종료 날짜
	PRIMARY KEY (id) -- 기본키 지정: id
);

-- 직원-프로젝트 테이블 (다대다 관계)
CREATE TABLE employee_projects (
	id INTEGER AUTO_INCREMENT, -- id
	employee_id INTEGER NOT NULL, -- 직원 id
	project_id INTEGER NOT NULL, -- 프로젝트 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (employee_id) REFERENCES employees(id), -- 외래키 지정: employee_id
	FOREIGN KEY (project_id) REFERENCES projects(id) -- 외래키 지정: project_id
);

-- 급여 기록 테이블
CREATE TABLE salary_records (
	id INTEGER AUTO_INCREMENT, -- id
	salary_date DATE NOT NULL, -- 급여 지급 날짜
	amount INTEGER NOT NULL, -- 지급 금액
	employee_id INTEGER NOT NULL, -- 직원 id
	PRIMARY KEY (id), -- 기본키 지정: id
	FOREIGN KEY (employee_id) REFERENCES employees(id) -- 외래키 지정: employee_id
);

-- 더미 데이터
INSERT INTO departments (id, name, location) VALUES
(1, 'IT', 'Seoul'),
(2, 'HR', 'Busan'),
(3, 'Sales', 'Incheon');

INSERT INTO employees (id, name, hire_date, salary, department_id) VALUES
(1, 'Alice', '2020-01-01', 5000, 1),
(2, 'Bob', '2019-03-15', 6000, 1),
(3, 'Charlie', '2018-07-23', 4000, 2),
(4, 'David', '2021-05-10', 5500, 3),
(5, 'Eve', '2022-11-05', 4500, 1);

INSERT INTO projects (id, name, start_date, end_date) VALUES
(1, 'Project Alpha', '2023-01-01', '2023-12-31'),
(2, 'Project Beta', '2023-06-01', NULL),
(3, 'Project Gamma', '2022-03-01', '2022-10-01');

INSERT INTO employee_projects (id, employee_id, project_id) VALUES
(1, 1, 1), -- Alice - Alpha
(2, 1, 2), -- Alice - Beta
(3, 2, 1), -- Bob - Alpha
(4, 2, 2), -- Bob - Beta
(5, 2, 3), -- Bob - Gamma
(6, 3, 2), -- Charlie - Beta
(7, 4, 1), -- David - Alpha
(8, 5, 2); -- Eve - Beta

INSERT INTO salary_records (id, salary_date, amount, employee_id) VALUES
(1, '2024-01-01', 5000, 1),
(2, '2024-01-01', 6000, 2),
(3, '2024-01-01', 4000, 3),
(4, '2024-01-01', 5500, 4),
(5, '2024-01-01', 4500, 5),
(6, '2024-02-01', 5000, 1),
(7, '2024-02-01', 6000, 2),
(8, '2024-02-01', 4000, 3),
(9, '2024-02-01', 5500, 4),
(10, '2024-02-01', 4500, 5);

-- 문제에서 주어진 조건은 참고만 하되 너무 복잡하다면 다르게 짜도 상관없습니다!!
-- 같은 결과에 대해서도 다양한 답이 나올수 있음

-- 문제 1: SELECT 절에서의 서브쿼리
-- 각 직원의 이름과 참여 중인 프로젝트 수를 조회하세요.

-- 정답:
SELECT name AS '이름', COUNT(project_id) AS '프로젝트 수' 
FROM employees LEFT JOIN employee_projects ep ON e.id = ep.employee_id
GROUP BY e.id, name; -- 동명이인이 있을 수 있기 때문에 id 로도 함께 묶어줌, 프로젝트에 참여하지 않는 사람도 있을 수 있기에 LEFT JOIN 해줌

SELECT name, (SELECT COUNT(*) FROM employee_projects ep WHERE ep.employee_id = e.id)
FROM employees e;

SELECT e.name
FROM employee_projects ep JOIN employees e ON e.id = ep.employee_id
GROUP BY e.id;

-- 문제 2: WHERE 절에서의 서브쿼리
-- 특정 부서(예: IT 부서)의 직원 이름을 조회하세요.

-- 정답: 
SELECT name 
FROM employees
WHERE department_id = (
	SELECT id
    FROM departments
    WHERE name = 'IT'
);


-- 문제 3: FROM 절에서의 서브쿼리
-- 부서별 직원 수를 조회하세요.

-- 정답: 
SELECT d.name AS 부서, total_num AS '직원 수'
FROM (
	SELECT department_id, COUNT(*) AS total_num
    FROM employees
    GROUP BY department_id
) sub JOIN departments d ON d.id = sub.department_id;
-- 나중에 JOIN 으로 짤 때 LEFT JOIN, COUNT(컬럼명) 등으로 직원이 없는 부서도 출력해주세요

SELECT de.na, COUNT(*) AS '직원 수'
FROM (
	SELECT d.name as na
    FROM employees e
    JOIN departments d ON d.id = e.department_id
) AS de
GROUP BY de.na;


-- 문제 4: JOIN 절에서의 서브쿼리
-- 가장 높은 급여를 받은 직원의 이름과 급여를 조회하세요.

-- 정답: 
SELECT sub.name AS 이름, sub.max_salary AS 급여
FROM (
	SELECT name, MAX(amount) AS max_salary
    FROM employees e JOIN salary_records sr ON e.id = sr.employee_id
    GROUP BY name
    ORDER BY max_salary DESC LIMIT 1
) sub JOIN employees e ON e.name = sub.name;
-- MAX() 함수의 존재를 잊고있었네!


-- 문제 5: HAVING 절에서의 서브쿼리
-- 부서별 평균 급여가 전체 평균 급여 이상인 부서명을 조회하세요.

-- 정답:
SELECT d.name AS 부서, AVG(salary) AS 평균급여
FROM departments d JOIN employees e ON e.department_id = d.id
GROUP BY d.name
HAVING AVG(salary) >= (
	SELECT AVG(salary)
    FROM employees
);


-- 문제 6: 복합 조건을 조합한 서브쿼리
-- 가장 많은 직원이 참여한 프로젝트명을 조회하세요.

-- 정답:

SELECT name AS 프로젝트명
FROM projects
WHERE id = (
	SELECT project_id
	FROM employee_projects
	GROUP BY project_id
	ORDER BY count(*) DESC LIMIT 1
);

-- 선생님 쿼리문 보기!!!