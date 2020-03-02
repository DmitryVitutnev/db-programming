-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema internet_market
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema internet_market
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `internet_market` DEFAULT CHARACTER SET utf8 ;
USE `internet_market` ;

-- -----------------------------------------------------
-- Table `internet_market`.`byer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`byer` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`byer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `internet_market`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`category` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `internet_market`.`seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`seller` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`seller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `internet_market`.`trade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`trade` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`trade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `byer_id` INT NOT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_trade_byer1_idx` (`byer_id` ASC) VISIBLE,
  INDEX `fk_trade_seller1_idx` (`seller_id` ASC) VISIBLE,
  CONSTRAINT `fk_trade_byer1`
    FOREIGN KEY (`byer_id`)
    REFERENCES `internet_market`.`byer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trade_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `internet_market`.`seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `internet_market`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`product` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `amount` INT NOT NULL,
  `price` INT NOT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_seller1_idx` (`seller_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `internet_market`.`seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `internet_market`.`product_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`product_has_category` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`product_has_category` (
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `product_id`),
  INDEX `fk_product_has_category_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_product_has_category_product1_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `internet_market`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `internet_market`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `internet_market`.`product_in_trade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`product_in_trade` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`product_in_trade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` INT NOT NULL,
  `price` INT NOT NULL,
  `trade_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  INDEX `fk_product_in_trade_trade_idx` (`trade_id` ASC) VISIBLE,
  INDEX `fk_product_in_trade_product1_idx` (`product_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_product_in_trade_trade`
    FOREIGN KEY (`trade_id`)
    REFERENCES `internet_market`.`trade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_in_trade_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `internet_market`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
