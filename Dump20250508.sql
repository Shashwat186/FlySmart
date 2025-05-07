-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: flightreservation
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `action_log`
--

DROP TABLE IF EXISTS `action_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action_log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `action_performed` varchar(255) NOT NULL,
  `controller_name` varchar(100) NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=440 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airline` (
  `Airline_ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Airline_ID`),
  UNIQUE KEY `Code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `airport` (
  `Airport_ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `contact_info` varchar(255) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Airport_ID`),
  UNIQUE KEY `Code` (`code`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `Booking_ID` int NOT NULL AUTO_INCREMENT,
  `Flight_ID` int NOT NULL,
  `Seat_Class_ID` int NOT NULL,
  `Booking_Date_Time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Number_of_Seats` int NOT NULL,
  `total_price` double NOT NULL,
  `number_of_adults` int DEFAULT NULL,
  `number_of_children` int DEFAULT NULL,
  `User_ID` int DEFAULT NULL,
  `status` enum('BOOKED','CANCELLED') DEFAULT 'BOOKED',
  PRIMARY KEY (`Booking_ID`),
  KEY `Flight_ID` (`Flight_ID`),
  KEY `Seat_Class_ID` (`Seat_Class_ID`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`Flight_ID`) REFERENCES `flight` (`flight_Id`) ON DELETE CASCADE,
  CONSTRAINT `booking_ibfk_3` FOREIGN KEY (`Seat_Class_ID`) REFERENCES `seat_class` (`Seat_Class_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_seats_after_cancellation` AFTER UPDATE ON `booking` FOR EACH ROW BEGIN
    IF NEW.status = 'CANCELLED' AND OLD.status = 'BOOKED' THEN
        UPDATE flight_seats
        SET Available_Seats = Available_Seats + NEW.Number_of_Seats
        WHERE Flight_ID = NEW.Flight_ID AND Seat_Class_ID = NEW.Seat_Class_ID;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `business_owner`
--

DROP TABLE IF EXISTS `business_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `business_owner` (
  `BO_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  PRIMARY KEY (`BO_ID`),
  UNIQUE KEY `User_ID` (`User_ID`),
  CONSTRAINT `business_owner_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `Feedback_ID` int NOT NULL AUTO_INCREMENT,
  `User_ID` int NOT NULL,
  `Feedback_Date_Time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Rating` int DEFAULT NULL,
  `Feedback_Content` text NOT NULL,
  `status` enum('unchecked','checked') DEFAULT 'unchecked',
  `Booking_ID` int NOT NULL,
  PRIMARY KEY (`Feedback_ID`),
  KEY `User_ID` (`User_ID`),
  KEY `FK_BookingFeedback` (`Booking_ID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_BookingFeedback` FOREIGN KEY (`Booking_ID`) REFERENCES `booking` (`Booking_ID`) ON DELETE CASCADE,
  CONSTRAINT `feedback_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight` (
  `flight_Id` int NOT NULL AUTO_INCREMENT,
  `flight_number` varchar(255) NOT NULL,
  `Airline_ID` int NOT NULL,
  `Departure_Airport_ID` int NOT NULL,
  `Arrival_Airport_ID` int NOT NULL,
  `Departure_Date_Time` datetime NOT NULL,
  `Arrival_Date_Time` datetime NOT NULL,
  `Status` enum('Scheduled','Delayed','Cancelled','Completed') NOT NULL,
  `FM_ID` int NOT NULL,
  PRIMARY KEY (`flight_Id`),
  UNIQUE KEY `Flight_Number` (`flight_number`),
  KEY `Airline_ID` (`Airline_ID`),
  KEY `Departure_Airport_ID` (`Departure_Airport_ID`),
  KEY `Arrival_Airport_ID` (`Arrival_Airport_ID`),
  KEY `FM_ID` (`FM_ID`),
  CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`Airline_ID`) REFERENCES `airline` (`Airline_ID`) ON DELETE CASCADE,
  CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`Departure_Airport_ID`) REFERENCES `airport` (`Airport_ID`) ON DELETE CASCADE,
  CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`Arrival_Airport_ID`) REFERENCES `airport` (`Airport_ID`) ON DELETE CASCADE,
  CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`FM_ID`) REFERENCES `flight_manager` (`FM_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flight_manager`
--

DROP TABLE IF EXISTS `flight_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_manager` (
  `FM_ID` int NOT NULL AUTO_INCREMENT,
  `BO_ID` int NOT NULL,
  `User_ID` int NOT NULL,
  PRIMARY KEY (`FM_ID`),
  UNIQUE KEY `User_ID` (`User_ID`),
  KEY `BO_ID` (`BO_ID`),
  CONSTRAINT `flight_manager_ibfk_1` FOREIGN KEY (`BO_ID`) REFERENCES `business_owner` (`BO_ID`) ON DELETE CASCADE,
  CONSTRAINT `flight_manager_ibfk_2` FOREIGN KEY (`User_ID`) REFERENCES `user` (`User_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flight_seats`
--

DROP TABLE IF EXISTS `flight_seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `flight_seats` (
  `Flight_Seat_ID` int NOT NULL AUTO_INCREMENT,
  `Flight_ID` int NOT NULL,
  `Seat_Class_ID` int NOT NULL,
  `Available_Seats` int NOT NULL,
  `Total_Seats` int NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`Flight_Seat_ID`),
  KEY `Flight_ID` (`Flight_ID`),
  KEY `Seat_Class_ID` (`Seat_Class_ID`),
  CONSTRAINT `flight_seats_ibfk_1` FOREIGN KEY (`Flight_ID`) REFERENCES `flight` (`flight_Id`) ON DELETE CASCADE,
  CONSTRAINT `flight_seats_ibfk_2` FOREIGN KEY (`Seat_Class_ID`) REFERENCES `seat_class` (`Seat_Class_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `Passenger_ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `Loyalty_Points` int DEFAULT '0',
  `Is_Registered` tinyint(1) DEFAULT '0',
  `Link_Reg_ID` int DEFAULT NULL,
  `Booking_ID` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  PRIMARY KEY (`Passenger_ID`),
  KEY `FK_passengers_bookings` (`Booking_ID`),
  CONSTRAINT `FK_passengers_bookings` FOREIGN KEY (`Booking_ID`) REFERENCES `booking` (`Booking_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expiry_date` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `Payment_ID` int NOT NULL AUTO_INCREMENT,
  `Booking_ID` int NOT NULL,
  `card_number` varchar(255) DEFAULT NULL,
  `card_holder_name` varchar(255) DEFAULT NULL,
  `expiry_date` varchar(10) DEFAULT NULL,
  `Payment_Date_Time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Payment_Mode` enum('Credit Card','Debit Card','UPI') NOT NULL,
  `Transaction_ID` varchar(255) DEFAULT NULL,
  `upi_id` varchar(255) DEFAULT NULL,
  `Wallet_Name` varchar(100) DEFAULT NULL,
  `Card_Type` enum('Credit','Debit') DEFAULT NULL,
  `Amount` double NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  KEY `Booking_ID` (`Booking_ID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Booking_ID`) REFERENCES `booking` (`Booking_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seat_class`
--

DROP TABLE IF EXISTS `seat_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat_class` (
  `Seat_Class_ID` int NOT NULL AUTO_INCREMENT,
  `Class_Name` enum('Economy','Business','First Class') NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`Seat_Class_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `User_ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `Role` enum('Passenger','Manager','Owner') NOT NULL,
  `Gender` enum('Male','Female','Other') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `password_hash` varchar(64) NOT NULL,
  `password_salt` varchar(40) NOT NULL,
  `profile_photo` longblob,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `Email` (`email`),
  UNIQUE KEY `Phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `user_AFTER_UPDATE` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
IF OLD.Role != 'Owner' AND NEW.Role = 'Owner' THEN
    -- Insert the User_ID into the business_owner table
    INSERT INTO business_owner (User_ID)
    VALUES (NEW.User_ID);
END IF;
 
-- Check if the role was changed FROM 'Owner' to something else
IF OLD.Role = 'Owner' AND NEW.Role != 'Owner' THEN
    -- Delete the corresponding entry from the business_owner table
    DELETE FROM business_owner
    WHERE User_ID = OLD.User_ID;
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'flightreservation'
--

--
-- Dumping routines for database 'flightreservation'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-08  4:07:38
