-- 16. view
-- select 문을 저장한 객체 (논리적 테이블, 가상 테이블)
-- 사용하는 이유? (1) 보안성 (2) 복잡한 구문을 간결화 

-- view 생성
CREATE VIEW hansik AS
SELECT  
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 4;
 
-- view 를 테이블처럼 사용
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- 베이스 테이블(tbl_menu)에서 데이터 변경 => view의 데이터도 변경 됨 
INSERT 
  INTO tbl_menu
VALUES (NULL, '식혜맛 국밥', 5500, 4, 'Y');
-- view(hansik) 에서 데이터 변경 => 베이스 테이블의 데이터도 변경 됨
INSERT 
  INTO hansik
VALUES (99, '수정과맛 국밥', 5500, 4, 'Y');

UPDATE hansik
   SET menu_name = '버터맛 국밥'
     , menu_price = 5700
 WHERE menu_code = 99;

DELETE 
  FROM hansik
 WHERE menu_code = 99;

-- view를 이용해서 DML 명령어 조작이 불가능한 경우
-- (1) 뷰 정의에 포함되지 않은 컬럼을 조작할 때
-- (2) 뷰에 포함 되지 않은 컬럼 중 베이스 테이블에 not null 조건이 있는 경우
-- (3) 산술 표현식이 정의 된 경우
-- (4) join을 이용해 여러 테이블을 연결한 경우
-- (5) distinct를 포함한 경우
-- (6) 그룹함수 또는 group by 등을 포함한 경우

-- view 생성 옵션
-- or replace
-- 동일한 이름의 뷰가 있다면 교체 (수정 시 사용 가능)
CREATE OR REPLACE VIEW hansik AS
SELECT  
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 4;
 
-- check option
-- 뷰를 통한 데이터 변경 시 뷰 정의 조건을 만족하지 않는 데이터는 
-- 추가/수정 불가하도록 제한하는 옵션 
CREATE OR REPLACE VIEW hansik_with_check AS
SELECT  
       menu_code
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu
 WHERE category_code = 4
  WITH CHECK OPTION;

-- check option 을 위반하는 예제
INSERT 
  INTO hansik_with_check
VALUES (100, '감자탕', 8000, 3, 'Y');	-- check option 위반으로 삽입 실패

INSERT 
  INTO hansik
VALUES (100, '감자탕', 8000, 3, 'Y');  -- check option 없어 삽입 됨

SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- check option을 위반하지 않는 경우 
INSERT 
  INTO hansik_with_check
VALUES (101, '곰탕', 8000, 4, 'Y');

SELECT * FROM hansik_with_check;
SELECT * FROM tbl_menu;

-- view 삭제
DROP VIEW hansik;
DROP VIEW hansik_with_check;
