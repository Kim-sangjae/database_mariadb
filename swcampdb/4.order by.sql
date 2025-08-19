-- order by : 결과 집합을 기준에 따라 정렬

-- 메뉴가격 오름차순 , 내림차순
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
ORDER BY menu_price DESC;




-- 메뉴 가격이 같을 경우 메뉴명으로 추가 정렬
SELECT
		menu_code,
		menu_name,
		menu_price
	FROM tbl_menu
	ORDER BY menu_price desc , menu_name;
	
	

-- 연산 결과로 정렬
SELECT
		menu_code,
		menu_name,
		menu_price,
		menu_code * menu_price AS '연산결과'
	FROM tbl_menu
	ORDER BY 연산결과;
	
	
	
-- field 내장 함수
SELECT FIELD ('A', 'A', 'B', 'C');
SELECT FIELD ('B', 'A', 'B', 'C');
SELECT FIELD ('C', 'A', 'B', 'C');


-- field 내장 함수를 order by절에서 사용
-- 숫자 크기나 문자 순서와 무관하게 특정한 값을 우선적으로 정렬하는 용도
SELECT
	menu_name,
	orderable_status,
	FIELD(orderable_status, 'N' , 'Y')
	FROM tbl_menu
	ORDER BY FIELD(orderable_status , 'N','Y');
	
	

	
-- null 값을 포함한 정렬
-- 오름차순 시 null값이 처음으로 정렬 (default)
SELECT
		category_code,
		category_name,
		ref_category_code
	FROM tbl_category
-- 	ORDER BY ref_category_code;
-- 	ORDER BY ref_category_code asc;
-- 	ORDER BY ref_category_code desc;
-- 	ORDER BY -ref_category_code asc;
	ORDER BY -ref_category_code desc;