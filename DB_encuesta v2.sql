-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.21-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ds7_proyecto1
DROP DATABASE IF EXISTS `ds7_proyecto1`;
CREATE DATABASE IF NOT EXISTS `ds7_proyecto1` /*!40100 DEFAULT CHARACTER SET utf16 COLLATE utf16_spanish_ci */;
USE `ds7_proyecto1`;

-- Dumping structure for table ds7_proyecto1.encuesta
DROP TABLE IF EXISTS `encuesta`;
CREATE TABLE IF NOT EXISTS `encuesta` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'El identificador que representa la fila.',
  `descripcion` varchar(50) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Una corta descripción del tópico de la encuesta.',
  `fechaInicial` datetime NOT NULL DEFAULT curdate() COMMENT 'La fecha en la que inicia la encuesta.',
  `fechaFinal` datetime NOT NULL DEFAULT curdate() COMMENT 'La fecha límite para completar la encuesta',
  `EstaAbierta` bit(1) NOT NULL DEFAULT b'1' COMMENT 'Un indicador para determinar si la encuesta sigue abierta',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci COMMENT='Tabla que maneja las encuestas';

-- Dumping data for table ds7_proyecto1.encuesta: ~0 rows (approximately)
/*!40000 ALTER TABLE `encuesta` DISABLE KEYS */;
INSERT INTO `encuesta` (`id`, `descripcion`, `fechaInicial`, `fechaFinal`, `EstaAbierta`) VALUES
	(1, 'Deportes', '2021-11-09 00:00:00', '2021-11-09 00:00:00', b'1');
/*!40000 ALTER TABLE `encuesta` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.encuestado
DROP TABLE IF EXISTS `encuestado`;
CREATE TABLE IF NOT EXISTS `encuestado` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) COLLATE utf16_spanish_ci NOT NULL,
  `apellido` varchar(20) COLLATE utf16_spanish_ci NOT NULL,
  `sexo_id` tinyint(1) NOT NULL,
  `rango_edad_id` tinyint(2) NOT NULL,
  `rango_salarial_id` tinyint(2) NOT NULL,
  `provincia_id` tinyint(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sexo_encuestado` (`sexo_id`),
  KEY `FK_rango_edad_encuestado` (`rango_edad_id`),
  KEY `FK_rango_salarial_encuestado` (`rango_salarial_id`),
  KEY `FK_provincia_encuestado` (`provincia_id`),
  CONSTRAINT `FK_provincia_encuestado` FOREIGN KEY (`provincia_id`) REFERENCES `provincias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_rango_edad_encuestado` FOREIGN KEY (`rango_edad_id`) REFERENCES `rango_edad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_rango_salarial_encuestado` FOREIGN KEY (`rango_salarial_id`) REFERENCES `rango_salarial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_sexo_encuestado` FOREIGN KEY (`sexo_id`) REFERENCES `sexo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci COMMENT='Tabla que almacena los usuarios encuestados';

-- Dumping data for table ds7_proyecto1.encuestado: ~22 rows (approximately)
/*!40000 ALTER TABLE `encuestado` DISABLE KEYS */;
INSERT INTO `encuestado` (`id`, `nombre`, `apellido`, `sexo_id`, `rango_edad_id`, `rango_salarial_id`, `provincia_id`) VALUES
	(1, 'Maximiliano', 'Pitti', 1, 3, 1, 3),
	(2, 'Alejandra', 'Gutierrez', 2, 2, 5, 7),
	(3, 'Erik', 'Montenegro', 1, 1, 2, 8),
	(4, 'Valeria', 'Atencio', 2, 4, 6, 8),
	(5, 'Guillermo', 'Santos', 1, 3, 5, 8),
	(6, 'Felipe', 'Lopez', 1, 2, 4, 4),
	(7, 'Marco', 'Miranda', 1, 2, 2, 5),
	(8, 'Berta', 'Egea', 2, 3, 5, 2),
	(9, 'Casilda', 'Almagro', 2, 5, 1, 10),
	(10, 'Jordi', 'Arranz', 1, 1, 2, 9),
	(11, 'Jose Miguel', 'Valdez', 1, 3, 4, 4),
	(12, 'Ramon', 'Portillo', 1, 2, 7, 6),
	(13, 'Lucia', 'Lorenzo', 2, 2, 2, 8),
	(14, 'Victorina', 'Molina', 2, 3, 4, 8),
	(15, 'Florencia', 'Velez', 2, 2, 2, 1),
	(16, 'Candelaria', 'Ramos', 2, 5, 7, 8),
	(17, 'Noemi', 'del Pino', 2, 3, 4, 4),
	(18, 'Aurelio', 'Frances', 1, 2, 5, 10),
	(19, 'Christian', 'Quiroz', 1, 3, 3, 6),
	(20, 'Regina', 'Lara', 2, 1, 1, 2),
	(21, 'Matilde', 'Andreu', 2, 3, 6, 3),
	(22, 'Severino', 'Alvarez', 1, 3, 8, 4);
