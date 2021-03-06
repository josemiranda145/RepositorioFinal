-- MySQL Script generated by MySQL Workbench
-- Fri Jun  1 20:14:25 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Ferreteria_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Ferreteria_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Ferreteria_db` DEFAULT CHARACTER SET utf8 ;
USE `Ferreteria_db` ;

-- -----------------------------------------------------
-- Table `Ferreteria_db`.`CRol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`CRol` (
  `IDRol` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`IDRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `DPI` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Telefono` VARCHAR(45) NULL,
  `Login` VARCHAR(45) NULL,
  `Contraseña` VARCHAR(45) NULL,
  `Ciudad` VARCHAR(45) NULL,
  `Correo` VARCHAR(45) NULL,
  `CRol_IDRol` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `CRol_IDRol`),
  INDEX `fk_Usuario_CRol1_idx` (`CRol_IDRol` ASC),
  CONSTRAINT `fk_Usuario_CRol1`
    FOREIGN KEY (`CRol_IDRol`)
    REFERENCES `Ferreteria_db`.`CRol` (`IDRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Solicitud` (
  `idSolicitud` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `FechaPeticion` DATE NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Usuario_CRol_IDRol` INT NOT NULL,
  `Usuario_idUsuario1` INT NOT NULL,
  `Usuario_CRol_IDRol1` INT NOT NULL,
  PRIMARY KEY (`idSolicitud`, `Usuario_idUsuario`, `Usuario_CRol_IDRol`, `Usuario_idUsuario1`, `Usuario_CRol_IDRol1`),
  INDEX `fk_Solicitud_Usuario1_idx` (`Usuario_idUsuario1` ASC, `Usuario_CRol_IDRol1` ASC),
  CONSTRAINT `fk_Solicitud_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario1` , `Usuario_CRol_IDRol1`)
    REFERENCES `Ferreteria_db`.`Usuario` (`idUsuario` , `CRol_IDRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Pedido` (
  `idPedido` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `FechaPeticion` DATE NULL,
  `Solicitud_idSolicitud` INT NOT NULL,
  `Solicitud_Usuario_idUsuario` INT NOT NULL,
  `Solicitud_Usuario_CRol_IDRol` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Solicitud_idSolicitud`, `Solicitud_Usuario_idUsuario`, `Solicitud_Usuario_CRol_IDRol`),
  INDEX `fk_Pedido_Solicitud1_idx` (`Solicitud_idSolicitud` ASC, `Solicitud_Usuario_idUsuario` ASC, `Solicitud_Usuario_CRol_IDRol` ASC),
  CONSTRAINT `fk_Pedido_Solicitud1`
    FOREIGN KEY (`Solicitud_idSolicitud` , `Solicitud_Usuario_idUsuario` , `Solicitud_Usuario_CRol_IDRol`)
    REFERENCES `Ferreteria_db`.`Solicitud` (`idSolicitud` , `Usuario_idUsuario` , `Usuario_CRol_IDRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Estado` (
  `idEstado` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Solicitud_idSolicitud` INT NOT NULL,
  `Pedido_Solicitud_Usuario_idUsuario` INT NOT NULL,
  `Pedido_Solicitud_Usuario_CRol_IDRol` INT NOT NULL,
  PRIMARY KEY (`idEstado`, `Pedido_idPedido`, `Pedido_Solicitud_idSolicitud`, `Pedido_Solicitud_Usuario_idUsuario`, `Pedido_Solicitud_Usuario_CRol_IDRol`),
  INDEX `fk_Estado_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Solicitud_idSolicitud` ASC, `Pedido_Solicitud_Usuario_idUsuario` ASC, `Pedido_Solicitud_Usuario_CRol_IDRol` ASC),
  CONSTRAINT `fk_Estado_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Solicitud_idSolicitud` , `Pedido_Solicitud_Usuario_idUsuario` , `Pedido_Solicitud_Usuario_CRol_IDRol`)
    REFERENCES `Ferreteria_db`.`Pedido` (`idPedido` , `Solicitud_idSolicitud` , `Solicitud_Usuario_idUsuario` , `Solicitud_Usuario_CRol_IDRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Catalogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Catalogo` (
  `idCatalogo` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idCatalogo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Categoria` (
  `idCategoria` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Catalogo_idCatalogo` INT NOT NULL,
  PRIMARY KEY (`idCategoria`, `Catalogo_idCatalogo`),
  INDEX `fk_Categoria_Catalogo1_idx` (`Catalogo_idCatalogo` ASC),
  CONSTRAINT `fk_Categoria_Catalogo1`
    FOREIGN KEY (`Catalogo_idCatalogo`)
    REFERENCES `Ferreteria_db`.`Catalogo` (`idCatalogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Articulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Articulo` (
  `idArticulo` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Categoria_idCategoria` INT NOT NULL,
  `Categoria_Catalogo_idCatalogo` INT NOT NULL,
  `Solicitud_idSolicitud` INT NOT NULL,
  PRIMARY KEY (`idArticulo`, `Categoria_idCategoria`, `Categoria_Catalogo_idCatalogo`, `Solicitud_idSolicitud`),
  INDEX `fk_Articulo_Categoria1_idx` (`Categoria_idCategoria` ASC, `Categoria_Catalogo_idCatalogo` ASC),
  INDEX `fk_Articulo_Solicitud1_idx` (`Solicitud_idSolicitud` ASC),
  CONSTRAINT `fk_Articulo_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria` , `Categoria_Catalogo_idCatalogo`)
    REFERENCES `Ferreteria_db`.`Categoria` (`idCategoria` , `Catalogo_idCatalogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Articulo_Solicitud1`
    FOREIGN KEY (`Solicitud_idSolicitud`)
    REFERENCES `Ferreteria_db`.`Solicitud` (`idSolicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ferreteria_db`.`Atributo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ferreteria_db`.`Atributo` (
  `idAtributo` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Valor` VARCHAR(45) NULL,
  `FechaPeticion` VARCHAR(45) NULL,
  `Articulo_idArticulo` INT NOT NULL,
  `Articulo_Categoria_idCategoria` INT NOT NULL,
  `Articulo_Categoria_Catalogo_idCatalogo` INT NOT NULL,
  PRIMARY KEY (`idAtributo`, `Articulo_idArticulo`, `Articulo_Categoria_idCategoria`, `Articulo_Categoria_Catalogo_idCatalogo`),
  INDEX `fk_Atributo_Articulo1_idx` (`Articulo_idArticulo` ASC, `Articulo_Categoria_idCategoria` ASC, `Articulo_Categoria_Catalogo_idCatalogo` ASC),
  CONSTRAINT `fk_Atributo_Articulo1`
    FOREIGN KEY (`Articulo_idArticulo` , `Articulo_Categoria_idCategoria` , `Articulo_Categoria_Catalogo_idCatalogo`)
    REFERENCES `Ferreteria_db`.`Articulo` (`idArticulo` , `Categoria_idCategoria` , `Categoria_Catalogo_idCatalogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
