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
				