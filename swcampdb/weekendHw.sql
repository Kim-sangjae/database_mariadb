-- Q1.
-- 1.
SELECT category_code,category_name
FROM tbl_category
WHERE ref_category_code IS NOT NULL
ORDER BY category_name DESC;


-- 2.
SELECT menu_name,menu_price
FROM tbl_menu
WHERE menu_name LIKE ('%밥%')
&& menu_price BETWEEN 20000 and 30000;


-- 3.
SELECT *
FROM tbl_menu
WHERE menu_name LIKE('%김치%')
|| menu_price < 10000
ORDER BY menu_price ASC , menu_name DESC;


-- 4.
SELECT a.*
FROM tbl_menu a 
JOIN tbl_category USING(category_code) 
WHERE ref_category_code IS NOT NULL
&& category_code NOT IN(8,9,10)
&& orderable_status != 'N'
&& menu_price = 13000;


-- ----------------------------------------------------------------------
-- Q2.
-- 1.
SELECT emp_id,emp_name,phone,hire_date,ent_yn
FROM employee
WHERE ent_yn = 'N'
ORDER BY hire_date DESC
LIMIT 3;

-- 2.
SELECT emp_name,job_name,salary,emp_id,email,phone,hire_date
FROM employee
JOIN job USING(job_code)
WHERE job_name = '대리'
ORDER BY salary DESC;

-- 3.
SELECT 
dept_title '부서명',count(dept_code) '인원',
SUM(salary) '급여합계' ,AVG(salary) '급여평균'
FROM employee a JOIN department b ON a.DEPT_CODE = b.DEPT_ID
GROUP BY dept_code
with ROLLUP;

-- 4.
SELECT a.emp_name,a.emp_no,a.phone,b.dept_title,c.job_name
FROM employee a
JOIN department b ON a.DEPT_CODE = b.DEPT_ID
JOIN job c USING(job_code)
ORDER BY a.HIRE_DATE ASC;

-- 5.
-- (1)
SELECT COUNT(*)
FROM employee a
JOIN employee b ON a.EMP_id = b.MANAGER_ID;


-- (2)
SELECT COUNT(*)
FROM employee
WHERE manager_id IS NOT NULL;


-- (3)
SELECT a.emp_name '직원명', b.EMP_NAME '관리자명'
FROM employee a
left JOIN employee b ON b.EMP_id = a.MANAGER_ID;


-- (4)
SELECT a.emp_name '직원명',b.dept_title '부서',c.emp_name '관리자명',d.dept_title '관리자 부서'
FROM employee a
JOIN employee c ON a.MANAGER_ID = c.EMP_ID
JOIN department b ON a.DEPT_CODE = b.DEPT_ID
JOIN department d ON c.DEPT_CODE = d.DEPT_ID;


-- -------------------------------------------------------------------------
-- Q3.
-- 1.
SELECT SUM(salary) 
FROM employee
GROUP BY dept_code
ORDER BY SUM(salary) DESC
LIMIT 1;

-- 2.
SELECT emp_id,emp_name,dept_code,salary
FROM employee
WHERE dept_code IN (
SELECT dept_id
FROM department
WHERE dept_title LIKE('%영업%'));


-- 3.
SELECT emp_id,emp_name,dept_title,salary
FROM employee
JOIN department ON dept_code = dept_id
WHERE dept_code IN (
SELECT dept_id
FROM department
WHERE dept_title LIKE('%영업%'));


-- 4.
-- (1)
SELECT a.dept_id,a.dept_title,b.local_name,c.NATIONAL_NAME
FROM department a
JOIN location b ON a.LOCATION_ID = b.LOCAL_CODE
JOIN national c USING(NATIONAL_CODE);

-- (2)
WITH deptNationalInfo AS (
SELECT a.dept_id,a.dept_title,b.local_name,c.NATIONAL_NAME
FROM department a
JOIN location b ON a.LOCATION_ID = b.LOCAL_CODE
JOIN national c USING(NATIONAL_CODE)
)

SELECT emp_id,emp_name,salary,dept_title,NATIONAL_NAME
FROM employee
JOIN deptNationalInfo ON dept_code = dept_id
ORDER BY national_name desc;



-- 5.
WITH deptNationalInfo AS (
SELECT a.dept_id,a.dept_title,b.local_name,c.NATIONAL_NAME
FROM department a
JOIN location b ON a.LOCATION_ID = b.LOCAL_CODE
JOIN national c USING(NATIONAL_CODE)
WHERE national_name = '러시아'
)

SELECT emp_id,emp_name,salary,dept_title,
NATIONAL_NAME,(salary * min_sal) 위로금
FROM employee
JOIN deptNationalInfo ON dept_code = dept_id
JOIN sal_grade USING(sal_level)
ORDER BY 위로금 desc;



-- 5 다른 풀이

SELECT E.EMP_ID, E.EMP_NAME, E.SALARY, DLN.DEPT_TITLE, 
       DLN.NATIONAL_NAME, E.SALARY + S.MIN_SAL 위로금
 FROM EMPLOYEE E
 JOIN (SELECT D.DEPT_ID, D.DEPT_TITLE, L.LOCAL_NAME, N.NATIONAL_NAME
 FROM DEPARTMENT D
 JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
 JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)) DLN ON E.DEPT_CODE = DLN.DEPT_ID
 JOIN SAL_GRADE S ON (E.SAL_LEVEL = S.SAL_LEVEL)
WHERE DLN.NATIONAL_NAME = '러시아'
ORDER BY 위로금 DESC;

