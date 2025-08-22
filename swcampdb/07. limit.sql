-- 05. limit : select 문의 결과 집합에서 반환할 행의 갯수 제한
-- limit 시작 , 끝
SELECT
		menu_code,
		menu_name,
		menu_price
		FROM tbl_menu
		ORDER BY menu_price;
		

SELECT
		menu_code,
		menu_name,
		menu_price
		FROM tbl_menu
		ORDER BY menu_price
		LIMIT 1 , 4;
-- limit offset , row_count
-- [OFFSET] :시작할 행의 번호(인덱스 0 부터 시작)
-- row_count : 이후 행부터 반환 할 갯수

-- offset(시작위치) 는 생략이 가능 row_count만 입력하면 top-n 행 반환
SELECT
		menu_code,
		menu_name,
		menu_price
		FROM tbl_menu
		ORDER BY menu_price
		LIMIT 5; -- 맨 위 부터 5개 반환