/*!40000 ALTER TABLE `encuestado` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.preguntas
DROP TABLE IF EXISTS `preguntas`;
CREATE TABLE IF NOT EXISTS `preguntas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Columan que registra el indice de la tabla',
  `numero_pregunta` int(11) NOT NULL,
  `encuesta_id` int(11) NOT NULL,
  `tipo_pregunta` enum('Binaria','Simple','Multiple') COLLATE utf16_spanish_ci NOT NULL DEFAULT 'Binaria' COMMENT 'Columna que almacena el tipo de pregunta.\r\nElección Binaria (Si/No)\r\nElección Simple (una de varias)\r\nElección Múltiple (una, alguna o todas)',
  `pregunta` varchar(100) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda la pregunta hecha',
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_pregunta_encuesta_id` (`numero_pregunta`,`encuesta_id`),
  KEY `FK_encuesta_pregunta` (`encuesta_id`),
  CONSTRAINT `FK_encuesta_pregunta` FOREIGN KEY (`encuesta_id`) REFERENCES `encuesta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.preguntas: ~21 rows (approximately)
/*!40000 ALTER TABLE `preguntas` DISABLE KEYS */;
INSERT INTO `preguntas` (`id`, `numero_pregunta`, `encuesta_id`, `tipo_pregunta`, `pregunta`) VALUES
	(1, 1, 1, 'Binaria', '¿Te gustan los deportes?'),
	(2, 2, 1, 'Binaria', '¿Juegas algún deporte?'),
	(3, 3, 1, 'Multiple', '¿Qué deportes juegas?'),
	(4, 4, 1, 'Multiple', '¿Cuál es tu deporte favorito?'),
	(5, 5, 1, 'Simple', 'Para ti el deporte es:'),
	(6, 6, 1, 'Simple', '¿Crees que haya diferencias físicas de una persona que realiza deporte y una que no?'),
	(7, 7, 1, 'Simple', '¿Cuánta actividad física realiza en la semana?'),
	(8, 8, 1, 'Simple', '¿Qué porcentaje de la población crees que haga deporte o actividades deportiva?'),
	(9, 9, 1, 'Binaria', '¿Utilizas algún suplemento para mejorar?'),
	(10, 10, 1, 'Binaria', '¿Eres fanático de algún deportista?'),
	(11, 11, 1, 'Multiple', '¿Qué marca de tenis te gusta?'),
	(12, 12, 1, 'Multiple', '¿Cuál es la bebida favorita al terminar un deporte?'),
	(13, 13, 1, 'Binaria', '¿Crees que estas bebidas ayudan al atleta?'),
	(14, 14, 1, 'Binaria', '¿Crees que la condición es importante para un deportista?'),
	(15, 15, 1, 'Binaria', '¿Qué es lo más importante antes de realizar un deporte?'),
	(16, 16, 1, 'Binaria', '¿Quién crees que gane la final de la Champion Leage?'),
	(17, 17, 1, 'Simple', '¿Juegas hobbie o eres perteneciente a un club?'),
	(18, 18, 1, 'Binaria', '¿Sigues una dieta nutricional?'),
	(19, 19, 1, 'Binaria', '¿has tenido alguna lesión al practicar un deporte?'),
	(20, 20, 1, 'Simple', '¿Cómo calificarías tu nivel de acondicionamiento físico?'),
	(25, 21, 1, 'Binaria', '¿Tienes Dinero?');
