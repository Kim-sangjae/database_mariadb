-- 07. grouping
-- group by : 결과 집할을 특정 열의 값에 따라 그룹솨
-- having : group by 절과 함께 사용히며 그룹의 조건을 적용


-- 그룹함수 : count, sum, avg, min, max

SELECT
		category_code,
		COUNT(*)
		FROM tbl_menu
		GROUP BY category_code;
		

-- count 함수의 특성
SELECT 
		COUNT(*), -- * 모든 행 
		COUNT(category_code), -- 해당 컬럼 행만 카운트
		COUNT(ref_category_code) -- null 값은 카운트 하지 않는다
FROM tbl_category;



-- sum : 숫자 합계
-- avg : 숫자 평균


SELECT
		category_code,
		sum(menu_price)
		FROM tbl_menu
		GROUP BY category_code;
		
		
SELECT
		category_code,
		AVG(menu_price)
		FROM tbl_menu
		GROUP BY category_code;
		
		
		
-- min, max 는 모든 데이터 타입(문자,숫자,날짜)를 대상으로 사용 가능
-- 최솟값 , 최댓값		
SELECT
		MIN(emp_name),
		MAX(emp_name),
		MIN(hire_date),
		MAX(hire_date)
		FROM employee;
		

SELECT
		category_code,
		min(menu_price)
		FROM tbl_menu
		GROUP BY category_code;


SELECT
		category_code,
		max(menu_price)
		FROM tbl_menu
		GROUP BY category_code;
		



-- group by 절에 2개 이상의 기준 컬럼 작성 가능
SELECT
		menu_price,
		category_code,
		COUNT(*)
		FROM tbl_menu
		GROUP BY menu_price,category_code;
		

-- 카테고리 코드별로 메뉴 가격 평균이 10000원 이상인
-- 카테고리의 코드 , 이름 , 평균 메뉴 가격 조회
SELECT
		a.category_code,
		b.category_name,
		AVG(a.menu_price)
		FROM tbl_menu a
		JOIN tbl_category b ON a.category_code = b.category_code
		GROUP BY a.category_code, b.category_name
		having AVG(a.menu_price) > 10000;
		


-- select : 조회 컬럼
-- from : 조회 대상 테이블
-- join : 조인 대상 테이블
-- where : 테이블 행을 조건으로 필터링
-- group by : 대상 컬럼으로 결과 집합 그루핑
-- having : 그루핑 결과를 조건으로 필터링
-- order by : 결과 집합 정렬


-- roll up : 중간 집계 함수 , group by와 함께 사용하는 함수
-- group by 절의 첫번째 컬럼이 기준이 되어서 중간집계 , 총집계
SELECT
		category_code,
		SUM(menu_price)
		FROM tbl_menu
		GROUP BY category_code
		WITH ROLLUP;


SELECT
		menu_price,
		category_code,
		SUM(menu_price)
		FROM tbl_menu
		GROUP BY menu_price,category_code
		WITH ROLLUP;	
		
		
		
SELECT
		category_code,
		menu_price,
		SUM(menu_price)
		FROM tbl_menu
		GROUP BY category_code,menu_price
		WITH ROLLUP;				