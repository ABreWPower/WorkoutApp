-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: workoutapp
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.21.10.2

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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `icon` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
INSERT INTO `equipment` VALUES (1,'Dumbbell',NULL),(2,'Bench',NULL),(3,'Treadmill',NULL),(4,'Pullup bar',NULL),(5,'Stationary Bicyle',NULL),(6,'Jump Rope',NULL),(7,'Resistance Bands',NULL),(8,'Elliptical',NULL),(9,'Barbell',NULL),(10,'Kettlebell',NULL),(11,'Squat Rack',NULL),(12,'Benchpress Rack',NULL),(13,'Row Machine',NULL),(14,'Medicine Ball',NULL),(15,'Foam Roller',NULL),(16,'Ropes',NULL),(17,'Platform',NULL),(18,'Speed Bag',NULL),(19,'Heavy Bag',NULL),(20,'Chair',NULL),(21,'TRX/Suspension',NULL),(22,'Dip Bar',NULL),(23,'Weighted Neck Strengthener',NULL);
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `video` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `picture` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `instructions` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `difficulty` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exercise`
--

LOCK TABLES `exercise` WRITE;
/*!40000 ALTER TABLE `exercise` DISABLE KEYS */;
INSERT INTO `exercise` VALUES (8,'Chinup',NULL,'chinup.jpg','Pull your self up on a bar with your palms facing you',3,12,NULL),(9,'Pullup',NULL,'pullup.jfif','Pull your self up on a bar with your palms facing away from you',3,12,NULL),(10,'Bicep Curl',NULL,'dumbbell_bicep_curl.jfif','Curl arms up holding a bar or dumbbell',1,12,NULL),(11,'Preacher Curl',NULL,'preacher_curl.jfif','Curl arms up holding a bar or dumbbell',2,12,NULL),(12,'Hammer Curl',NULL,'hammer_curl.jfif','Curl arms up holding a bar or dumbbell',1,12,NULL),(13,'Concentration Curl',NULL,'concentration_curl.jfif','Curl arms up holding a bar or dumbbell',1,12,NULL),(14,'Reverse Curl',NULL,'reverse_curl.jfif','Curl arms up holding a bar or dumbbell',1,12,NULL),(15,'Waiters Curl','https://www.youtube.com/watch?v=tQRlbZ48U_I','waiters_curl.jfif','Curl arms up holding a bar or dumbbell',2,12,NULL),(16,'Skull Crusher',NULL,'skull_crusher.jpg','Lower weight near your head while on bench, palms facing up, upper arm should be mostly verical',2,10,NULL),(17,'Wide Grip Pushup',NULL,'wide_grip_pushup.jfif','Push off of the ground while keeping the core tight',2,20,NULL),(18,'Pushup',NULL,'pushup.jfif','Push off of the ground while keeping the core tight',2,15,NULL),(19,'Diamond Pushup',NULL,'diamond_pushup.jfif','Push off of the ground while keeping the core tight',3,10,NULL),(20,'Plank',NULL,'plank.jfif','On elbow and toes with body straight out keeping your core tight',3,NULL,60),(21,'Suspension Reverse Rows',NULL,'suspension_reverse_row.png','Heels planted on the ground, arms holding the Suspension handles, lean back to where your arms are almost straight, palms facing together, then pull your hands to the side of your body tightening up your back',2,12,NULL),(22,'Suspension Face Pull',NULL,'suspension_face_pull.webp','Heels planted on the ground, arms holding the Suspension handles, lean back to where your arms are almost straight, palms down together, then pull your hands to your neck with at the same level as your shoulders, tightening up your back and shoulders',2,12,NULL),(23,'Band Wall Walk',NULL,'band_wall_walk.jpg','Place a band around your arms around wrists, then place hands on the wall, move one of your armes away from the other, come back then go diagnoally up and come back and then go diagnally back, repeat for other arm',1,24,NULL),(24,'Neck Strengthing','https://www.youtube.com/watch?v=RN6M1hCE4wY','neck_strengthing.jpg','To perform this exercise find a bench or an object you can have your head laying off of, you will complete reps in each of the for dirctions, forward, backward, and each side.  The direction you are working should be moving way from the ground.  This can ',1,15,NULL),(25,'Prone T','https://www.youtube.com/watch?v=Ygok5LNB1tY','prone_t.jpg','Laying down on the ground, bench, or ball, With you arms straight out to the sides, raise and lower your arms engaging your upper back',1,10,NULL),(26,'Prone Y','https://www.youtube.com/watch?v=Yv6sUKOwOY8&t=6s','prone_y.jpg','Laying down on the ground, bench, or ball, With you arms up making a Y position with your body, raise and lower your arms engaging your upper back',1,10,NULL),(27,'Prone Shoulder Press (swimmers)','https://www.youtube.com/watch?v=SsMtMrc1f9s','prone_shoulder_press.jfif','This motion is similar to a overhead press, start with your hand in the lowered position and then raise them, palms open.  But you will be doing this will lying down on the ground, ball, or bench',1,10,NULL),(28,'Shoulder Shrugs',NULL,'shoulder_shrugs.jfif','Shrug your shoulders holding dumbells or a barbell',1,12,NULL),(29,'Straight arm Raise',NULL,'straight_arm_raise.jfif','Start with your arms at your sides, raise your arms up to shoulder high, you should be creating a T shape',1,12,NULL),(30,'Front Straight arm Raise',NULL,'front_straight_arm_raise.jfif','Start with your arms in front of you, raise your arms up in front of you until they are at shoulder height',1,12,NULL),(31,'Speed Bag - Single Arm Bicycle Chain','https://www.youtube.com/watch?v=AjJ3AYffCsw','speed_bag_multiple.jpg','Speed bag technique',1,NULL,120),(32,'Speed Bag - Front Alternating Bicycle Chain','https://www.youtube.com/watch?v=AjJ3AYffCsw','speed_bag_multiple.jpg','Speed bag technique',1,NULL,120),(33,'Speed Bag - Rear Alternating Bicycle Chain','https://www.youtube.com/watch?v=AjJ3AYffCsw','speed_bag_multiple.jpg','Speed bag technique',2,NULL,120),(34,'Speed Bag - Elbows Roll','https://www.youtube.com/watch?v=xxzMbt1Yvyo','speed_bag_multiple.jpg','Speed bag technique',3,NULL,120),(35,'Speed Bag - Rear Alternating Bicycle Chain','https://www.youtube.com/watch?v=AjJ3AYffCsw','speed_bag_multiple.jpg','Speed bag technique',2,NULL,120),(36,'Speed Bag - Rolling','https://www.youtube.com/watch?v=WpjueP-tOZA','speed_bag_multiple.jpg','Speed bag technique',1,NULL,120),(37,'Speed Bag - Linking','https://www.youtube.com/watch?v=hOTzM8ln_R8','speed_bag_multiple.jpg','Speed bag technique',2,NULL,120),(38,'Speed Bag - Double Punch','https://www.youtube.com/watch?v=5EmwpHSbB5c','speed_bag_multiple.jpg','Speed bag technique',3,NULL,120),(39,'Speed Bag - Pinning/Trapping','https://www.youtube.com/watch?v=3B3nnbw89MA','speed_bag_multiple.jpg','Speed bag technique',3,NULL,120),(40,'Speed Bag - Freestyle',NULL,'speed_bag_multiple.jpg','Speed bag technique',3,NULL,120),(41,'Heavy Bag - Uppercuts',NULL,'heavy_bag.jfif','Hit the hanging heavy back or standing bag',1,NULL,120),(42,'Heavy Bag - Hooks',NULL,'heavy_bag.jfif','Hit the hanging heavy back or standing bag',1,NULL,120),(43,'Heavy Bag - Jabs',NULL,'heavy_bag.jfif','Hit the hanging heavy back or standing bag',1,NULL,120),(44,'Heavy Bag - Crosses',NULL,'heavy_bag.jfif','Hit the hanging heavy back or standing bag',1,NULL,120),(45,'Heavy Bag - Freestyle',NULL,'heavy_bag.jfif','Hit the hanging heavy back or standing bag',2,NULL,120),(46,'Tricep Kickback ',NULL,'tricep_kickback.png','Stand with your knees bent and lean forward slightly, with a dumbbell in each hand. Keeping your back straight, bend your dumbell-holding arm 90 degrees at the elbow so your triceps are aligned with your back and your biceps are perpendicular to the floor',1,12,NULL),(47,'Tricep Dips',NULL,'tricep_dip.jfif','Pur your hands behind you on a chair, bench, or other object. Lower your body until your ares at 90 degrees',2,10,NULL),(48,'Overhead Triceps Extensions',NULL,'overhead_triceps_extensions.jfif','Start with a dumbbell above your head and slowly lower behind your head until your elbows are at 90 degrees ',1,12,NULL),(49,'Rocker Bodyweight Skull Crusher','https://www.youtube.com/watch?v=8gtzrtyKu9E','rocker_bodyweight_skull_crusher.jfif','Contract your triceps to push your body off the ground and slightly back. Squeeze your triceps hard at the top of the rep and slowly return to the starting position. Repeat this motion for your desired number of reps.',3,8,NULL),(50,'Incline Pushup ',NULL,'incline_pushup.jfif','Do a pushup with your arms on a chair, bench, or wall while your feet are still on the ground',1,12,NULL),(51,'Decline Pushup',NULL,'decline_pushup.png','Do a pushup with your feet on a chair, bench, or wall while your hands are still on the ground',2,12,NULL),(52,'Bench press',NULL,'dumbell_bench_press.jfif','Start with your arms straight up while laying on a bench. Lower the dumbell or bar to your chest and then push back to the start position',2,10,NULL),(53,'Incline Bench Press',NULL,'dumbell_incline_bench_press.jfif','Start with your arms straight up while laying on a bench. Lower the dumbell or bar to your chest and then push back to the start position',2,10,NULL),(54,'Decline Bench Press',NULL,'dumbell_decline_bench_press.jfif','Start with your arms straight up while laying on a bench. Lower the dumbell or bar to your chest and then push back to the start position',2,10,NULL),(55,'Chest Dips',NULL,'chest_dips.jfif','Step up on the dip station (if possible) and position your hands with a neutral grip. Initiate the dip by unlocking the elbows and slowly lowering the body until the forearms are almost parallel with the floor. Control the descent to parallel and then drive back to the starting position by pushing through the palms.',2,12,NULL),(56,'Alternating Dumbbell Bench Press',NULL,'alternating_dumbbell_bench_press.png','Start with one arms straight up while laying on a bench. Lower the dumbell to your chest and then push your other arm to the start position',2,10,NULL),(57,'Dumbbell fly',NULL,'dumbbell_fly.jfif','Lie back on a flat bench with a dumbbell in each hand. Keep a slight bend in your elbows and spread your arms wide, lowering the weights until they’re even with your chest. Flex your pecs and lift the weights back to the starting position.',2,8,NULL),(58,'Incline Dumbbell Fly',NULL,'incline_dumbbell_fly.jfif','Lie back on a flat bench with a dumbbell in each hand. Keep a slight bend in your elbows and spread your arms wide, lowering the weights until they’re even with your chest. Flex your pecs and lift the weights back to the starting position.',2,10,NULL),(59,'Decline Dumbbell Fly',NULL,'decline_dumbbell_fly.jfif','Lie back on a flat bench with a dumbbell in each hand. Keep a slight bend in your elbows and spread your arms wide, lowering the weights until they’re even with your chest. Flex your pecs and lift the weights back to the starting position.',2,10,NULL),(60,'Dumbbell Pullover',NULL,NULL,'Extend your arms toward the ceiling, over your chest. Your palms should be facing each other and your elbows slightly bent.  Inhale and extend the weights back and over your head, keeping a strong back and core.  Lower your arms to a fully extended position where the weights are behind—but not below—your head.  Return your arms to the starting position.',1,12,NULL),(61,'Suspension Fly',NULL,NULL,'Extend your arms in front of your shoulders, palms facing each other, and position your feet behind you. Lean forward.  Keeping your abs braced, open your arms to a T position with your palms forward and elbows slightly bent.  Squeeze your chest to bring your hands together in front of you.',2,10,NULL),(62,'Suspension Pushup',NULL,NULL,'Lower yourself down, bending at the elbows and until your chest reaches handle level in the center of the cables.\nExhale as you push yourself up, maintaining a tight core, and back to start position.',2,10,NULL),(63,'Overhead Press',NULL,NULL,'Stand upright and keep the back straight. Hold a dumbbell in each hand, at the shoulders, with an overhand grip.  Raise the weights above the head in a controlled motion. Return to the start position.',1,12,NULL),(64,'Arnold Press',NULL,NULL,'Press the dumbbells upward and rotate your wrists so that your palms face forward at the top of the movement.  Inhale as you lower the dumbbells and rotate your palms so that they face you again at the bottom of the movement.',2,12,NULL),(65,'Seated Dumbbell Rear Delt Raise',NULL,NULL,'Place a couple of dumbbells looking forward in front of a flat bench.  Sit on the end of the bench with your legs together and the dumbbells behind your calves.  Bend at the waist while keeping the back straight in order to pick up the dumbbells. The palms of your hands should be facing each other as you pick them. This will be your starting position.  Keeping your torso forward and stationary, and the arms slightly bent at the elbows, lift the dumbbells straight to the side until both arms are parallel to the floor. Exhale as you lift the weights. After a one second contraction at the top, slowly lower the dumbbells back to the starting position.',2,12,NULL);
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
INSERT INTO `exercise_equipment` VALUES (4,1),(5,1),(10,1),(12,1),(13,1),(14,1),(15,1),(16,1),(28,1),(29,1),(30,1),(46,1),(48,1),(52,1),(53,1),(54,1),(56,1),(57,1),(58,1),(59,1),(60,1),(63,1),(64,1),(65,1),(5,2),(11,2),(14,2),(16,2),(50,2),(51,2),(52,2),(53,2),(54,2),(56,2),(57,2),(58,2),(59,2),(60,2),(63,2),(65,2),(1,4),(2,4),(8,4),(9,4),(23,7),(10,9),(11,9),(16,9),(28,9),(52,9),(53,9),(54,9),(56,9),(63,9),(53,12),(54,12),(56,12),(31,18),(32,18),(33,18),(34,18),(35,18),(36,18),(37,18),(38,18),(39,18),(40,18),(41,19),(42,19),(43,19),(44,19),(45,19),(61,21),(62,21);
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
INSERT INTO `exercise_musclegroup` VALUES (1,1),(2,1),(8,1),(17,1),(18,1),(19,1),(47,1),(49,1),(50,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(3,2),(6,2),(9,2),(21,2),(25,2),(20,3),(3,4),(5,4),(1,5),(2,5),(4,5),(8,8),(10,8),(23,8),(26,8),(29,8),(30,8),(58,8),(63,8),(64,8),(65,8),(21,9),(22,9),(23,9),(25,9),(26,9),(28,9),(8,10),(21,10),(22,10),(60,10),(8,11),(9,11),(10,11),(11,11),(12,11),(13,11),(14,11),(15,11),(64,11),(8,12),(16,12),(17,12),(18,12),(19,12),(46,12),(47,12),(48,12),(49,12),(50,12),(51,12),(52,12),(53,12),(54,12),(55,12),(56,12),(8,13),(9,14),(21,14),(22,14),(24,14),(25,14);
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `picture` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `musclegroup`
--

LOCK TABLES `musclegroup` WRITE;
/*!40000 ALTER TABLE `musclegroup` DISABLE KEYS */;
INSERT INTO `musclegroup` VALUES (1,'Chest',NULL),(2,'Back',NULL),(3,'Abs',NULL),(4,'Quads ',NULL),(5,'Hamstrings',NULL),(6,'Calves',NULL),(7,'Glutes',NULL),(8,'Shoulder',NULL),(9,'Traps',NULL),(10,'Lats',NULL),(11,'Biceps',NULL),(12,'Triceps',NULL),(13,'Forarms',NULL),(14,'Neck',NULL);
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
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
  `userid` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `picture` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_workout_users1_idx` (`userid`),
  CONSTRAINT `fk_workout_users1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout`
