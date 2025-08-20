-- 08. subquery : 메인 쿼리 내에서 실행 되는 보조쿼리

-- '민트미역국' 과 같은 카테고리인 메뉴를 조회
SELECT
		category_code
		FROM tbl_menu
		WHERE menu_name = '민트미역국';
		
		
SELECT
		menu_name
		FROM tbl_menu
		WHERE category_code='4';
		

-- 위의 질의를 하나의 질의로 변경
SELECT
		menu_name
		FROM tbl_menu
		WHERE category_code= (SELECT
											category_code
											FROM tbl_menu
											WHERE menu_name = '민트미역국');
											
											


-- 인라인 뷰 : 서브쿼리가 from절에서 사용 되는 경우
-- 인라인뷰를 사용 할 경우 테이블 별칭을 꼭 써줘야한다
-- 서브쿼리에 정해진 함수를 쓰는경우에도 별칭을 꼭 붙여줘야 한다.

SELECT 
		MAX(COUNT)
		FROM (SELECT COUNT(*) as 'count'
						FROM tbl_menu
						GROUP BY category_code) as countmenu;
						
						


-- 상호연관(상관) 서브쿼리 : 메인 쿼리가 서브 쿼리의 결과에 영향을 주는 형태
-- 해당 카테로기 메뉴의 평균가보다 높은 가격을 가진 메뉴만 조회
SELECT                                                   
       menu_code                                         
     , menu_name                                         
     , menu_price                                        
     , category_code                                     
     , orderable_status                                  
  FROM tbl_menu a                                        
 WHERE menu_price > (SELECT AVG(menu_price)
                       FROM tbl_menu                  
                      WHERE category_code = a.category_code);
		
		
		

-- exists : 조회 결과가 있을 때 true , 없을 떄 false
-- 메뉴 테이블에 존재하는 카테고리만 조회
SELECT
		category_name
		FROM tbl_category a
		WHERE EXISTS (SELECT 1
								FROM tbl_menu b
								WHERE b.category_code = a.category_code);
								
								

-- CTE(Common Table Expression)
-- 인라인 뷰로 사용되는 서브 쿼리를 미리 정의해서 사용 하는 문법
WITH menucate AS(
	select
			menu_name,
			category_name
			FROM tbl_menu a
			JOIN tbl_category b ON a.category_code = b.category_code )

	SELECT * FROM menucate;
	
	

		