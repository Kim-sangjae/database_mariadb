-- 19. trigger



DELIMITER //

CREATE OR REPLACE TRIGGER after_order_menu_insert
    AFTER INSERT
    ON tbl_order_menu
    FOR EACH ROW
BEGIN
    UPDATE tbl_order
    SET total_order_price = total_order_price + NEW.order_amount * (SELECT menu_price FROM tbl_menu WHERE menu_code = NEW.menu_code)
    WHERE order_code = NEW.order_code;
END//

DELIMITER ;

-- 1. tbl_order insert
INSERT
	INTO tbl_order
	VALUES (
	NULL,
	DATE_FORMAT(CURRENT_DATE, '%Y%m%d'),
	DATE_FORMAT(CURRENT_TIME, '%H%i%s'),
	0
	);
	

-- 2. tbl_order_menu insert(수행후 trigger 동작 확인)
INSERT
INTO tbl_order_menu
VALUES (1,3,2);

INSERT
INTO tbl_order_menu
VALUES (1,4,1);

SELECT * FROM tbl_order_menu;