-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: news
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `body` text NOT NULL,
  `category` varchar(100) NOT NULL,
  `submitted_by` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `submitted_by` (`submitted_by`),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'City Park Renovation Begins','The city has started a renovation project in the central park to improve walking paths and playground areas.','Local',2,'2026-03-14 21:46:30'),(2,'Tech Conference 2026 Announced','Developers and technology companies will gather for a major conference next year.','Technology',5,'2026-03-14 21:46:30'),(3,'New Cafe Opens Downtown','A new cafe has opened in the city center and is already attracting many visitors.','Local',1,'2026-03-14 21:46:30'),(4,'Local School Wins Award','Students from a local school received a national award for their community project.','Education',4,'2026-03-14 21:46:30'),(5,'Heavy Rain Expected This Weekend','Weather experts say the region may experience heavy rain over the weekend.','Weather',6,'2026-03-14 21:46:30'),(6,'Startup Launches New Mobile App','A small startup has launched a new mobile app designed to help people manage daily tasks.','Technology',3,'2026-03-14 21:46:30'),(7,'City Announces Road Improvements','Several major roads will be repaired this year to improve traffic flow.','Local',2,'2026-03-14 21:46:30'),(8,'Health Officials Encourage Regular Exercise','Doctors remind people that regular physical activity can improve overall health.','Health',7,'2026-03-14 21:46:30'),(9,'Local Library Expands Opening Hours','The city library will now remain open longer to support students and readers.','Education',5,'2026-03-14 21:46:30'),(10,'Online Shopping Continues to Grow','Retail experts report steady growth in online shopping over the past year.','Business',1,'2026-03-14 21:46:30'),(11,'Sports Championship Ends in Surprise Victory','Fans were surprised when the underdog team won the championship match.','Sports',3,'2026-03-14 21:46:30'),(12,'Public Transport Schedule Updated','The city transport authority has released a new schedule for buses and trains.','Local',6,'2026-03-14 21:46:30'),(13,'Local Restaurant Celebrates 20 Years','A popular restaurant is celebrating twenty years of serving the community.','Business',2,'2026-03-14 21:46:30'),(14,'Community Clean-Up Event Announced','Volunteers are invited to join a city-wide clean-up event next month.','Local',4,'2026-03-14 21:46:30'),(15,'New Smartphone Release Attracts Attention','A major electronics company has released its newest smartphone model this week.','Technology',1,'2026-03-14 21:46:30'),(16,'New Test Article title','New! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ','New Test Category',9,'2026-03-15 13:25:24');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jane.doe@example.com','$examplehash1','2026-03-14 20:54:42'),(2,'ola.hansen@example.com','$examplehash2','2026-03-14 20:54:42'),(3,'john.smith@example.com','$examplehash3','2026-03-14 20:54:42'),(4,'emma.thompson@example.com','$examplehash4','2026-03-14 20:54:42'),(5,'kari.nilsen@example.com','$examplehash5','2026-03-14 20:54:42'),(6,'michael.brown@example.com','$examplehash6','2026-03-14 20:54:42'),(7,'oliver.jones@example.com','$examplehash7','2026-03-14 20:54:42'),(8,'test@example.com','$2b$10$VIFPJ3KdVoCaHNVoomZKd.Szg74NwrNAsz1SoT/KZS3iPdvucxfOu','2026-03-15 07:42:17'),(9,'test2@example.com','$2b$10$Tbxsm6.DNW8Mopd3OsgdoOuEk7.lKjkiw7pzoEosVRzQU9N0TuTtq','2026-03-15 13:21:54'),(10,'test3@example.com','$2b$10$FNHdwbF9yKrTjn9soQWWHe/3eWpWNCQE7X6YkTlmvgw3A.3babY16','2026-03-15 13:51:33');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-15 15:23:53
