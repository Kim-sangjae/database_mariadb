-- 13. DDL (데이터 정의 언어)
-- 데이터베이스의 스키마를 정의하거나 수정

-- 1. create : 테이블 생성
CREATE TABLE tb (
pk INT PRIMARY KEY,
fk INT,
col1 VARCHAR(255),
CHECK(col1 IN('Y','N'))
);


-- 테이블 구조 확인 명령어
DESCRIBE tb;
DESC tb;


-- 생성할때 조건사항을 추가해서 쓸 수도 있다
-- IF NOT Exists
CREATE TABLE IF NOT Exists tb (
pk INT PRIMARY KEY,
fk INT,
col1 VARCHAR(255),
CHECK(col1 IN('Y','N'))
);




-- insert
INSERT INTO tb VALUES (1,10,'Y');
SELECT * FROM tb;


-- auto_increment
CREATE TABLE tb2 (
    pk INT AUTO_INCREMENT PRIMARY KEY,
    fk INT,
    col1 VARCHAR(255),
    CHECK(col1 IN ('Y', 'N'))
) ;

-- insert
INSERT INTO tb2 VALUES (null, 10, 'Y');





-- 2-1. alter : 테이블을 변경 수정 삭제
ALTER TABLE tb2
ADD col2 INT NOT NULL;
DESC tb2;

SELECT * FROM tb2;

-- 2-2 열 이름 및 데이터 형식 변경
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

DESC tb2;

-- 2-3 열 삭제
ALTER TABLE tb2
DROP COLUMN col2;

DESC tb2;



-- 2-4 제약조건 추가 및 제거
-- pk 제약 조건은 auto_increment가 설정 된 상태로 제거 불가능
-- pk 컬럼의 정의를 먼저 수정하고 제거 시도
ALTER TABLE tb2
MODIFY pk INT; -- modify : 컬럼 재정의

ALTER TABLE tb2
DROP PRIMARY KEY; -- pk키 삭제

DESC tb2;

-- 삭제 되었던 제약 조건 다시 추가
ALTER TABLE tb2
ADD PRIMARY KEY(pk); -- pk키 추가

DESC tb2;





-- drop : 테이블 삭제
DROP TABLE if Exists tb2;
DROP TABLE if EXISTS tb, tb2, tb3; -- if Exists 조건을 걸어서 테이블에 없어도 오류가 안난다



-- 4. truncate : 테이블을 drop해서 날린 후  테이블을 재생성한다 
-- 논리적으로는 delete 구문과 차이가 없어보이지만
-- drop 이후 테이블을 재생성 해주는 구문이다
-- delete from 테이블로 모든행을 제거하는것보다 성능적으로 좋다
SELECT * FROM tb;
TRUNCATE tb;




