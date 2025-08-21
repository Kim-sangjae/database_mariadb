-- 17. index : 데이터 검색 속도 향상
CREATE TABLE phone (
phone_code INT PRIMARY KEY,
phone_name VARCHAR(100),
phone_price DECIMAL(10,2)
);

INSERT INTO phone
VALUES 
(1, 'galaxyS23',120000),
(2, 'galaxyS24',130000),
(3, 'galaxyS25',140000);

-- 인덱스 없는 상태에서 확인한 실행 계획은
-- type : ALL로 풀스캐을 하는 계획
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS24';


-- phone_name 컬럼에 인덱스 생성
CREATE INDEX idx_name ON phone(phone_name);


-- 인덱스 생성 후 확인 한 실행계획
-- type : ref, idx_name indexx 를 이용하는 계획으로 변경 됨
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS24';


-- 인덱스 조회 ( 특정 테이블 )
SHOW INDEX FROM phone;

-- 인덱스 조회 ( 데이터베이스 스키마에 존재하는 인덱스 조회 )
SELECT * FROM information_schema.STATISTICS 
WHERE table_schema = 'menudb';



-- 인덱스에 해당하는 컬럼 값이 변화하면 인덱스도 변화(재정렬) 해야함
-- 인덱스 최적화
ALTER TABLE phone DROP INDEX idx_name;
ALTER TABLE phone ADD INDEX idx_name(phone_name);
OPTIMIZE TABLE phone;