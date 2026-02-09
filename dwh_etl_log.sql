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
-- Table structure for table `etl_log`
--

DROP TABLE IF EXISTS `etl_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etl_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `process_name` varchar(100) DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `message` text,
  `duration_seconds` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etl_log`
--

LOCK TABLES `etl_log` WRITE;
/*!40000 ALTER TABLE `etl_log` DISABLE KEYS */;
INSERT INTO `etl_log` VALUES (1,'ETL_To_DWH','2026-02-09 11:05:44','2026-02-09 11:05:44','FAILED','(pymysql.err.OperationalError) (1049, \"Unknown database \'db_sumber\'\")\n(Background on this error at: https://sqlalche.me/e/20/e3q8)',0.03),(2,'ETL_To_DWH','2026-02-09 11:06:24','2026-02-09 11:06:24','SUCCESS','Berhasil memuat 23 transaksi ke DWH.',0.25),(3,'ETL_To_DWH','2026-02-09 11:13:08','2026-02-09 11:13:08','SUCCESS','Berhasil memuat 23 transaksi ke DWH.',0.26),(4,'ETL_Full_Process','2026-02-09 11:18:49','2026-02-09 11:18:49','SUCCESS','Success. DimBranch: 5, DimCustomer: 20, DimAccount: 22, FactTransaction: 23',0.25),(5,'ETL_Full_Process','2026-02-09 11:23:02','2026-02-09 11:23:02','SUCCESS','Success. DimBranch: 5, DimCustomer: 20, DimAccount: 22, FactTransaction: 23',0.48),(6,'ETL_Full_Process','2026-02-09 11:24:05','2026-02-09 11:24:06','SUCCESS','Success. DimBranch: 5, DimCustomer: 20, DimAccount: 22, FactTransaction: 23',0.50),(7,'ETL_Full_Process','2026-02-09 17:16:25','2026-02-09 17:16:26','SUCCESS','Success. dimbranch: 5, dimcustomer: 20, dimaccount: 22, facttransaction: 23',0.89),(8,'ETL_Full_Process','2026-02-09 17:20:37','2026-02-09 17:20:38','SUCCESS','Success. dimbranch: 5, dimcustomer: 20, dimaccount: 22, facttransaction: 23',0.48),(9,'ETL_Full_Process','2026-02-09 17:20:55','2026-02-09 17:20:56','SUCCESS','Success. dimbranch: 5, dimcustomer: 20, dimaccount: 22, facttransaction: 23',0.48),(10,'ETL_Full_Process','2026-02-09 19:56:42','2026-02-09 19:56:43','SUCCESS','Success. dimbranch: 5, dimcustomer: 20, dimaccount: 22, facttransaction: 23',0.64);
/*!40000 ALTER TABLE `etl_log` ENABLE KEYS */;
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
