-- MySQL dump 10.13  Distrib 8.0.28, for Linux (x86_64)
--
-- Host: localhost    Database: workoutapp
-- ------------------------------------------------------
-- Server version	8.0.28-0ubuntu0.21.10.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
INSERT INTO `equipment` VALUES 
  (1,'Dumbbell',NULL),
  (2,'Bench',NULL),
  (3,'Treadmill',NULL),
  (4,'Pullup bar',NULL),
  (5,'Stationary Bicyle', NULL),
  (6,'Jump Rope', NULL),
  (7,'Resistance Bands', NULL),
  (8,'Elliptical', NULL),
  (9,'Barbell', NULL),
  (10,'Kettlebell', NULL),
  (11,'Squat Rack', NULL),
  (12,'Benchpress Rack', NULL),
  (13,'Row Machine', NULL),
  (14,'Medicine Ball', NULL),
  (15,'Foam Roller', NULL),
  (16,'Ropes', NULL),
  (17,'Platform', NULL);
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
-- (id, name, video, picture, instructions, difficulty, reps, duration)
INSERT INTO `exercise` VALUES 
  (1, 'Rest', NULL, 'rest.jpg', 'Allow the body to take time to recover', 0, NULL, 30),
  (2,'Chinup',NULL,NULL,'Pull your self up on a bar with your palms facing you',1,10,NULL),
  (3,'Pullup',NULL,NULL,'Pull your self up on a bar with your palms facing away from you',2,15,NULL),
  (4,'Pushup',NULL, 'pushup.jpg','Push off of the ground while keeping the core tight',3,20,NULL),
  (5,'Bicep Curl',NULL,NULL,'Curl arms up holding a bar or dumbbell',1,12,NULL),
  (6,'Skull Crusher',NULL,NULL,'Lower weight near your head while on bench, palms facing up, upper arm should be mostly verical',2,8,NULL),
  (7,'Plank',NULL,NULL,'On elbow and toes with body straight out keeping your core tight',3,NULL,60),
  (8, 'Suspension Reverse Rows', NULL, 'Suspension_row.png', 'Heels planted on the ground, arms holding the Suspension handles, lean back to where your arms are almost straight, palms facing together, then pull your hands to the side of your body tightening up your back', 2, 12, NULL),
  (9, 'Suspension Face Pull', NULL, 'Suspension_face_pull.jfif', 'Heels planted on the ground, arms holding the Suspension handles, lean back to where your arms are almost straight, palms down together, then pull your hands to your neck with at the same level as your shoulders, tightening up your back and shoulders', 2, 12, NULL),
  (10, 'Band Wall Walk', NULL, 'band_wall_walk.jpg', 'Place a band around your arms around wrists, then place hands on the wall, move one of your armes away from the other, come back then go diagnoally up and come back and then go diagnally back, repeat for other arm', 1, 5, NULL),
  (11, 'Neck Strengthing', 'https://www.youtube.com/watch?v=RN6M1hCE4wY', 'neck_strengthing.jpg', 'To perform this exercise find a bench or an object you can have your head laying off of, you will complete reps in each of the for dirctions, forward, backward, and each side.  The direction you are working should be moving way from the ground.  This can be weighted or unweighted', 1, 15, NULL),
  (12, 'Prone T', 'https://www.youtube.com/watch?v=Ygok5LNB1tY', 'prone_t.jpg', 'Laying down on the ground, bench, or ball, With you arms straight out to the sides, raise and lower your arms engaging your upper back', 1, 10, NULL),
  (13, 'Prone Y', 'https://www.youtube.com/watch?v=Yv6sUKOwOY8&t=6s', 'prone_y.jpg', 'Laying down on the ground, bench, or ball, With you arms up making a Y position with your body, raise and lower your arms engaging your upper back', 1, 10, NULL),
  (14, 'Swimmers', NULL, NULL, 'This motion is similar to a overhead press, start with your hand in the lowered position and then raise them, palms open.  But you will be doing this will lying down on the ground, ball, or bench', 1, 10, NULL),
  (15, 'Shoulder Shrugs', NULL, 'shoulder_shrugs.jfif', 'Shrug your shoulders holding dumbells or a barbell', 1, 12, NULL),
  (16, 'Straight arm Raise', NULL, 'straight_arm_raise.jfif', 'Start with your arms at your sides, raise your arms up to shoulder high, you should be creating a T shape', 1, 12, NULL),
  (17, 'Front Straight arm Raise', NULL, 'front_straight_arm_raise.jfif', 'Start with your arms in front of you, raise your arms up in front of you until they are at shoulder height', 1, 12, NULL)
  -- (18, 'Speed Bag - Single Arm Bicycle Chain'), https://www.youtube.com/watch?v=AjJ3AYffCsw
  -- (19, 'Speed Bag - Front Alternating Bicycle Chain'), https://www.youtube.com/watch?v=AjJ3AYffCsw
  -- (20, 'Speed Bag - Rear Alternating Bicycle Chain'), https://www.youtube.com/watch?v=AjJ3AYffCsw
  -- (21, 'Speed Bag - Elbows Roll'), https://www.youtube.com/watch?v=xxzMbt1Yvyo
  -- (22, 'Speed Bag - Rear Alternating Bicycle Chain'), https://www.youtube.com/watch?v=AjJ3AYffCsw
  -- (23, 'Speed Bag - Rolling'), https://www.youtube.com/watch?v=WpjueP-tOZA
  -- (24, 'Speed Bag - Linking'), https://www.youtube.com/watch?v=hOTzM8ln_R8
  -- (25, 'Speed Bag - Double Punch'), 
  -- (26, 'Speed Bag - Pinning/Trapping'),
  -- (26, 'Speed Bag - Freestyle'),
  -- (28, 'Heavy Bag - Uppercuts'),
  -- (29, 'Heavy Bag - Hooks'),
  -- (30, 'Heavy Bag - Jabs'),
  -- (31, 'Heavy Bag - Crosses'),
  -- (32, 'Heavy Bag - Freestyle'),
  -- (33, 'Isometrics - Neck),
  -- (34, ),
  -- (35, ),
  -- (36, ),
  -- (37, ),
  -- (38, ),
  -- (39, ),
  -- (40, ),
  ;
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
INSERT INTO `musclegroup` VALUES 
  (1, 'Chest',NULL),
  (2, 'Back',NULL),
  (3, 'Abs',NULL),
  (4, 'Quads ',NULL),
  (5, 'Hamstrings',NULL),
  (6, 'Calves',NULL),
  (7, 'Glutes',NULL),
  (8, 'Shoulder', NULL),
  (9, 'Traps',NULL),
  (10, 'Lats',NULL),
  (11, 'Bicepts', NULL),
  (12, 'Tricepts', NULL),
  (13, 'Forarms', NULL),
  (14, 'Neck',NULL);
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
CREATE TABLE IF NOT EXISTS `workout_exercise` (
  `workoutid` INT NOT NULL,
  `exerciseid` INT NOT NULL,
  `reps` INT UNSIGNED NULL,
  `sets` INT UNSIGNED NULL,
  `duration` INT UNSIGNED NULL,
  `rest` INT UNSIGNED NULL,
  PRIMARY KEY (`workoutid`, `exerciseid`),
  INDEX `fk_workout_has_exercise_exercise1_idx` (`exerciseid` ASC),
  INDEX `fk_workout_has_exercise_workout_idx` (`workoutid` ASC),
  CONSTRAINT `fk_workout_has_exercise_workout`
    FOREIGN KEY (`workoutid`)
    REFERENCES `workout` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_workout_has_exercise_exercise1`
    FOREIGN KEY (`exerciseid`)
    REFERENCES `exercise` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


--
-- Dumping data for table `workout_exercise`
--

-- TODO update values to have 0s or fake data
LOCK TABLES `workout_exercise` WRITE;
/*!40000 ALTER TABLE `workout_exercise` DISABLE KEYS */;
INSERT INTO `workout_exercise` (workoutid, exerciseid) VALUES (1,1),(2,1),(1,2),(2,2),(3,2),(1,3),(2,3),(1,4),(3,4),(1,5),(2,5),(3,6);
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

-- Dump completed on 2022-04-21  2:12:45
