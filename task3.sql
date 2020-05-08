use internet_market;

-- Индексы
CREATE INDEX price_index
ON product (price);

CREATE INDEX seller_index
ON product (seller_id);

-- Триггеры
DELIMITER |
CREATE TRIGGER product_before_insert
	BEFORE INSERT
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Попытка добавить товар: ", NEW.`name`));
	END; 
|

DELIMITER |
CREATE TRIGGER product_after_insert
	AFTER INSERT
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Товар успешно добавлен: ", NEW.`name`));
	END; 
|

DELIMITER |
CREATE TRIGGER product_before_update
	BEFORE UPDATE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Попытка обновить товар: ", OLD.`name`));
	END; 
|

DELIMITER |
CREATE TRIGGER product_after_update
	AFTER UPDATE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Товар успешно обновлен: ", OLD.`name`));
	END; 
|

DELIMITER |
CREATE TRIGGER product_before_delete
	BEFORE DELETE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Попытка удалить товар: ", OLD.`name`));
	END; 
|

DELIMITER |
CREATE TRIGGER product_after_delete
	AFTER DELETE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Товар успешно удален: ", OLD.`name`));
	END; 
|


-- Хранимые процедуры



SELECT * FROM log;