--

LOCK TABLES `workout` WRITE;
/*!40000 ALTER TABLE `workout` DISABLE KEYS */;
INSERT INTO `workout` VALUES (1,1,'Workout 1',NULL,'Lots of workouts'),(2,2,'Super B',NULL,'Hard workout'),(3,3,'Short',NULL,'Small number of exercies'),(4,1,'Week 0-2 PT 1',NULL,'Week 0-2 PT 1'),(5,1,'Week 0-2 PT 2',NULL,'Week 0-2 PT 2');
/*!40000 ALTER TABLE `workout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workout_exercise`
--

DROP TABLE IF EXISTS `workout_exercise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workout_exercise` (
  `id` int NOT NULL AUTO_INCREMENT,
  `workoutid` int NOT NULL,
  `exerciseid` int NOT NULL,
  `reps` int unsigned DEFAULT NULL,
  `sets` int unsigned DEFAULT NULL,
  `duration` int unsigned DEFAULT NULL,
  `rest` int unsigned DEFAULT NULL,
  `sort` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_workout_has_exercise_exercise1_idx` (`exerciseid`),
  KEY `fk_workout_has_exercise_workout_idx` (`workoutid`),
  CONSTRAINT `fk_workout_has_exercise_exercise1` FOREIGN KEY (`exerciseid`) REFERENCES `exercise` (`id`),
  CONSTRAINT `fk_workout_has_exercise_workout` FOREIGN KEY (`workoutid`) REFERENCES `workout` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workout_exercise`
--

LOCK TABLES `workout_exercise` WRITE;
/*!40000 ALTER TABLE `workout_exercise` DISABLE KEYS */;
INSERT INTO `workout_exercise` VALUES (6,2,7,NULL,NULL,NULL,NULL,NULL),(7,2,8,NULL,NULL,NULL,NULL,NULL),(8,2,9,NULL,NULL,NULL,NULL,NULL),(9,2,10,NULL,NULL,NULL,NULL,NULL),(10,3,8,NULL,NULL,NULL,NULL,NULL),(11,3,10,NULL,NULL,NULL,NULL,NULL),(12,3,12,NULL,NULL,NULL,NULL,NULL),(13,1,7,NULL,1,NULL,NULL,0),(14,1,8,NULL,NULL,NULL,NULL,1),(15,1,9,NULL,NULL,NULL,NULL,2),(16,1,10,NULL,NULL,NULL,NULL,3),(17,1,11,NULL,NULL,NULL,NULL,4),(28,4,15,15,2,NULL,30,2),(29,4,28,12,2,NULL,30,3),(30,4,23,24,2,NULL,30,4),(31,4,25,10,2,NULL,30,0),(32,4,26,10,2,NULL,30,1),(33,5,27,10,NULL,NULL,NULL,0),(34,5,21,12,NULL,NULL,NULL,1),(35,5,10,12,NULL,NULL,NULL,2),(36,5,29,12,NULL,NULL,NULL,3),(37,5,22,12,NULL,NULL,NULL,4);
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
  `workoutid` int NOT NULL,
  `userid` int NOT NULL,
  `datestarted` datetime DEFAULT NULL,
  `datecompleted` datetime DEFAULT NULL,
  `completed` tinyint(1) GENERATED ALWAYS AS ((`datecompleted` is not null)) VIRTUAL,
  PRIMARY KEY (`id`),
  KEY `fk_workoutlog_users1_idx` (`userid`),
  KEY `fk_workoutlog_workout1_idx` (`workoutid`),
  CONSTRAINT `fk_workoutlog_users1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_workoutlog_workout1` FOREIGN KEY (`workoutid`) REFERENCES `workout` (`id`)
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
  `workoutlogid` int NOT NULL,
  `exerciseid` int NOT NULL,
  `sets` int DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `rest` int DEFAULT NULL,
  `weight` int DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `datestarted` datetime DEFAULT NULL,
  `datecompleted` datetime DEFAULT NULL,
  `span` int DEFAULT NULL,
  `actualspan` int GENERATED ALWAYS AS ((`span` - (`sets` * `rest`))) VIRTUAL,
  `completed` tinyint(1) GENERATED ALWAYS AS ((`datecompleted` is not null)) VIRTUAL,
  PRIMARY KEY (`id`),
  KEY `fk_workoutlogexercise_workoutlog1_idx` (`workoutlogid`),
  KEY `fk_workoutlogexercise_exercise1_idx` (`exerciseid`),
  CONSTRAINT `fk_workoutlogexercise_exercise1` FOREIGN KEY (`exerciseid`) REFERENCES `exercise` (`id`),
  CONSTRAINT `fk_workoutlogexercise_workoutlog1` FOREIGN KEY (`workoutlogid`) REFERENCES `workoutlog` (`id`)
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

-- Dump completed on 2022-06-14 23:49:54
