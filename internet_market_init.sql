-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `internet_market` DEFAULT CHARACTER SET utf8 ;
USE `internet_market` ;

-- -----------------------------------------------------
-- Table `mydb`.`byer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`byer` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`byer` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`seller` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`seller` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`product` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`product` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `amount` INT NULL,
  `price` INT NULL,
  `seller_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_seller1_idx` (`seller_id` ASC),
  CONSTRAINT `fk_product_seller1`
    FOREIGN KEY (`seller_id`)
    REFERENCES `mydb`.`seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`order` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`order` (
  `id` INT NOT NULL,
  `byer_id` INT NULL,
  `seller_id` INT NULL,
  `date` DATE NULL,
  `byer_id1` INT NOT NULL,
  `seller_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_byer_idx` (`byer_id1` ASC),
  INDEX `fk_order_seller1_idx` (`seller_id1` ASC),
  CONSTRAINT `fk_order_byer`
    FOREIGN KEY (`byer_id1`)
    REFERENCES `mydb`.`byer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_seller1`
    FOREIGN KEY (`seller_id1`)
    REFERENCES `mydb`.`seller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`category` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_in_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`product_in_order` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`product_in_order` (
  `number` INT NOT NULL,
  `amount` INT NULL,
  `price` INT NULL,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`number`, `order_id`, `product_id`),
  INDEX `fk_product_in_order_order1_idx` (`order_id` ASC),
  INDEX `fk_product_in_order_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_product_in_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_in_order_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`product_has_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `internet_market`.`product_has_category` ;

CREATE TABLE IF NOT EXISTS `internet_market`.`product_has_category` (
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `category_id`),
  INDEX `fk_product_has_category_category1_idx` (`category_id` ASC),
  INDEX `fk_product_has_category_product1_idx` (`product_id` ASC),
  CONSTRAINT `fk_product_has_category_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `mydb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
