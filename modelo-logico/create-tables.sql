-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BracaTECH
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BracaTECH
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BracaTECH` DEFAULT CHARACTER SET utf8 ;
USE `BracaTECH` ;

-- -----------------------------------------------------
-- Table `BracaTECH`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`Funcionario` (
  `id` INT NOT NULL,
  `nome_completo` VARCHAR(128) NOT NULL,
  `tipo` VARCHAR(1) NOT NULL,
  `sexo` VARCHAR(1) NULL,
  `data_nascimento` DATE NOT NULL,
  `data_registo_perfil` DATETIME NOT NULL,
  `valor_total_vendas` DOUBLE NULL,
  `salario` DOUBLE NOT NULL,
  `email` VARCHAR(64) NOT NULL,
  `codigo_postal` VARCHAR(16) NOT NULL,
  `cidade` VARCHAR(32) NOT NULL,
  `freguesia` VARCHAR(32) NOT NULL,
  `rua` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`Cliente` (
  `nif` INT NOT NULL,
  `nome_completo` VARCHAR(128) NOT NULL,
  `sexo` CHAR(1) NULL,
  `valor_total_descontos` DOUBLE NULL,
  `valor_total_gasto` DOUBLE NULL,
  `data_nascimento` DATE NOT NULL,
  `data_registo_perfil` DATETIME NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `profissao` VARCHAR(200) NULL,
  `codigo_postal` VARCHAR(20) NOT NULL,
  `cidade` VARCHAR(20) NOT NULL,
  `freguesia` VARCHAR(20) NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `classificacao` VARCHAR(45) NULL,
  PRIMARY KEY (`nif`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`Venda` (
  `id` INT NOT NULL,
  `data_venda` DATETIME NOT NULL,
  `preco_total` DOUBLE NOT NULL,
  `nif_cliente` INT NULL,
  `id_funcionario` INT NOT NULL,
  `valor_desconto` DOUBLE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Venda_Cliente1_idx` (`nif_cliente` ASC) VISIBLE,
  INDEX `fk_Venda_Funcionario1_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_Cliente1`
    FOREIGN KEY (`nif_cliente`)
    REFERENCES `BracaTECH`.`Cliente` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_Funcionario1`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `BracaTECH`.`Funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`Servico` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(2000) NOT NULL,
  `data_inicio` DATETIME NOT NULL,
  `data_fim` DATETIME NULL,
  `estado_equipamento` VARCHAR(2000) NOT NULL,
  `id_funcionario` INT NOT NULL,
  `id_venda` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Servico_Funcionario_idx` (`id_funcionario` ASC) VISIBLE,
  INDEX `fk_Servico_Venda1_idx` (`id_venda` ASC) VISIBLE,
  CONSTRAINT `fk_Servico_Funcionario`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `BracaTECH`.`Funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Servico_Venda1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `BracaTECH`.`Venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`Produto` (
  `id` INT NOT NULL,
  `designacao` VARCHAR(200) NOT NULL,
  `descricao` VARCHAR(2000) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `stock` INT NOT NULL,
  `preco_unitario` DOUBLE NOT NULL,
  `desconto` DOUBLE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`VendaProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`VendaProduto` (
  `id_venda` INT NOT NULL,
  `id_produto` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario_final` DOUBLE NOT NULL,
  `preco_total` DOUBLE NOT NULL,
  `desconto_unitario` DOUBLE NOT NULL,
  `desconto_total` DOUBLE NOT NULL,
  PRIMARY KEY (`id_venda`, `id_produto`),
  INDEX `fk_Venda_has_Produto_Produto1_idx` (`id_produto` ASC) VISIBLE,
  INDEX `fk_Venda_has_Produto_Venda1_idx` (`id_venda` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_has_Produto_Venda1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `BracaTECH`.`Venda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venda_has_Produto_Produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `BracaTECH`.`Produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`ClienteTelefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`ClienteTelefone` (
  `nr_telefone` INT NOT NULL,
  `tipo` CHAR(1) NOT NULL,
  `nif_cliente` INT NOT NULL,
  PRIMARY KEY (`nr_telefone`),
  INDEX `fk_ClienteTelefone_Cliente1_idx` (`nif_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_ClienteTelefone_Cliente1`
    FOREIGN KEY (`nif_cliente`)
    REFERENCES `BracaTECH`.`Cliente` (`nif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BracaTECH`.`FuncionarioTelefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BracaTECH`.`FuncionarioTelefone` (
  `nr_telefone` INT NOT NULL,
  `tipo` VARCHAR(1) NOT NULL,
  `id_funcionario` INT NOT NULL,
  PRIMARY KEY (`nr_telefone`),
  INDEX `fk_FuncionarioTelefone_Funcionario1_idx` (`id_funcionario` ASC) VISIBLE,
  CONSTRAINT `fk_FuncionarioTelefone_Funcionario1`
    FOREIGN KEY (`id_funcionario`)
    REFERENCES `BracaTECH`.`Funcionario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;