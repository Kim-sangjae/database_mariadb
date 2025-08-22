-- 18. procedure(프로시져)

-- 1. 매개변수 없는 간단한 예제
delimiter //

CREATE PROCEDURE getAllEmployee()
BEGIN
	SELECT emp_id , emp_name , salary
	FROM employee;
END //

delimiter ;


CALL getAllEmployee();



-- 2. in 매개변수 : 호출 시 전달 된 값을 사용
-- 특정 부서의 직원 정보 조회 프로시져

delimiter //

CREATE PROCEDURE getEmployeeByDepartment( IN dept CHAR(2) )
BEGIN
	SELECT emp_id , emp_name , salary
	FROM employee
	WHERE dept_code = dept;
END //

delimiter ;


CALL getEmployeeByDepartment ('D9');



-- 3. out 매개변수 : 결과 값을 호출 한 곳으로 반환
-- 특정 직원의 급여를 반환하는 프로시져

delimiter //

CREATE PROCEDURE getEmployeeSalry( IN id VARCHAR(3) , OUT sal DECIMAL(10,2) )
BEGIN
	SELECT salary INTO sal
	FROM employee
	WHERE emp_id = id;
END //

delimiter ;



-- '@' : 사용자 변수 선언
SET @sal = 0;
CALL getEmployeeSalry('200',@sal);
SELECT @sal;




-- 4. inout 매개변수
-- 특정 직원의 급여를 증가시킨 뒤 증가 된 급여(보너스 포함)을 반환하는 프로시저

DELIMITER //

CREATE PROCEDURE updateAndReturnSalary (
	IN id VARCHAR(3), 
	INOUT sal DECIMAL(10,2)
)
BEGIN
    UPDATE employee
    SET salary = sal
    WHERE emp_id = id;
    
    SELECT salary + (salary * IFNULL(bonus, 0)) INTO sal
    FROM employee
    WHERE emp_id = id;
END //

DELIMITER ;


--
SET @new_sal = 9000000;
CALL updateAndReturnSalary('200',@new_sal);
SELECT @new_sal;



-- 5. if else 활용
-- 특정 직원의 급여가 특정 값 보다 높은지 여부를 확인

DELIMITER //

CREATE PROCEDURE checkEmployeeSalary (
	IN id VARCHAR(3), 
	IN threshold DECIMAL(10,2),
	OUT result VARCHAR(50)
)
BEGIN
	-- declare : 내부에서 변수를 사용할 때 쓰는 선언방식
    DECLARE sal DECIMAL(10,2);
    
    SELECT salary INTO sal
    FROM employee
    WHERE emp_id = id;
    
    if sal > threshold then
    
	 SET result = '기준치를 넘는 급여입니다';
    else
    SET result = '기준치와 같거나 기준치 이하의 급여입니다,';
    
	 END if;
    
END //

DELIMITER ;


SET @reuslt = '';
CALL checkEmployeeSalary('200', 5000000, @result);
SELECT @result;



-- 6. case 문법

DELIMITER //

CREATE PROCEDURE getDepartmentMessage (
	IN id VARCHAR(3), 
	OUT message VARCHAR(50)
)
BEGIN
	-- declare : 내부에서 변수를 사용할 때 쓰는 선언방식
    DECLARE dept VARCHAR(50);
    
    SELECT dept_code INTO dept
    FROM employee
    WHERE emp_id = id;
    
 	case
 		when dept = 'D1' then
 			SET message = '인사 관리부 직원입니다';
 		when dept = 'D2' then
 			SET message = '회계 관리부 직원입니다.';
 		else
 			SET message = '어떤 부서도 아닙니다.';
	END case;
    
END //

DELIMITER ;


SET @message = '';
CALL getDepartmentMessage('214' , @message);
SELECT @message;



-- 7. while 

DELIMITER //

CREATE PROCEDURE calculatoeSumUpTo1 (
	IN max_num INT,
	OUT sum_result INT 
)
BEGIN
	-- declare : 내부에서 변수를 사용할 때 쓰는 선언방식
    DECLARE current_num INT DEFAULT 1;
    DECLARE total_sum INT DEFAULT 0;
   
   while current_num <= max_num do
   	SET total_sum = total_sum + current_num;
   	SET current_num = current_num + 1;
   	
   END while;
    
   SET sum_result = total_sum;
   
   SELECT @result; 
    
END //

DELIMITER ;




CALL calculatoeSumUpTo(10, @result);
SELECT @result; 

CALL calculatoeSumUpTo1(10, @result); -- select @result를 함수 안쪽에 넣어서 호출과 동시에 불러올수 있다






-- 8. 예외 처리


DELIMITER //

CREATE PROCEDURE divideNumbers (
	IN numberator DOUBLE,
	IN denominator DOUBLE,
	OUT result1 DOUBLE 
)
BEGIN
	
	
	-- sqlstate : sql의 오류코드 45000 : 사용자 정의 예외코드
	if denominator = 0 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '0으로 나눌수 없습니다';
	END if;


	SET result1 = numberator / denominator;
	
	
END //

DELIMITER ;




SET @result = 0;
CALL divideNumbers(10,0, @result);
SELECT @result;






-- function
-- 파라미터는 받아오는 값만 가능
-- 리턴값을 명시 해야함

DELIMITER //

CREATE FUNCTION getAnnualSalary (
	id VARCHAR(3)
)
RETURNS DECIMAL(15,2)
DETERMINISTIC 

BEGIN
	
	 DECLARE monthly_salary DECIMAL(10, 2);
    DECLARE annual_salary DECIMAL(15, 2);

    SELECT salary INTO monthly_salary
    FROM employee
    WHERE emp_id = id;

    SET annual_salary = monthly_salary * 12;

    RETURN annual_salary;
    
END //

DELIMITER ;

SELECT 
		emp_name,
		salary,
		getAnnualSalary(emp_id) AS annual_salary
 FROM employee;


