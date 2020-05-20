-- Сгенерируйте в соответствии с равномерным распределением (по a и по
-- b) выборку {a,b}. Рассматривая b как функцию от a, проверить эту
-- функцию на монотонность. Рассчитайте для этой выборки (для a и для b)
-- медиану, среднее и среднеквадратичное отклонение.

CREATE SCHEMA IF NOT EXISTS `task4_6` DEFAULT CHARACTER SET utf8 ;
USE `task4_6` ;

DROP TABLE IF EXISTS `task4_6`.`table1` ;

CREATE TABLE IF NOT EXISTS `task4_6`.`table1` (
  `id` INT NOT NULL auto_increment,
  `a` REAL NOT NULL,
  `b` REAL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- Заполнение таблицы
DROP PROCEDURE IF EXISTS fillTable;
delimiter $$
CREATE PROCEDURE fillTable (IN rowNumber INT)
BEGIN
    DECLARE counter INT DEFAULT 0;
    fillFirst: LOOP
        INSERT INTO table1 VALUES (null, RAND(), RAND());
        SET counter = counter + 1;
		IF  counter = rowNumber THEN
			LEAVE fillFirst;
		END IF;
    END LOOP fillFirst;
    
END;

$$
-- Проверка на монотонность
DROP FUNCTION IF EXISTS isMonotonous; $$
CREATE FUNCTION isMonotonous ()
RETURNS BOOL 
DETERMINISTIC
BEGIN
	DECLARE ascend BOOL DEFAULT TRUE;
	DECLARE descend BOOL DEFAULT TRUE;
	DECLARE curB REAL DEFAULT 0;
	DECLARE prevB REAL DEFAULT 0;
	DECLARE done INT DEFAULT 0;
    
    DECLARE curLine
		CURSOR FOR
			SELECT b from `table1`
            ORDER BY a;
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN curLine;
    
    FETCH curLine INTO curB;
    cycle: LOOP
		SET prevB = curB;
		FETCH curLine INTO curB;
        IF prevB < curB THEN
			SET descend = FALSE;
        END IF;
        IF prevB > curB THEN
			SET ascend = FALSE;
        END IF;
		IF  done = 1 THEN
			LEAVE cycle;
		END IF;
    END LOOP cycle;
    
    CLOSE curLine;
    
    RETURN ascend OR descend;
    
END; 

$$

-- Вычисление статистик
DROP PROCEDURE IF EXISTS showStatAB; $$
CREATE PROCEDURE showStatAB () 
BEGIN
	DECLARE avg1A REAL DEFAULT 0;
	DECLARE median1A REAL DEFAULT 0;
	DECLARE std1A REAL DEFAULT 0;
    
    DECLARE avg1B REAL DEFAULT 0;
	DECLARE median1B REAL DEFAULT 0;
	DECLARE std1B REAL DEFAULT 0;
    
    DECLARE rowCount INT DEFAULT 0;
    DECLARE medianRowLow INT DEFAULT 0;
    DECLARE medianRowHigh INT DEFAULT 0;
    
    SET rowCount = (SELECT COUNT(*) FROM table1);
    SET medianRowLow = FLOOR((rowCount-1) / 2);
    SET medianRowHigh = CEIL((rowCount-1) / 2);
    
    SET avg1A = (SELECT AVG(a) from table1);
    SET std1A = (SELECT STD(a) from table1);
    SET median1A = (SELECT a FROM table1 ORDER BY a ASC LIMIT medianRowLow,1);
    SET median1A = median1A + (SELECT a FROM table1 ORDER BY a ASC LIMIT medianRowHigh,1);
    SET median1A = median1A / 2;
    
    SET avg1B = (SELECT AVG(b) from table1);
    SET std1B = (SELECT STD(b) from table1);
    SET median1B = (SELECT b FROM table1 ORDER BY b ASC LIMIT medianRowLow,1);
    SET median1B = median1B + (SELECT b FROM table1 ORDER BY b ASC LIMIT medianRowHigh,1);
    SET median1B = median1B / 2;
    
    SELECT isMonotonous(), avg1A, std1A, median1A, avg1B, std1B, median1B;
    
END;
$$
CALL fillTable(4); $$
CALL showStatAB(); $$