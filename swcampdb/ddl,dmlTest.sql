-- DDL / DML TEST
-- Q1.
CREATE TABLE team_info (
team_code INT AUTO_INCREMENT PRIMARY KEY COMMENT '소속코드',
team_name VARCHAR(100) NOT NULL COMMENT '소속명',
team_detail VARCHAR(500) COMMENT '소속상세정보',
use_yn CHAR(2) DEFAULT 'Y' NOT NULL COMMENT '사용여부',
CHECK(use_yn IN ('Y','N'))
) ENGINE=INNODB COMMENT '소속정보';

DESC team_info;

CREATE TABLE member_info (
 member_code INT PRIMARY KEY AUTO_INCREMENT COMMENT '회원코드',
 member_name VARCHAR(70) NOT NULL COMMENT '회원이름',
 birth_date DATE COMMENT '생년월일',
 division_code CHAR(2) COMMENT '구분코드',
 detail_info VARCHAR(500) COMMENT '상세정보',
 dontact VARCHAR(50) NOT NULL COMMENT '연락처',
 team_code INT NOT NULL COMMENT '소속코드',
 active_status CHAR(2) NOT NULL DEFAULT('Y') COMMENT '활동상태',
 CHECK(active_status IN ('Y','N','H')),
 FOREIGN KEY(team_code) REFERENCES team_info(team_code)
) ENGINE=INNODB COMMENT '회원정보';

DESC member_info;


-- Q2.
-- 1.
INSERT INTO team_info 
VALUES (
DEFAULT ,'음악감상부','클래식 및 재즈 음악을 감상하는 사람들의 모임',DEFAULT 
);
INSERT INTO team_info 
VALUES (
DEFAULT ,'맛집탐방부','맛집을 찾아다니는 사람들의 모임','N' 
);
INSERT INTO team_info 
VALUES (
DEFAULT ,'행복찾기부',null,DEFAULT 
);

SELECT * FROM team_info;
SELECT * FROM member_info;

-- 2.
INSERT INTO member_info 
VALUES(
DEFAULT,'송가인','1990-01-30',1,'안녕하세요 송가인입니다~','010-9494-9494',1,'H'
);
INSERT INTO member_info 
VALUES(
DEFAULT,'임영웅','1992-05-03',null,'국민아들 임영웅입니다~','hero@trot.com',1,default
);
INSERT INTO member_info 
VALUES(
DEFAULT,'태진아',null,null,NULL,'(일급기밀)',3,default
);

SELECT * FROM member_info;

ALTER TABLE member_info CHANGE dontact contact VARCHAR(50);