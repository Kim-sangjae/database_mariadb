CREATE DATABASE book_rental_system;
USE book_rental_system;
-- GRANT ALL PRIVILEGES ON book_rental_system.* TO 'practice'@'%';
-- 
-- 사용자 정보 테이블
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,  -- 사용자 ID 
    username VARCHAR(50) NOT NULL,           -- 사용자 이름 
    password VARCHAR(255) NOT NULL,          -- 비밀번호 (암호화 저장 권장)
    email VARCHAR(100) UNIQUE NOT NULL,      -- 이메일 
    role ENUM('admin', 'user') DEFAULT 'user',  -- 사용자 역할 (관리자 / 일반 사용자)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 계정 생성 시간
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 마지막 업데이트 시간
    is_deleted ENUM('Y', 'N') DEFAULT 'N'  -- 계정 삭제 여부 
);

-- 도서 정보 테이블
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,  -- 도서 ID 
    title VARCHAR(255) NOT NULL,             -- 도서 제목
    author VARCHAR(100) NOT NULL,            -- 저자
    available ENUM('Y', 'N') DEFAULT 'Y',    -- 대여 가능 여부
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 도서 등록 시간
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 마지막 업데이트 시간
    is_deleted ENUM('Y', 'N') DEFAULT 'N'  -- 도서 삭제 여부 
);

-- 대여 기록 테이블 (한 번의 대여 건을 대표)
CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,  -- 대여 기록 ID 
    user_id INT,  -- 대여한 사용자 ID (users 테이블 참조)
    rental_date DATE DEFAULT CURDATE(),  -- 대여일
    due_date DATE,  -- 반납 예정일
    return_date DATE,  -- 실제 반납일 (NULL이면 미반납)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 대여 기록 생성 시간
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 마지막 업데이트 시간
    is_deleted ENUM('Y', 'N') DEFAULT 'N',  -- 대여 기록 삭제 여부 
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 대여 도서 매핑 테이블 (대여 건별 여러 도서 연결)
CREATE TABLE rental_books (
    rental_book_id INT AUTO_INCREMENT PRIMARY KEY,  -- 개별 대여 도서 매핑 ID
    rental_id INT,  -- 대여 ID (rentals 테이블 참조)
    book_id INT,  -- 도서 ID (books 테이블 참조)
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- 벌금 정보 테이블
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,  -- 벌금 ID 
    rental_id INT,  -- 해당 벌금이 발생한 대여 기록 ID (rentals 테이블 참조)
    fine_amount DECIMAL(10,2) DEFAULT 0.00,  -- 벌금 금액
    paid ENUM('Y', 'N') DEFAULT 'N',  -- 벌금 납부 여부 (Y: 납부 완료, N: 미납)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 벌금 기록 생성 시간
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- 마지막 업데이트 시간
    is_deleted ENUM('Y', 'N') DEFAULT 'N',  -- 벌금 기록 삭제 여부 
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);

-- 연체 기간별 벌금 기준 테이블
CREATE TABLE fine_rates (
    rate_id INT AUTO_INCREMENT PRIMARY KEY,  -- 벌금 기준 ID 
    min_days INT NOT NULL,  -- 최소 연체 일수 (해당 구간 시작)
    max_days INT,  -- 최대 연체 일수 (해당 구간 종료)
    daily_fine DECIMAL(10,2) NOT NULL  -- 해당 기간에 적용될 1일당 벌금 금액
);


