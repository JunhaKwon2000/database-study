-- DB 만들기
CREATE DATABASE library_project;

-- 테이블 만들기
CREATE TABLE book (
	isbn CHAR(13),
	type ENUM('소설', '시') NOT NULL,
    price INT NOT NULL,
    PRIMARY KEY (isbn)
);

-- 확인용
SELECT * FROM book;