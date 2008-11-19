-- MySQL dump 10.11
--
-- Host: localhost    Database: tianblue_production
-- ------------------------------------------------------
-- Server version	5.0.51a-3ubuntu5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article_images`
--

DROP TABLE IF EXISTS `article_images`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `article_images` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `height` int(11) default NULL,
  `width` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `thumbnail` varchar(255) default NULL,
  `article_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `article_images`
--

LOCK TABLES `article_images` WRITE;
/*!40000 ALTER TABLE `article_images` DISABLE KEYS */;
INSERT INTO `article_images` VALUES (13,170590,'image/jpeg','Snow_Polo_2.jpg',317,423,NULL,NULL,1,'2008-06-28 09:56:13','2008-06-28 09:56:13'),(14,42366,'image/jpeg','Snow_Polo_2_mini.jpg',153,205,13,'mini',NULL,'2008-06-28 09:56:13','2008-06-28 09:56:13'),(15,158309,'image/jpeg','Snow_Polo_2_main.jpg',317,423,13,'main',NULL,'2008-06-28 09:56:13','2008-06-28 09:56:13'),(16,3953,'image/jpeg','Snow_Polo_2_thumb.jpg',45,45,13,'thumb',NULL,'2008-06-28 09:56:13','2008-06-28 09:56:13'),(21,135248,'image/jpeg','Snow_Polo_3.jpg',317,423,NULL,NULL,1,'2008-06-28 10:19:09','2008-06-28 10:19:09'),(22,38270,'image/jpeg','Snow_Polo_3_mini.jpg',153,205,21,'mini',NULL,'2008-06-28 10:19:09','2008-06-28 10:19:09'),(23,121470,'image/jpeg','Snow_Polo_3_main.jpg',317,423,21,'main',NULL,'2008-06-28 10:19:09','2008-06-28 10:19:09'),(24,4279,'image/jpeg','Snow_Polo_3_thumb.jpg',45,45,21,'thumb',NULL,'2008-06-28 10:19:09','2008-06-28 10:19:09');
/*!40000 ALTER TABLE `article_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles`
--

DROP TABLE IF EXISTS `articles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `articles` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `body` text,
  `posted_at` datetime default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `summary` text,
  `permalink` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'FEM Snow Polo Tournament Postponed','This years Panamericano FEM Snow Polo Tournament which was scheduled to be played at the end of August in Bariloche, Argentina, has been postponed until August 2009. \r\n\r\nAdverse weather has affected Bariloche in recent months due to a volcano erupting in Chile. The popular ski resort has had very little snow so far this year, and as such, organizer Claudia Hodari has had no choice, but to postpone the event until August next year. \r\n\r\nTianblue was appointed as an official partner of the event as was set to produce a range of apparel for the tournament. As well as this, Tianblue was also bringing the first ever Asian Ladies Snow Polo team out to Argentina for the tournament.\r\n\r\nDespite the postponement, Tianblue is still committed to supporting this unique event, and will look to work with Claudia and her team over the next year to ensure the 2009 event is a huge success for all.    \r\n','2008-08-08 00:00:00','2008-05-12 14:22:21','2008-08-17 11:44:05','This years Panamericano FEM Snow Polo Tournament has been postponed until 2009. Tianblue are the official apparel of the tournament.   \r\n\r\n','08-08-08-fem-snow-polo-tournament-postponed');
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cart_items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `price` decimal(8,2) default '0.00',
  `quantity` int(11) default NULL,
  `cart_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `sku` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (12,'Tian (Small)','100.00',1,134,'2008-06-19 12:07:50','2008-06-19 12:07:50','lppog-s'),(17,'Polo Girl (Medium)','100.00',2,151,'2008-06-23 08:30:28','2008-06-23 08:30:28','lppog-m'),(22,'Valentina (Small)','100.00',1,166,'2008-06-24 08:37:37','2008-06-24 08:37:37','lpval-s'),(32,'Chino White (Small)','120.00',1,255,'2008-07-07 11:41:41','2008-07-07 11:41:41','mpkog-s'),(33,'Valentina (Small)','100.00',1,262,'2008-07-07 14:52:41','2008-07-07 14:52:41','lpval-s'),(43,'Chino Black (Small)','120.00',5,319,'2008-07-13 02:05:44','2008-07-13 02:05:44','mpchibl-s'),(46,'Polo Stick (Boys) (26)','85.00',1,344,'2008-07-18 09:35:00','2008-07-18 09:35:00','cppos-26'),(55,'La Vita E Bella (Extra Large)','100.00',3,434,'2008-07-26 10:19:14','2008-07-26 10:19:37','lplvb-xl'),(56,'La Vita E Bella (Large)','100.00',1,434,'2008-07-26 10:19:46','2008-07-26 10:19:46','lplvb-l'),(57,'La Vita E Bella (Small)','100.00',3,434,'2008-07-26 10:19:55','2008-07-26 10:20:09','lplvb-s'),(58,'La Vita E Bella (Medium)','100.00',1,434,'2008-07-26 10:20:04','2008-07-26 10:20:04','lplvb-m'),(64,'Polo Stick (Boys) (26)','85.00',1,455,'2008-07-27 00:31:24','2008-07-27 00:31:24','cppos-26'),(67,'Polo Stick (Boys) (26)','85.00',1,453,'2008-07-27 00:48:49','2008-07-27 00:48:49','cppos-26'),(69,'Valentina (Small)','100.00',1,497,'2008-07-27 05:54:13','2008-07-27 05:54:13','lpval-s'),(71,'Chino Black (Small)','120.00',1,497,'2008-07-27 07:09:20','2008-07-27 07:09:20','mpchibl-s'),(72,'Tian Cap Navy (Standard)','35.00',1,503,'2008-07-27 07:09:54','2008-07-27 07:09:54','cptianv-sd'),(85,'Valentina (Small)','100.00',1,558,'2008-07-28 06:15:15','2008-07-28 06:15:15','lpval-s'),(95,'Valentina (Small)','100.00',1,750,'2008-08-04 02:06:29','2008-08-04 02:06:29','lpval-s'),(97,'Chino White (Small)','120.00',1,868,'2008-08-09 01:55:29','2008-08-09 01:55:31','mpkog-s'),(98,'Chino White (Extra Large)','120.00',1,868,'2008-08-09 01:55:37','2008-08-09 01:55:37','mpkog-xl'),(105,'La Vita E Bella (Small)','100.00',1,984,'2008-08-15 12:38:41','2008-08-15 12:38:42','lplvb-s'),(106,'Polo Stick (Boys) (26)','85.00',1,1001,'2008-08-16 08:07:07','2008-08-16 08:07:07','cppos-26'),(107,'Valentina (Small)','100.00',1,1018,'2008-08-17 09:59:38','2008-08-17 09:59:38','lpval-s');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `carts` (
  `id` int(11) NOT NULL auto_increment,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1027 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (267,'2008-08-18 02:40:21','2008-08-18 02:40:21'),(984,'2008-08-15 12:36:56','2008-08-15 12:36:56'),(985,'2008-08-15 13:41:21','2008-08-15 13:41:21'),(986,'2008-08-15 13:43:47','2008-08-15 13:43:47'),(987,'2008-08-15 13:44:34','2008-08-15 13:44:34'),(988,'2008-08-15 14:40:35','2008-08-15 14:40:35'),(989,'2008-08-15 17:05:29','2008-08-15 17:05:29'),(990,'2008-08-15 18:04:34','2008-08-15 18:04:34'),(991,'2008-08-15 19:17:40','2008-08-15 19:17:40'),(992,'2008-08-15 20:08:38','2008-08-15 20:08:38'),(993,'2008-08-15 22:57:49','2008-08-15 22:57:49'),(994,'2008-08-16 01:31:49','2008-08-16 01:31:49'),(995,'2008-08-16 01:38:08','2008-08-16 01:38:08'),(996,'2008-08-16 01:41:16','2008-08-16 01:41:16'),(997,'2008-08-16 05:43:57','2008-08-16 05:43:57'),(998,'2008-08-16 06:35:39','2008-08-16 06:35:39'),(999,'2008-08-16 06:37:29','2008-08-16 06:37:29'),(1000,'2008-08-16 06:44:02','2008-08-16 06:44:02'),(1001,'2008-08-16 08:06:39','2008-08-16 08:06:39'),(1002,'2008-08-16 09:57:56','2008-08-16 09:57:56'),(1003,'2008-08-16 10:43:16','2008-08-16 10:43:16'),(1004,'2008-08-16 10:55:46','2008-08-16 10:55:46'),(1005,'2008-08-16 11:49:21','2008-08-16 11:49:21'),(1006,'2008-08-16 12:30:27','2008-08-16 12:30:27'),(1007,'2008-08-16 13:13:17','2008-08-16 13:13:17'),(1008,'2008-08-16 13:13:23','2008-08-16 13:13:23'),(1009,'2008-08-16 13:58:11','2008-08-16 13:58:11'),(1010,'2008-08-16 14:00:04','2008-08-16 14:00:04'),(1011,'2008-08-16 14:33:45','2008-08-16 14:33:45'),(1012,'2008-08-16 16:11:46','2008-08-16 16:11:46'),(1013,'2008-08-16 17:10:57','2008-08-16 17:10:57'),(1014,'2008-08-16 18:04:39','2008-08-16 18:04:39'),(1015,'2008-08-16 18:37:06','2008-08-16 18:37:06'),(1016,'2008-08-16 22:06:03','2008-08-16 22:06:03'),(1017,'2008-08-17 08:02:42','2008-08-17 08:02:42'),(1018,'2008-08-17 09:59:18','2008-08-17 09:59:18'),(1019,'2008-08-17 10:09:03','2008-08-17 10:09:03'),(1020,'2008-08-17 10:09:43','2008-08-17 10:09:43'),(1021,'2008-08-17 11:34:27','2008-08-17 11:34:27'),(1022,'2008-08-17 11:41:31','2008-08-17 11:41:31'),(1023,'2008-08-17 18:04:46','2008-08-17 18:04:46'),(1024,'2008-08-18 01:46:52','2008-08-18 01:46:52'),(1025,'2008-08-18 02:08:31','2008-08-18 02:08:31'),(1026,'2008-08-18 09:21:30','2008-08-18 09:21:30');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `title` varchar(255) default NULL,
  `description` text,
  `featured` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'men','2008-05-11 12:42:13','2008-07-06 04:17:08','Men\'s ','',1),(2,'ladies','2008-05-11 12:42:21','2008-07-06 04:17:27','Ladies ','',1),(3,'children','2008-05-11 12:42:27','2008-07-06 04:17:34','Children\'s ','',0),(4,'caps','2008-06-03 05:43:40','2008-06-03 05:43:40','Caps','',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_images`
--

DROP TABLE IF EXISTS `category_images`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `category_images` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `height` int(11) default NULL,
  `width` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `thumbnail` varchar(255) default NULL,
  `category_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `category_images`
--

LOCK TABLES `category_images` WRITE;
/*!40000 ALTER TABLE `category_images` DISABLE KEYS */;
INSERT INTO `category_images` VALUES (17,441658,'image/pjpeg','Use_for_big_pic_cap_page.JPG',1296,969,NULL,NULL,NULL,'2008-06-03 05:44:25','2008-06-04 06:02:56'),(18,19568,'image/pjpeg','Use_for_big_pic_cap_page_mini.JPG',88,205,17,'mini',NULL,'2008-06-03 05:44:25','2008-06-04 06:03:43'),(33,190373,'image/pjpeg','caps_catagories.jpg',520,423,NULL,NULL,NULL,'2008-06-05 10:01:25','2008-06-05 10:05:46'),(41,190373,'image/pjpeg','caps_catagories.jpg',520,423,NULL,NULL,4,'2008-06-05 10:20:26','2008-06-05 10:20:26'),(42,20704,'image/pjpeg','caps_catagories_mini.jpg',88,205,41,'mini',4,'2008-06-05 10:20:26','2008-06-05 10:20:26'),(43,191809,'image/pjpeg','caps_catagories_main.jpg',520,423,41,'main',4,'2008-06-05 10:20:26','2008-06-05 10:20:26'),(44,3667,'image/pjpeg','caps_catagories_thumb.jpg',45,45,41,'thumb',4,'2008-06-05 10:20:26','2008-06-05 10:20:26'),(45,218866,'image/jpeg','Mens_Catagories.jpg',520,423,NULL,NULL,1,'2008-06-23 07:27:16','2008-06-23 07:27:16'),(46,198438,'image/jpeg','Mens_Catagories_main.jpg',520,423,45,'main',1,'2008-06-23 07:27:16','2008-06-23 07:27:16'),(47,55881,'image/jpeg','Mens_Catagories_mini.jpg',250,205,45,'mini',1,'2008-06-23 07:27:16','2008-06-23 07:27:16'),(48,3710,'image/jpeg','Mens_Catagories_thumb.jpg',45,45,45,'thumb',1,'2008-06-23 07:27:16','2008-06-23 07:27:16'),(49,176191,'image/jpeg','Catagory_Pic.jpg',520,423,NULL,NULL,2,'2008-06-23 11:54:09','2008-06-23 11:54:09'),(50,169089,'image/jpeg','Catagory_Pic_main.jpg',520,423,49,'main',2,'2008-06-23 11:54:09','2008-06-23 11:54:09'),(51,48568,'image/jpeg','Catagory_Pic_mini.jpg',250,205,49,'mini',2,'2008-06-23 11:54:10','2008-06-23 11:54:10'),(52,3332,'image/jpeg','Catagory_Pic_thumb.jpg',45,45,49,'thumb',2,'2008-06-23 11:54:10','2008-06-23 11:54:10'),(69,143562,'image/jpeg','Children_Catagory3.jpg',520,423,NULL,NULL,3,'2008-07-06 05:58:53','2008-07-06 05:58:53'),(70,43813,'image/jpeg','Children_Catagory3_mini.jpg',250,205,69,'mini',3,'2008-07-06 05:58:53','2008-07-06 05:58:53'),(71,141904,'image/jpeg','Children_Catagory3_main.jpg',520,423,69,'main',3,'2008-07-06 05:58:53','2008-07-06 05:58:53'),(72,3277,'image/jpeg','Children_Catagory3_thumb.jpg',45,45,69,'thumb',3,'2008-07-06 05:58:53','2008-07-06 05:58:53');
/*!40000 ALTER TABLE `category_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `a2` varchar(255) default NULL,
  `a3` varchar(255) default NULL,
  `numeric` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=434389328 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (6562054,'United Arab Emirates','AE','ARE',784,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6562067,'Argentina','AR','ARG',32,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6562070,'Australia','AU','AUS',36,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6629716,'Brazil','BR','BRA',76,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6697347,'Canada','CA','CAN',124,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6697355,'Switzerland','CH','CHE',756,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6697361,'China','CN','CHN',156,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6765001,'Germany','DE','DEU',276,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6765007,'Denmark','DK','DNK',208,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6832652,'Egypt','EG','EGY',818,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6832664,'Spain','ES','ESP',724,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6900303,'Finland','FI','FIN',246,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6900307,'Micronesia','FM','FSM',583,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6900312,'France','FR','FRA',250,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6967950,'Guernsey','GG','GGY',831,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6967952,'Gibraltar','GI','GIB',292,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6967955,'Greenland','GL','GRL',304,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(6967961,'Greece','GR','GRC',300,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7035603,'Hong Kong','HK','HKG',344,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7035613,'Hungary','HU','HUN',348,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7103244,'Indonesia','ID','IDN',360,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7103245,'Ireland','IE','IRL',372,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7103253,'Israel','IL','ISR',376,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7103255,'India','IN','IND',356,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7103260,'Iceland','IS','ISL',352,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7103261,'Italy','IT','ITA',380,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7170894,'Jersey','JE','JEY',832,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7170906,'Japan','JP','JPN',392,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7238557,'Korea, South','KR','KOR',410,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7238562,'Kuwait','KW','KWT',414,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7306198,'Sri Lanka','LK','LKA',144,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7306209,'Luxembourg','LU','LUX',442,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373839,'Monaco','MC','MCO',492,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373840,'Moldova','MD','MDA',498,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373841,'Montenegro','ME','MNE',499,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373847,'Macedonia','MK','MKD',807,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373852,'Macau','MO','MAC',446,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373857,'Malta','MT','MLT',470,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373859,'Maldives','MV','MDV',462,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373861,'Mexico','MX','MEX',484,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7373862,'Malaysia','MY','MYS',458,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7441497,'Netherlands','NL','NLD',528,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7441512,'New Zealand','NZ','NZL',554,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7509147,'Oman','OM','OMN',512,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7576784,'Panama','PA','PAN',591,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7576791,'Philippines','PH','PHL',608,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7576794,'Pakistan','PK','PAK',586,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7576795,'Poland','PL','POL',616,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7576804,'Portugal','PT','PRT',620,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7644433,'Qatar','QA','QAT',634,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7712096,'Romania','RO','ROU',642,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7712101,'Serbia','RS','SRB',688,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7712103,'Russian Federation','RU','RUS',643,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7779731,'Saudi Arabia','SA','SAU',682,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7779735,'Sweden','SE','SWE',752,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7779737,'Singapore','SG','SGP',702,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7779739,'Slovenia','SI','SVN',705,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7779741,'Slovakia','SK','SVK',703,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7847387,'Thailand','TH','THA',764,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7847393,'Tunisia','TN','TUN',788,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7847403,'Taiwan','TW','TWN',158,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7915029,'Ukraine','UA','UKR',804,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7915039,'United Kingdom','GB','GBR',826,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7915047,'United States of America','US','USA',840,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(7982691,'Vietnam','VN','VNM',704,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(8253274,'South Africa','ZA','ZAF',710,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(8253296,'Zimbabwe','ZW','ZWE',716,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(434389326,'Norway','NO','NOR',578,'2008-06-12 21:03:00','2008-06-12 21:03:00'),(434389327,'Holland','','',0,'2008-07-27 09:53:54','2008-07-27 09:53:54');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line_items`
--

DROP TABLE IF EXISTS `line_items`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `line_items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `price` decimal(8,2) default '0.00',
  `quantity` int(11) default NULL,
  `order_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `sku` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `line_items`
--

LOCK TABLES `line_items` WRITE;
/*!40000 ALTER TABLE `line_items` DISABLE KEYS */;
INSERT INTO `line_items` VALUES (20,'Valentina (Small)','100.00',1,NULL,'2008-07-01 04:28:12','2008-07-01 04:28:12','lpval-s'),(33,'La Vita E Bella (Small)','100.00',1,NULL,'2008-08-14 13:59:58','2008-08-14 13:59:58','lplvb-s');
/*!40000 ALTER TABLE `line_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `address` text,
  `postcode` varchar(255) default NULL,
  `transaction_reference` varchar(255) default NULL,
  `status` varchar(255) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `user_id` int(11) default NULL,
  `country_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_images`
--

DROP TABLE IF EXISTS `page_images`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `page_images` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `height` int(11) default NULL,
  `width` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `thumbnail` varchar(255) default NULL,
  `page_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `page_images`
--

LOCK TABLES `page_images` WRITE;
/*!40000 ALTER TABLE `page_images` DISABLE KEYS */;
INSERT INTO `page_images` VALUES (34,291237,'image/jpeg','Home_Test_1.jpg',365,859,NULL,NULL,NULL,'2008-07-02 11:30:41','2008-07-02 11:32:28'),(38,53487,'image/jpeg','Home_Test_1_mini.jpg',250,205,34,'mini',NULL,'2008-07-02 11:30:41','2008-07-02 11:33:04'),(39,273699,'image/jpeg','Home_Test_1.jpg',365,859,NULL,NULL,4,'2008-07-02 11:32:28','2008-07-02 11:32:28'),(40,297479,'image/jpeg','Home_Test_1_home.jpg',365,859,39,'home',4,'2008-07-02 11:32:28','2008-07-02 11:32:28'),(41,174422,'image/jpeg','Home_Test_1_main.jpg',520,423,39,'main',4,'2008-07-02 11:32:28','2008-07-02 11:32:28'),(42,3546,'image/jpeg','Home_Test_1_thumb.jpg',45,45,39,'thumb',4,'2008-07-02 11:32:28','2008-07-02 11:32:28'),(43,56460,'image/jpeg','Home_Test_1_mini.jpg',250,205,39,'mini',4,'2008-07-02 11:32:28','2008-07-02 11:32:28'),(44,273699,'image/jpeg','Home_Test_1.jpg',365,859,NULL,NULL,4,'2008-07-02 11:33:04','2008-07-02 11:33:04'),(45,297479,'image/jpeg','Home_Test_1_home.jpg',365,859,44,'home',4,'2008-07-02 11:33:04','2008-07-02 11:33:04'),(46,174422,'image/jpeg','Home_Test_1_main.jpg',520,423,44,'main',4,'2008-07-02 11:33:04','2008-07-02 11:33:04'),(47,3546,'image/jpeg','Home_Test_1_thumb.jpg',45,45,44,'thumb',4,'2008-07-02 11:33:04','2008-07-02 11:33:04'),(48,56460,'image/jpeg','Home_Test_1_mini.jpg',250,205,44,'mini',4,'2008-07-02 11:33:04','2008-07-02 11:33:04'),(74,204325,'image/jpeg','Terms_and_Conditions.jpg',520,423,NULL,NULL,NULL,'2008-07-06 06:39:03','2008-07-08 14:07:54'),(76,209520,'image/jpeg','Terms_and_Conditions_home.jpg',365,859,74,'home',NULL,'2008-07-06 06:39:03','2008-07-08 14:08:29'),(79,220073,'image/jpeg','Shopping.jpg',520,423,NULL,NULL,5,'2008-07-06 06:47:07','2008-07-06 06:47:07'),(80,49863,'image/jpeg','Shopping_mini.jpg',250,205,79,'mini',5,'2008-07-06 06:47:07','2008-07-06 06:47:07'),(81,185192,'image/jpeg','Shopping_home.jpg',365,859,79,'home',5,'2008-07-06 06:47:07','2008-07-06 06:47:07'),(82,180407,'image/jpeg','Shopping_main.jpg',520,423,79,'main',5,'2008-07-06 06:47:07','2008-07-06 06:47:07'),(83,3734,'image/jpeg','Shopping_thumb.jpg',45,45,79,'thumb',5,'2008-07-06 06:47:07','2008-07-06 06:47:07'),(94,57337,'image/jpeg','Privacy..jpg',520,423,NULL,NULL,3,'2008-07-07 13:48:32','2008-07-07 13:48:32'),(95,3244,'image/jpeg','Privacy._thumb.jpg',45,45,94,'thumb',3,'2008-07-07 13:48:32','2008-07-07 13:48:32'),(96,46704,'image/jpeg','Privacy._mini.jpg',250,205,94,'mini',3,'2008-07-07 13:48:32','2008-07-07 13:48:32'),(97,148578,'image/jpeg','Privacy._home.jpg',365,859,94,'home',3,'2008-07-07 13:48:32','2008-07-07 13:48:32'),(98,129020,'image/jpeg','Privacy._main.jpg',520,423,94,'main',3,'2008-07-07 13:48:32','2008-07-07 13:48:32'),(99,62459,'image/jpeg','Terms_and_Conditions.jpg',520,423,NULL,NULL,2,'2008-07-08 14:07:53','2008-07-08 14:07:53'),(100,3509,'image/jpeg','Terms_and_Conditions_thumb.jpg',45,45,99,'thumb',2,'2008-07-08 14:07:54','2008-07-08 14:07:54'),(101,141476,'image/jpeg','Terms_and_Conditions_home.jpg',365,859,99,'home',2,'2008-07-08 14:07:54','2008-07-08 14:07:54'),(102,50350,'image/jpeg','Terms_and_Conditions_mini.jpg',250,205,99,'mini',2,'2008-07-08 14:07:54','2008-07-08 14:07:54'),(103,136154,'image/jpeg','Terms_and_Conditions_main.jpg',520,423,99,'main',2,'2008-07-08 14:07:54','2008-07-08 14:07:54'),(104,62459,'image/jpeg','Terms_and_Conditions.jpg',520,423,NULL,NULL,2,'2008-07-08 14:08:29','2008-07-08 14:08:29'),(105,3509,'image/jpeg','Terms_and_Conditions_thumb.jpg',45,45,104,'thumb',2,'2008-07-08 14:08:29','2008-07-08 14:08:29'),(106,141476,'image/jpeg','Terms_and_Conditions_home.jpg',365,859,104,'home',2,'2008-07-08 14:08:29','2008-07-08 14:08:29'),(107,50350,'image/jpeg','Terms_and_Conditions_mini.jpg',250,205,104,'mini',2,'2008-07-08 14:08:29','2008-07-08 14:08:29'),(108,136154,'image/jpeg','Terms_and_Conditions_main.jpg',520,423,104,'main',2,'2008-07-08 14:08:29','2008-07-08 14:08:29'),(119,248556,'image/jpeg','Mariposa1.jpg',520,423,NULL,NULL,8,'2008-07-13 03:04:37','2008-07-13 03:04:37'),(120,4020,'image/jpeg','Mariposa1_thumb.jpg',45,45,119,'thumb',8,'2008-07-13 03:04:38','2008-07-13 03:04:38'),(121,209595,'image/jpeg','Mariposa1_home.jpg',365,859,119,'home',8,'2008-07-13 03:04:38','2008-07-13 03:04:38'),(122,225778,'image/jpeg','Mariposa1_main.jpg',520,423,119,'main',8,'2008-07-13 03:04:38','2008-07-13 03:04:38'),(123,65296,'image/jpeg','Mariposa1_mini.jpg',250,205,119,'mini',8,'2008-07-13 03:04:38','2008-07-13 03:04:38'),(124,115500,'image/jpeg','Returns_and_Refunds.jpg',520,423,NULL,NULL,6,'2008-07-13 09:42:19','2008-07-13 09:42:19'),(125,3060,'image/jpeg','Returns_and_Refunds_thumb.jpg',45,45,124,'thumb',6,'2008-07-13 09:42:19','2008-07-13 09:42:19'),(126,131211,'image/jpeg','Returns_and_Refunds_home.jpg',365,859,124,'home',6,'2008-07-13 09:42:19','2008-07-13 09:42:19'),(127,134813,'image/jpeg','Returns_and_Refunds_main.jpg',520,423,124,'main',6,'2008-07-13 09:42:19','2008-07-13 09:42:19'),(128,41182,'image/jpeg','Returns_and_Refunds_mini.jpg',250,205,124,'mini',6,'2008-07-13 09:42:19','2008-07-13 09:42:19'),(149,187922,'image/jpeg','La_Vita_E_Bella.jpg',520,423,NULL,NULL,1,'2008-07-28 13:38:58','2008-07-28 13:38:58'),(150,3615,'image/jpeg','La_Vita_E_Bella_thumb.jpg',45,45,149,'thumb',1,'2008-07-28 13:38:58','2008-07-28 13:38:58'),(151,166911,'image/jpeg','La_Vita_E_Bella_home.jpg',365,859,149,'home',1,'2008-07-28 13:38:58','2008-07-28 13:38:58'),(152,51647,'image/jpeg','La_Vita_E_Bella_mini.jpg',250,205,149,'mini',1,'2008-07-28 13:38:58','2008-07-28 13:38:58'),(153,186531,'image/jpeg','La_Vita_E_Bella_main.jpg',520,423,149,'main',1,'2008-07-28 13:38:58','2008-07-28 13:38:58');
/*!40000 ALTER TABLE `page_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL auto_increment,
  `permalink` varchar(255) default NULL,
  `body` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'about-us','Tianblue was founded in Singapore in 2004 as a producer of high quality, stylish and well fitting ladies polo shirts.  \r\n\r\nThe polo shirts were a huge success and soon were in great demand not only by those people playing polo, but also for leisure & fashion wear. They are a great fit and shape and look fantastic on everyone. \r\n\r\nTianblue is totally committed to promoting the sport of polo, not only through it’s polo shirts but also by sponsoring and supporting  tournaments and all aspects of the game.\r\n\r\nOur name is made up from the Chinese Character  Tian\r\n {  Heaven / Sky  }    \r\n\r\np=. Tianblue 蓝天\r\n             \r\n \"Info@tianblue.com\":mailto:info@tianblue.com\r\n                 \r\nCheck out Tianblue on \"*Myspace*\":http://profile.myspace.com/index.cfm?fuseaction=user.viewprofile&friendid=379514846 and \"*Facebook*\":http://www.facebook.com/group.php?gid=15495552166\r\n\r\n\r\n\r\n                        \r\n\r\n\r\n   \r\n\r\n','2008-06-12 15:58:28','2008-08-11 16:45:44','About Us'),(2,'terms-and-conditions','Please carefully read the following Terms of Use before using the tianblue.com Web site (the \"Site\"). By accessing this Site, you agree to be bound by these Terms and Conditions. These Terms and Conditions may be updated from time to time. Accordingly, you should check the date of the Terms and Conditions (which appear at the end of this document) and review any changes since the last version. If at any time you do not agree to these Terms and Conditions, please do not use this Site. \r\n\r\nh2. Prices and Quantity Limits \r\n\r\nWe reserve the right at any time after receipt of your order to accept or decline your order, or any portion thereof, even after your receipt of an order confirmation. We reserve the right, at our sole discretion, to limit the quantity of items purchased and/or to prohibit sales to dealers. In the event that a product is listed at an incorrect price, we shall have the right to refuse or cancel orders placed for the product listed at the incorrect price, regardless of whether the order has been confirmed and/or your credit card charged. If your credit card has already been charged for the purchase and your order is canceled, we will promptly issue a credit to your credit card account in the amount of the incorrect price. \r\n\r\nh2. Copyright \r\n\r\nAll content included in the Site, such as text, graphics, logos, button icons, images, audio clips and software, is the property of Tianblue.com or its content suppliers and protected by international copyright laws. The compilation (meaning the collection, arrangement and assembly) of all content on the Site is the exclusive property of Tianblue.com and protected by international copyright laws. All software used on the Site is the property of Tianblue.com or its software suppliers and protected by international copyright laws. Permission is granted to electronically copy and print hard copy portions of the Site for the sole purpose of placing an order on the Site or using the Site as a shopping resource. Any other use, including the reproduction, modification, distribution, transmission, republication, display or performance, of the content of the Site is strictly prohibited. \r\n\r\nh2. Trademarks \r\n\r\nAll trademarks, logos, service marks and trade names are proprietary to Tianblue.com, Tianblue PTE LTD or other respective owners that have granted the Site the right and license to use such intellectual property. \r\n\r\nh2. Registration, Accounts and Passwords \r\n\r\nIf you register and create an account on the Site you agree to be responsible for: (i) maintaining the confidentiality of passwords or other account identifiers which you choose, and (ii) all activities that occur under such password or account identifiers. \r\nYou agree to notify Tianblue.com of: (i) any loss of your password or other account identifiers and (ii) any unauthorized use of your password or other account identifiers. Tianblue.com shall not be responsible or liable, directly or indirectly, in any way for any loss or damage of any kind incurred as a result of, or in connection with, your failure to comply with this section of the Terms and Conditions.  \r\n\r\nh2. Disclaimer \r\n\r\nThe information, services, products offered for sale and materials contained in and/or advertised on the Site, including, without limitation, text, graphics and links, are provided on an \"As Is\" basis with no warranty. TO THE MAXIMUM EXTENT PERMITTED BY LAW, Tianblue.com AND ITS SUPPLIERS DISCLAIM ALL REPRESENTATIONS AND WARRANTIES, EXPRESS OR IMPLIED, WITH RESPECT TO SUCH INFORMATION, SERVICES, PRODUCTS AND MATERIALS, INCLUDING, BUT NOT LIMITED TO, WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, TITLE, NON-INFRINGEMENT, FREEDOM FROM COMPUTER VIRUS AND IMPLIED WARRANTIES ARISING FROM COURSE OF DEALING OR COURSE OF PERFORMANCE. In addition, Tianblue.com and its suppliers do not represent or warrant that the information accessible via the Site is accurate, complete or current. We are not responsible for typographical errors. Price and availability information is subject to change without notice. \r\n\r\nh2. Product Information \r\n\r\nThe prices displayed on the Site are quoted in U.S. dollars. The particular technical specifications and settings of your computer and its display could effect the accuracy of its display of the colors of products offered on the Site. \r\n\r\nh2. Links to Other Web sites and \r\nServices \r\n\r\nThis Site may contain links to Web sites other than our own. Tianblue.com does not assume any responsibility for those sites and provides those links solely for the convenience of our visitors. Tianblue.com does not control the content of these sites and takes no responsibility for their content, nor should it be implied that Tianblue.com endorses or otherwise recommends such sites or the products or services offered. \r\n\r\nh2. Limitation on Liability \r\n\r\nIN NO EVENT SHALL Tianblue.com OR ANY OF ITS AFFILIATED ENTITIES OR SUPPLIERS BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES, EVEN IF Tianblue.com HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, WHETHER IN AN ACTION, UNDER CONTRACT, NEGLIGENCE OR ANY OTHER THEORY, ARISING OUT OF OR IN CONNECTION WITH THE USE, INABILITY TO USE OR PERFORMANCE OF THE INFORMATION, SERVICES, PRODUCTS AND MATERIALS AVAILABLE FROM THE SITE. These limitations shall apply notwithstanding any failure of essential purpose or the existence of any limited remedy. Because some jurisdictions do not allow limitations on how long an implied warranty lasts, or the exclusion or limitation of liability for consequential or incidental damages, the above limitations may not apply to you. \r\n\r\n(24/06/08)\r\n','2008-06-23 10:35:54','2008-06-24 09:28:36','Terms and Conditions'),(3,'privacy-policy','Personally identifiable information you provide Tianblue.com when you sign up will not be sold or given to outside sources without your permission. Tianblue.com uses the information we collect in order to provide you with a personalized account making transactions easier.\r\n\r\nh2. Sign-up Information\r\n\r\nIn order to make a purchase on Tianblue.com, you must register certain information with us. The member registration process requires that you provide your full name, street address, email address, and other identifying information. \r\n\r\nh2. Our use of Cookies\r\n\r\nTianblue.com uses cookies to provide you access to protected pages without requesting a login each time. Cookies are small files that are placed on your computer when you visit our site. Our web site will reference and update the cookie each time you visit Tianblue.com. We use cookies to deliver content specific to you, for pages such as product purchase pages. We accomplish this by storing encrypted information that uniquely identifies you in a cookie.\r\n\r\nh2. Security \r\n\r\nThis site has security measures in place to protect the loss, misuse, and alteration of the information under our control. All member data and activity is stored separately and is not directly accessible through a web browser. We use industry standard procedures and processes to safeguard the confidentiality of your identifiable personal information. Remember that your account is accessible only through the use of your Password.\r\n\r\nh2. No Guarantees\r\n\r\nWhile this Privacy Policy states our standards for maintenance of Data and we will make efforts to meet them, we are not in a position to guarantee these standards. There may be factors beyond our control that may result in disclosure of data. As a consequence, we disclaim any warranties or representations relating to maintenance or nondisclosure of Data.\r\n\r\nh2. Who will have access to my personal information?\r\n\r\nOur priority is to keep your personal information private and confidential. Tianblue.com will not willfully disclose, rent, or sell your personal information to third parties. \r\n\r\nTianblue.com may choose to disclose your personally identifiable information to others under the following circumstances:\r\n\r\n- You consent to share your information.\r\n- In response to a criminal investigation, subpoena, court order or legal process.\r\n- Your actions on Tianblue.com appear to be in violation of our policies.\r\n\r\nNothing in this policy shall limit, prohibit, or otherwise deny the ability of Tianblue.com to (1) transfer, assign, or sell our assets to a third party without limitation, or (2) dispose of our assets in any manner, through bankruptcy or similar proceeding. In addition, Tianblue.com makes no warranties or claims regarding the accuracy or completeness of the information we disclose through our site, and disclaims any liability regarding its use.\r\n','2008-06-23 10:36:13','2008-07-07 07:36:56','Privacy Policy'),(4,'home','h1. Where Polo & Fashion Meet','2008-06-23 10:39:58','2008-07-04 05:37:17','Home'),(5,'shopping-guide','h2. How to add a product to your basket\r\n\r\nOnce you have selected a product that you would like to purchase, type the quantity ypu wish to purchase into the quantity section and then select a size from the scroll down bar. Once selected, hit ‘Add to Basket’ and the item will be added to your online shopping basket. If you wish to purchase different sizes of the same product, simply go back to the product page, type in your quantity, select a size and hit ‘Add to Basket’ once more. \r\n\r\nh2. How the basket works\r\n\r\nItems will be placed in your basket when you have selected ‘Add to Basket’ on a product page. Your basket then holds the specified products until you decide to checkout or change the products within your basket. To view the items in your basket, simply click the ‘Checkout’ link in the top right hand corner of your screen. Once on this page, you are able to navigate back to the various product pages without losing what’s in your basket. Simply click ‘Empty Basket’ on the checkout page to remove the items currently in your basket and start again.   \r\n\r\nh2. How to check out\r\n\r\nWhen you have completed shopping, head to the Checkout Page by clicking the link in the top right hand corner. Then simply hit checkout, to start the purchasing process. The first section you will come to is a page asking for your shipping information. We apologize in advance if we do not ship to your country. If this is the case, please feel free to send us an email at \"info@tianblue.com\":mailto:info@tianblue.com as we may be able to make special arrangements depending on your order.   \r\n\r\nh2. How your login information works\r\n\r\nOnce logged in, you are able to view the past orders you have made. To login, please follow the link to the login page on the top right of the screen. If you do not have an account, simply click on Sign Up and enter the required information. A confirmation email will be sent to you. \r\n\r\nh2. Forgotten Passwords \r\n\r\nIf you have forgotten your password, simply slick on the ‘I Forgot My Password’ Button on the login page. Then enter you email address and an email will be sent to you with a link to a page where you may reset your password.  \r\n\r\nh2. How to check previous orders\r\n\r\nOnce logged in, you can check the status of your previous orders by clicking the ‘Previous Order’s’ link in the top right hand corner. Once there, all of your orders will be listed chronologically and the value and order status will be displayed. By clicking on the date of an order, you will be able to view that order. You will have one of four order status’s:\r\n\r\n_Pending_: This is an order that has gone through, but payment confirmation has not yet been received by Tianblue. \r\n\r\n_Paid_: This is an order that has gone through and confirmation of payment has been received. It is due to be shipped within the next 3 days.\r\n\r\n_Shipped_: This order has been shipped. Once the order has been shipped, you will receive a confirmation email with a DHL tracking number. You can then track your order on the \"DHL wbsite.\":http://www.dhl.com\r\n\r\n_Canceled_: This is an order which has been canceled. If you wish to cancel an order before it has been shipped, please send an email to \"info@tianblue.com\":mailto:info@tianblue.com confirming cancelation. If you wish to return an item once it has been shipped, please refer to our \"Returns and Refunds Policy.\":http://www.tianblue.com/returns-refunds   \r\n\r\nh2. Shipping\r\n\r\nFor a limited time, all shipping is free of charge. Items will be shipped by DHL. Please visit “www.dhl.com”:http://www.dhl.com for more information. Once shipped, you will receive a confirmation email with your DHL tracking number included. \r\n\r\nh2. How long it will take\r\n\r\nOnce you have made an order, please allow up two weeks for delivery. Please contact us at \"info@tianblue.com\":mailto:info@tianblue.com if you do not receive your order. Please also contact us at \"info@tianblue.com\":mailto:info@tianblue.com if you do not receive shipping confirmation within 7 days of your purchase. \r\n\r\n\r\n\r\n\r\n\r\n\r\n','2008-06-24 01:50:10','2008-07-16 02:31:03','Shopping Guide'),(6,'returns-refunds','If you are unhappy with your purchase or have selected the wrong size, please return items within 2 weeks of delivery to us, and we will replace the goods. Please include original receipt.\r\n\r\nIf you wish to return your purchase and not replace it, refunds will be given if the product is returned within 2 weeks of delivery with the original printed invoice. \r\n\r\nIf you wish to return or exchange an item, please email us at:\r\n\r\n\"info@tianblue.com\":mailto:info@tianblue.com\r\n\r\nItems returned without a receipt or more than 2 weeks after delivery will not be eligible for exchange or refund.\r\n\r\nTianblue will bear the cost of shipping when sending a replacement product to the consumer, but will not bear the cost of shipping for those products that are returned. \r\n\r\n\r\n','2008-07-03 03:44:23','2008-07-15 01:16:43','Returns & Refunds'),(7,'stockists','These are the dudes who carry our shit:\r\n\r\nshop\r\nshop\r\nshop\r\n','2008-07-09 11:35:29','2008-07-09 11:36:42','Stockists'),(8,'sizing-guide','h2. Polo Shirt Sizing\r\n\r\nh2. Cap Sizing\r\n\r\nTianblue caps have adjustable sizing, meaning that one size fits all. ','2008-07-13 02:23:53','2008-07-13 03:05:38','Sizing Guide');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `product_images` (
  `id` int(11) NOT NULL auto_increment,
  `size` int(11) default NULL,
  `content_type` varchar(255) default NULL,
  `filename` varchar(255) default NULL,
  `height` int(11) default NULL,
  `width` int(11) default NULL,
  `parent_id` int(11) default NULL,
  `thumbnail` varchar(255) default NULL,
  `product_id` int(11) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=373 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (213,153240,'image/jpeg','Chino_White_1.jpg',520,423,NULL,NULL,5,'2008-06-23 07:46:17','2008-06-23 07:46:17'),(214,46650,'image/jpeg','Chino_White_1_mini.jpg',250,205,213,'mini',NULL,'2008-06-23 07:46:17','2008-06-23 07:46:17'),(215,151509,'image/jpeg','Chino_White_1_main.jpg',520,423,213,'main',NULL,'2008-06-23 07:46:17','2008-06-23 07:46:17'),(216,3526,'image/jpeg','Chino_White_1_thumb.jpg',45,45,213,'thumb',NULL,'2008-06-23 07:46:17','2008-06-23 07:46:17'),(225,181850,'image/jpeg','Mens_Catagories.jpg',520,423,NULL,NULL,5,'2008-06-23 07:50:18','2008-06-23 07:50:18'),(226,56367,'image/jpeg','Mens_Catagories_mini.jpg',250,205,225,'mini',NULL,'2008-06-23 07:50:18','2008-06-23 07:50:18'),(227,197220,'image/jpeg','Mens_Catagories_main.jpg',520,423,225,'main',NULL,'2008-06-23 07:50:18','2008-06-23 07:50:18'),(228,3720,'image/jpeg','Mens_Catagories_thumb.jpg',45,45,225,'thumb',NULL,'2008-06-23 07:50:18','2008-06-23 07:50:18'),(257,178649,'image/jpeg','Navy1.jpg',520,423,NULL,NULL,8,'2008-06-23 08:28:47','2008-06-23 08:28:47'),(258,55204,'image/jpeg','Navy1_mini.jpg',250,205,257,'mini',NULL,'2008-06-23 08:28:47','2008-06-23 08:28:47'),(259,195527,'image/jpeg','Navy1_main.jpg',520,423,257,'main',NULL,'2008-06-23 08:28:47','2008-06-23 08:28:47'),(260,3915,'image/jpeg','Navy1_thumb.jpg',45,45,257,'thumb',NULL,'2008-06-23 08:28:47','2008-06-23 08:28:47'),(265,169424,'image/jpeg','la_vita_e_bella_2.jpg',520,423,NULL,NULL,6,'2008-06-23 11:56:43','2008-06-23 11:56:43'),(266,187922,'image/jpeg','la_vita_e_bella_2_main.jpg',520,423,265,'main',NULL,'2008-06-23 11:56:43','2008-06-23 11:56:43'),(267,52166,'image/jpeg','la_vita_e_bella_2_mini.jpg',250,205,265,'mini',NULL,'2008-06-23 11:56:43','2008-06-23 11:56:43'),(268,3619,'image/jpeg','la_vita_e_bella_2_thumb.jpg',45,45,265,'thumb',NULL,'2008-06-23 11:56:43','2008-06-23 11:56:43'),(273,138226,'image/jpeg','Valentina1.jpg',520,423,NULL,NULL,1,'2008-06-23 12:05:16','2008-06-23 12:05:16'),(274,155178,'image/jpeg','Valentina1_main.jpg',520,423,273,'main',NULL,'2008-06-23 12:05:16','2008-06-23 12:05:16'),(275,47656,'image/jpeg','Valentina1_mini.jpg',250,205,273,'mini',NULL,'2008-06-23 12:05:17','2008-06-23 12:05:17'),(276,3513,'image/jpeg','Valentina1_thumb.jpg',45,45,273,'thumb',NULL,'2008-06-23 12:05:17','2008-06-23 12:05:17'),(277,140914,'image/jpeg','Valentina2.jpg',520,423,NULL,NULL,1,'2008-06-23 12:05:28','2008-06-23 12:05:28'),(278,158272,'image/jpeg','Valentina2_main.jpg',520,423,277,'main',NULL,'2008-06-23 12:05:28','2008-06-23 12:05:28'),(279,48952,'image/jpeg','Valentina2_mini.jpg',250,205,277,'mini',NULL,'2008-06-23 12:05:28','2008-06-23 12:05:28'),(280,3737,'image/jpeg','Valentina2_thumb.jpg',45,45,277,'thumb',NULL,'2008-06-23 12:05:28','2008-06-23 12:05:28'),(281,167625,'image/jpeg','Valentina23.jpg',520,423,NULL,NULL,1,'2008-06-23 12:05:44','2008-06-23 12:05:44'),(282,186483,'image/jpeg','Valentina23_main.jpg',520,423,281,'main',NULL,'2008-06-23 12:05:44','2008-06-23 12:05:44'),(283,48317,'image/jpeg','Valentina23_mini.jpg',250,205,281,'mini',NULL,'2008-06-23 12:05:44','2008-06-23 12:05:44'),(284,3626,'image/jpeg','Valentina23_thumb.jpg',45,45,281,'thumb',NULL,'2008-06-23 12:05:44','2008-06-23 12:05:44'),(285,184911,'image/jpeg','Polo_Girl_1.jpg',520,423,NULL,NULL,2,'2008-06-23 12:06:57','2008-06-23 12:06:57'),(286,178984,'image/jpeg','Polo_Girl_1_main.jpg',520,423,285,'main',NULL,'2008-06-23 12:06:57','2008-06-23 12:06:57'),(287,53581,'image/jpeg','Polo_Girl_1_mini.jpg',250,205,285,'mini',NULL,'2008-06-23 12:06:57','2008-06-23 12:06:57'),(288,3850,'image/jpeg','Polo_Girl_1_thumb.jpg',45,45,285,'thumb',NULL,'2008-06-23 12:06:57','2008-06-23 12:06:57'),(289,121959,'image/jpeg','Polo_Girl_2.jpg',520,423,NULL,NULL,2,'2008-06-23 12:07:08','2008-06-23 12:07:08'),(290,129043,'image/jpeg','Polo_Girl_2_main.jpg',520,423,289,'main',NULL,'2008-06-23 12:07:08','2008-06-23 12:07:08'),(291,42898,'image/jpeg','Polo_Girl_2_mini.jpg',250,205,289,'mini',NULL,'2008-06-23 12:07:08','2008-06-23 12:07:08'),(292,3414,'image/jpeg','Polo_Girl_2_thumb.jpg',45,45,289,'thumb',NULL,'2008-06-23 12:07:08','2008-06-23 12:07:08'),(293,156077,'image/jpeg','Polo_Girl_3.jpg',520,423,NULL,NULL,2,'2008-06-23 12:07:20','2008-06-23 12:07:20'),(294,158661,'image/jpeg','Polo_Girl_3_main.jpg',520,423,293,'main',NULL,'2008-06-23 12:07:21','2008-06-23 12:07:21'),(295,49551,'image/jpeg','Polo_Girl_3_mini.jpg',250,205,293,'mini',NULL,'2008-06-23 12:07:21','2008-06-23 12:07:21'),(296,3762,'image/jpeg','Polo_Girl_3_thumb.jpg',45,45,293,'thumb',NULL,'2008-06-23 12:07:21','2008-06-23 12:07:21'),(317,160213,'image/jpeg','la_vita_e_bella_1.jpg',520,423,NULL,NULL,6,'2008-06-24 02:05:28','2008-06-24 02:05:28'),(318,166316,'image/jpeg','la_vita_e_bella_1_main.jpg',520,423,317,'main',NULL,'2008-06-24 02:05:28','2008-06-24 02:05:28'),(319,48815,'image/jpeg','la_vita_e_bella_1_mini.jpg',250,205,317,'mini',NULL,'2008-06-24 02:05:28','2008-06-24 02:05:28'),(320,3596,'image/jpeg','la_vita_e_bella_1_thumb.jpg',45,45,317,'thumb',NULL,'2008-06-24 02:05:28','2008-06-24 02:05:28'),(321,146329,'image/jpeg','Children_Catagory_2.jpg',520,423,NULL,NULL,4,'2008-07-06 05:53:48','2008-07-06 05:53:48'),(322,163293,'image/jpeg','Children_Catagory_2_main.jpg',520,423,321,'main',NULL,'2008-07-06 05:53:49','2008-07-06 05:53:49'),(323,49633,'image/jpeg','Children_Catagory_2_mini.jpg',250,205,321,'mini',NULL,'2008-07-06 05:53:49','2008-07-06 05:53:49'),(324,3712,'image/jpeg','Children_Catagory_2_thumb.jpg',45,45,321,'thumb',NULL,'2008-07-06 05:53:49','2008-07-06 05:53:49'),(333,163863,'image/jpeg','Mariposa2.jpg',520,423,NULL,NULL,9,'2008-07-06 06:21:16','2008-07-06 06:21:16'),(334,160572,'image/jpeg','Mariposa2_main.jpg',520,423,333,'main',NULL,'2008-07-06 06:21:16','2008-07-06 06:21:16'),(335,3552,'image/jpeg','Mariposa2_thumb.jpg',45,45,333,'thumb',NULL,'2008-07-06 06:21:16','2008-07-06 06:21:16'),(336,50148,'image/jpeg','Mariposa2_mini.jpg',250,205,333,'mini',NULL,'2008-07-06 06:21:16','2008-07-06 06:21:16'),(337,148090,'image/jpeg','Mariposa3.jpg',520,423,NULL,NULL,9,'2008-07-06 06:21:34','2008-07-06 06:21:34'),(338,146531,'image/jpeg','Mariposa3_main.jpg',520,423,337,'main',NULL,'2008-07-06 06:21:34','2008-07-06 06:21:34'),(339,3723,'image/jpeg','Mariposa3_thumb.jpg',45,45,337,'thumb',NULL,'2008-07-06 06:21:34','2008-07-06 06:21:34'),(340,47459,'image/jpeg','Mariposa3_mini.jpg',250,205,337,'mini',NULL,'2008-07-06 06:21:34','2008-07-06 06:21:34'),(341,165164,'image/jpeg','Mariposa4.jpg',520,423,NULL,NULL,9,'2008-07-06 06:21:47','2008-07-06 06:21:47'),(342,162528,'image/jpeg','Mariposa4_main.jpg',520,423,341,'main',NULL,'2008-07-06 06:21:47','2008-07-06 06:21:47'),(343,3581,'image/jpeg','Mariposa4_thumb.jpg',45,45,341,'thumb',NULL,'2008-07-06 06:21:48','2008-07-06 06:21:48'),(344,49831,'image/jpeg','Mariposa4_mini.jpg',250,205,341,'mini',NULL,'2008-07-06 06:21:48','2008-07-06 06:21:48'),(345,41543,'image/jpeg','tiancapwhite1.jpg',520,423,NULL,NULL,10,'2008-07-07 13:59:38','2008-07-07 13:59:38'),(346,3373,'image/jpeg','tiancapwhite1_thumb.jpg',45,45,345,'thumb',NULL,'2008-07-07 13:59:38','2008-07-07 13:59:38'),(347,37887,'image/jpeg','tiancapwhite1_mini.jpg',250,205,345,'mini',NULL,'2008-07-07 13:59:38','2008-07-07 13:59:38'),(348,97420,'image/jpeg','tiancapwhite1_main.jpg',520,423,345,'main',NULL,'2008-07-07 13:59:38','2008-07-07 13:59:38'),(349,27564,'image/jpeg','tiancapwhite2.jpg',520,423,NULL,NULL,10,'2008-07-07 14:09:50','2008-07-07 14:09:50'),(350,3192,'image/jpeg','tiancapwhite2_thumb.jpg',45,45,349,'thumb',NULL,'2008-07-07 14:09:50','2008-07-07 14:09:50'),(351,28971,'image/jpeg','tiancapwhite2_mini.jpg',250,205,349,'mini',NULL,'2008-07-07 14:09:50','2008-07-07 14:09:50'),(352,67276,'image/jpeg','tiancapwhite2_main.jpg',520,423,349,'main',NULL,'2008-07-07 14:09:50','2008-07-07 14:09:50'),(353,40944,'image/jpeg','tiancapnavy2.jpg',520,423,NULL,NULL,8,'2008-07-07 14:19:55','2008-07-07 14:19:55'),(354,3282,'image/jpeg','tiancapnavy2_thumb.jpg',45,45,353,'thumb',NULL,'2008-07-07 14:19:56','2008-07-07 14:19:56'),(355,98961,'image/jpeg','tiancapnavy2_main.jpg',520,423,353,'main',NULL,'2008-07-07 14:19:56','2008-07-07 14:19:56'),(356,39134,'image/jpeg','tiancapnavy2_mini.jpg',250,205,353,'mini',NULL,'2008-07-07 14:19:56','2008-07-07 14:19:56'),(357,135244,'image/jpeg','Children_s_Black_1.jpg',520,423,NULL,NULL,3,'2008-07-16 02:23:49','2008-07-16 02:23:49'),(358,44166,'image/jpeg','Children_s_Black_1_mini.jpg',250,205,357,'mini',NULL,'2008-07-16 02:23:49','2008-07-16 02:23:49'),(359,3674,'image/jpeg','Children_s_Black_1_thumb.jpg',45,45,357,'thumb',NULL,'2008-07-16 02:23:50','2008-07-16 02:23:50'),(360,137662,'image/jpeg','Children_s_Black_1_main.jpg',520,423,357,'main',NULL,'2008-07-16 02:23:50','2008-07-16 02:23:50'),(361,119322,'image/jpeg','Children_s_Black_2.jpg',520,423,NULL,NULL,3,'2008-07-16 02:24:34','2008-07-16 02:24:34'),(362,40185,'image/jpeg','Children_s_Black_2_mini.jpg',250,205,361,'mini',NULL,'2008-07-16 02:24:35','2008-07-16 02:24:35'),(363,3292,'image/jpeg','Children_s_Black_2_thumb.jpg',45,45,361,'thumb',NULL,'2008-07-16 02:24:35','2008-07-16 02:24:35'),(364,127453,'image/jpeg','Children_s_Black_2_main.jpg',520,423,361,'main',NULL,'2008-07-16 02:24:35','2008-07-16 02:24:35'),(365,137965,'image/jpeg','Children_s_White_1.jpg',520,423,NULL,NULL,4,'2008-07-16 02:28:00','2008-07-16 02:28:00'),(366,43761,'image/jpeg','Children_s_White_1_mini.jpg',250,205,365,'mini',NULL,'2008-07-16 02:28:00','2008-07-16 02:28:00'),(367,3175,'image/jpeg','Children_s_White_1_thumb.jpg',45,45,365,'thumb',NULL,'2008-07-16 02:28:00','2008-07-16 02:28:00'),(368,138959,'image/jpeg','Children_s_White_1_main.jpg',520,423,365,'main',NULL,'2008-07-16 02:28:00','2008-07-16 02:28:00'),(369,36968,'image/jpeg','Chino_Black_1.jpg',520,423,NULL,NULL,7,'2008-07-18 09:04:55','2008-07-18 09:04:55'),(370,3442,'image/jpeg','Chino_Black_1_thumb.jpg',45,45,369,'thumb',NULL,'2008-07-18 09:04:55','2008-07-18 09:04:55'),(371,90235,'image/jpeg','Chino_Black_1_main.jpg',520,423,369,'main',NULL,'2008-07-18 09:04:55','2008-07-18 09:04:55'),(372,38348,'image/jpeg','Chino_Black_1_mini.jpg',250,205,369,'mini',NULL,'2008-07-18 09:04:56','2008-07-18 09:04:56');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `products` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` text,
  `price` decimal(8,2) default '0.00',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `category_id` int(11) default NULL,
  `sku` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Valentina','Ladies pink polo shirt\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 2 embroidered on front, back & sleeves\r\n\r\nPolo stick on back & front\r\n\r\n\r\n','100.00','2008-05-11 14:22:04','2008-07-16 02:28:10',2,'lpval'),(2,'Polo Girl','Ladies blue polo shirt\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 1 embroidered on front, back & sleeves\r\n\r\nPolo Girl on back and front\r\n\r\n\r\n\r\n','100.00','2008-05-11 14:36:57','2008-07-27 06:08:56',2,'lppog'),(3,'Polo Stick (Boys)','Children\'s black polo shirt\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 2 printed on front, back & sleeves\r\n\r\nPolo stick on back & front\r\n\r\n\r\n','85.00','2008-05-11 14:52:20','2008-07-16 02:28:17',3,'cppos'),(4,'Princesa','Children\'s white polo shirt\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 2 printed on front, back & sleeves\r\n\r\nPolo Girl on back & front\r\n\r\n\r\n \r\n','85.00','2008-05-11 15:00:32','2008-07-16 02:28:05',3,'cppog'),(5,'Chino White','Men\'s White polo shirt\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 2 embroidered on front, back & sleeves\r\n\r\n\'King of Games\' in Chinese Characters on back. \r\n\r\nPolo stick on back & front\r\n\r\n \r\n\r\n','120.00','2008-05-12 13:11:57','2008-07-16 02:28:28',1,'mpkog'),(6,'La Vita E Bella','Ladies black polo shirt with pink collar\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 2 embroidered on chest, back and sleeves\r\n\r\nChinese Character Tian  [Heaven / Sky] on front\r\n\r\nPolo stick on back\r\n\r\n\r\n','100.00','2008-05-20 11:57:55','2008-07-16 02:28:33',2,'lplvb'),(7,'Chino Black','Men\'s Black polo shirt\r\n\r\nTianblue logo embroidered on front\r\n\r\nNumber 3 embroidered on front, back & sleeves\r\n\r\n\'King of Games\' in Chinese Characters on back. \r\n\r\nPolo stick on back & front \r\n\r\n','120.00','2008-05-28 15:46:59','2008-07-16 02:28:40',1,'mpchibl'),(8,'Tian Cap Navy','Navy Tianblue cap\r\n\r\nEmbroidered polo stick on front\r\n\r\nEmbroidered Chinese Charater Tian \r\n[Heaven /sky] on front\r\n\r\nTianblue embroidered on back\r\n\r\nOne size fits all.\r\n\r\n','35.00','2008-06-05 05:57:11','2008-07-25 06:38:06',4,'cptianv'),(9,'Mariposa','Ladies  black  polo shirt  \r\n\r\nTianblue  logo embroidered on front\r\nNumber 3 embroidered on chest, back and sleeves\r\n\r\nPolo stick on front & back\r\n\r\nChinese Characters ‘ King of Games ‘ on back\r\n\r\n ','100.00','2008-06-05 06:06:46','2008-07-27 00:12:22',2,'lpmarbl'),(10,'Tian Cap White','Tianblue cap\r\n\r\nEmbroidered polo stick on front\r\n\r\nEmbroidered Chinese Charater Tian \r\n[Heaven /sky ] on front\r\n\r\nTianblue embroidered on back\r\n\r\n','35.00','2008-07-07 13:58:21','2008-07-25 06:37:58',4,'cptiawhite');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20080407100648'),('20080407102351'),('20080407102905'),('20080415091325'),('20080421022649'),('20080421160803'),('20080421160820'),('20080422024320'),('20080423031107'),('20080428052712'),('20080509075059'),('20080509095359'),('20080511030959'),('20080512015523'),('20080522025249'),('20080529064020'),('20080530082310'),('20080530105228'),('20080531084034'),('20080609154125'),('20080610110514'),('20080610142009'),('20080612162920'),('20080612185426'),('20080612211825'),('20080623093848'),('20080624064002'),('20080625033437'),('20080625051418'),('20080625115108'),('20080626105952'),('20080626152523'),('20080628104550'),('20080629083810');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sizes` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `code` varchar(255) default NULL,
  `description` text,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `relative_order` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sizes`
--

LOCK TABLES `sizes` WRITE;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` VALUES (1,'Large','l','L','2008-06-12 15:53:24','2008-06-23 10:18:22',500),(2,'Small','s','S','2008-06-12 15:54:56','2008-06-23 10:18:38',300),(3,'Medium','m','M','2008-06-14 08:30:33','2008-06-23 10:18:30',400),(4,'Extra Large','xl','XL','2008-06-18 03:44:27','2008-06-23 10:18:59',600),(5,'Extra Extra Large','xxl','XXL','2008-06-18 03:44:57','2008-06-23 10:19:06',700),(6,'Extra Small','xs','XS','2008-06-18 03:59:33','2008-06-23 10:18:45',200),(7,'Extra Extra Small','xxs','XXS','2008-06-18 04:03:26','2008-06-23 10:18:52',100),(8,'Standard','sd','Standard Sized','2008-06-23 10:09:08','2008-06-23 10:19:13',400),(9,'26','26','26','2008-07-13 09:07:39','2008-07-13 09:07:39',26),(10,'28','28','28','2008-07-13 09:07:57','2008-07-13 09:07:57',28),(11,'30','30','30','2008-07-13 09:08:08','2008-07-13 09:08:08',30),(12,'32','32','32','2008-07-13 09:08:17','2008-07-13 09:08:17',32),(13,'34','34','34','2008-07-13 09:08:25','2008-07-13 09:08:25',34);
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_units`
--

DROP TABLE IF EXISTS `stock_units`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `stock_units` (
  `id` int(11) NOT NULL auto_increment,
  `product_id` int(11) default NULL,
  `size_id` int(11) default NULL,
  `stock` int(11) default '0',
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `sku` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `stock_units`
--

LOCK TABLES `stock_units` WRITE;
/*!40000 ALTER TABLE `stock_units` DISABLE KEYS */;
INSERT INTO `stock_units` VALUES (1,1,2,2,'2008-06-12 15:54:03','2008-07-13 02:15:41','lpval-s'),(2,1,3,10,'2008-06-12 15:55:37','2008-07-13 02:15:47','lpval-m'),(3,2,2,4,'2008-06-18 16:18:35','2008-07-13 02:16:50','lppog-s'),(4,1,1,10,'2008-06-19 03:34:30','2008-07-13 02:15:54','lpval-l'),(5,1,4,5,'2008-06-19 03:36:41','2008-07-13 02:16:00','lpval-xl'),(6,2,3,10,'2008-06-19 03:37:35','2008-07-13 02:16:59','lppog-m'),(7,2,1,10,'2008-06-19 03:37:43','2008-07-13 02:17:06','lppog-l'),(8,2,4,5,'2008-06-19 03:37:49','2008-07-13 02:17:12','lppog-xl'),(9,5,2,2,'2008-06-19 03:45:36','2008-07-12 07:02:49','mpkog-s'),(10,5,3,6,'2008-06-19 03:45:42','2008-07-12 07:03:00','mpkog-m'),(11,5,1,8,'2008-06-19 03:45:47','2008-07-12 07:03:19','mpkog-l'),(12,5,4,7,'2008-06-19 03:45:53','2008-07-12 07:03:33','mpkog-xl'),(13,6,2,0,'2008-06-19 03:47:28','2008-06-26 14:50:40','lplvb-s'),(14,6,3,0,'2008-06-19 03:47:34','2008-06-26 14:50:40','lplvb-m'),(15,6,1,0,'2008-06-19 03:47:38','2008-06-26 14:50:40','lplvb-l'),(16,6,4,0,'2008-06-19 03:47:45','2008-06-26 14:50:40','lplvb-xl'),(17,7,2,2,'2008-06-19 07:53:34','2008-07-13 02:04:19','mpchibl-s'),(18,7,3,2,'2008-06-19 07:53:39','2008-07-13 02:04:31','mpchibl-m'),(19,7,1,5,'2008-06-19 07:53:47','2008-07-13 02:04:45','mpchibl-l'),(20,7,4,7,'2008-06-19 07:53:53','2008-07-13 02:04:52','mpchibl-xl'),(21,9,2,4,'2008-06-19 07:54:07','2008-07-13 02:21:25','lpmarbl-s'),(22,9,3,8,'2008-06-19 07:54:18','2008-07-13 02:21:32','lpmarbl-m'),(23,9,1,8,'2008-06-19 07:54:23','2008-07-13 02:21:38','lpmarbl-l'),(24,9,4,4,'2008-06-19 07:54:29','2008-07-13 02:21:43','lpmarbl-xl'),(25,8,8,10,'2008-06-23 10:19:30','2008-06-26 14:50:40','cptianv-sd'),(26,10,8,25,'2008-07-07 13:58:50','2008-07-07 13:58:50','cptiawhite-sd'),(27,5,5,3,'2008-07-12 07:03:45','2008-07-12 07:03:45','mpkog-xxl'),(28,7,5,3,'2008-07-13 02:05:03','2008-07-13 02:05:03','mpchibl-xxl'),(29,4,9,5,'2008-07-13 09:09:03','2008-07-13 09:09:13','cppog-26'),(30,4,10,5,'2008-07-13 09:09:26','2008-07-13 09:09:26','cppog-28'),(31,4,11,6,'2008-07-13 09:09:59','2008-07-13 09:09:59','cppog-30'),(32,4,12,6,'2008-07-13 09:10:07','2008-07-13 09:10:07','cppog-32'),(33,4,13,6,'2008-07-13 09:10:13','2008-07-13 09:10:13','cppog-34'),(34,3,9,4,'2008-07-13 11:35:15','2008-07-13 11:35:15','cppos-26'),(35,3,10,6,'2008-07-13 11:35:27','2008-07-13 11:35:27','cppos-28'),(36,3,11,6,'2008-07-13 11:35:33','2008-07-13 11:35:33','cppos-30'),(37,3,12,6,'2008-07-13 11:35:44','2008-07-13 11:35:44','cppos-32'),(38,3,13,6,'2008-07-13 11:35:51','2008-07-13 11:35:51','cppos-34');
/*!40000 ALTER TABLE `stock_units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `login` varchar(40) default NULL,
  `name` varchar(100) default '',
  `email` varchar(100) default NULL,
  `crypted_password` varchar(40) default NULL,
  `salt` varchar(40) default NULL,
  `created_at` datetime default NULL,
  `updated_at` datetime default NULL,
  `remember_token` varchar(40) default NULL,
  `remember_token_expires_at` datetime default NULL,
  `activation_code` varchar(40) default NULL,
  `activated_at` datetime default NULL,
  `state` varchar(255) default 'passive',
  `deleted_at` datetime default NULL,
  `password_reset_code` varchar(40) default NULL,
  `is_admin` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'andycroll','Andy Croll','andycroll@deepcalm.com','551d526e6f6c6c62ba8405976bc3d41704bf3d66','79714150b5727bdcb56f443b4607048096a1318b','2008-06-30 07:20:56','2008-07-27 12:31:33',NULL,NULL,NULL,'2008-06-30 07:21:22','active',NULL,'627155060797e5111204184a142ec3b3fe50fb3a',1),(2,'tphutton','Tom Hutton','tphutton@tianblue.com','fc06aa5d35f953f6e8f2e417324d44cb408e21b4','6672edf7f5ed055a3d9d671580b35b380add4d5e','2008-06-30 07:22:51','2008-07-18 07:38:28',NULL,NULL,NULL,'2008-07-01 03:32:05','active',NULL,'4999eaf476a567ba0f8012add4966b2cbc302ec5',1),(3,'marc.howard','','marc.howard@tianblue.com','1162e5e1247c1e70ad5b9a8df36325ee7ba6963b','e13f0210ae6b8a7097ec7650d67ab9bf8a87a82f','2008-07-02 12:03:17','2008-07-02 12:03:17',NULL,NULL,'b17fee9418375bfd71eb2c3172e226ce0cf2464f',NULL,'pending',NULL,NULL,0),(7,'louise','','louise_devlin@hotmaill.com','64713ff3ea00ca1df416a5ed9ff6f46744d74abd','d326c1791c6315a326693750806c1b2e28dd9bbd','2008-07-27 07:14:29','2008-07-27 07:17:19',NULL,NULL,'80689a645b53df3060d24daa001045f87689cea5',NULL,'pending',NULL,'8d24e61147e53942b096b592771988494c34074a',0),(8,'louise_devlin','','louise_devlin@hotmail.com','4e1fb1e3e348d00110db6c407c50657fae13a56a','3e785297242efb63995f6eed0f1db9a701c2f9e8','2008-07-27 07:15:05','2008-07-27 07:15:05',NULL,NULL,'d3e9bcf13606efc00a660b692e46b7984c2d034d',NULL,'pending',NULL,NULL,0),(9,'tinny','','clindman@hotmail.com','ca4f7c3fd2e8f796b50789b13b0b2598d4e38d26','e2eda143b55ed6cb02848cbda42ce6b8b2f6e9e1','2008-07-27 09:52:59','2008-07-27 09:52:59',NULL,NULL,'6600c11c12e0fe27828c00982e1fa7836394ffa0',NULL,'pending',NULL,NULL,0),(10,'testing','','andycroll+testing@deepcalm.com','7fc04d1ff31b932453b688f4a558c86fe622e6d7','d6f514bd6837f407ceb6822420bfd92d2343973d','2008-07-28 05:36:13','2008-07-28 05:36:13',NULL,NULL,'7936bf9023d383225c72063ae64d5d61b1a0d502',NULL,'pending',NULL,NULL,0),(11,'Tom','','tphutton@hotmail.com','6da62b52eaa997f6033f0b57c660ebd506078179','abd7cfd1e6fdae14c75d50ac1230157d3709fcf5','2008-07-28 11:37:20','2008-07-28 11:37:20',NULL,NULL,'4bf6d9cbe5ca022f89a7b9e597ba2336066cdf13',NULL,'pending',NULL,NULL,0),(12,'bob','','tomhutton@tgafootball.com','5c3b0541e5d93cf86a779550c1f4916c7464ae66','f6ce6415a08651abbcf85df577cfbfc9e88d2eb8','2008-07-28 11:41:28','2008-07-28 11:41:28',NULL,NULL,'66b764a8d5dde959cb8544f1df59d83e919096e5',NULL,'pending',NULL,NULL,0),(13,'nickh','','tianunique@hotmail.com','0599b2602344bb14b5066a73716ecbc79810d9e1','6ddb4ee2c132144e25bcda5690e28c3b3579a3d2','2008-07-28 11:51:35','2008-07-28 13:30:02',NULL,NULL,NULL,'2008-07-28 12:05:01','active',NULL,NULL,0),(14,'susan','','nphutton@gmail.com','b2a4346e7e9771a6ee659dcd665205649c6121bd','003fe3f66779dc96661ea86ace3636fe79b9565e','2008-07-28 12:02:16','2008-08-06 07:32:25','048deccfa12697b2d382b0ec4a7ca10c038e70b7','2008-08-20 07:32:25',NULL,'2008-07-28 12:11:12','active',NULL,NULL,0),(15,'christopher.hawken@gmail.com','','christopher.hawken@gmail.com','30a8834d364f7dec5d64475963e73fc799c1fe88','545eba27545a49ce77a8a02e29d5770bfc2bd5e7','2008-08-09 01:57:13','2008-08-09 01:57:13',NULL,NULL,'b43c1892323eb1d07a887321ba3e2fbca515d78d',NULL,'pending',NULL,NULL,0),(16,'tiendung','','dungtn@gmail.com','90c067bb2882c891db7ce86cf6cf3ad7e761d2f5','400e04d5e83685e5b22afccadaa282857edad0b0','2008-08-12 23:40:35','2008-08-14 13:59:39',NULL,NULL,NULL,'2008-08-12 23:44:18','active',NULL,NULL,0),(17,'dungtn','','tiendung@spiragram.com','2faef5107b62a57d0e118bed07a7da442a97a470','f7b6090221bf726594a68fe4dc7ca06b40d82690','2008-08-12 23:47:05','2008-08-12 23:47:05',NULL,NULL,'be79ed9f670c9f96be7228f094a8adb93576a910',NULL,'pending',NULL,NULL,0);
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

-- Dump completed on 2008-08-18 10:39:29
