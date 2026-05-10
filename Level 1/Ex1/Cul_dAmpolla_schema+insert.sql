
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Cul_d_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Cul_d_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Cul_d_ampolla` DEFAULT CHARACTER SET utf8mb4 ;
USE `Cul_d_ampolla` ;

-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Addresses` (
  `Addresses_id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `floor` VARCHAR(45) NULL,
  `apt` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Addresses_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Suppliers` (
  `suppliers_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `Addresses_id` INT NOT NULL,
  PRIMARY KEY (`suppliers_id`),
  INDEX `fk_Suppliers_Addresses_idx` (`Addresses_id` ASC),
  CONSTRAINT `fk_Suppliers_Addresses1`
    FOREIGN KEY (`Addresses_id`)
    REFERENCES `Cul_d_ampolla`.`Addresses` (`Addresses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Clients` (
  `Clients_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `registration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `referred_by` INT NULL,
  INDEX `referred_by` (`referred_by` ASC),
  PRIMARY KEY (`Clients_id`),
  CONSTRAINT `fk_clientes_referred_by`
    FOREIGN KEY (`referred_by`)
    REFERENCES `Cul_d_ampolla`.`Clients` (`Clients_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Brands`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Brands` (
  `brands_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `Suppliers_suppliers_id` INT NOT NULL,
  PRIMARY KEY (`brands_id`),
  INDEX `fk_Brands_Suppliers1_idx` (`Suppliers_suppliers_id` ASC),
  CONSTRAINT `fk_Brands_Suppliers1`
    FOREIGN KEY (`Suppliers_suppliers_id`)
    REFERENCES `Cul_d_ampolla`.`Suppliers` (`suppliers_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Glasses` (
  `glasses_id` INT NOT NULL AUTO_INCREMENT,
  `left_lens_prescription` DECIMAL(7,2) NOT NULL,
  `right_lens_prescription` DECIMAL(7,2) NOT NULL,
  `frame_type` ENUM('RIMLESS', 'ACETATE', 'METAL') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `left_lens_color` VARCHAR(45) NOT NULL,
  `right_lens_color` VARCHAR(45) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `Brands_brands_id` INT NOT NULL,
  PRIMARY KEY (`glasses_id`),
  INDEX `fk_Glasses_Brands1_idx` (`Brands_brands_id` ASC),
  CONSTRAINT `fk_Glasses_Brands1`
    FOREIGN KEY (`Brands_brands_id`)
    REFERENCES `Cul_d_ampolla`.`Brands` (`brands_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Employees` (
  `employees_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employees_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `Cul_d_ampolla`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cul_d_ampolla`.`Sales` (
  `sales_id` INT NOT NULL AUTO_INCREMENT,
  `Employees_id` INT NOT NULL,
  `Glasses_id` INT NOT NULL,
  `Clients_Clients_id` INT NOT NULL,
  `sale_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_id`),
  INDEX `fk_Sales_Employees_idx` (`Employees_id` ASC),
  INDEX `fk_Sales_Glasses_idx` (`Glasses_id` ASC),
  INDEX `fk_Sales_Clients1_idx` (`Clients_Clients_id` ASC),
  CONSTRAINT `fk_Sales_Employees`
    FOREIGN KEY (`Employees_id`)
    REFERENCES `Cul_d_ampolla`.`Employees` (`employees_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Glasses`
    FOREIGN KEY (`Glasses_id`)
    REFERENCES `Cul_d_ampolla`.`Glasses` (`glasses_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sales_Clients1`
    FOREIGN KEY (`Clients_Clients_id`)
    REFERENCES `Cul_d_ampolla`.`Clients` (`Clients_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO Addresses (Addresses_id, street, number, floor, apt, city, zip_code, country)
VALUES
(1, 'Carrer Major', '10', NULL, NULL, 'Barcelona', '08001', 'Spain'),
(2, 'Avinguda Roma', '25', '2', '1A', 'Tarragona', '43005', 'Spain'),
(3, 'Passeig Marítim', '88', NULL, NULL, 'Reus', '43201', 'Spain');

INSERT INTO Suppliers (suppliers_id, name, phone, fax, NIF, Addresses_id)
VALUES
(1, 'Optica Barcelona SL', '931234567', '931234568', 'B12345678', 1),
(2, 'Vision Costa SL', '977112233', '977112234', 'B87654321', 2);

INSERT INTO Clients (Clients_id, name, address, phone, email, registration_date, referred_by)
VALUES
(1, 'Ana López', 'Barcelona', '600111222', 'ana@mail.com', '2023-01-10', NULL),
(2, 'Marc Puig', 'Tarragona', '600333444', 'marc@mail.com', '2025-02-18', 1),
(3, 'Laura Serra', 'Reus', '600555666', 'laura@mail.com', '2026-03-05', 1);

INSERT INTO Brands (brands_id, name, Suppliers_suppliers_id)
VALUES
(1, 'RayVision', 1),
(2, 'SunOptic', 2);

INSERT INTO Glasses (
glasses_id, left_lens_prescription, right_lens_prescription,
frame_type, frame_color, left_lens_color, right_lens_color, price, Brands_brands_id
)
VALUES
(1, 1.25, 1.00, 'METAL', 'Black', 'Transparent', 'Transparent', 120.00, 1),
(2, 2.00, 2.25, 'ACETATE', 'Brown', 'Blue', 'Blue', 150.00, 2);

INSERT INTO Employees (employees_id, name)
VALUES
(1, 'Carlos Martín'),
(2, 'Elena Vidal');

INSERT INTO Sales (sales_id, Employees_id, Glasses_id, Clients_Clients_id)
VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 1, 2, 3);