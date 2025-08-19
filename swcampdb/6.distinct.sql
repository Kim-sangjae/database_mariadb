-- 04. distinct : 중복 컬럼값 제외

-- 메뉴 테이블에 존재하는 카테고리의 종류를 조회
SELECT
		distinct category_code
		FROM tbl_menu
		ORDER BY category_code;
		

-- null 값이 존재하는 컬럼 중복 제거 할 경우
-- null 값도 중복 제외 가능
SELECT
		distinct ref_category_code
		FROM tbl_category
		ORDER BY 1; -- select 절에 나열 된 컬럼 순번으로도 정렬 가능
		
		
		
-- 다중열에 distinct 사용 할 경우
-- 다중열에 조합으로 중복 제거
-- select distinct A,B : A와B의 조합 중복 되는 값들 제거

SELECT
		category_code,
		orderable_status
		FROM tbl_menu;
		
		
SELECT
		distinct category_code,
		orderable_status
		FROM tbl_menu;
		

