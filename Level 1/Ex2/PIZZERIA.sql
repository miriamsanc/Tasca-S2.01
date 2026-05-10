-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Clients` (
  `idClients` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Zip code` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idClients`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Store` (
  `idStore` INT NOT NULL AUTO_INCREMENT,
  `Address` VARCHAR(45) NOT NULL,
  `Zipcode` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idStore`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Employees` (
  `idEmployees` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Surname` VARCHAR(45) NOT NULL,
  `NIF` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `WorkPosition` ENUM('COOK', 'DRIVER') NOT NULL,
  `Store_idStore` INT NOT NULL,
  PRIMARY KEY (`idEmployees`),
  INDEX `fk_Employees_Store1_idx` (`Store_idStore` ASC),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  CONSTRAINT `fk_Employees_Store1`
    FOREIGN KEY (`Store_idStore`)
    REFERENCES `Pizzeria`.`Store` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `Datetime` DATETIME NOT NULL,
  `Type` ENUM('DELIVERY', 'TAKE AWAY') NOT NULL,
  `ProductQuantity` INT NOT NULL,
  `TotalPrice` DECIMAL(7,2) NOT NULL,
  `DateTimeDelivery` DATETIME NOT NULL,
  `Clients_idClients` INT NOT NULL,
  `Store_idStore` INT NOT NULL,
  `Employees_idEmployees` INT NOT NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `fk_Orders_Clients1_idx` (`Clients_idClients` ASC),
  INDEX `fk_Orders_Store1_idx` (`Store_idStore` ASC),
  INDEX `fk_Orders_Employees1_idx` (`Employees_idEmployees` ASC),
  CONSTRAINT `fk_Orders_Clients1`
    FOREIGN KEY (`Clients_idClients`)
    REFERENCES `Pizzeria`.`Clients` (`idClients`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Store1`
    FOREIGN KEY (`Store_idStore`)
    REFERENCES `Pizzeria`.`Store` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employees1`
    FOREIGN KEY (`Employees_idEmployees`)
    REFERENCES `Pizzeria`.`Employees` (`idEmployees`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categories` (
  `idCategories` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategories`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Products` (
  `idProducts` INT NOT NULL AUTO_INCREMENT,
  `Type` ENUM('PIZZA', 'BURGER', 'DRINK') NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(100) NULL,
  `Image` BLOB NULL,
  `Price` DECIMAL(7,2) NOT NULL,
  `Categories_idCategories` INT NULL,
  PRIMARY KEY (`idProducts`),
  INDEX `fk_Products_Categories1_idx` (`Categories_idCategories` ASC),
  CONSTRAINT `fk_Products_Categories1`
    FOREIGN KEY (`Categories_idCategories`)
    REFERENCES `Pizzeria`.`Categories` (`idCategories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Order_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Order_products` (
  `idOrder_products` INT NOT NULL AUTO_INCREMENT,
  `Orders_idOrders` INT NOT NULL,
  `Products_idProducts` INT NOT NULL,
  PRIMARY KEY (`idOrder_products`, `Orders_idOrders`, `Products_idProducts`),
  INDEX `fk_Order_products_Orders1_idx` (`Orders_idOrders` ASC),
  INDEX `fk_Order_products_Products1_idx` (`Products_idProducts` ASC),
  CONSTRAINT `fk_Order_products_Orders1`
    FOREIGN KEY (`Orders_idOrders`)
    REFERENCES `Pizzeria`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_products_Products1`
    FOREIGN KEY (`Products_idProducts`)
    REFERENCES `Pizzeria`.`Products` (`idProducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO Clients (Name, Surname, Address, `Zip code`, City, Province, Phone) VALUES
('Mark', 'Gonzalez', 'Main Street 12', '08221', 'Terrassa', 'Barcelona', '612345678'),
('Laura', 'Martinez', 'Catalonia Ave 55', '08025', 'Barcelona', 'Barcelona', '698745632'),
('George', 'Peters', 'Saint Peter St 8', '08202', 'Sabadell', 'Barcelona', '677889900');

INSERT INTO Store (Address, Zipcode, City, Province) VALUES
('Colom Street 33', '08222', 'Terrassa', 'Barcelona'),
('Rambla 120', '08001', 'Barcelona', 'Barcelona');

INSERT INTO Employees (Name, Surname, NIF, Phone, WorkPosition, Store_idStore) VALUES
('Paul', 'Serrano', '12345678A', '611223344', 'COOK', 1),
('Martha', 'Ribas', '87654321B', '622334455', 'COOK', 2),
('Arnold', 'Casas', '11223344C', '633445566', 'DRIVER', 1),
('Claire', 'Jimenez', '44332211D', '644556677', 'DRIVER', 2);

INSERT INTO Categories (Name) VALUES
('Classic'),
('Special'),
('Vegetarian');

INSERT INTO Products (Type, Name, Description, Image, Price, Categories_idCategories) VALUES
('PIZZA', 'Margherita', 'Tomato, mozzarella, basil', NULL, 8.50, 1),
('PIZZA', 'Four Cheese', 'Mozzarella, gorgonzola, parmesan, cheddar', NULL, 10.00, 1),
('PIZZA', 'Veggie', 'Mixed vegetables and cheese', NULL, 9.50, 3),
('BURGER', 'Classic Burger', 'Beef, lettuce, tomato, cheese', NULL, 7.20, NULL),
('BURGER', 'BBQ Burger', 'Beef, caramelized onion, BBQ sauce', NULL, 8.00, NULL),
('DRINK', 'Coca-Cola', 'Can 33cl', NULL, 1.80, NULL),
('DRINK', 'Mineral Water', 'Bottle 50cl', NULL, 1.20, NULL);

INSERT INTO Orders (Datetime, Type, ProductQuantity, TotalPrice, DateTimeDelivery, Clients_idClients, Store_idStore, Employees_idEmployees) VALUES
('2024-01-10 20:15:00', 'DELIVERY', 3, 18.50, '2024-01-10 20:45:00', 1, 1, 3),
('2024-01-11 13:00:00', 'TAKE AWAY', 1, 9.50, '2024-01-11 13:00:00', 2, 2, 4),
('2024-01-12 21:10:00', 'DELIVERY', 3, 22.00, '2024-01-12 21:40:00', 3, 1, 3);


INSERT INTO Order_products (idOrder_products, Orders_idOrders, Products_idProducts) VALUES
(1, 1, 1),  -- Margherita
(2, 1, 6),  -- Coca-Cola
(3, 1, 6),  -- Coca-Cola (2nd unit)
(4, 2, 3),  -- Veggie
(5, 3, 2),  -- Four Cheese
(6, 3, 4),  -- Classic Burger
(7, 3, 7);  -- Mineral Water

