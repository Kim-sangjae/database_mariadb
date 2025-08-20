-- 10. DML (데이터 조작 언어)
-- 테이블에 값을 삽입 , 수정 , 삭제 할 때 사용하는 언어


-- 1. insert : 새로운 행을 추가한다
-- insert 시 null 을 허용하거나 auto increment 등 
-- 기본 값이 존재하는 컬럼은 제외하고 쓸 수 있다.
INSERT INTO tbl_menu VALUES(
NULL,
'바나나해장국',
8500,
4,
'Y'
);

SELECT * FROM tbl_menu;





INSERT INTO tbl_menu (
menu_name, 
menu_price, 
category_code, 
orderable_status)
VALUES(
'초콜릿죽',
9000,
7,
'Y'
);

SELECT * FROM tbl_menu;


-- 컬럼을 명시적으로 작성 할 경우 순서를 변경할 수 있다

INSERT INTO tbl_menu (
menu_price,
menu_name, 
orderable_status,
category_code 
)
VALUES(
7000,
'파인애플탕',
'Y',
4
);

SELECT * FROM tbl_menu;



-- multi insert
INSERT
		INTO tbl_menu
		VALUES( NULL,'참치맛아이스크림',1700,12,'Y'),
				( NULL,'멸치맛아이스크림',1700,12,'Y'),
				( NULL,'고등어맛아이스크림',1700,12,'Y');
				
SELECT * FROM tbl_menu;


-- 2. update : 테이블에 기록 된 값 수정
-- 0~n 개의 행이 업데이트 되며, 테이블의 전체행의 수는 변화하지 않는다.
SELECT * FROM tbl_menu;

UPDATE tbl_menu
	SET category_code = 7 ,
		 menu_name = '딸기맛붕어빵'
	WHERE menu_code = 24;
	

-- subquery를 활용하여 update 할 수도 있다.
UPDATE tbl_menu
	SET category_code = 6
	WHERE menu_code = (SELECT menu_code
								FROM tbl_menu
								WHERE menu_name = '초콜릿죽');



-- 3. delete : 테이블의 행을 삭제한다

-- where 을 이용한 삭제
DELETE
	FROM tbl_menu
	WHERE menu_code = 24;
	
	
-- limit 을 이용한 삭제 ( offset은 불가 : 시작위치 지정 불가 )
DELETE
	FROM tbl_menu
	ORDER BY menu_price
	LIMIT 2;


-- delete의 조건절 없이 삭제 ( 모든 데이터 삭제 )
-- DELETE FROM tbl_menu;




-- 4. replace : 중복 된 데이터를 덮어 쓸 수 있다
INSERT
	INTO tbl_menu
	values
	(17,'참기름소주',5000,10,'Y'); -- pk 17 값이 중복되서 안된다

REPLACE 
	INTO tbl_menu
	values
	(17,'참기름소주',5000,10,'Y'); -- replace로 데이터 교체 가능
	
	
	
REPLACE tbl_menu
	SET menu_code = 2,
		 menu_price = 1000,
		 menu_name = '우럭쥬스',
		 category_code = 9,
		 orderable_status = 'N';
	
	
	
SELECT * FROM tbl_menu;
