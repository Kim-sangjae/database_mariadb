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
		menu_code * menu_price AS '코드*가격'
	FROM tbl_menu
	ORDER BY menu_code * menu_price;