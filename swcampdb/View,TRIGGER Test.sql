-- View ~ TRIGGER Test

-- students
CREATE TABLE students (
student_id INT PRIMARY KEY,
name VARCHAR(255),
class VARCHAR(255)
);


-- student insert
INSERT INTO students VALUES(1,'홍길동','A');
INSERT INTO students VALUES(2,'유관순','A');
INSERT INTO students VALUES(3,'신사임당','B');

SELECT * FROM students;


-- grades
CREATE TABLE grades (
grade_id INT PRIMARY KEY,
student_id INT,
SUBJECT VARCHAR(255),
grade CHAR(2),
FOREIGN KEY(student_id) REFERENCES students(student_id)
);


-- grade insert
INSERT INTO grades VALUES(1,1,'수학','A');
INSERT INTO grades VALUES(2,2,'수학','B');
INSERT INTO grades VALUES(3,3,'수학','C');

INSERT INTO grades VALUES(4,1,'과학','B');
INSERT INTO grades VALUES(5,2,'과학','A');
INSERT INTO grades VALUES(6,3,'과학','B');


SELECT * FROM grades;

-- q1 view 생성

-- view
CREATE VIEW students_info AS
SELECT 
	 b.SUBJECT,
    a.name,
    a.class,
    b.grade
  FROM students a 
  JOIN grades b ON (a.student_id = b.student_id);


-- students_info 조회
SELECT * FROM students_info ORDER BY SUBJECT ASC;



-- q2. index 생성
CREATE INDEX emp_dept ON employee (dept_code);
SHOW INDEX FROM employee;
DROP INDEX emp_dept ON employee;
SHOW INDEX FROM employee;


-- q3. procedure 생성

delimiter //

CREATE PROCEDURE addNumbers(
IN a1 INT, 
IN a2 INT, 
OUT sum INT 
)
BEGIN	

	SET sum=a1+a2;
			
END //

delimiter ;


SET @SUM = 0;
CALL addNumbers(10,20,@SUM);
SELECT @SUM; -- 30




-- q4. function
DELIMITER //

CREATE FUNCTION increasePrice(
	current_price DOUBLE, 
	increase_rate DOUBLE
)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN current_price * (1 + increase_rate);
END//

DELIMITER ;


SELECT 
       menu_name 메뉴명
	  ,  menu_price 기존가
	  , TRUNCATE(increasePrice(menu_price, 0.1), -2) 예정가
 FROM tbl_menu;


-- q5

CREATE TABLE salary_history (
history_id INT PRIMARY KEY,
emp_id VARCHAR(255),
old_salary DECIMAL,
new_salary DECIMAL,
change_date DATETIME,
FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);




DELIMITER //

CREATE TRIGGER after_emp_salary_update
    AFTER UPDATE 
    ON employee
    FOR EACH ROW
    
BEGIN
   INSERT INTO salary_history
   VALUES (
1,
new.emp_id,
old.SALARY,
new.SALARY,
NOW()
);
    
END//

DELIMITER ;

DROP TRIGGER after_emp_salary_update;



UPDATE
	employee
	SET SALARY = 5000000
	WHERE emp_id = '202';
	
SELECT * FROM employee WHERE emp_id = '202';




SELECT * FROM salary_history;
