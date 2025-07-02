-- maven_project 데이터베이스 생성
CREATE DATABASE maven_project CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- 생성된 데이터베이스 사용
USE maven_project;

-- 회원(member) 테이블 생성
CREATE TABLE member (
    member_no INT AUTO_INCREMENT PRIMARY KEY,
    member_id VARCHAR(50),
    member_pw VARCHAR(100)
);

-- 게시판(board) 테이블 생성
CREATE TABLE board (
	board_no INT AUTO_INCREMENT PRIMARY KEY,
  board_title VARCHAR(100) NOT NULL,
  board_content TEXT,
  board_writer INT NOT NULL,
  reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  mod_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 첨부파일(attach) 테이블 생성
CREATE TABLE attach (
  attach_no INT AUTO_INCREMENT PRIMARY KEY,
  board_no INT NOT NULL,                         
  ori_name VARCHAR(255) NOT NULL,           
  re_name VARCHAR(255) NOT NULL,             
  reg_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);