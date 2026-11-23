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

select * from psicologo;

CREATE TABLE IF NOT EXISTS test (
                                    idtest         INT NOT NULL AUTO_INCREMENT,
                                    cedula         INT NOT NULL,                       -- psicólogo que lo creó
                                    nombre         VARCHAR(150) NOT NULL,
    categoria      VARCHAR(150) DEFAULT NULL,
    duracion_min   INT DEFAULT NULL,
    descripcion    VARCHAR(2000) DEFAULT NULL,
    instrucciones  VARCHAR(2000) DEFAULT NULL,
    puntaje_min    DECIMAL(10,2) NOT NULL DEFAULT 0,
    puntaje_max    DECIMAL(10,2) NOT NULL DEFAULT 0,
    activo         TINYINT(1) NOT NULL DEFAULT 1,
    fecha_creacion DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idtest),
    KEY test_psicologo_idx (cedula),
    CONSTRAINT fk_test_psicologo FOREIGN KEY (cedula) REFERENCES psicologo (cedula)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS pregunta (
                                        idpregunta   INT NOT NULL AUTO_INCREMENT,
                                        idtest       INT NOT NULL,
                                        orden        INT NOT NULL,
                                        texto        VARCHAR(1000) NOT NULL,
    tipo         VARCHAR(20) NOT NULL,                 -- unica | multiple | escala | abierta
    obligatoria  TINYINT(1) NOT NULL DEFAULT 1,
    escala_min   DECIMAL(10,2) DEFAULT NULL,
    escala_max   DECIMAL(10,2) DEFAULT NULL,
    etiqueta_min VARCHAR(60) DEFAULT NULL,
    etiqueta_max VARCHAR(60) DEFAULT NULL,
    PRIMARY KEY (idpregunta),
    KEY pregunta_test_idx (idtest),
    CONSTRAINT fk_pregunta_test FOREIGN KEY (idtest) REFERENCES test (idtest) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS opcion (
                                      idopcion   INT NOT NULL AUTO_INCREMENT,
                                      idpregunta INT NOT NULL,
                                      orden      INT NOT NULL,
                                      texto      VARCHAR(500) NOT NULL,
    puntos     DECIMAL(10,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (idopcion),
    KEY opcion_pregunta_idx (idpregunta),
    CONSTRAINT fk_opcion_pregunta FOREIGN KEY (idpregunta) REFERENCES pregunta (idpregunta) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS rango_resultado (
                                               idrango     INT NOT NULL AUTO_INCREMENT,
                                               idtest      INT NOT NULL,
                                               minimo      DECIMAL(10,2) NOT NULL,
    maximo      DECIMAL(10,2) NOT NULL,
    titulo      VARCHAR(150) NOT NULL,
    descripcion VARCHAR(2000) DEFAULT NULL,
    nivel       VARCHAR(20) NOT NULL DEFAULT 'primary', -- success | primary | warning | danger | secondary
    PRIMARY KEY (idrango),
    KEY rango_test_idx (idtest),
    CONSTRAINT fk_rango_test FOREIGN KEY (idtest) REFERENCES test (idtest) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS intento (
                                       idintento  INT NOT NULL AUTO_INCREMENT,
                                       idtest     INT NOT NULL,
                                       idpaciente INT NOT NULL,
                                       fecha      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                       puntaje    DECIMAL(10,2) NOT NULL DEFAULT 0,
    idrango    INT DEFAULT NULL,
    PRIMARY KEY (idintento),
    KEY intento_test_idx (idtest),
    KEY intento_paciente_idx (idpaciente),
    CONSTRAINT fk_intento_test FOREIGN KEY (idtest) REFERENCES test (idtest),
    CONSTRAINT fk_intento_paciente FOREIGN KEY (idpaciente) REFERENCES paciente (idpaciente),
    CONSTRAINT fk_intento_rango FOREIGN KEY (idrango) REFERENCES rango_resultado (idrango) ON DELETE SET NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS respuesta_intento (
                                                 idrespuesta INT NOT NULL AUTO_INCREMENT,
                                                 idintento   INT NOT NULL,
                                                 idpregunta  INT NOT NULL,
                                                 idopcion    INT DEFAULT NULL,
                                                 valor       DECIMAL(10,2) DEFAULT NULL,
    texto       VARCHAR(2000) DEFAULT NULL,
    puntos      DECIMAL(10,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (idrespuesta),
    KEY respuesta_intento_idx (idintento),
    CONSTRAINT fk_respuesta_intento FOREIGN KEY (idintento) REFERENCES intento (idintento) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