/*!40000 ALTER TABLE `preguntas` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.provincias
DROP TABLE IF EXISTS `provincias`;
CREATE TABLE IF NOT EXISTS `provincias` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT COMMENT 'Columan que registra el indice de la tabla',
  `codigo` varchar(6) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda el codigo de provincia',
  `nombre` varchar(30) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda el nombre de la provincia',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.provincias: ~13 rows (approximately)
/*!40000 ALTER TABLE `provincias` DISABLE KEYS */;
INSERT INTO `provincias` (`id`, `codigo`, `nombre`) VALUES
	(1, 'BOCAS', 'Bocas del Toro'),
	(2, 'COCLE', 'Coclé'),
	(3, 'COLON', 'Colón'),
	(4, 'CHIRIQ', 'Chiriquí'),
	(5, 'DARIEN', 'Darién'),
	(6, 'HERRER', 'Herrera'),
	(7, 'LOSSAN', 'Los Santos'),
	(8, 'PANAMA', 'Panamá'),
	(9, 'VERAGU', 'Veraguas'),
	(10, 'POESTE', 'Panamá Oeste'),
	(11, 'ENBERA', 'Enberá-Wounaan'),
	(12, 'GUNAYA', 'Guna Yala'),
	(13, 'NGABE', 'Ngabe-Buglé');
/*!40000 ALTER TABLE `provincias` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.rango_edad
DROP TABLE IF EXISTS `rango_edad`;
CREATE TABLE IF NOT EXISTS `rango_edad` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT COMMENT 'Columan que registra el identificador de la tabla',
  `descripcion` varchar(20) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda el tipo de rango en edad',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.rango_edad: ~9 rows (approximately)
/*!40000 ALTER TABLE `rango_edad` DISABLE KEYS */;
INSERT INTO `rango_edad` (`id`, `descripcion`) VALUES
	(1, 'De 10 a 20 años'),
	(2, 'De 21 a 30 años'),
	(3, 'De 31 a 40 años'),
	(4, 'De 41 a 50 años'),
	(5, 'De 51 a 60 años'),
	(6, 'De 61 a 70 años'),
	(7, 'De 71 a 80 años'),
	(8, 'De 81 a 90 años'),
	(9, 'De 91 a 100 años');
/*!40000 ALTER TABLE `rango_edad` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.rango_salarial
DROP TABLE IF EXISTS `rango_salarial`;
CREATE TABLE IF NOT EXISTS `rango_salarial` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT COMMENT 'Columan que registra el indice de la tabla',
  `descripcion` varchar(30) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda el tipo de salario',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.rango_salarial: ~9 rows (approximately)
/*!40000 ALTER TABLE `rango_salarial` DISABLE KEYS */;
INSERT INTO `rango_salarial` (`id`, `descripcion`) VALUES
	(1, 'De 400.00 a 600.00 Dolares'),
	(2, 'De 601.00 a 800.00 Dolares'),
	(3, 'De 801.00 a 1000.00 Dolares'),
	(4, 'De 1001.00 a 1500.00 Dolares'),
	(5, 'De 1501.00 a 2000.00 Dolares'),
	(6, 'De 2001.00 a 2500.00 Dolares'),
	(7, 'De 2501.00 a 3000.00 Dolares'),
	(8, 'De 3001.00 a 5000.00 Dolares'),
	(9, 'Más de 5000.00 Dolares');
