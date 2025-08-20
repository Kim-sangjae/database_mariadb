-- set operators : 두개 이상의 select 문의 결과 집합을 결합

-- 1. union 합집합 (중복제거)
-- 두개이상의 select 문의 결과를 결합하여 중복 레코드 제거 후 반환
SELECT
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
		FROM tbl_menu
		WHERE category_code = 10
		UNION 
SELECT
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
		FROM tbl_menu
		WHERE menu_price < 9000;
		
		

-- union all 합집합 (중복제거x)
-- 두 개 이사으이 select 문의 결과를 결합하여 중복레코드 제거하지 않고 반환

SELECT
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
		FROM tbl_menu
		WHERE category_code = 10
		UNION ALL 
SELECT
		menu_code,
		menu_name,
		menu_price,
		category_code,
		orderable_status
		FROM tbl_menu
		WHERE menu_price < 9000;
		

-- 3. intersect 교집합 (오라클에만 존재 , mysql mariadb에는 없다)
-- 두 select의 결과 중 공통 되는 레코드만 반환
-- mysql mariadb 에서는 inner join 이나  in 연산자로 구현 가능


-- (1) inner join
SELECT
		a.menu_code,
		a.menu_name,
		a.menu_price,
		a.category_code,
		a.orderable_status
		FROM tbl_menu a
		JOIN(SELECT
				menu_code,
				menu_name,
				menu_price,
				category_code,
				orderable_status
				FROM tbl_menu
				WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code)
		WHERE a.category_code = 10;
		
		
		
-- (2) in 연산자

SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE category_code = 10 
   AND menu_code IN (SELECT menu_code
                       FROM tbl_menu
                      WHERE menu_price < 9000);
                      
                      
-- 4.minus 차집합 ( mysql mariadb는 제공x )
-- 첫번째 select문의 결과에서 두 번째 select문의 결과가 포함하는
-- 레코드를 제외한 레코드만 반환
-- mysql mariadb에서는 left join을 통해 구현한다
SELECT
		a.menu_code,
		a.menu_name,
		a.menu_price,
		a.category_code,
		a.orderable_status
		FROM tbl_menu a
		left JOIN(SELECT
				menu_code,
				menu_name,
				menu_price,
				category_code,
				orderable_status
				FROM tbl_menu
				WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code)
		WHERE a.category_code = 10
		AND b.menu_code IS null;
				
		
	