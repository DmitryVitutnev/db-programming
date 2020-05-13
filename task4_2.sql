-- Имеется таблица вопрос/ответ1/ответ2/ответ3/уровень сложности с
-- вопросами с указанием уровня их сложности: 1 – простые, 2 – средние, 3
-- – трудные. Необходимо сформировать тест из вопросов так, чтобы
-- простые и сложные вопросы входили в него в соответствии с заданным
-- процентным соотношением.

CREATE SCHEMA IF NOT EXISTS `task4_2` DEFAULT CHARACTER SET utf8 ;
USE `task4_2` ;

DROP TABLE IF EXISTS `task4_2`.`question` ;

CREATE TABLE IF NOT EXISTS `task4_2`.`question` (
  `id` INT NOT NULL auto_increment,
  `text` VARCHAR(45) NOT NULL,
  `var1` VARCHAR(45) NOT NULL,
  `var2` VARCHAR(45) NOT NULL,
  `var3` VARCHAR(45) NOT NULL,
  `difficulty` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `task4_2`.`test` ;

CREATE TABLE IF NOT EXISTS `task4_2`.`test` (
  `test_id` INT NOT NULL,
  `question_id` INT NOT NULL,
  PRIMARY KEY (`test_id`, `question_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 1);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 1);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 1);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 1);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 1);

INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 2);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 2);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 2);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 2);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 2);

INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 3);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 3);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 3);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 3);
INSERT INTO `question` VALUES (NULL, "s", "a", "b", "c", 3);


-- В мою процедуру нужно передавать не процентное соотношение вопросов, а количества вопросов каждого типа.
-- Такой подход показался мне более удобным в использовании, так как при процентном соотношении возникают проблемы,
-- если хочется сделать поровну вопросов каждого типа - получается, что нужно указать 33.33333...%, а это неудобно и ненадёжно.
-- А так как потребность сделать тест с одинаковым числом вопросов каждого типа возникает довольно часто, я решил
-- изменить сигнатуру, чтобы проблем не возникало.
DROP PROCEDURE IF EXISTS createTest;
delimiter $$
CREATE PROCEDURE createTest (IN testId INT, IN easy INT, IN normal INT, IN hard INT)
BEGIN

	DECLARE questionNumber INT DEFAULT 0;

	DECLARE needEasy INT DEFAULT 0;
	DECLARE needNormal INT DEFAULT 0;
	DECLARE needHard INT DEFAULT 0;
    
    DECLARE done INT DEFAULT 0;
    DECLARE curId INT DEFAULT 0;
    DECLARE curDif INT DEFAULT 0;
    
    DECLARE curQuestion
		CURSOR FOR
			SELECT id, difficulty from `question`
				ORDER BY RAND();
            
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN curQuestion;
    
    SET needEasy = easy;
    SET needNormal = normal;
    SET needHard = hard;
    
    
	fillTest: LOOP
		FETCH curQuestion INTO curId, curDif;
        IF  done = 1 or (needEasy + needNormal + needHard = 0) THEN
			LEAVE fillTest;
        END IF;
        
        IF  curDif = 1 and needEasy > 0 THEN
			INSERT INTO test VALUES (testId, curId);
            SET needEasy = needEasy - 1;
        END IF;
        IF  curDif = 2 and needNormal > 0 THEN
			INSERT INTO test VALUES (testId, curId);
            SET needNormal = needNormal - 1;
        END IF;
        IF  curDif = 3 and needHard > 0 THEN
			INSERT INTO test VALUES (testId, curId);
            SET needHard = needHard - 1;
        END IF;
        
    END LOOP fillTest;
    
	CLOSE curQuestion;
END;

$$


CALL createTest(1, 3, 5, 4);

SELECT * from test;