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
INSERT INTO `categoria` VALUES (1,'Mantenimiento de Infraestructura'),(2,'Suministros y Dotación'),(3,'Soporte Técnico'),(4,'Apoyo Logístico'),(5,'Redes y Conectividad'),(6,'Software y Aplicaciones'),(7,'Hardware y Equipos'),(8,'Acceso a Sistemas'),(9,'Cuentas de Usuario'),(10,'Otros');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoriausuario`
--

DROP TABLE IF EXISTS `categoriausuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoriausuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idCategoria` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idCategoria` (`idCategoria`),
  CONSTRAINT `categoriausuario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `categoriausuario_ibfk_2` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoriausuario`
--

LOCK TABLES `categoriausuario` WRITE;
/*!40000 ALTER TABLE `categoriausuario` DISABLE KEYS */;
INSERT INTO `categoriausuario` VALUES (1,3,1),(2,5,2),(3,6,3),(4,7,4),(5,8,5),(6,9,6),(7,10,7),(8,11,8),(9,12,9);
/*!40000 ALTER TABLE `categoriausuario` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentario`
--

LOCK TABLES `comentario` WRITE;
/*!40000 ALTER TABLE `comentario` DISABLE KEYS */;
INSERT INTO `comentario` VALUES (1,4,'hjbhbhhu','2026-08-14'),(2,4,'hhyhh','2026-08-14'),(3,4,'holaaaa','2026-08-14'),(4,4,'vgggg','2026-08-14'),(5,4,'bbbb','2026-08-14'),(6,4,'es muy bueno','2026-08-14'),(7,4,'ghgh','2026-08-14'),(8,4,'okmml','2026-08-18'),(9,4,'hbjnkml','2026-08-18'),(10,4,'tfgtlk','2026-08-19'),(11,4,'jktlgmyñ','2026-08-19'),(12,1,'ghbjnk','2026-08-19');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructor`
--

LOCK TABLES `instructor` WRITE;
/*!40000 ALTER TABLE `instructor` DISABLE KEYS */;
/*!40000 ALTER TABLE `instructor` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prioridad`
--

LOCK TABLES `prioridad` WRITE;
/*!40000 ALTER TABLE `prioridad` DISABLE KEYS */;
INSERT INTO `prioridad` VALUES (1,'BAJA'),(2,'MEDIA'),(3,'ALTA'),(4,'CRITICA');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programa`
--

LOCK TABLES `programa` WRITE;
/*!40000 ALTER TABLE `programa` DISABLE KEYS */;
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
INSERT INTO `rol` VALUES (1,'ADMIN'),(2,'AGENTE'),(3,'FUNCIONARIO'),(4,'APRENDIZ');
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
INSERT INTO `rolusuario` VALUES (2,1,4),(3,2,1),(4,3,2),(5,4,3);
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
  `idComentario` int DEFAULT NULL,
  `estado` varchar(20) NOT NULL,
  `fechaCreacion` datetime NOT NULL,
  `programa` varchar(255) DEFAULT NULL,
  `numeroPrograma` varchar(100) DEFAULT NULL,
  `instructor` varchar(255) DEFAULT NULL,
  `jornada` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idCategoria` (`idCategoria`),
  KEY `idPrioridad` (`idPrioridad`),
  KEY `idComentario` (`idComentario`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`id`),
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`idPrioridad`) REFERENCES `prioridad` (`id`),
  CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`idComentario`) REFERENCES `comentario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (2,'jkn','bhjhbbh',7,NULL,10,'NUEVO','2026-08-13 20:52:38',NULL,NULL,NULL,NULL),(3,'bhhhb','jrfhjefer',8,NULL,NULL,'NUEVO','2026-08-13 20:55:49',NULL,NULL,NULL,NULL),(4,'hgvhgtvh','n frcvhrfv',5,NULL,NULL,'NUEVO','2026-08-13 20:57:34',NULL,NULL,NULL,NULL),(5,'jhhbhb','uhhhb',8,NULL,NULL,'NUEVO','2026-08-13 21:01:36',NULL,NULL,NULL,NULL),(6,'bhjhb','grfrbrf',6,NULL,NULL,'NUEVO','2026-08-14 20:47:47',NULL,NULL,NULL,NULL),(7,'gvtgykuhhul','gbvuihuyftrdefgyhjkiuhyugtrfghbj',5,NULL,11,'NUEVO','2026-08-14 20:48:50',NULL,NULL,NULL,NULL),(8,'yugg','bhhygh',5,NULL,NULL,'NUEVO','2026-08-14 20:53:01',NULL,NULL,NULL,NULL),(9,'jnewdfjefjejrfn','jnefjnrfnearjk',6,NULL,NULL,'NUEVO','2026-08-14 20:53:53',NULL,NULL,NULL,NULL),(10,'hjuygctfyvhbujighj','tfyghujikl',4,NULL,NULL,'NUEVO','2026-08-14 20:54:06',NULL,NULL,NULL,NULL),(11,'yughjiokñ{','xdfcgjkml',9,NULL,NULL,'NUEVO','2026-08-14 20:54:17',NULL,NULL,NULL,NULL),(12,'cfdvcgyuuyh','fcfghyhujju',3,NULL,7,'NUEVO','2026-08-14 20:54:29',NULL,NULL,NULL,NULL),(15,'tfyyuyggh','vcvfghjkm',2,4,NULL,'NUEVO','2026-08-14 21:36:38',NULL,NULL,NULL,NULL),(16,'knj njmn','kjjknkj',4,1,8,'NUEVO','2026-08-18 17:12:37',NULL,NULL,NULL,NULL),(18,'ghgjblñ,kjn','fgvhbjl,',1,1,NULL,'NUEVO','2026-08-18 21:47:59',NULL,NULL,NULL,NULL),(19,'hgjkml','tfgyhujik',3,3,NULL,'NUEVO','2026-08-18 21:48:12',NULL,NULL,NULL,NULL),(20,'hjrefd','bnjmkdswaz',7,4,NULL,'NUEVO','2026-08-18 21:57:51',NULL,NULL,NULL,NULL),(21,'hjnkml,ñ',' vbnm,',3,2,NULL,'NUEVO','2026-08-18 21:58:11',NULL,NULL,NULL,NULL),(22,'gvhbjmn,','nm,.',5,3,NULL,'NUEVO','2026-08-19 10:14:50',NULL,NULL,NULL,NULL),(23,'ghbjl','glgfcvhjk',1,1,12,'NUEVO','2026-08-19 10:39:36',NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketagente`
