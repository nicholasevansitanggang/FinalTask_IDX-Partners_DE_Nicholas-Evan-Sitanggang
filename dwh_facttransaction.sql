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
-- Table structure for table `facttransaction`
--

DROP TABLE IF EXISTS `facttransaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facttransaction` (
  `TransactionID` int NOT NULL,
  `AccountID` int DEFAULT NULL,
  `TransactionDate` datetime DEFAULT NULL,
  `Amount` bigint DEFAULT NULL,
  `TransactionType` varchar(50) DEFAULT NULL,
  `BranchID` int DEFAULT NULL,
  PRIMARY KEY (`TransactionID`),
  KEY `AccountID` (`AccountID`),
  KEY `BranchID` (`BranchID`),
  CONSTRAINT `facttransaction_ibfk_1` FOREIGN KEY (`AccountID`) REFERENCES `dimaccount` (`AccountID`),
  CONSTRAINT `facttransaction_ibfk_2` FOREIGN KEY (`BranchID`) REFERENCES `dimbranch` (`BranchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facttransaction`
--

LOCK TABLES `facttransaction` WRITE;
/*!40000 ALTER TABLE `facttransaction` DISABLE KEYS */;
INSERT INTO `facttransaction` VALUES (1,1,'2022-01-01 09:10:00',100000,'Deposit',1),(2,2,'2022-01-01 10:10:00',1000000,'Deposit',1),(3,3,'2022-01-11 08:30:00',10000000,'Transfer',1),(4,3,'2022-01-11 10:45:00',1000000,'Withdrawal',1),(5,5,'2022-02-21 11:10:00',200000,'Deposit',1),(6,6,'2022-02-21 13:10:00',50000,'Withdrawal',1),(7,6,'2022-02-21 14:00:00',100000,'Payment',1),(8,7,'2022-03-05 09:10:00',5000000,'Deposit',1),(9,8,'2022-03-15 10:40:00',300000,'Withdrawal',2),(10,9,'2022-03-24 12:10:00',2000000,'Deposit',1),(11,10,'2024-01-20 15:00:00',1000000,'Transfer',1),(12,11,'2024-01-20 10:00:00',500000,'Deposit',1),(13,12,'2024-01-20 12:10:00',500000,'Withdrawal',5),(14,13,'2024-01-21 14:00:00',1500000,'Deposit',4),(15,14,'2024-01-21 08:00:00',500000,'Transfer',3),(16,15,'2024-01-22 09:00:00',100000,'Deposit',1),(17,16,'2024-01-22 13:10:00',100000,'Withdrawal',5),(18,17,'2024-01-22 10:20:00',700000,'Deposit',5),(19,18,'2024-01-22 11:00:00',30000,'Payment',2),(20,19,'2024-01-22 15:00:00',2500000,'Deposit',2),(21,20,'2024-01-22 11:30:00',150000,'Payment',4),(22,21,'2024-01-22 10:45:00',800000,'Withdrawal',5),(23,22,'2024-01-22 10:50:00',100000,'Withdrawal',1);
/*!40000 ALTER TABLE `facttransaction` ENABLE KEYS */;
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
