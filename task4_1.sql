-- Используя таблицу с полями дата/соперник/результат, найти самую
-- долгую серию побед, поражений и ничьих команды в сезоне. Поле
-- результат принимает следующие значения: 1 – победа, 0 – ничья, -1 –
-- поражение.

CREATE SCHEMA IF NOT EXISTS `task4_1` DEFAULT CHARACTER SET utf8 ;
USE `task4_1` ;

DROP TABLE IF EXISTS `task4_1`.`table` ;

CREATE TABLE IF NOT EXISTS `task4_1`.`table` (
  `date` INT NOT NULL auto_increment,
  `opponent` VARCHAR(45) NOT NULL,
  `result` INT NOT NULL,
  PRIMARY KEY (`date`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

INSERT INTO `table` VALUES (NULL, "s", 1);
INSERT INTO `table` VALUES (NULL, "s", 1);
INSERT INTO `table` VALUES (NULL, "s", -1);
INSERT INTO `table` VALUES (NULL, "s", 0);
INSERT INTO `table` VALUES (NULL, "s", 1);
INSERT INTO `table` VALUES (NULL, "s", -1);
INSERT INTO `table` VALUES (NULL, "s", -1);


-- Процедура в качестве параметров принимает переменные, в которые будет записан результат.
DROP PROCEDURE IF EXISTS task4_1;
delimiter $$
CREATE PROCEDURE task4_1 (OUT winStreak INT, OUT drawStreak INT, OUT loseStreak INT)
BEGIN

	DECLARE maxWin INT DEFAULT 0;
	DECLARE maxLose INT DEFAULT 0;
	DECLARE maxDraw INT DEFAULT 0;
	DECLARE curWin INT DEFAULT 0;
	DECLARE curLose INT DEFAULT 0;
	DECLARE curDraw INT DEFAULT 0;
    
    DECLARE done INT DEFAULT 0;
    DECLARE res INT DEFAULT 0;
    
    DECLARE curResult
		CURSOR FOR
			SELECT result from `table`;
            
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN curResult;
	getResult: LOOP
		FETCH curResult INTO res;
        IF  done = 1 THEN
			LEAVE getResult;
        END IF;
        
        IF  res = 1 THEN
			SET curWin = curWin + 1;
            SET curDraw = 0;
            SET curLose = 0;
        END IF;
        IF  res = 0 THEN
			SET curWin = 0;
            SET curDraw = curDraw + 1;
            SET curLose = 0;
        END IF;
        IF  res = -1 THEN
			SET curWin = 0;
            SET curDraw = 0;
            SET curLose = curLose + 1;
        END IF;
        
        IF  curWin > maxWin THEN
			SET maxWin = curWin;
        END IF;
        IF  curDraw > maxDraw THEN
			SET maxDraw = curDraw;
        END IF;
        IF  curLose > maxLose THEN
			SET maxLose = curLose;
        END IF;
    END LOOP getResult;
    CLOSE curResult;
    SET winStreak = maxWin;
    SET drawStreak = maxDraw;
    SET loseStreak = maxLose;
    
END;

$$


CALL task4_1(@win, @draw, @lose);
select @win, @draw, @lose;

