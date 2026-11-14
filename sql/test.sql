-- contraseña de escuela "n0m3l0"
-- contraseña de erick "3141592653589793238463"

drop database if exists psicometric;
create database psicometric;
use psicometric;
CREATE TABLE `tutor` (
                         `idtutor` int NOT NULL AUTO_INCREMENT,
                         `Nombretut` varchar(50) NOT NULL,
                         `Apellidostut` varchar(60) NOT NULL,
                         `correotut` varchar(50) DEFAULT NULL,
                         `Contratut` varchar(30) NOT NULL,
                         `Fechanactutor` date NOT NULL,
                         PRIMARY KEY (`idtutor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `psicometric`.`paciente` (
                                          `idpaciente` INT NOT NULL AUTO_INCREMENT,
                                          `Nombrepac` VARCHAR(45) NOT NULL,
                                          `Apellidospac` VARCHAR(50) NOT NULL,
                                          `Fechanacpac` DATE NOT NULL,
                                          `generopsc` VARCHAR(20) NOT NULL,
                                          `correopac` VARCHAR(50) DEFAULT NULL,
                                          `contrapac` VARCHAR(30) NOT NULL,
                                          PRIMARY KEY (`idpaciente`));
CREATE TABLE `consulta` (
                            `idconsulta` int NOT NULL,
                            `Cedula` smallint NOT NULL,
                            `idpaciente` int DEFAULT NULL,
                            `idtutor` int DEFAULT NULL,
                            `Fechaconsulta` DATETIME DEFAULT NULL,
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
                             `correopsic` varchar(50) default NULL,
                             `Titulo` varchar(30) NOT NULL,
                             `Escuela` varchar(50) NOT NULL,
                             PRIMARY KEY (`cedula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into paciente (Nombrepac, Apellidospac, Fechanacpac, generopsc, contrapac, correopac)
values ('Erick', 'Gonzalez', '2000-01-01', 'Masculino', '3141592653589793238463', 'erick.gonzalez@email.com'),
       ('Juan', 'Perez', '1995-05-15', 'Masculino', 'password123', 'juan.perez@email.com'),
       ('Maria', 'Lopez', '1988-10-20', 'Femenino', 'securepass', 'maria.lopez@email.com'),
       ('Ana', 'Gomez', '2002-07-30', 'Femenino', 'mypassword', 'ana.gomez@email.com'),
       ('Luis', 'Martinez', '1990-03-12', 'Masculino', 'passw0rd', 'luis.martinez@email.com');
insert into tutor (Nombretut, Apellidostut, Contratut, Fechanactutor, correotut)
values ('Carlos', 'Ramirez', 'tutorpass1', '1975-04-10', 'carlos.ramirez@email.com'),
       ('Laura', 'Torres', 'tutorpass2', '1980-08-25', 'laura.torres@email.com');
insert into psicologo (cedula, Nombre, Apellidospsic, Fechanacpsic, Generopsic, Contrapsic, correopsic, Titulo, Escuela)
values (123456, 'Dr. Juan', 'Martinez', '1970-02-15', 'Masculino', 'psicopass1', 'juan.martinez@email.com', 'Psicologo', 'UNAM'),
         (789012, 'Dra. Ana', 'Gomez', '1985-11-05', 'Femenino', 'psicopass2', 'ana.gomez@email.com', 'Psicologo', 'UNAM');