/*!40000 ALTER TABLE `rango_salarial` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.respuestas
DROP TABLE IF EXISTS `respuestas`;
CREATE TABLE IF NOT EXISTS `respuestas` (
  `id` int(2) NOT NULL AUTO_INCREMENT COMMENT 'Columna que registra el indice de la tabla',
  `respuesta` varchar(100) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda las respuestas de una pregunta dada',
  `es_alternativa` bit(1) NOT NULL DEFAULT b'0',
  `mostrar_texto` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.respuestas: ~43 rows (approximately)
/*!40000 ALTER TABLE `respuestas` DISABLE KEYS */;
INSERT INTO `respuestas` (`id`, `respuesta`, `es_alternativa`, `mostrar_texto`) VALUES
	(1, 'Si', b'0', b'0'),
	(2, 'No', b'0', b'0'),
	(3, 'Voleibol', b'0', b'0'),
	(4, 'Basquetbol', b'0', b'0'),
	(5, 'Futbol', b'0', b'0'),
	(6, 'Baseball', b'0', b'0'),
	(7, 'Softball', b'0', b'0'),
	(8, 'Tenis', b'0', b'0'),
	(9, 'Atletismo', b'0', b'0'),
	(10, 'Natación', b'0', b'0'),
	(11, 'Otros', b'1', b'1'),
	(12, 'Muy importante', b'0', b'0'),
	(13, 'Importante', b'0', b'0'),
	(14, 'Poco Importante', b'0', b'0'),
	(15, 'Nada Importante', b'0', b'0'),
	(16, 'Tal vez', b'0', b'0'),
	(17, 'Más de 4 horas', b'0', b'0'),
	(18, '4 horas a 3 horas', b'0', b'0'),
	(19, '3 horas a 2 horas', b'0', b'0'),
	(20, '2 horas a 1 hora', b'0', b'0'),
	(21, '1 hora a 30 minutos', b'0', b'0'),
	(22, 'Nada', b'0', b'0'),
	(23, '0% - 25%', b'0', b'0'),
	(24, '26% - 50%', b'0', b'0'),
	(25, '51% - 75%', b'0', b'0'),
	(26, '76% - 100%', b'0', b'0'),
	(27, 'Sí (Por favor especifique)', b'1', b'1'),
	(28, 'Puma', b'0', b'0'),
	(29, 'Converse', b'0', b'0'),
	(30, 'Adidas', b'0', b'0'),
	(31, 'Nike', b'0', b'0'),
	(32, 'Gatorade', b'0', b'0'),
	(33, 'Power aid', b'0', b'0'),
	(34, 'Agua', b'0', b'0'),
	(35, 'Energy Drink', b'0', b'0'),
	(36, 'Ejercitar los músculos', b'0', b'0'),
	(37, 'Calentar', b'0', b'0'),
	(38, 'Barcelona', b'0', b'0'),
	(39, 'Real Madrid', b'0', b'0'),
	(40, 'Hobbie', b'0', b'0'),
	(41, 'Club', b'0', b'0'),
	(42, 'Alto', b'0', b'0'),
	(43, 'Medio', b'0', b'0'),
	(44, 'Bajo', b'0', b'0');
/*!40000 ALTER TABLE `respuestas` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.respuesta_a_pregunta
DROP TABLE IF EXISTS `respuesta_a_pregunta`;
CREATE TABLE IF NOT EXISTS `respuesta_a_pregunta` (
  `pregunta_id` int(11) NOT NULL COMMENT 'El identificador del registro en la tabla de preguntas',
  `respuesta_id` int(11) NOT NULL COMMENT 'El identificador del registro en la tabla de respuestas',
  PRIMARY KEY (`pregunta_id`,`respuesta_id`) USING BTREE,
  KEY `FK_respuesta_respuesta_a_pregunta` (`respuesta_id`),
  CONSTRAINT `FK_respuesta_a_pregunta_preguntas` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_respuesta_respuesta_a_pregunta` FOREIGN KEY (`respuesta_id`) REFERENCES `respuestas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci COMMENT='Es una tabla de enlace que permite tener varias respuestas sobre una misma preguntas.';

-- Dumping data for table ds7_proyecto1.respuesta_a_pregunta: ~76 rows (approximately)
/*!40000 ALTER TABLE `respuesta_a_pregunta` DISABLE KEYS */;
INSERT INTO `respuesta_a_pregunta` (`pregunta_id`, `respuesta_id`) VALUES
	(1, 1),
	(1, 2),
	(2, 1),
	(2, 2),
	(3, 3),
	(3, 4),
	(3, 5),
	(3, 6),
	(3, 7),
	(3, 8),
	(3, 9),
	(3, 10),
	(3, 11),
	(4, 3),
	(4, 4),
	(4, 5),
	(4, 6),
	(4, 7),
	(4, 8),
	(4, 9),
	(4, 10),
	(4, 11),
	(5, 12),
	(5, 13),
	(5, 14),
	(5, 15),
	(6, 1),
	(6, 2),
	(6, 16),
	(7, 17),
	(7, 18),
	(7, 19),
	(7, 20),
	(7, 21),
	(7, 22),
	(8, 23),
	(8, 24),
	(8, 25),
	(8, 26),
	(9, 1),
	(9, 2),
	(10, 1),
	(10, 2),
	(10, 27),
	(11, 11),
	(11, 28),
	(11, 29),
	(11, 30),
	(11, 31),
	(12, 11),
	(12, 32),
	(12, 33),
	(12, 34),
	(12, 35),
	(13, 1),
	(13, 2),
	(13, 27),
	(14, 1),
	(14, 2),
	(15, 11),
	(15, 36),
	(15, 37),
	(16, 11),
	(16, 38),
	(16, 39),
	(17, 40),
	(17, 41),
	(18, 1),
	(18, 2),
	(19, 1),
	(19, 2),
	(20, 42),
	(20, 43),
	(20, 44),
	(25, 1),
	(25, 2);
