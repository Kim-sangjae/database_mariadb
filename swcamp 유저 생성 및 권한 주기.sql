-- 주석
show databases; :  현재 있는 데이터 베이스들 조회

-- 계정 생성

-- swcamp 라는 이름과 swcamp 라는 패스워드로 새 계정 생성
CREATE USER 'swcamp'@'%'IDENTIFIED BY 'swcamp'; -- % : 외부에서의 접속을 허용한다.

-- 사용할 데이터베이스 선택
USE mysql;

-- 계정 생성 여부 확인
SELECT * FROM user;

-- 새 데이터베이스 생성
CREATE DATABASE menudb;
SHOW DATABASES;



-- 계정 권환 확인
SHOW GRANTS FOR 'swcamp'@'%';


-- swcamp 계정에게 menudb 사용 권한 부여
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';