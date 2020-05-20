use internet_market;

-- Индексы
CREATE INDEX price_index
ON product (price);

CREATE INDEX seller_index
ON product (seller_id);

-- В интернет магазине часто возникает необходимость узнать товары определенного продавца
-- или товары в определенной ценовой категории. Для более быстрого поиска стоит добавить индексы.

-- Триггеры
DELIMITER |
DROP TRIGGER IF EXISTS product_before_insert;|
CREATE TRIGGER product_before_insert
	BEFORE INSERT
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Попытка добавить товар: ", NEW.`name`));
	END;
|

DROP TRIGGER IF EXISTS product_after_insert;|
CREATE TRIGGER product_after_insert
	AFTER INSERT
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Товар успешно добавлен: ", NEW.`name`));
	END; 
|

DROP TRIGGER IF EXISTS product_before_update;|
CREATE TRIGGER product_before_update
	BEFORE UPDATE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Попытка обновить товар: ", OLD.`name`));
	END; 
|

DROP TRIGGER IF EXISTS product_after_update;|
CREATE TRIGGER product_after_update
	AFTER UPDATE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Товар успешно обновлен: ", OLD.`name`));
	END; 
|

DROP TRIGGER IF EXISTS product_before_delete;|
CREATE TRIGGER product_before_delete
	BEFORE DELETE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Попытка удалить товар: ", OLD.`name`));
	END; 
|

DROP TRIGGER IF EXISTS product_after_delete;|
CREATE TRIGGER product_after_delete
	AFTER DELETE
	ON product
	FOR EACH ROW BEGIN
		INSERT INTO log values (null, CONCAT("Товар успешно удален: ", OLD.`name`));
	END; 
|

-- Эти триггеры позволяют отслеживать операции с базой данных и в случае ошибки
-- отследить, какая операция не выполнилась или выполнилась не целиком.


-- Хранимые процедуры и функции

-- Возвращает максимум из двух чисел
DROP FUNCTION IF EXISTS maxInt;|
CREATE FUNCTION maxInt (a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN
	IF a > b THEN
		RETURN a;
	ELSE
		RETURN b;
    END IF;
END;
|
-- Генерирует случайное целое число из полуинтервала [a,b)
DROP PROCEDURE IF EXISTS randomInt;
|
CREATE PROCEDURE randomInt (IN a INT, IN b INT, OUT result INT)
BEGIN
	SET result = FLOOR(a + RAND()*(b-a));
END;
|
-- Превращает число в модуль числа
DROP PROCEDURE IF EXISTS abs;
|
CREATE PROCEDURE abs (INOUT a INT)
BEGIN
	IF a < 0 THEN
		SET a = -1 * a;
    END IF;
END;

-- Для проверки триггеров можно заново вызвать код в файле FILL а потом посмотреть таблицу лог.

SELECT * FROM log;