/*!40000 ALTER TABLE `respuesta_a_pregunta` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.respuesta_encuestado
DROP TABLE IF EXISTS `respuesta_encuestado`;
CREATE TABLE IF NOT EXISTS `respuesta_encuestado` (
  `pregunta_id` int(11) NOT NULL COMMENT 'Columna que guarda la clave de la pregunta',
  `respuesta_id` int(11) NOT NULL COMMENT 'Columan que registra el indice de la tabla',
  `encuestado_id` bigint(20) NOT NULL COMMENT 'Columna que guarda la clave del encuestado',
  `texto_alternativo` varchar(50) COLLATE utf16_spanish_ci NOT NULL,
  PRIMARY KEY (`respuesta_id`,`encuestado_id`,`pregunta_id`) USING BTREE,
  KEY `FK_pregunta_respuesta_encuestado` (`pregunta_id`),
  KEY `FK_encuestado_respuesta_encuestado` (`encuestado_id`),
  CONSTRAINT `FK_encuestado_respuesta_encuestado` FOREIGN KEY (`encuestado_id`) REFERENCES `encuestado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pregunta_respuesta_encuestado` FOREIGN KEY (`pregunta_id`) REFERENCES `preguntas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_respuestas_respuesta_encuestado` FOREIGN KEY (`respuesta_id`) REFERENCES `respuestas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.respuesta_encuestado: ~43 rows (approximately)
/*!40000 ALTER TABLE `respuesta_encuestado` DISABLE KEYS */;
INSERT INTO `respuesta_encuestado` (`pregunta_id`, `respuesta_id`, `encuestado_id`, `texto_alternativo`) VALUES
	(2, 1, 19, ''),
	(3, 1, 19, ''),
	(4, 1, 19, ''),
	(14, 1, 19, ''),
	(18, 1, 19, ''),
	(2, 1, 20, ''),
	(14, 1, 20, ''),
	(18, 1, 20, ''),
	(2, 1, 21, ''),
	(14, 1, 21, ''),
	(18, 1, 21, ''),
	(1, 1, 22, ''),
	(13, 1, 22, ''),
	(10, 2, 19, ''),
	(19, 2, 19, ''),
	(10, 2, 20, ''),
	(19, 2, 20, ''),
	(10, 2, 21, ''),
	(19, 2, 21, ''),
	(2, 2, 22, ''),
	(18, 2, 22, ''),
	(3, 5, 20, ''),
	(4, 5, 20, ''),
	(3, 5, 21, ''),
	(4, 5, 21, ''),
	(3, 7, 20, ''),
	(3, 7, 21, ''),
	(3, 11, 22, ''),
	(7, 19, 19, ''),
	(7, 19, 20, ''),
	(7, 19, 21, ''),
	(7, 22, 22, ''),
	(11, 31, 22, ''),
	(12, 32, 22, ''),
	(12, 34, 22, ''),
	(15, 36, 19, ''),
	(15, 36, 20, ''),
	(15, 36, 21, ''),
	(15, 37, 22, ''),
	(17, 40, 22, ''),
	(17, 41, 19, ''),
	(17, 41, 20, ''),
	(17, 41, 21, '');
/*!40000 ALTER TABLE `respuesta_encuestado` ENABLE KEYS */;

-- Dumping structure for table ds7_proyecto1.sexo
DROP TABLE IF EXISTS `sexo`;
CREATE TABLE IF NOT EXISTS `sexo` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT COMMENT 'Columan que registra el identificador de la tabla',
  `codigo` char(1) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda e codigol sexo',
  `descripcion` varchar(12) COLLATE utf16_spanish_ci NOT NULL COMMENT 'Columna que guarda el tipo de sexo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf16 COLLATE=utf16_spanish_ci;

-- Dumping data for table ds7_proyecto1.sexo: ~3 rows (approximately)
/*!40000 ALTER TABLE `sexo` DISABLE KEYS */;
INSERT INTO `sexo` (`id`, `codigo`, `descripcion`) VALUES
	(1, 'H', 'Hombre'),
	(2, 'M', 'Mujer'),
	(3, 'O', 'Otro Género');
/*!40000 ALTER TABLE `sexo` ENABLE KEYS */;

