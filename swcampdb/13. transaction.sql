-- 11. transaction 트랜잭션
-- 데이터베이스에서 한번에 수행되는 작업의 단위


-- mysql은 기본적으로 auto commit 설정이 되어 있으므로 변경한 뒤 테스트할 것
SET autocommit = 1;   -- 활성화
SET autocommit = ON;  -- 활성화
SET autocommit = 0;   -- 비활성화
SET autocommit = OFF; -- 비활성화


START TRANSACTION; -- 트랙잭션 시작을 알린다


SELECT * FROM tbl_menu;
INSERT INTO tbl_menu VALUES ( NULL, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 이름' WHERE menu_code = 5;

-- 트랜잭션 rollback
ROLLBACK;

-- 트랜잭션 commit
COMMIT;

-- commit 이후에 rollback 실행하면 마지막 commit 시점으로 돌아간다
ROLLBACK;

SELECT * FROM tbl_menu;