-- book rental system

-- 1. 대여

-- 도서 대여가능 여부
SELECT available
FROM books
WHERE book_id = 3
AND is_deleted = 'N';

-- 미납 연체료가 있을 시 대여 불가
SELECT COUNT(*)
FROM fines f
JOIN rentals r ON f.rental_id = r.rental_id
WHERE r.user_id = 5
&& r.is_deleted = 'N'
&& f.paid = 'N'
&& f.is_deleted = 'N';

-- 현재 대여중인 도서 갯수 확인 (최대 5권)
SELECT COUNT(*)
FROM rentals r
JOIN rental_books rb USING(rental_id)
WHERE r.user_id = 1
&& r.return_date IS NULL
&& r.is_deleted = 'N';

-- rentals와 rental_books 에 데이터 삽입
INSERT INTO rentals(user_id,rental_date,due_date) VALUES(
1,CURDATE(),DATE_ADD(CURDATE(),INTERVAL 7 DAY)
);

-- 마지막으로 발생한 auto_increment 값 조회
SELECT LAST_INSERT_ID(); 

INSERT 
INTO rental_books (rental_id , book_id) 
VALUES(LAST_INSERT_ID(),3);


-- 대여 된 책의 상태 변경
UPDATE books
SET available = 'N'
WHERE book_id = 3;



-- --------------------------------
-- 2. 반납

-- CalculateFine stored function 정의
-- 벌금 계산용 함수
DELIMITER //

CREATE FUNCTION CalculateFine(rentalId INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC 
BEGIN
	
	DECLARE overdue_days INT; -- 연체일
	DECLARE fine_amount DECIMAL(10,2); -- 벌금액
-- 반납 예정일과 현재 일자 비교하여 연체일 계산
	
	SELECT DATEDIFF(CURDATE(), due_date) INTO overdue_days
	FROM rentals WHERE rental_id = rentalId;
	
	-- 연체가 발생했을 경우 연체료 계산
	if overdue_days > 0 then
	SELECT daily_fine * overdue_days INTO fine_amount
	FROM fine_rates
	WHERE overdue_days >= min_days
	&& (max_days is null or overdue_days <= max_days);
	END if;
	
	RETURN IFNULL(fine_amount, 0);

END //



DELIMITER ;


-- function 동작 테스트
SELECT
	rental_id,
	DATEDIFF(CURDATE(),due_date),
	CalculateFine(rental_id)
	FROM rentals
	WHERE rental_id = 6;

-- AddFineAfterDueDate trigger 정의
-- 연체가 일어났다면 위에서 정의한 함수를 통헤 fine_amount를 계산하고
-- fines에 데이터 삽입하는 트리거



DELIMITER //

CREATE TRIGGER  AddFineAfterDueDate
AFTER UPDATE ON rentals
FOR EACH ROW 
BEGIN
-- return_date 컬럼이 null 에서 not null로 변경될때
-- fines에 데이터 삽입
if 
OLD.return_date IS NULL 
AND NEW.return_date IS NOT NULL
AND OLD.due_date < NEW.return_date
then
INSERT INTO fines(rental_id , fine_amount, paid ) 
VALUES (NEW.rental_id , CalculateFine(NEW.rental_id),'N');
END if;

END //

DELIMITER ;



-- rentals 에 return_date 기록 -> 이 시점에서 trigger 동작
-- 6번 대여기록을 반환
UPDATE rentals
	SET return_date = curdate()
	WHERE rental_id = 6;

-- 반납 된 책의 상태 변경
UPDATE books
SET available = 'Y'
WHERE book_id IN(
SELECT book_id FROM rental_books WHERE rental_id = 6
);
