-- 12. data type

-- 형 변환
-- 1. 명시적 형 변환
-- cast as
-- convert ,

SELECT AVG(menu_price) FROM tbl_menu;

-- cast : ANSI 표준함수
SELECT CAST(AVG(menu_price) AS SIGNED INTEGER) 펑균메뉴가격 FROM tbl_menu;
-- convert : mysql mariadb 제공 함수
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) 펑균메뉴가격 FROM tbl_menu;

SELECT CAST('2023$5$30' AS DATE); -- 2023-05-30
SELECT CAST('2023/5/30' AS DATE); -- 2023-05-30
SELECT CAST('2023%5%30' AS DATE); -- 2023-05-30
SELECT CAST('2023@5@30' AS DATE); -- 2023-05-30

SELECT CAST(menu_price AS CHAR(5)) FROM tbl_menu; -- 숫자를 문자형태로  
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu; -- 숫자를 문자형태로



-- 2.암시적 형 변화
SELECT '1'+'2';  -- 맥락적으로 숫자형태이므로 문자->정수 12 가 아니라 3이 나온다
SELECT CONCAT(menu_price,'원')FROM tbl_menu; -- menu_price가 문자형태로 4500원 식으로 나온다 
SELECT 3 > 'MAY'; -- 문자가 0으로 변환 뒤 값 비교 1이나옴 true

SELECT 5 > '6MAY'; -- 문자에서 첫번째로 나오는 숫자는 정수로 변환 : 0
SELECT 5 > 'M6AY'; -- 숫자가 뒤에나오면 문자로 인식되어 0으로 변환 : 1
SELECT hire_date > '2000-5-30' FROM employee;
		-- 날짜형으로 바뀔 수 있는 문자는 date 형식으로 전환된다

