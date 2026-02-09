-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: dwh
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `dimaccount`
--

DROP TABLE IF EXISTS `dimaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dimaccount` (
  `AccountID` int NOT NULL,
  `CustomerID` int DEFAULT NULL,
  `AccountType` varchar(50) DEFAULT NULL,
  `Balance` bigint DEFAULT NULL,
  `DateOpened` datetime DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`AccountID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `dimaccount_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `dimcustomer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dimaccount`
--

LOCK TABLES `dimaccount` WRITE;
/*!40000 ALTER TABLE `dimaccount` DISABLE KEYS */;
INSERT INTO `dimaccount` VALUES (1,1,'saving',1500000,'2020-05-01 09:00:00','active'),(2,2,'saving',500000,'2020-06-01 10:00:00','active'),(3,1,'checking',25000000,'2020-06-21 09:00:00','active'),(4,3,'checking',4500000,'2021-06-24 11:00:00','terminated'),(5,4,'saving',75000000,'2020-06-29 13:00:00','active'),(6,5,'checking',1500000,'2020-07-01 09:00:00','active'),(7,6,'saving',15000000,'2020-07-14 09:00:00','terminated'),(8,7,'checking',25000000,'2020-07-15 09:00:00','active'),(9,8,'saving',80000000,'2020-07-15 11:00:00','active'),(10,9,'checking',25000000,'2020-07-16 10:00:00','active'),(11,10,'saving',75000000,'2020-07-24 11:00:00','active'),(12,11,'checking',25000000,'2020-08-08 10:00:00','active'),(13,12,'saving',55000000,'2020-08-15 11:00:00','active'),(14,13,'checking',25000000,'2020-08-15 14:00:00','active'),(15,14,'saving',45000000,'2020-09-25 08:00:00','terminated'),(16,15,'checking',25000000,'2020-09-26 09:00:00','active'),(17,15,'saving',10000000,'2020-10-19 09:00:00','active'),(18,17,'checking',25000000,'2020-10-21 10:00:00','active'),(19,18,'saving',55000000,'2020-11-11 09:00:00','active'),(20,19,'checking',25000000,'2020-11-19 08:00:00','active'),(21,20,'checking',6000000,'2020-11-29 08:00:00','active'),(22,20,'saving',500000,'2022-01-01 00:00:00','active');
/*!40000 ALTER TABLE `dimaccount` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-09 21:11:04
