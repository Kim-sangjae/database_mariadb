-- SELECT : 특정 테이블에서 원하는 데이터 조회

-- 단일 열 데이터 검색
SELECT menu_name FROM tbl_menu;

-- 여러 열 데이터 검색
SELECT 
		menu_name,
		menu_price,
		menu_code 
	FROM tbl_menu;

-- 전체컬럼  데이터 검색
SELECT * 
  FROM tbl_menu;
  
  
-- 단독 select 문 사용

-- 연산자 테스트
SELECT 7 + 3 AS '합';
SELECT 7 - 4 AS '빼기';

-- 내장 함수 테스트
SELECT NOW();
SELECT CONCAT('홍',' ',"길동");



-- 컬럼에 별칭 부여 (AS)
SELECT NOW() AS 현재시간;
SELECT CONCAT("홍" , ' ' , "길동") AS "성 띄고 이름";
  


