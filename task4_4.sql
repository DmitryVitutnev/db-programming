-- Сгенерируйте в соответствии с равномерным распределением значения a
-- и поместите их в таблицу с полями id/a, где a – натуральное число.
-- Постройте по этой выборке выборку с полями id/a', где a'=min a, если a
-- больше среднего значения по столбцу, и a'=max a иначе. Рассчитайте и
-- сравните для исходной и полученной выборок медиану, среднее и
-- среднеквадратичное отклонение.

CREATE SCHEMA IF NOT EXISTS `task4_4` DEFAULT CHARACTER SET utf8 ;
USE `task4_4` ;

DROP TABLE IF EXISTS `task4_4`.`table1` ;

CREATE TABLE IF NOT EXISTS `task4_4`.`table1` (
  `id` INT NOT NULL auto_increment,
  `a` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `task4_4`.`table2`;
    
CREATE TABLE IF NOT EXISTS `task4_4`.`table2` (
	`id` INT NOT NULL,
	`a` INT NOT NULL,
	PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));
INSERT INTO `table1` VALUES (NULL, FLOOR(RAND() * 10));


-- Заполнение второй таблицы
DROP PROCEDURE IF EXISTS minMax;
delimiter $$
CREATE PROCEDURE minMax ()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE curId INT DEFAULT 0;
    DECLARE curA INT DEFAULT 0;
    DECLARE minA INT DEFAULT 1000;
    DECLARE maxA INT DEFAULT -1000;
    
    DECLARE average REAL DEFAULT 0;
    DECLARE row_num INT DEFAULT 0;
    
    DECLARE curLine
		CURSOR FOR
			SELECT id, a from `table1`;
            
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    
    
    OPEN curLine;
    
    
	countAvg: LOOP
		FETCH curLine INTO curId, curA;
        IF  done = 1 THEN
			LEAVE countAvg;
		END IF;
		SET average = average + curA;
        IF curA > maxA THEN
			SET maxA = curA;
        END IF;
        IF curA < minA THEN
			SET minA = curA;
        END IF;
        SET row_num = row_num + 1;
    END LOOP countAvg;
    
	CLOSE curLine;
    
    SET average = average / row_num;
    
    SET done = 0;
    
    OPEN curLine;
    
	fillTable: LOOP
		FETCH curLine INTO curId, curA;
        IF  done = 1 THEN
			LEAVE fillTable;
		END IF;
		IF curA > average THEN
			INSERT INTO table2 VALUES (curId, maxA);
		ELSE
			INSERT INTO table2 VALUES (curId, minA);
        END IF;
    END LOOP fillTable;
    
	CLOSE curLine;
    
END;

$$

-- Вычисление статистик
DROP PROCEDURE IF EXISTS showStat; $$
CREATE PROCEDURE showStat () 
BEGIN
	DECLARE avg1 REAL DEFAULT 0;
	DECLARE median1 REAL DEFAULT 0;
	DECLARE std1 REAL DEFAULT 0;
	DECLARE avg2 REAL DEFAULT 0;
	DECLARE median2 REAL DEFAULT 0;
	DECLARE std2 REAL DEFAULT 0;
    DECLARE rowCount INT DEFAULT 0;
    DECLARE medianRowLow INT DEFAULT 0;
    DECLARE medianRowHigh INT DEFAULT 0;
    
    SET rowCount = (SELECT COUNT(*) FROM table1);
    SET medianRowLow = FLOOR((rowCount-1) / 2);
    SET medianRowHigh = CEIL((rowCount-1) / 2);
    
    SET avg1 = (SELECT AVG(a) from table1);
    SET std1 = (SELECT STD(a) from table1);
    SET avg2 = (SELECT AVG(a) from table2);
    SET std2 = (SELECT STD(a) from table2);
    
    
	SET median1 = (SELECT a FROM table1 ORDER BY a ASC LIMIT medianRowLow,1);
    SET median1 = median1 + (SELECT a FROM table1 ORDER BY a ASC LIMIT medianRowHigh,1);
    SET median1 = median1 / 2;
	SET median2 = (SELECT a FROM table2 ORDER BY a ASC LIMIT medianRowLow,1);
    SET median2 = median2 + (SELECT a FROM table2 ORDER BY a ASC LIMIT medianRowHigh,1);
	SET median2 = median2 / 2; 
    
    SELECT avg1, avg2, std1, std2, median1, median2;
    
END;
$$
CALL minMax(); $$
CALL showStat(); $$

