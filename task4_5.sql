CREATE SCHEMA IF NOT EXISTS `task4_5` DEFAULT CHARACTER SET utf8 ;
USE `task4_5` ;

DROP TABLE IF EXISTS `task4_5`.`table1` ;

CREATE TABLE IF NOT EXISTS `task4_5`.`table1` (
  `id` INT NOT NULL auto_increment,
  `a` INT NOT NULL,
  `b` REAL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `task4_5`.`table2`;
    
CREATE TABLE IF NOT EXISTS `task4_5`.`table2` (
	`id` INT NOT NULL auto_increment,
	`a` INT NOT NULL,
	`b` REAL NOT NULL,
	PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


DROP PROCEDURE IF EXISTS fillTables;
delimiter $$
CREATE PROCEDURE fillTables (IN rowNumber INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE curA INT DEFAULT 0;
    DECLARE counter INT DEFAULT 0;
    DECLARE a INT DEFAULT 0;
    
    DECLARE curLine
		CURSOR FOR
			SELECT a from `table1`;
            
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    fillFirst: LOOP
		SET a = FLOOR(RAND() * 10);
        INSERT INTO table1 VALUES (null, a, 0.01 * a);
        SET counter = counter + 1;
		IF  counter = rowNumber THEN
			LEAVE fillFirst;
		END IF;
    END LOOP fillFirst;
		
    OPEN curLine;
    
	fillSecond: LOOP
		FETCH curLine INTO a;
        IF  done = 1 THEN
			LEAVE fillSecond;
		END IF;
        INSERT INTO table2 VALUES (null, a, a*a);
    END LOOP fillSecond;
    
	CLOSE curLine;
    
END;

$$

DROP PROCEDURE IF EXISTS showStatAB; $$
CREATE PROCEDURE showStatAB () 
BEGIN
	DECLARE avg1A REAL DEFAULT 0;
	DECLARE median1A REAL DEFAULT 0;
	DECLARE std1A REAL DEFAULT 0;
	DECLARE avg2A REAL DEFAULT 0;
	DECLARE median2A REAL DEFAULT 0;
	DECLARE std2A REAL DEFAULT 0;
    
    DECLARE avg1B REAL DEFAULT 0;
	DECLARE median1B REAL DEFAULT 0;
	DECLARE std1B REAL DEFAULT 0;
	DECLARE avg2B REAL DEFAULT 0;
	DECLARE median2B REAL DEFAULT 0;
	DECLARE std2B REAL DEFAULT 0;
    
    DECLARE medianRow INT DEFAULT 0;
    
    SET medianRow = FLOOR((SELECT COUNT(*) FROM table1) / 2);
    
    SET avg1A = (SELECT AVG(a) from table1);
    SET std1A = (SELECT STD(a) from table1);
    SET avg2A = (SELECT AVG(a) from table2);
    SET std2A = (SELECT STD(a) from table2);
    SET median1A = (SELECT a FROM table1 ORDER BY a ASC LIMIT medianRow,1);
    SET median2A = (SELECT a FROM table2 ORDER BY a ASC LIMIT medianRow,1);
    
    SET avg1B = (SELECT AVG(b) from table1);
    SET std1B = (SELECT STD(b) from table1);
    SET avg2B = (SELECT AVG(b) from table2);
    SET std2B = (SELECT STD(b) from table2);
    SET median1B = (SELECT b FROM table1 ORDER BY a ASC LIMIT medianRow,1);
    SET median2B = (SELECT b FROM table2 ORDER BY a ASC LIMIT medianRow,1);
    
    SELECT avg1A, avg2A, std1A, std2A, median1A, median2A, avg1B, avg2B, std1B, std2B, median1B, median2B;
    
END;
$$
CALL fillTables(100); $$
CALL showStatAB(); $$