-- Dumping structure for procedure ds7_proyecto1.usp_actualizar_pregunta
DROP PROCEDURE IF EXISTS `usp_actualizar_pregunta`;
DELIMITER //
CREATE PROCEDURE `usp_actualizar_pregunta`(
	IN `param_id` INT,
	IN `param_pregunta` VARCHAR(100),
	IN `param_tipo_pregunta` ENUM('Binaria','Simple','Multiple')
)
BEGIN
	UPDATE preguntas
	SET pregunta = param_pregunta, tipo_pregunta = param_tipo_pregunta
	WHERE id = param_id;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_cantidad_encuestados
DROP PROCEDURE IF EXISTS `usp_cantidad_encuestados`;
DELIMITER //
CREATE PROCEDURE `usp_cantidad_encuestados`(
	IN `param_campo` ENUM('sexo_id','rango_edad_id', 'rango_salarial_id', 'provincia_id')
)
BEGIN
	SET @s = CONCAT("SELECT ", param_campo, ", COUNT(id) AS encuestados FROM encuestado GROUP BY ", param_campo); 

   PREPARE stmt FROM @s; 
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_eliminar_pregunta
DROP PROCEDURE IF EXISTS `usp_eliminar_pregunta`;
DELIMITER //
CREATE PROCEDURE `usp_eliminar_pregunta`(
	IN `param_id` INT
)
BEGIN
	DELETE FROM respuesta_a_pregunta WHERE pregunta_id = param_id;
	DELETE FROM preguntas WHERE id = param_id;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_insertar_encuestado
DROP PROCEDURE IF EXISTS `usp_insertar_encuestado`;
DELIMITER //
CREATE PROCEDURE `usp_insertar_encuestado`(
	IN `param_nombre` VARCHAR(20),
	IN `param_apellido` VARCHAR(20),
	IN `param_sexo_id` TINYINT,
	IN `param_rango_edad_id` TINYINT,
	IN `param_rango_salarial_id` TINYINT,
	IN `param_provincia_id` TINYINT
)
BEGIN
	INSERT INTO encuestado (nombre, apellido, sexo_id, rango_edad_id, rango_salarial_id, provincia_id)
	VALUES (param_nombre, param_apellido, param_sexo_id, param_rango_edad_id, param_rango_salarial_id, param_provincia_id);
	SELECT LAST_INSERT_ID() AS `ID`;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_insertar_pregunta
DROP PROCEDURE IF EXISTS `usp_insertar_pregunta`;
DELIMITER //
CREATE PROCEDURE `usp_insertar_pregunta`(
	IN `param_encuesta_id` INT,
	IN `param_pregunta` VARCHAR(100),
	IN `param_tipo_pregunta` ENUM('Binaria','Simple', 'Multiple')
)
BEGIN
	set @numero_pregunta = (SELECT MAX(numero_pregunta) AS maxi FROM preguntas WHERE encuesta_id = param_encuesta_id LIMIT 1);
	INSERT INTO preguntas (numero_pregunta, encuesta_id, pregunta, tipo_pregunta)
	VALUES (@numero_pregunta +1, param_encuesta_id, param_pregunta, param_tipo_pregunta);
	SELECT LAST_INSERT_ID() AS `ID`;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_insertar_respuesta_a_pregunta
DROP PROCEDURE IF EXISTS `usp_insertar_respuesta_a_pregunta`;
DELIMITER //
CREATE PROCEDURE `usp_insertar_respuesta_a_pregunta`(
	IN `param_pregunta_id` INT,
	IN `param_respuesta_id` INT
)
BEGIN
	INSERT INTO respuesta_a_pregunta (pregunta_id, respuesta_id) VALUES (param_pregunta_id, param_respuesta_id); 
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_insertar_respuesta_encuestado
DROP PROCEDURE IF EXISTS `usp_insertar_respuesta_encuestado`;
DELIMITER //
CREATE PROCEDURE `usp_insertar_respuesta_encuestado`(
	IN `param_pregunta_id` INT,
	IN `param_respuesta_id` INT,
	IN `param_encuestado_id` BIGINT,
	IN `param_texto_alternativo` VARCHAR(50)
)
BEGIN
	INSERT INTO respuesta_encuestado(pregunta_id, respuesta_id, encuestado_id, texto_alternativo)
	VALUES (param_pregunta_id, param_respuesta_id, param_encuestado_id, param_texto_alternativo);
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_listar_edades
DROP PROCEDURE IF EXISTS `usp_listar_edades`;
DELIMITER //
CREATE PROCEDURE `usp_listar_edades`()
BEGIN
	SELECT id, descripcion FROM rango_edad;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_listar_preguntas
