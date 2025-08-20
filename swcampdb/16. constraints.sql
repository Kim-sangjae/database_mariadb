-- 14. constraints (제약조건)
-- 테이블에 데이터가 입력되거나 수정 될 떄의 규칙
-- 데이터베이스 무결성보장을 위해 필요

-- 1. not null : null 값을 허용하지 않는다.
-- 컬럼 레벨의 제약조건 (컬럼 옆에 제약조건을 건다)
CREATE TABLE if NOT EXISTS user_notnull (
 user_no INT NOT NULL,
 user_id VARCHAR(255) NOT NULL,
 user_pw VARCHAR(255) NOT NULL,
 user_name VARCHAR(255) NOT NULL,
 gender VARCHAR(3),
 phone VARCHAR(255) NOT NULL,
 email VARCHAR(255)
 );
 
 
-- insert test (정상)
INSERT INTO user_notnull
VALUES ( 1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' );

SELECT * FROM user_notnull;

-- insert test2 (notnull 제약 확인)
INSERT INTO user_notnull
VALUES ( 
1 , 'NULL' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' 
);




-- 2. unique : 중복 값을 허가하지 않는다
-- 컬럼 레벨의 제약조건 (컬럼 옆에 제약조건을 건다)
CREATE TABLE if NOT EXISTS user_unique (
 user_no INT NOT NULL UNIQUE,
 user_id VARCHAR(255) NOT NULL,
 user_pw VARCHAR(255) NOT NULL,
 user_name VARCHAR(255) NOT NULL,
 gender VARCHAR(3),
 phone VARCHAR(255) NOT NULL,
 email VARCHAR(255)
 );
 
 
-- insert test (정상)
INSERT INTO user_unique
VALUES ( 1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' );

SELECT * FROM user_unique;
DESC user_unique;


-- insert test2 (unique 제약 확인)
INSERT INTO user_unique
VALUES ( 
1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' 
);





-- 3. primary key : 테이블의 식별자 역할 (한 행을 구분한다)
-- not null + unique
-- 한 테이블당 하나만 설정 가능
-- 테이블레벨로 제약조건을 걸면 여러개의 키를 묶어서 pk로 만들수도있다 (복합키)
CREATE TABLE if NOT EXISTS user_primarykey (
 user_no INT,
 user_id VARCHAR(255) NOT NULL,
 user_pw VARCHAR(255) NOT NULL,
 user_name VARCHAR(255) NOT NULL,
 gender VARCHAR(3),
 phone VARCHAR(255) NOT NULL,
 email VARCHAR(255),
 PRIMARY KEY(user_no) -- 테이블 레벨에 제약조건 (not null은 테이블 레벨 불가)
 );
 
 
-- insert test (정상)
INSERT INTO user_primarykey
VALUES ( 1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' );

SELECT * FROM user_primarykey;
DESC user_primarykey;


-- insert test2 (unique 제약 확인)
INSERT INTO user_primarykey
VALUES ( 
1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' 
);





-- 4. foreign key(외래키) : 참조 제약조건 (참조 무결성 위해바지 않도록)

-- 회원 등급 (참조 대상 테이블)
CREATE TABLE if NOT EXISTS user_grade (
grade_code INT UNIQUE,
grade_name VARCHAR(255) NOT NULL
);

INSERT INTO user_grade
VALUES ( 10 , '일반회원'), (20, '우수회원') , ( 30, '특별회원');

SELECT * FROM user_grade;


-- 회원 정보 ( 회원 등급을 참조 , fk 설정할 테이블)
CREATE TABLE if NOT EXISTS user_foreignkey (
 user_no INT,
 user_id VARCHAR(255) NOT NULL,
 user_pw VARCHAR(255) NOT NULL,
 user_name VARCHAR(255) NOT NULL,
 gender VARCHAR(3),
 phone VARCHAR(255) NOT NULL,
 email VARCHAR(255),
 grade_code INT,
 PRIMARY KEY(user_no), -- 테이블 레벨에 제약조건 (not null은 테이블 레벨 불가)
 FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
 );
 
-- insert (정상)
 INSERT INTO user_foreignkey
VALUES ( 
1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' ,10
);
-- insert (fk 제약오류)
 INSERT INTO user_foreignkey
VALUES ( 
2 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' ,40
);

-- insert(null 값은 가능)
 INSERT INTO user_foreignkey
VALUES ( 
2 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' ,null
);

SELECT * FROM user_foreignkey;



-- user_grade 테이블에서 행 삭제
-- 부모 테이블에서 참조되고 있는 행은 삭제,수정 불가
DELETE
	FROM user_grade
	WHERE grade_code = 10;


-- fk 삭제룰 변경해서 적용
-- 컬럼 레벨에서 조건을 걸 때도 똑같이 적으면 가능하다
-- grade_code INT foreign key REFERENCES user_grade(grade_code) ON UPDATE SET NULL ON DELETE SET NULL

CREATE TABLE if NOT EXISTS user_foreignkey2 (
 user_no INT,
 user_id VARCHAR(255) NOT NULL,
 user_pw VARCHAR(255) NOT NULL,
 user_name VARCHAR(255) NOT NULL,
 gender VARCHAR(3),
 phone VARCHAR(255) NOT NULL,
 email VARCHAR(255),
 grade_code INT,
 PRIMARY KEY(user_no), -- 테이블 레벨에 제약조건 (not null은 테이블 레벨 불가)
 FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
 ON UPDATE SET NULL ON DELETE SET NULL
 -- 수정 및 삭제시 null값으로 변경
 
 -- on update set cascade on delete set cascade
 -- 수정 및 삭제 시 함께 삭제[
 );
 

INSERT INTO user_foreignkey2
VALUES ( 
1 , 'user01' , 'pass01' , '홍길동' , '남' , '010-1234-5678' , 'hong@gmail' ,10
);
 
SELECT * FROM user_foreignkey2;

-- 전에 만들었던 테이블 설정 떄문에 삭제 불가능 하므로 전 테이블 삭제
DROP TABLE user_foreignkey; 


-- 삭제시 참조하고있는 데이터는 null 값으로 변경
DELETE
	FROM user_grade
	WHERE grade_code = 10;
	
	

-- 5. check 제약조건
CREATE TABLE if NOT EXISTS user_check  (
user_no INT AUTO_INCREMENT PRIMARY KEY,
user_name VARCHAR(255) NOT NULL,
gender VARCHAR(3) CHECK (gender IN ('남','여')),
age INT CHECK(age >= 19)
);

-- insert 테스트 ( 정상 )
INSERT INTO user_check
VALUES ( NULL , '홍길동' , '남', 20);

-- insert 테스트 (check 제약)
INSERT INTO user_check
VALUES ( NULL , '홍길동' , '남자', 20); -- gender 체크 오류
INSERT INTO user_check
VALUES ( NULL , '홍길동' , '남', 15); -- age 체크 오류

SELECT * FROM user_check;



-- 6. default : 컬럼에 null값 대신 기본값을 적용할 수있다.
-- 제약 조건 은 아니다
CREATE TABLE tbl_country (
country_code INT AUTO_INCREMENT PRIMARY KEY,
country_name varchar(255) DEFAULT '한국',
population VARCHAR(255) DEFAULT '0명',
add_day DATE DEFAULT (CURRENT_DATE),
add_time DATETIME DEFAULT (CURRENT_TIME)
);

INSERT INTO tbl_country
VALUES ( NULL , DEFAULT , default , DEFAULT , DEFAULT );

SELECT * FROM tbl_country;
DESC tbl_country;