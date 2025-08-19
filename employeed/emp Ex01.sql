-- 1
SELECT * FROM employee;

-- 2
SELECT emp_id,emp_name FROM employee;

-- 3
SELECT emp_id,emp_name FROM employee WHERE emp_id = 201;

-- 4
SELECT emp_name,dept_code FROM employee WHERE dept_code = 'D9';

-- 5
SELECT * FROM employee WHERE job_code = 'J1';

-- 6
SELECT emp_id,emp_name,salary FROM employee 
WHERE salary > 3000000
OR salary = 3000000;

-- 7
SELECT emp_name,salary FROM employee 
WHERE dept_code = 'D6' 
AND salary > 3000000;

-- 8
SELECT emp_id , emp_name , salary , bonus FROM employee
WHERE bonus IS NULL;

-- 9
SELECT emp_id,emp_name FROM employee
WHERE not dept_code = 'D9';

-- 10
SELECT emp_id,emp_name,hire_date AS '입사일' FROM employee
WHERE ent_yn = 'N';

-- 11
SELECT emp_id,emp_name,salary FROM employee
WHERE salary BETWEEN 3500000 and 5500000;

-- 12
SELECT emp_id,emp_name,hire_date FROM employee
WHERE emp_name LIKE '김%';

-- 13
SELECT emp_id,emp_name,hire_date FROM employee
WHERE emp_name not LIKE '김%';

-- 14
SELECT emp_name,emp_no,dept_code FROM employee
WHERE emp_name LIKE '%하%'; 

-- 15
SELECT emp_name , salary FROM employee
WHERE (job_code = 'J2' 
OR job_code = 'J7')
AND salary > 2000000;

-- 16
SELECT emp_name,salary FROM employee
ORDER BY salary DESC
LIMIT 0,5;

-- 17
SELECT distinct salary FROM employee;

-- 18
SELECT emp_name FROM employee
ORDER BY 1
LIMIT 0,10;