DROP PROCEDURE IF EXISTS `usp_listar_preguntas`;
DELIMITER //
CREATE PROCEDURE `usp_listar_preguntas`(
	IN `param_encuesta_id` INT
)
BEGIN
	SELECT id, numero_pregunta, encuesta_id, tipo_pregunta, pregunta
	FROM preguntas
	WHERE encuesta_id = param_encuesta_id;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_listar_provincias
DROP PROCEDURE IF EXISTS `usp_listar_provincias`;
DELIMITER //
CREATE PROCEDURE `usp_listar_provincias`()
BEGIN
	SELECT id, nombre FROM provincias;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_listar_respuestas_no_pregunta_por_id
DROP PROCEDURE IF EXISTS `usp_listar_respuestas_no_pregunta_por_id`;
DELIMITER //
CREATE PROCEDURE `usp_listar_respuestas_no_pregunta_por_id`(
	IN `param_id` INT
)
    COMMENT 'Este store procedure lista las respuestas que no estén seleccionadas en una pregunta.'
BEGIN
	SELECT * FROM respuestas WHERE id NOT IN (SELECT respuesta_id FROM respuesta_a_pregunta WHERE pregunta_id = param_id);
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_listar_salarios
DROP PROCEDURE IF EXISTS `usp_listar_salarios`;
DELIMITER //
CREATE PROCEDURE `usp_listar_salarios`()
BEGIN
	SELECT id, descripcion FROM rango_salarial;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_listar_sexos
DROP PROCEDURE IF EXISTS `usp_listar_sexos`;
DELIMITER //
CREATE PROCEDURE `usp_listar_sexos`()
BEGIN
	SELECT id, codigo, descripcion FROM sexo;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_obtener_etiqueta
DROP PROCEDURE IF EXISTS `usp_obtener_etiqueta`;
DELIMITER //
CREATE PROCEDURE `usp_obtener_etiqueta`(
	IN `param_tabla` VARCHAR(20),
	IN `param_llave` INT
)
BEGIN
	SET @s = CONCAT("SELECT ", IF(param_tabla = "provincias", "nombre", "descripcion"), " as title FROM ", param_tabla," WHERE id = ", param_llave); 

   PREPARE stmt FROM @s; 
   EXECUTE stmt;
   DEALLOCATE PREPARE stmt;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_obtener_pregunta_por_id
DROP PROCEDURE IF EXISTS `usp_obtener_pregunta_por_id`;
DELIMITER //
CREATE PROCEDURE `usp_obtener_pregunta_por_id`(
	IN `param_id` VARCHAR(100)
)
BEGIN
	SELECT id, numero_pregunta, tipo_pregunta, pregunta FROM preguntas
	where  FIND_IN_SET( id, param_id);
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_obtener_respuesta_a_pregunta_por_id
DROP PROCEDURE IF EXISTS `usp_obtener_respuesta_a_pregunta_por_id`;
DELIMITER //
CREATE PROCEDURE `usp_obtener_respuesta_a_pregunta_por_id`(
	IN `param_id` INT
)
BEGIN
	SELECT * FROM respuestas AS r INNER JOIN respuesta_a_pregunta AS rap ON r.id = rap.respuesta_id
	WHERE rap.pregunta_id = param_id
	ORDER BY r.es_alternativa, r.id;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_rango_de_preguntas
DROP PROCEDURE IF EXISTS `usp_rango_de_preguntas`;
DELIMITER //
CREATE PROCEDURE `usp_rango_de_preguntas`(
	IN `param_encuesta` INT
)
BEGIN
	SELECT max(numero_pregunta) as maxi, min(numero_pregunta) as mini FROM preguntas
	WHERE encuesta_id = param_encuesta;
END//
DELIMITER ;

-- Dumping structure for procedure ds7_proyecto1.usp_remover_respuesta_a_pregunta
DROP PROCEDURE IF EXISTS `usp_remover_respuesta_a_pregunta`;
DELIMITER //
CREATE PROCEDURE `usp_remover_respuesta_a_pregunta`(
	IN `param_pregunta_id` INT,
	IN `param_respuesta_id` INT
)
BEGIN
	DELETE FROM respuesta_a_pregunta WHERE pregunta_id = param_pregunta_id AND respuesta_id = param_respuesta_id;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