--

LOCK TABLES `ticketagente` WRITE;
/*!40000 ALTER TABLE `ticketagente` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticketagente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticketusuario`
--

DROP TABLE IF EXISTS `ticketusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticketusuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idTicket` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idTicket` (`idTicket`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `ticketusuario_ibfk_1` FOREIGN KEY (`idTicket`) REFERENCES `ticket` (`id`),
  CONSTRAINT `ticketusuario_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketusuario`
--

LOCK TABLES `ticketusuario` WRITE;
/*!40000 ALTER TABLE `ticketusuario` DISABLE KEYS */;
INSERT INTO `ticketusuario` VALUES (1,2,4),(2,3,4),(3,4,4),(4,5,4),(5,6,4),(6,7,4),(7,8,4),(8,9,4),(9,10,4),(10,11,4),(11,12,4),(12,15,4),(13,16,4),(14,18,4),(15,19,4),(16,20,4),(17,21,4),(18,22,4),(19,23,1);
/*!40000 ALTER TABLE `ticketusuario` ENABLE KEYS */;
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
INSERT INTO `usuario` VALUES (1,'andrea','a@gmail.com','1234'),(2,'admin','admin@gmail.com','246'),(3,'camila','cam@gmail.com','abc'),(4,'luis','l@gmail.com','mmm'),(5,'Carlos ','carlos@gmail.com','abc123'),(6,'Ana ','ana@gmail.com','clave456'),(7,'Luis ','luis@gmail.com','pass789'),(8,'María ','maria@gmail.com','xyz987'),(9,'Jorge ','jorge@gmail.com','pwd321'),(10,'Lucía ','lucia@gmail.com','qwe654'),(11,'Andrés ','andres@gmail.com','rty741'),(12,'Sofía ','sofia@gmail.com','iop852');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarioprograma`
--

DROP TABLE IF EXISTS `usuarioprograma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarioprograma` (
  `idUsuario` int NOT NULL,
  `idPrograma` int NOT NULL,
  PRIMARY KEY (`idUsuario`,`idPrograma`),
  KEY `idPrograma` (`idPrograma`),
  CONSTRAINT `usuarioprograma_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`),
  CONSTRAINT `usuarioprograma_ibfk_2` FOREIGN KEY (`idPrograma`) REFERENCES `programa` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarioprograma`
--

LOCK TABLES `usuarioprograma` WRITE;
/*!40000 ALTER TABLE `usuarioprograma` DISABLE KEYS */;
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

-- Dump completed on 2026-08-19 11:04:16
