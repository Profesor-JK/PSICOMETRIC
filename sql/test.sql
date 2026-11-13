-- contraseña de escuela "n0m3l0"
-- contraseña de erick "3141592653589793238463"

drop database if exists psicometric;
create database psicometric;
CREATE TABLE `psicometric`.`paciente` (
                                          `idpaciente` INT NOT NULL AUTO_INCREMENT,
                                          `Nombrepac` VARCHAR(45) NOT NULL,
                                          `Apellidospac` VARCHAR(50) NOT NULL,
                                          `Fechanacpac` DATE NOT NULL,
                                          `generopsc` VARCHAR(20) NOT NULL,
                                          `contrapac` VARCHAR(30) NOT NULL,
                                          PRIMARY KEY (`idpaciente`));
CREATE TABLE `consulta` (
                            `idconsulta` int NOT NULL,
                            `Cedula` smallint NOT NULL,
                            `idpaciente` int DEFAULT NULL,
                            `idtutor` int DEFAULT NULL,
                            `consultacol` varchar(45) DEFAULT NULL,
                            PRIMARY KEY (`idconsulta`),
                            KEY `idpaciente_idx` (`idpaciente`),
                            KEY `idtutor_idx` (`idtutor`),
                            CONSTRAINT `idpaciente` FOREIGN KEY (`idpaciente`) REFERENCES `paciente` (`idpaciente`),
                            CONSTRAINT `idtutor` FOREIGN KEY (`idtutor`) REFERENCES `tutor` (`idtutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `psicologo` (
                             `cedula` int NOT NULL,
                             `Nombre` varchar(45) NOT NULL,
                             `Apellidospsic` varchar(45) NOT NULL,
                             `Fechanacpsic` date NOT NULL,
                             `Generopsic` varchar(20) NOT NULL,
                             `Contrapsic` varchar(30) NOT NULL,
                             PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `tutor` (
                         `idtutor` int NOT NULL AUTO_INCREMENT,
                         `Nombretut` varchar(50) NOT NULL,
                         `Apellidostut` varchar(60) NOT NULL,
                         `Contratut` varchar(30) NOT NULL,
                         `Fechanactutor` date NOT NULL,
                         PRIMARY KEY (`idtutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;