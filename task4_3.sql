-- Выполнять только после выполнения файла task4_2. Используется та же база и таблица

-- Напишите процедуру, которая выводит тестовые вопросы из таблицы с
-- полями id-test/id-quest/var1/var2/var3 в случайном порядке. Варианты
-- ответов при этом для каждого вопроса также выводятся в случайном
-- порядке.

USE `task4_2` ;

-- В моей процедуре для каждой строки выбирается случайная последовательность ответов. Мне кажется, что менять местами столбцы целиком несколько странно.
-- Перемешивание ведь делают, чтобы если у злоумышленника есть клюжч к тесту в виде номеров правильных ответов, то он не смог их применить, потому что варианты перемешаны.
-- Если же менять столбцы целиком, то по нескольким вопросам злоумышленник может вычислить перестановку и ответить на остальные вопросы правильно. 
DROP PROCEDURE IF EXISTS shuffleTest;
delimiter $$
CREATE PROCEDURE shuffleTest (IN testId INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE curId INT DEFAULT 0;
    DECLARE curText CHAR(45) DEFAULT "";
    DECLARE curVar1 CHAR(45) DEFAULT "";
    DECLARE curVar2 CHAR(45) DEFAULT "";
    DECLARE curVar3 CHAR(45) DEFAULT "";
    
    DECLARE r INT DEFAULT 0;
    
    DECLARE curQuestion
		CURSOR FOR
			SELECT question_id, `text`, var1, var2, var3 from `test`
				JOIN question on question.id = question_id
                WHERE test_id = testId;
            
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    CREATE TABLE IF NOT EXISTS `task4_2`.`temp` (
		`test_id` INT NOT NULL,
		`question_id` INT NOT NULL,
		`text` VARCHAR(45) NOT NULL,
		`var1` VARCHAR(45) NOT NULL,
		`var2` VARCHAR(45) NOT NULL,
		`var3` VARCHAR(45) NOT NULL,
		PRIMARY KEY (`test_id`,`question_id`))
	ENGINE = InnoDB
	DEFAULT CHARACTER SET = utf8;
    
    OPEN curQuestion;
    
	fillTemp: LOOP
		FETCH curQuestion INTO curId, curText, curVar1, curVar2, curVar3;
        IF  done = 1 THEN
			LEAVE fillTemp;
		END IF;
		SET r = FLOOR(RAND() * 6);
        CASE r
			WHEN 0 THEN INSERT INTO temp VALUES (testId, curId, curText, curVar1, curVar2, curVar3);
			WHEN 1 THEN INSERT INTO temp VALUES (testId, curId, curText, curVar1, curVar3, curVar2);
			WHEN 2 THEN INSERT INTO temp VALUES (testId, curId, curText, curVar2, curVar1, curVar3);
			WHEN 3 THEN INSERT INTO temp VALUES (testId, curId, curText, curVar2, curVar3, curVar1);
			WHEN 4 THEN INSERT INTO temp VALUES (testId, curId, curText, curVar3, curVar1, curVar2);
			WHEN 5 THEN INSERT INTO temp VALUES (testId, curId, curText, curVar3, curVar2, curVar1);
        END CASE;
        
    END LOOP fillTemp;
    
	CLOSE curQuestion;
    
    SELECT * from temp ORDER BY RAND();
    
    DROP TABLE `task4_2`.`temp`;
    
END;

$$

CALL shuffleTest(1);