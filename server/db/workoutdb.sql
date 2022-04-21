-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: devbox.home.lan    Database: workoutapp
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.21.10.3

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
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Dumbbell',NULL),(2,'Bench',NULL),(3,'Treadmill',NULL),(4,'Pullup bar',NULL);
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise`
--

DROP TABLE IF EXISTS `exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `instructions` varchar(255) DEFAULT NULL,
  `difficulty` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise`
--

LOCK TABLES `exercise` WRITE;
/*!40000 ALTER TABLE `exercise` DISABLE KEYS */;
INSERT INTO `exercise` VALUES (1,'Chinup',NULL,NULL,'Pull your self up on a bar',1,10,NULL),(2,'Pullup',NULL,NULL,'Pull your self up on a bar',2,15,NULL),(3,'Pushup',NULL,NULL,'Push off of the ground',3,20,NULL),(4,'Bicep Curl',NULL,NULL,'Curl arms up holding a bar or dumbbell',1,12,NULL),(5,'Skull Crusher',NULL,NULL,'lower weight near your head while on bench',2,8,NULL),(6,'Plank',NULL,NULL,'On elbow and toes with body straight out',3,NULL,60);
/*!40000 ALTER TABLE `exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_equipment`
--

DROP TABLE IF EXISTS `exercise_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_equipment` (
  `exerciseid` int NOT NULL,
  `equipmentid` int NOT NULL,
  PRIMARY KEY (`exerciseid`,`equipmentid`),
  KEY `fk_exercise_has_equipment_equipment1_idx` (`equipmentid`),
  KEY `fk_exercise_has_equipment_exercise1_idx` (`exerciseid`),
  CONSTRAINT `fk_exercise_has_equipment_equipment1` FOREIGN KEY (`equipmentid`) REFERENCES `equipment` (`id`),
  CONSTRAINT `fk_exercise_has_equipment_exercise1` FOREIGN KEY (`exerciseid`) REFERENCES `exercise` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_equipment`
--

LOCK TABLES `exercise_equipment` WRITE;
/*!40000 ALTER TABLE `exercise_equipment` DISABLE KEYS */;
INSERT INTO `exercise_equipment` VALUES (4,1),(5,1),(5,2),(1,4),(2,4);
/*!40000 ALTER TABLE `exercise_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exercise_musclegroup`
--

DROP TABLE IF EXISTS `exercise_musclegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercise_musclegroup` (
  `exerciseid` int NOT NULL,
  `musclegroupid` int NOT NULL,
  PRIMARY KEY (`exerciseid`,`musclegroupid`),
  KEY `fk_exercise_has_musclegroup_musclegroup1_idx` (`musclegroupid`),
  KEY `fk_exercise_has_musclegroup_exercise1_idx` (`exerciseid`),
  CONSTRAINT `fk_exercise_has_musclegroup_exercise1` FOREIGN KEY (`exerciseid`) REFERENCES `exercise` (`id`),
  CONSTRAINT `fk_exercise_has_musclegroup_musclegroup1` FOREIGN KEY (`musclegroupid`) REFERENCES `musclegroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise_musclegroup`
--

LOCK TABLES `exercise_musclegroup` WRITE;
/*!40000 ALTER TABLE `exercise_musclegroup` DISABLE KEYS */;
INSERT INTO `exercise_musclegroup` VALUES (1,1),(2,1),(3,2),(6,2),(3,4),(5,4),(1,5),(2,5),(4,5);
/*!40000 ALTER TABLE `exercise_musclegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `musclegroup`
--

DROP TABLE IF EXISTS `musclegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `musclegroup` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musclegroup`
--

LOCK TABLES `musclegroup` WRITE;
/*!40000 ALTER TABLE `musclegroup` DISABLE KEYS */;
INSERT INTO `musclegroup` VALUES (1,'Chest',NULL),(2,'Abs',NULL),(3,'Quadriceps',NULL),(4,'Tricep',NULL),(5,'Bicep',NULL);
/*!40000 ALTER TABLE `musclegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'John Smith','john.smith@email.com',NULL),(2,'Adam Smith','adam.smith@email.com',NULL),(3,'Patrick Smith','patrick.smith@email.com',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout`
--

DROP TABLE IF EXISTS `workout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `user` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout`
--

LOCK TABLES `workout` WRITE;
/*!40000 ALTER TABLE `workout` DISABLE KEYS */;
INSERT INTO `workout` VALUES (1,'Workout 1',NULL,'Lots of workouts',1,90),(2,'Super B',NULL,'Hard workout',2,60),(3,'Short',NULL,'Small number of exercies',3,30);
/*!40000 ALTER TABLE `workout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_exercise`
--

DROP TABLE IF EXISTS `workout_exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_exercise` (
  `workoutid` int NOT NULL,
  `exerciseid` int NOT NULL,
  PRIMARY KEY (`workoutid`,`exerciseid`),
  KEY `fk_workout_has_exercise_exercise1_idx` (`exerciseid`),
  KEY `fk_workout_has_exercise_workout_idx` (`workoutid`),
  CONSTRAINT `fk_workout_has_exercise_exercise1` FOREIGN KEY (`exerciseid`) REFERENCES `exercise` (`id`),
  CONSTRAINT `fk_workout_has_exercise_workout` FOREIGN KEY (`workoutid`) REFERENCES `workout` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_exercise`
--

LOCK TABLES `workout_exercise` WRITE;
/*!40000 ALTER TABLE `workout_exercise` DISABLE KEYS */;
INSERT INTO `workout_exercise` VALUES (1,1),(2,1),(1,2),(2,2),(3,2),(1,3),(2,3),(1,4),(3,4),(1,5),(2,5),(3,6);
/*!40000 ALTER TABLE `workout_exercise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workoutlog`
--

DROP TABLE IF EXISTS `workoutlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workoutlog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user` int NOT NULL,
  `workout` int NOT NULL,
  `totalduration` int DEFAULT NULL,
  `starteddatetime` int DEFAULT NULL,
  `wlexercises` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workoutlog`
--

LOCK TABLES `workoutlog` WRITE;
/*!40000 ALTER TABLE `workoutlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `workoutlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workoutlogexercise`
--

DROP TABLE IF EXISTS `workoutlogexercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workoutlogexercise` (
  `id` int NOT NULL AUTO_INCREMENT,
  `workoutlog` int NOT NULL,
  `exercise` int NOT NULL,
  `sets` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `rest` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `actualduration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workoutlogexercise`
--

LOCK TABLES `workoutlogexercise` WRITE;
/*!40000 ALTER TABLE `workoutlogexercise` DISABLE KEYS */;
/*!40000 ALTER TABLE `workoutlogexercise` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-20 21:24:46
