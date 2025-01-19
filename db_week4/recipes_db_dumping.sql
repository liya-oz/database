-- MySQL dump 10.13  Distrib 8.4.3, for macos14 (x86_64)
--
-- Host: localhost    Database: recipes_db
-- ------------------------------------------------------
-- Server version	8.4.3

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
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `CategoryId` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(255) NOT NULL,
  PRIMARY KEY (`CategoryId`),
  UNIQUE KEY `CategoryName` (`CategoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES (1,'Bakery'),(3,'Beverages'),(2,'Main Course');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CookingStep`
--

DROP TABLE IF EXISTS `CookingStep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CookingStep` (
  `CookingStepId` int NOT NULL AUTO_INCREMENT,
  `CookingStepName` varchar(255) NOT NULL,
  PRIMARY KEY (`CookingStepId`),
  UNIQUE KEY `CookingStepName` (`CookingStepName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CookingStep`
--

LOCK TABLES `CookingStep` WRITE;
/*!40000 ALTER TABLE `CookingStep` DISABLE KEYS */;
INSERT INTO `CookingStep` VALUES (2,'Boil the water'),(1,'Chop the vegetables'),(3,'Mix the ingredients'),(4,'Serve in a glass');
/*!40000 ALTER TABLE `CookingStep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diet_Types`
--

DROP TABLE IF EXISTS `Diet_Types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Diet_Types` (
  `DietTypeID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`DietTypeID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diet_Types`
--

LOCK TABLES `Diet_Types` WRITE;
/*!40000 ALTER TABLE `Diet_Types` DISABLE KEYS */;
INSERT INTO `Diet_Types` VALUES (3,'Keto'),(2,'Vegan'),(1,'Vegetarian');
/*!40000 ALTER TABLE `Diet_Types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredient` (
  `IngredientId` int NOT NULL AUTO_INCREMENT,
  `IngredientName` varchar(255) NOT NULL,
  `IngredientGroupId` int NOT NULL,
  PRIMARY KEY (`IngredientId`),
  UNIQUE KEY `IngredientName` (`IngredientName`),
  KEY `IngredientGroupId` (`IngredientGroupId`),
  CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`IngredientGroupId`) REFERENCES `IngredientGroup` (`IngredientGroupId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (1,'Carrot',1),(2,'Tomato',1),(3,'Lettuce',1),(4,'Apple',2),(5,'Chicken',3);
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IngredientGroup`
--

DROP TABLE IF EXISTS `IngredientGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IngredientGroup` (
  `IngredientGroupId` int NOT NULL AUTO_INCREMENT,
  `IngredientGroupName` varchar(255) NOT NULL,
  PRIMARY KEY (`IngredientGroupId`),
  UNIQUE KEY `IngredientGroupName` (`IngredientGroupName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IngredientGroup`
--

LOCK TABLES `IngredientGroup` WRITE;
/*!40000 ALTER TABLE `IngredientGroup` DISABLE KEYS */;
INSERT INTO `IngredientGroup` VALUES (2,'Fruits'),(3,'Meats'),(1,'Vegetables');
/*!40000 ALTER TABLE `IngredientGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe_Category`
--

DROP TABLE IF EXISTS `Recipe_Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipe_Category` (
  `RecipeId` int NOT NULL,
  `CategoryId` int NOT NULL,
  UNIQUE KEY `RecipeId` (`RecipeId`,`CategoryId`),
  KEY `idx_recipe_category` (`CategoryId`),
  CONSTRAINT `recipe_category_ibfk_1` FOREIGN KEY (`RecipeId`) REFERENCES `Recipes` (`RecipeId`) ON DELETE CASCADE,
  CONSTRAINT `recipe_category_ibfk_2` FOREIGN KEY (`CategoryId`) REFERENCES `Category` (`CategoryId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_Category`
--

LOCK TABLES `Recipe_Category` WRITE;
/*!40000 ALTER TABLE `Recipe_Category` DISABLE KEYS */;
INSERT INTO `Recipe_Category` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `Recipe_Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe_CookingStep`
--

DROP TABLE IF EXISTS `Recipe_CookingStep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipe_CookingStep` (
  `RecipeId` int NOT NULL,
  `CookingStepId` int NOT NULL,
  `StepOrder` int NOT NULL,
  UNIQUE KEY `RecipeId` (`RecipeId`,`CookingStepId`,`StepOrder`),
  KEY `idx_recipe_step` (`CookingStepId`),
  CONSTRAINT `recipe_cookingstep_ibfk_1` FOREIGN KEY (`RecipeId`) REFERENCES `Recipes` (`RecipeId`) ON DELETE CASCADE,
  CONSTRAINT `recipe_cookingstep_ibfk_2` FOREIGN KEY (`CookingStepId`) REFERENCES `CookingStep` (`CookingStepId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_CookingStep`
--

LOCK TABLES `Recipe_CookingStep` WRITE;
/*!40000 ALTER TABLE `Recipe_CookingStep` DISABLE KEYS */;
INSERT INTO `Recipe_CookingStep` VALUES (1,1,1),(1,2,2),(2,3,1),(3,4,1);
/*!40000 ALTER TABLE `Recipe_CookingStep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe_Ingredient`
--

DROP TABLE IF EXISTS `Recipe_Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipe_Ingredient` (
  `RecipeId` int NOT NULL,
  `IngredientId` int NOT NULL,
  `NeededAmount` varchar(100) DEFAULT NULL,
  UNIQUE KEY `RecipeId` (`RecipeId`,`IngredientId`),
  KEY `idx_recipe_ingredient` (`IngredientId`),
  CONSTRAINT `recipe_ingredient_ibfk_1` FOREIGN KEY (`RecipeId`) REFERENCES `Recipes` (`RecipeId`) ON DELETE CASCADE,
  CONSTRAINT `recipe_ingredient_ibfk_2` FOREIGN KEY (`IngredientId`) REFERENCES `Ingredient` (`IngredientId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe_Ingredient`
--

LOCK TABLES `Recipe_Ingredient` WRITE;
/*!40000 ALTER TABLE `Recipe_Ingredient` DISABLE KEYS */;
INSERT INTO `Recipe_Ingredient` VALUES (1,1,'2 Carrots'),(1,2,'3 Tomatoes'),(2,3,'1 Lettuce'),(3,4,'2 Apples');
/*!40000 ALTER TABLE `Recipe_Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipes`
--

DROP TABLE IF EXISTS `Recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipes` (
  `RecipeId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` text,
  `CookingTime_min` int DEFAULT NULL,
  `IsVegetarian` tinyint(1) DEFAULT NULL,
  `IsVegan` tinyint(1) DEFAULT NULL,
  `DietTypeID` int DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdatedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CategoryId` int NOT NULL,
  PRIMARY KEY (`RecipeId`),
  UNIQUE KEY `Name` (`Name`),
  KEY `DietTypeID` (`DietTypeID`),
  KEY `CategoryId` (`CategoryId`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`DietTypeID`) REFERENCES `Diet_Types` (`DietTypeID`) ON DELETE SET NULL,
  CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`CategoryId`) REFERENCES `Category` (`CategoryId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipes`
--

LOCK TABLES `Recipes` WRITE;
/*!40000 ALTER TABLE `Recipes` DISABLE KEYS */;
INSERT INTO `Recipes` VALUES (1,'Vegetable Soup','A healthy vegetarian soup.',30,1,1,1,'2025-01-19 15:56:39','2025-01-19 15:56:39',2),(2,'Keto Salad','A delicious keto-friendly salad.',15,1,0,3,'2025-01-19 15:56:39','2025-01-19 15:56:39',2),(3,'Fruit Juice','Refreshing fruit juice.',10,1,1,2,'2025-01-19 15:56:39','2025-01-19 15:56:39',3);
/*!40000 ALTER TABLE `Recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SubCategory`
--

DROP TABLE IF EXISTS `SubCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SubCategory` (
  `SubCategoryId` int NOT NULL AUTO_INCREMENT,
  `SubCategoryName` varchar(255) NOT NULL,
  `CategoryId` int NOT NULL,
  PRIMARY KEY (`SubCategoryId`),
  UNIQUE KEY `SubCategoryName` (`SubCategoryName`),
  KEY `CategoryId` (`CategoryId`),
  CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`CategoryId`) REFERENCES `Category` (`CategoryId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SubCategory`
--

LOCK TABLES `SubCategory` WRITE;
/*!40000 ALTER TABLE `SubCategory` DISABLE KEYS */;
INSERT INTO `SubCategory` VALUES (1,'Bread',1),(2,'Cakes',1),(3,'Dinner',2),(4,'Drinks',3);
/*!40000 ALTER TABLE `SubCategory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-19 23:38:42
