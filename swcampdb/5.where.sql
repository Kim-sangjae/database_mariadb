-- WHERE : 특정 조건에 맞는 레코드(행)만 선택하기 위한 문

-- 1. 비교 연산자
-- 값이 일치하는지 확인(=)
SELECT
	menu_code,
	menu_name
	FROM tbl_menu
	WHERE orderable_status='Y';
	
-- 값이 일치 하지 않는 것 (!+ , <>)
SELECT
	menu_code,
	menu_name
	FROM tbl_menu
	WHERE orderable_status <> 'Y';


-- 값의 크기 비교 ( > , < , >= , <= )
SELECT
		menu_name,
		menu_price
	FROM tbl_menu
	WHERE menu_price > 13000;
	



-- 2. 논리 연산자 (and/or  &&/||)

-- A and B : A B 모두 만족하면 true
SELECT
		*
	FROM tbl_menu
	WHERE orderable_status = 'Y'
	and category_code = 10;


-- A or B : A 또는 B 둘중하나 만족하면 true
SELECT
		*
	FROM tbl_menu
	WHERE orderable_status = 'Y'
	or category_code = 4;
	
	

-- 우선순위 and > or 
-- 우선순위를 변경하고 싶다면 괄호를 사용한다
SELECT
		*
	FROM tbl_menu
	WHERE category_code = 4
	OR menu_price = 9000
	AND menu_code >10;
	
SELECT
		*
	FROM tbl_menu
	WHERE (category_code = 4
	OR menu_price = 9000)
	AND menu_code >10;
	
	


-- 3. between A and B ( 사이값 구하기 A 이상 B 이하 )
SELECT
		*
		FROM tbl_menu
		WHERE menu_price BETWEEN 10000 AND 25000;
	


-- NOT : 부정연산자
SELECT
		*
		FROM tbl_menu
		WHERE menu_price NOT BETWEEN 10000 AND 25000;
		



-- 4. like : 문자 검색 ( % 사용하여 문자위치 지정 )
-- like% : 문자로 시작하는 데이터
-- %like% : 문자가 있는 데이터 ( 시작이든 중간이든 끝이든 어디에든 들어가있으면 조회가능)
-- %like : 문자로 끝나는 데이터
-- ' _ ' (언더스코어) 를 통해 앞의 문자 갯수를 정해줄 수 있다
SELECT 
		* 
		FROM tbl_metbl_menunu
		WHERE menu_name LIKE "%마늘%";

SELECT 
		* 
		FROM tbl_menu
		WHERE menu_name LIKE "%아메리카노";
		
SELECT 
		* 
		FROM tbl_menu
		WHERE menu_name LIKE "생%";
		
	
-- _ (언더스코어) 를 통해 앞의 문자 갯수를 정해줄 수 있다	
SELECT 
		* 
		FROM tbl_menu
		WHERE menu_name LIKE "_마늘%";


-- '_' , '%' 같은 기호를 직접 검색하고 싶은 경우
-- LIKE '%\_%' 또는
-- LIKE '%!_%' ESCAPE '!' 와 같은 방식으로 ESCAPE 한다.

-- NOT LIKE : 부정
SELECT 
		* 
		FROM tbl_menu
		WHERE menu_name NOT LIKE "%마늘%";
		
		
		

-- 예) 메뉴 가격이 5000 이상이고 , 카테고리 코드가 10 이며
-- 메뉴 이름에 갈치가 들어가는 메뉴의 모든 컬럼값조회 (컬럼 명시)

SELECT 
		menu_price,
		category_code,
		menu_name
		FROM tbl_menu
		WHERE menu_name LIKE '%갈치%'
		AND menu_price > 5000
		AND category_code = 10;
		
		


-- 5. IN 연산자
-- SELECT
-- 		*
-- 		FROM tbl_menu
-- 		WHERE category_code = 4
-- 		or category_code = 5
-- 		or category_code = 6;



SELECT
		*
		FROM tbl_menu
		WHERE category_code IN (4,5,6);


-- not In : 부정	
SELECT
		*
		FROM tbl_menu
		WHERE category_code  not IN (4,5,6);
		
		



-- 6. is null : null값 비교 연산자 ( null 값 조회는  IS 를 붙이지 않으면 불가 )
SELECT
		*
		FROM tbl_category
		WHERE ref_category_code IS NULL;
		

SELECT
		*
		FROM tbl_category
		WHERE ref_category_code IS NOT NULL;
		
		
		s
