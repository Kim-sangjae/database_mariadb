-- JOIN ~ SET OPERATORS Test

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
SELECT 
		a.emp_id,
		a.emp_name,
		b.dept_title
		FROM employee a
		JOIN department b ON a.DEPT_CODE = b.dept_id
		WHERE a.EMP_NAME LIKE '%형%';

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
SELECT 
		a.emp_name,
		b.job_name,
		a.dept_code,
		c.dept_title
				FROM employee a
				JOIN job b ON a.JOB_CODE = b.JOB_CODE
				JOIN department c ON a.DEPT_CODE = c.DEPT_ID
				WHERE c.DEPT_TITLE LIKE '%해외영업%';


-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)
-- (INNER JOIN 결과)
SELECT
		a.emp_id,
		a.bonus,
		b.dept_title,
		c.local_name
		FROM employee a
		JOIN department b ON a.dept_code = b.DEPT_ID
		JOIN location c ON b.LOCATION_ID = c.LOCAL_CODE
		WHERE a.bonus IS NOT null;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
SELECT 
		a.emp_name,
		b.dept_title,
		c.local_name
		FROM employee a
		JOIN department b ON a.DEPT_CODE = b.DEPT_ID
		JOIN location c ON b.LOCATION_ID = c.LOCAL_CODE
		WHERE a.DEPT_CODE ='D2';


-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)

-- 연봉 계산법 : 월급 * (1 + 보너스) * 12 로 수행하시면 됩니다.
SELECT 
		a.emp_name , 
		b.dept_title, 
		a.salary , 
		(salary * (1+NVL(bonus, 0)) * 12) AS '연봉'
		FROM employee a
		JOIN department b ON a.DEPT_CODE = b.DEPT_ID
		WHERE a.salary > (SELECT min_sal
                       	FROM sal_grade                 
                      	WHERE sal_level = a.SAL_LEVEL);



-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)
SELECT 
		a.emp_name,
		b.dept_title,
		c.local_name,
		d.national_name
		FROM employee a
		JOIN department b ON a.DEPT_CODE = b.DEPT_ID
		JOIN location c ON b.LOCATION_ID = c.LOCAL_CODE
		JOIN national d ON c.NATIONAL_CODE = d.NATIONAL_CODE
		WHERE d.NATIONAL_code IN ('KO','JP');



-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)

SELECT
		a.emp_name,
		b.job_name,
		a.salary
		FROM employee a
		JOIN job b USING(job_code)
		WHERE a.bonus IS null
		AND a.job_code IN ('J4','J7');


-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오.
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)

SELECT
		a.EMP_ID,
		a.EMP_NAME,
		b.JOB_NAME,
		c.DEPT_TITLE,
		d.LOCAL_NAME,
		a.SALARY
		FROM employee a
		JOIN job b USING(job_code)
		JOIN department c ON a.DEPT_CODE = c.DEPT_ID
		JOIN location d ON c.LOCATION_ID = d.LOCAL_CODE
		WHERE b.JOB_NAME = '대리' && d.LOCAL_NAME LIKE '%ASIA%';
   
   
-- 9. 각 부서별 평균 급여와 직원 수를 조회하시오. (NULL 급여는 제외) 
-- 평균 급여가 높은 순으로 정렬하시오. (6행)
SELECT 
		AVG(salary) 평균급여,
		dept_code,
		COUNT(*)
		FROM employee
		GROUP BY dept_code
		HAVING dept_code IS NOT null 
		ORDER BY 평균급여 desc;


 
-- 10. 직원 중 보너스를 받는 직원들의 연봉 총합이 1억 원을 
-- 초과하는 부서의 부서명과 연봉 총합을 조회하시오. (1행)
SELECT
		SUM(salary * (1+NVL(bonus, 0)) * 12) AS '연봉총합',
		b.dept_title
		FROM employee
		JOIN department b ON dept_code = b.DEPT_ID
		WHERE bonus IS NOT NULL
		GROUP BY dept_code, '연봉총합'
		HAVING 연봉총합 > 100000000;
		
	
 
-- 11. 국내 근무하는 직원들 중 평균 급여 이상을 받는 
-- 직원들의 사원명, 급여, 부서명을 조회하시오. (서브쿼리 사용) (4행)
SELECT
		a.emp_name,
		a.salary,
		b.dept_title,
		c.NATIONAL_CODE
		FROM employee a
		JOIN department b ON a.DEPT_CODE = b.DEPT_ID
		JOIN location c ON b.LOCATION_ID = c.LOCAL_CODE
		WHERE salary >= (SELECT AVG(salary) FROM employee)
		&& c.NATIONAL_CODE = 'KO';



-- 12. 모든 부서의 부서명과 해당 부서에 소속된 직원 수를 조회하시오. 
-- 직원이 없는 부서도 함께 표시하시오. (9행)

SELECT
		COUNT(a.emp_id),
		dept_title
		FROM department
		left JOIN employee a ON a.DEPT_CODE = dept_id
		GROUP BY dept_id; 


-- 13. 차장(J4) 이상 직급을 가진 직원과 사원(J7) 직급을 가진 
-- 직원들의 급여 합계를 비교하여 결과를 출력하시오. (SET OPERATOR 사용) (2행)