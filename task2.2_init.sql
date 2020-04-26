-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema task2_2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema task2_2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `task2_2` DEFAULT CHARACTER SET utf8 ;
USE `task2_2` ;

-- -----------------------------------------------------
-- Table `task2_2`.`team_trainer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `task2_2`.`team_trainer` ;

CREATE TABLE IF NOT EXISTS `task2_2`.`team_trainer` (
  `team` VARCHAR(45) NOT NULL,
  `trainer` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`team`, `trainer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task2_2`.`author_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `task2_2`.`author_genre` ;

CREATE TABLE IF NOT EXISTS `task2_2`.`author_genre` (
  `author` VARCHAR(45) NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`author`, `genre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task2_2`.`team_trainer_place_score`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `task2_2`.`team_trainer_place_score` ;

CREATE TABLE IF NOT EXISTS `task2_2`.`team_trainer_place_score` (
  `team` VARCHAR(45) NOT NULL,
  `trainer` VARCHAR(45) NOT NULL,
  `place` INT NOT NULL,
  `score` INT NOT NULL,
  PRIMARY KEY (`team`, `trainer`, `place`, `score`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into team_trainer values("Первая", "Дмитрий");
insert into team_trainer values("Первая", "Иван");
insert into team_trainer values("Вторая", "Иван");
insert into team_trainer values("Третья", "Василий");

insert into author_genre values("Дмитрий", "Детектив");
insert into author_genre values("Дмитрий", "Ужасы");
insert into author_genre values("Иван", "Детектив");
insert into author_genre values("Иван", "Фентези");
insert into author_genre values("Иван", "Ужасы");
insert into author_genre values("Василий", "Ужасы");

insert into team_trainer_place_score values("Первая", "Дмитрий", 1, 20);
insert into team_trainer_place_score values("Вторая", "Иван", 2, 15);
insert into team_trainer_place_score values("Третья", "Василий", 3, 10);
insert into team_trainer_place_score values("Четвёртая", "Дмитрий", 4, 0);
insert into team_trainer_place_score values("Первая", "Иван", 1, 150);
