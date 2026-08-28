CREATE DATABASE  IF NOT EXISTS `mesaayuda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mesaayuda`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: mesaayuda
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Mantenimiento de Infraestructura'),(2,'Suministros y Dotación'),(3,'Soporte Técnico'),(4,'Apoyo Logístico'),(5,'Redes y Conectividad');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoriaagente`
--

DROP TABLE IF EXISTS `categoriaagente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoriaagente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idCategoria` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `categoriausuario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `categoriausuario_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoriaagente`
--

LOCK TABLES `categoriaagente` WRITE;
/*!40000 ALTER TABLE `categoriaagente` DISABLE KEYS */;
INSERT INTO `categoriaagente` VALUES (1,3,1),(2,5,2),(3,3,3),(4,5,4),(5,5,5);
/*!40000 ALTER TABLE `categoriaagente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentario`
--

DROP TABLE IF EXISTS `comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `texto` varchar(500) NOT NULL,
  `fecha` date NOT NULL,
  `idTicket` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
INSERT INTO `comentario` VALUES (1,3,'Revisando el proyector del aula 204.','2026-08-19',1),(2,2,'Por favor agilizar la entrega de marcadores.','2026-08-19',2),(3,3,'Verificando los switches principales del laboratorio.','2026-08-19',3),(4,1,'Se envió un correo de recuperación temporal.','2026-08-19',4),(5,2,'Muchas gracias por la pronta solución de la silla.','2026-08-19',5),(15,2,'si','2026-08-20',2),(16,3,'hola carlos esramos en proceso','2026-08-20',33),(17,2,'GHJL,','2026-08-20',34),(18,2,'FGVMK','2026-08-20',34),(19,4,'lkm,ñ','2026-08-20',1),(20,2,'hjbk','2026-08-27',35),(21,3,'b nm','2026-08-27',35);
/*!40000 ALTER TABLE `comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructor`
--

DROP TABLE IF EXISTS `instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) NOT NULL,
  `apellido` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
INSERT INTO `instructor` VALUES (1,'Carlos Alberto','Gómez Pérez'),(2,'María Fernanda','Rodríguez López'),(3,'Juan Carlos','Martínez Ruiz'),(4,'Ana Sofía','Hernández Torres'),(5,'Luis Miguel','Ramírez Castro');
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensaje_chat`
--

DROP TABLE IF EXISTS `mensaje_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensaje_chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTicket` int NOT NULL,
  `idUsuario` int NOT NULL,
  `mensaje` text NOT NULL,
  `fechaEnvio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_mensaje_ticket` (`idTicket`),
  KEY `fk_mensaje_usuario` (`idUsuario`),
  CONSTRAINT `fk_mensaje_ticket` FOREIGN KEY (`idTicket`) REFERENCES `ticket` (`id`),
  CONSTRAINT `fk_mensaje_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensaje_chat`
--

LOCK TABLES `mensaje_chat` WRITE;
/*!40000 ALTER TABLE `mensaje_chat` DISABLE KEYS */;
INSERT INTO `mensaje_chat` VALUES (1,1,2,'hola como estas','2026-08-26 05:00:00'),(2,35,2,'gbhnjñ','2026-08-27 22:42:54'),(3,35,2,'hgjblkmñ,{}','2026-08-27 22:42:57'),(4,35,3,'hola carlos','2026-08-27 22:43:29'),(5,2,2,'hola','2026-08-28 00:57:01'),(6,38,3,'hola','2026-08-28 01:06:35'),(7,2,2,'hola','2026-08-28 13:28:48'),(8,2,2,'hpla','2026-08-28 13:48:27'),(9,4,5,'hola andrea, tu ticket #4 ya se resolvio','2026-08-28 14:05:25');
/*!40000 ALTER TABLE `mensaje_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prioridad`
--

DROP TABLE IF EXISTS `prioridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prioridad` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipoPrioridad` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prioridad`
--

LOCK TABLES `prioridad` WRITE;
/*!40000 ALTER TABLE `prioridad` DISABLE KEYS */;
INSERT INTO `prioridad` VALUES (1,'BAJA'),(2,'MEDIA'),(3,'ALTA'),(4,'CRITICA'),(5,'URGENTE');
/*!40000 ALTER TABLE `prioridad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programa`
--

DROP TABLE IF EXISTS `programa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numeroFicha` int NOT NULL,
  `nombrePrograma` varchar(500) NOT NULL,
  `idInstructor` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_programa_instructor` (`idInstructor`),
  CONSTRAINT `fk_programa_instructor` FOREIGN KEY (`idInstructor`) REFERENCES `instructor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programa`
--

LOCK TABLES `programa` WRITE;
/*!40000 ALTER TABLE `programa` DISABLE KEYS */;
INSERT INTO `programa` VALUES (1,2671201,'Análisis y Desarrollo de Software (ADSO)',1),(2,2671202,'Gestión de Redes de Datos',2),(3,2671203,'Contabilidad y Finanzas',3),(4,2671204,'Gestión del Talento Humano',4),(5,2671205,'Mantenimiento de Equipos de Cómputo',5);
/*!40000 ALTER TABLE `programa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipoRol` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'ADMINISTRADOR'),(2,'FUNCIONARIO'),(3,'AGENTE'),(4,'APRENDIZ');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolusuario`
--

DROP TABLE IF EXISTS `rolusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolusuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idRol` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idRol` (`idRol`),
  CONSTRAINT `rolusuario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `rolusuario_ibfk_2` FOREIGN KEY (`idRol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolusuario`
--

LOCK TABLES `rolusuario` WRITE;
/*!40000 ALTER TABLE `rolusuario` DISABLE KEYS */;
INSERT INTO `rolusuario` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,3);
/*!40000 ALTER TABLE `rolusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text,
  `idCategoria` int NOT NULL,
  `idPrioridad` int DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `fechaCreacion` datetime NOT NULL,
  `jornada` varchar(50) DEFAULT NULL,
  `idUsuario` int DEFAULT NULL,
  `programa` varchar(255) DEFAULT NULL,
  `numeroPrograma` varchar(100) DEFAULT NULL,
  `instructor` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idCategoria` (`idCategoria`),
  KEY `idPrioridad` (`idPrioridad`),
  KEY `fk_ticket_usuario` (`idUsuario`),
  CONSTRAINT `fk_ticket_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`idPrioridad`) REFERENCES `prioridad` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,'Falla en proyector','El proyector del aula 204 no enciende.',1,2,'NUEVO','2026-08-19 08:30:00','Mañana',4,NULL,NULL,NULL),(2,'Falta de marcadores','Se acabaron los marcadores borrables en coordinación.',2,1,'NUEVO','2026-08-19 09:15:00','Mañana',2,NULL,NULL,NULL),(3,'Sin internet en laboratorio','Los equipos del laboratorio 3 no tienen red.',5,4,'ASIGNADO','2026-08-19 10:00:00','Tarde',4,NULL,NULL,NULL),(4,'Problema con correo institucional','No se puede restablecer la contraseña del SENA.',3,3,'RESUELTO','2026-08-19 11:45:00','Mixta',2,NULL,NULL,NULL),(5,'Silla ergonómica dañada','La silla de la oficina de bienestar presenta daños.',4,1,'CERRADO','2026-08-19 14:20:00','Tarde',2,NULL,NULL,NULL),(33,'red wifi','no hay wifi',2,1,'EN PROCESO','2026-08-20 09:35:27',NULL,2,NULL,NULL,NULL),(34,'FGHBJLKÑ,','GHBJNMKL,Ñ.',1,1,'ASIGNADO','2026-08-20 13:55:01',NULL,2,NULL,NULL,NULL),(35,'GTYHUJIOK','GFHBJLKMÑ,',1,1,'CERRADO','2026-08-20 20:33:09',NULL,2,NULL,NULL,NULL),(36,'red wifi','ksdmsmxqaso',5,3,'CANCELADO','2026-08-20 22:30:31','Tarde',4,NULL,NULL,NULL),(37,'daños en lapto','un computador no enciende',5,3,'NUEVO','2026-08-27 16:03:38',NULL,2,NULL,NULL,NULL),(38,'ghjblmknj','gvbhn',3,2,'CERRADO','2026-08-27 18:55:04','MAÑANA',2,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticketagente`
--

DROP TABLE IF EXISTS `ticketagente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticketagente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTicket` int NOT NULL,
  `idUsuario` int NOT NULL,
  `fechaAsignacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_ticketagente_ticket` (`idTicket`),
  KEY `idx_ticketagente_usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketagente`
--

LOCK TABLES `ticketagente` WRITE;
/*!40000 ALTER TABLE `ticketagente` DISABLE KEYS */;
INSERT INTO `ticketagente` VALUES (1,1,3,'2026-08-19 14:00:00'),(2,2,5,'2026-08-19 14:30:00'),(3,3,3,'2026-08-19 15:15:00'),(4,4,5,'2026-08-19 17:00:00'),(5,5,3,'2026-08-19 19:30:00'),(6,33,3,'2026-08-20 14:35:27'),(7,34,3,'2026-08-27 21:21:32'),(8,35,3,'2026-08-21 01:33:09'),(9,38,3,'2026-08-27 23:55:03');
/*!40000 ALTER TABLE `ticketagente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticketotp`
--

DROP TABLE IF EXISTS `ticketotp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticketotp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTicket` int NOT NULL,
  `codigo` varchar(10) NOT NULL,
  `fechaExpiracion` datetime NOT NULL,
  `usado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ticketotp_ticket` (`idTicket`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketotp`
--

LOCK TABLES `ticketotp` WRITE;
/*!40000 ALTER TABLE `ticketotp` DISABLE KEYS */;
INSERT INTO `ticketotp` VALUES (1,38,'355495','2026-08-28 09:05:36',1),(2,4,'246509','2026-08-28 09:15:01',1),(3,38,'900036','2026-08-28 09:15:55',1),(4,38,'239239','2026-08-28 09:16:53',1),(5,4,'844710','2026-08-28 09:17:43',0),(6,38,'279201','2026-08-28 09:26:28',1),(7,35,'111084','2026-08-28 12:56:13',1),(8,35,'279001','2026-08-28 12:56:33',1);
/*!40000 ALTER TABLE `ticketotp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Andrea Admin','andrea.admin@gmail.com','1234'),(2,'andrea Funcionario','andrea.martinez04.cruz@gmail.com','abc123'),(3,'Ana Agente','ana.agente@gmail.com','clave456'),(4,'Luis Aprendiz','luis.aprendiz@gmail.com','mmm789'),(5,'Sofia Soporte','sofia.soporte@gmail.com','soporte2026');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarioprograma`
--

DROP TABLE IF EXISTS `usuarioprograma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarioprograma` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idPrograma` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idPrograma` (`idPrograma`),
  CONSTRAINT `usuarioprograma_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `usuarioprograma_ibfk_2` FOREIGN KEY (`idPrograma`) REFERENCES `programa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioprograma`
--

LOCK TABLES `usuarioprograma` WRITE;
/*!40000 ALTER TABLE `usuarioprograma` DISABLE KEYS */;
INSERT INTO `usuarioprograma` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5);
/*!40000 ALTER TABLE `usuarioprograma` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-28 12:50:05
