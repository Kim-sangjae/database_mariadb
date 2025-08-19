-- 06 join : 두 개 이상의 테이블을 관련있는 컬럼을 통해 결합


-- 조인의 종류
-- AS는 as 를 안붙여도 띄어쓰기로 별칭 가능

-- 1. inner join : 두 테이블의 교집합 반환
-- (1) on : join할 테이블의 컬럼명이 동일하지 않거나 둘다 사용가능


SELECT
		a.menu_name,
		b.category_name
		FROM tbl_menu a
		JOIN tbl_category b ON a.category_code = b.category_code;
		


-- (2) using : join할 테이블의 컬럼명이 동일한 경우만 사용 가능

SELECT
		a.menu_name,
		b.category_name
		FROM tbl_menu a
		JOIN tbl_category b USING (category_code);
		
		
-- employee 와 department join
SELECT
		a.emp_name,
		b.dept_title
		FROM employee a
		JOIN department b ON a.dept_code = b.dept_id;
		
-- inner join은 교집합(값이 같은 경우) 만 반환하므로 위의 예시에서는
-- dept_code 가 null인 2명의 사원은 result set에 포합되지 않는다.
-- 포함 된 결과를 얻고 싶다면 outer join 을 수행한다.


-- 2. left [outer] join
-- : 왼쪽 테이블의 모든 레코드와 오른쪽 테이블에서 일치하는 레코드 반환
SELECT
		a.emp_name,
		b.dept_title
		FROM employee a
		LEFT JOIN department b ON a.dept_code = b.dept_id;


-- 3. RIGHT [OUTER] join
-- : 오른쪽 테이블의 모든 레코드와 왼쪽  테이블에서 일치하는 레코드 반환
SELECT
		a.emp_name,
		b.dept_title
		FROM employee a
		RIGHT JOIN department b ON a.dept_code = b.dept_id;
		

-- 4. cross join : 두 테이블의 가능한 모든 조합을 반환하는 조인
SELECT
		a.menu_name,
		b.category_name
		FROM tbl_menu a
		CROSS JOIN tbl_category b;
		

-- 5. self join : 같은 테이블 내에서 행과 행 사이의 관계를
-- 찾기 위해 사용 되는 유형의조인 (자기 자신을 조인한다)
SELECT 
		a.category_name 하위분류,
		b.category_name 상위분류
		FROM tbl_category a
		JOIN tbl_category b ON a.ref_category_code = b.category_code;
		


-- employee 테이블의 사원명, 관리자명 self join
-- 관리자가 할당 되지 않는 직원도 결과에 포함하도록 함

SELECT
		a.emp_name,
		b.emp_name 관리자
		FROM employee a
		LEFT JOIN employee b ON a.MANAGER_ID = b.emp_id;
		
		

-- employee에서 다중 테이블 join
-- 사원명 , 부서명 , 직급명 조회
SELECT
		a.emp_name,
		b.dept_title,
		c.job_name
		FROM employee a
		left JOIN department b ON a.dept_code = b.dept_id
		JOIN job c ON a.JOB_CODE = c.job_code;
		
-- 사원명(emp_name) , 근무 지역명 (local_name) , 근무 국가명(national_name)
SELECT
		a.emp_name,
		b.local_name,
		c.national_name
		FROM employee a
		JOIN department d ON a.DEPT_CODE = d.DEPT_ID
		JOIN location b ON d.LOCATION_ID = b.LOCAL_CODE 
		JOIN national c ON b.national_code = c.NATIONAL_CODE;
		

