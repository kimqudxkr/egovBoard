-- MariaDB dump 10.19  Distrib 10.5.9-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	10.5.9-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board_file`
--

DROP TABLE IF EXISTS `board_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_file` (
  `file_idx` int(11) NOT NULL AUTO_INCREMENT,
  `idx` int(11) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_path` varchar(100) NOT NULL,
  `file_extension` varchar(100) NOT NULL,
  PRIMARY KEY (`file_idx`),
  KEY `board_file_FK` (`idx`),
  CONSTRAINT `board_file_FK` FOREIGN KEY (`idx`) REFERENCES `boardtest` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_file`
--

LOCK TABLES `board_file` WRITE;
/*!40000 ALTER TABLE `board_file` DISABLE KEYS */;
INSERT INTO `board_file` VALUES (152,39,'1617791348141.jpg','/storage/emulated/0/Pictures/KakaoTalk/1617791348141.jpg','jpg'),(153,38,'FB_IMG_1523436268950.jpg','/storage/emulated/0/DCIM/Facebook/FB_IMG_1523436268950.jpg','jpg'),(155,36,'1618020665125.jpg','/storage/emulated/0/DCIM/browser-photos/1618020665125.jpg','jpg');
/*!40000 ALTER TABLE `board_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_list`
--

DROP TABLE IF EXISTS `board_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_list` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `writer` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `reg_date` datetime DEFAULT current_timestamp(),
  `cnt` int(11) DEFAULT 0,
  `option` varchar(100) DEFAULT NULL,
  `setting` varchar(100) DEFAULT NULL,
  `link1` varchar(100) DEFAULT NULL,
  `link2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_list`
--

LOCK TABLES `board_list` WRITE;
/*!40000 ALTER TABLE `board_list` DISABLE KEYS */;
INSERT INTO `board_list` VALUES (1,'테스트','으아','한글','2021-04-12 00:00:00',34,NULL,'free','https://www.naver.com','https://www.daum.net'),(2,'테스트','미처리','입력!','2021-04-12 00:00:00',17,NULL,'qna','',''),(3,'테스트','처리중','입니다.','2021-04-12 00:00:00',3,NULL,'review','',''),(4,'테스트','공지사항','으아','2021-04-12 00:00:00',8,NULL,'qna','',''),(5,'김병탁','아직 안됐네','하하\n됐겠지 뭐','2021-04-15 00:00:00',7,NULL,'review','',''),(6,'김병탁','스택테스트2','ㄹㅇㅎㄴㄷㄱ흎','2021-04-15 00:00:00',4,NULL,'review','',''),(7,'병탁김','이번에 진짜 완료','이번에 진짜 완료21312','2021-04-15 00:00:00',23,NULL,'free','',''),(8,'김병탁','global test complete','test complete','2021-04-15 00:00:00',33,NULL,'free','',''),(9,'테스트','타임테스트','timetest','2021-04-16 09:23:19',24,NULL,'review','',''),(10,'테스트','default test','디폴트 테스트','2021-04-16 09:24:37',13,NULL,'free','',''),(11,'테스트','redirect test','리다이렉트 테스트','2021-04-16 09:28:40',23,NULL,'review','',''),(12,'테스트','???','테스트중','2021-04-19 10:47:03',71,NULL,'qna','https://www.daum.net',''),(13,'테스트','공지','테스스트','2021-04-19 11:07:13',21,'','notice','',''),(14,'최고관리자','공지 테스트 안내','성공적으로 끝났다','2021-04-19 11:32:32',10,NULL,'notice','',''),(15,'테스트','4월 20일 글','포린키 테스트를 위한 게시글입니다.','2021-04-20 16:31:30',178,NULL,'review','https://www.naver.com',''),(16,'테스트','링크 테스트','링크 테스트 과연?','2021-04-21 16:15:25',36,NULL,'free','https://www.google.com',''),(17,'테스트','22일 새 글','ㅇㅎㅀ\n추가','2021-04-22 14:23:54',18,NULL,'free','',''),(18,'김병탁','세션 작업 후 작성 테스트','김병탁으로 작성되어야 함','2021-04-22 16:55:02',22,NULL,'free','',''),(19,'병탁김','이번거는 병탁김으로다가','작성되어야 함','2021-04-22 16:55:19',55,NULL,'free','',''),(20,'최고관리자','최고관리자 글','작성','2021-04-23 09:09:54',39,NULL,'review','',''),(21,'최고관리자','test3','test3','2021-04-26 14:35:48',34,NULL,'qna','',''),(22,'김병탁','22','222222','2021-04-27 08:51:42',64,NULL,'free','',''),(23,'테스트','무작정 긴 제목으로 글자수 넘치게하기','ㄴㅇㄹㄴㅁㅈㄺㄴ','2021-04-30 11:04:50',0,NULL,'qna','',''),(24,'김병탁','댓글 실험용 게시글','댓글 러쉬','2021-05-04 11:29:12',0,NULL,'qna','',''),(25,'최고관리자','어드민 글','작성완료','2021-05-04 14:51:07',0,NULL,'review','',''),(26,'김병탁','스택 테스트','가즈아','2021-05-04 14:55:25',0,NULL,'qna','',''),(27,'김병탁','으아','3432413','2021-05-04 14:56:26',1,NULL,'free','',''),(28,'김병탁','ㅇㄴㄹㅇㄴ','ㅇㄹxcxc','2021-05-04 15:30:21',2,NULL,'qna','',''),(29,'김병탁','필터와 더보기 테스트','ㅇㄴㄻㄴㅇㄹ','2021-05-06 16:57:16',3,NULL,'free','',''),(30,'김병탁','모바일로 글 작성','하하하하\n=> 링크 수정 테스트','2021-05-07 09:22:58',6,NULL,'qna','https://www.naver.com','https://www.google.com'),(31,'최고관리자','가나다라마바사아자차카타파하','가나다라마바사아자차카타파하가나다라마바사가나다라마바사아자차카타파하가나다라마바사','2021-05-07 11:20:10',4,NULL,'qna','',''),(32,'최고관리자','링크 작성 테스트','하하ㅏ','2021-05-10 10:55:56',41,NULL,'review','https://www.google.com','https://www.naver.com'),(33,'김병탁','으아','으아','2021-05-11 14:25:15',16,NULL,'free','',''),(34,'김병탁','하하하하하','하하하','2021-05-11 14:54:26',22,NULL,'free','http://www.naver.com',''),(35,'김병탁','dirnenej','jfjfjrj3','2021-05-11 14:58:01',47,NULL,'qna','https://www.naver.com',''),(36,'김병탁','upload','upload','2021-05-14 09:28:53',74,NULL,'free','',''),(37,'김병탁','취소 테스트','ㅌㅅㅌfgh','2021-05-17 11:51:17',69,NULL,'qna','',''),(38,'김병탁','취소 테스트 다시','야호tdyhrt','2021-05-17 14:11:56',103,NULL,'free','',''),(39,'김병탁','수정함','과연????','2021-05-20 10:55:30',46,NULL,'notice','',''),(40,'새유저','새로 가입해서 공지 띄웁니다!','반갑습니다~','2021-06-09 16:50:54',3,NULL,'notice','',''),(41,'새유저','내가 작성한 게시글용 테스트 게시글','내가 작성한 게시글용 테스트 게시글','2021-06-09 17:22:42',21,NULL,'free','','');
/*!40000 ALTER TABLE `board_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_reply`
--

DROP TABLE IF EXISTS `board_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_reply` (
  `reply_idx` int(11) NOT NULL AUTO_INCREMENT,
  `idx` int(11) NOT NULL,
  `writer` varchar(100) NOT NULL,
  `reply` varchar(100) NOT NULL,
  `reg_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`reply_idx`),
  KEY `board_reply_FK` (`idx`),
  CONSTRAINT `board_reply_FK` FOREIGN KEY (`idx`) REFERENCES `board_list` (`idx`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_reply`
--

LOCK TABLES `board_reply` WRITE;
/*!40000 ALTER TABLE `board_reply` DISABLE KEYS */;
INSERT INTO `board_reply` VALUES (6,12,'최고관리자','ㅈㄷㅂㄴㅇㅁㅇ','2021-04-20 15:49:23'),(7,12,'최고관리자','다시','2021-04-20 15:50:47'),(8,12,'최고관리자','세번','2021-04-20 15:51:56'),(10,9,'최고관리자','가자','2021-04-20 15:59:15'),(11,14,'최고관리자','공지 댓글','2021-04-20 16:00:22'),(13,9,'최고관리자','reply_idx 테스트','2021-04-20 16:18:07'),(15,8,'최고관리자','ㅎㅇㄴㄻ','2021-04-20 17:18:24'),(16,8,'아악','제발 되어라!','2021-04-20 17:28:12'),(19,16,'최고관리자','오 과연?','2021-04-20 17:49:50'),(22,13,'최고관리자','수정 123','2021-04-21 11:34:09'),(23,16,'최고관리자','버그','2021-04-21 15:35:03'),(24,11,'최고관리자','됐나? 됐나?','2021-04-21 15:37:02'),(25,11,'최고관리자','ㅇㅋ?','2021-04-21 15:37:13'),(26,16,'최고관리자','해결? ㅇㅋ','2021-04-21 15:37:22'),(27,1,'최고관리자','여긴 되나? 되네','2021-04-21 15:38:03'),(28,12,'최고관리자','kl; k;lk;','2021-04-21 16:49:52'),(29,17,'최고관리자','앜','2021-04-22 11:38:22'),(31,19,'병탁김','여기는 병탁김','2021-04-22 17:01:00'),(32,20,'최고관리자','? 엔터키 입력이 안되노','2021-04-23 09:24:30'),(33,20,'김병탁','이렇게 되면?\r\n엔터키','2021-04-23 09:48:34'),(37,23,'좋은삼정병원','댓글 테스트','2021-04-27 14:14:07'),(38,23,'좋은삼정병원','저건 뭐고 그로거ㅔ','2021-04-27 14:14:11'),(40,22,'김병탁','3333','2021-04-27 14:15:33'),(41,23,'최고관리자','추가','2021-04-27 14:53:00'),(42,25,'김병탁','김병탁이 작성한 댓글','2021-05-04 11:32:35'),(76,29,'김병탁','eafw1231223','2021-05-04 17:10:09'),(78,28,'김병탁','새로고침 만세','2021-05-04 17:15:18'),(80,29,'병탁김','댓글도 잘 달리고\n뭐가 문제여','2021-05-06 13:44:32'),(81,30,'김병탁','모바일로 댓글달기','2021-05-06 17:35:11'),(82,31,'김병탁','오오오','2021-05-07 09:23:03'),(83,32,'최고관리자','가나다라마바사아자차카타파하가나다라마바사가나다라마바사아자차카타파하가나다라마바사가나다라마바사아자차카타파하가나다라마바사가나다라마바사아자차카타파하가나다라마바사','2021-05-07 11:22:37'),(84,32,'김병탁','안녕\n하세요','2021-05-07 11:39:29'),(85,32,'김병탁','스페이스바를 이용하여 긴 글을 작성하면 단어 단위로 삐져 나가나? 한번 테스트 해보자ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ','2021-05-07 14:44:40'),(86,35,'김병탁','댓글까지?','2021-05-11 15:13:53'),(87,36,'김병탁','댓글까지','2021-05-17 14:59:38'),(89,38,'새유저','첫 댓글 작성!','2021-06-09 16:41:07'),(97,34,'김병탁','dsf','2021-06-10 09:23:14'),(100,41,'김병탁','tesar','2021-06-10 09:28:21'),(101,41,'김병탁','ㅎㅇㅎㅇ','2021-06-10 09:31:41');
/*!40000 ALTER TABLE `board_reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_user`
--

DROP TABLE IF EXISTS `board_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board_user` (
  `id` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_user`
--

LOCK TABLES `board_user` WRITE;
/*!40000 ALTER TABLE `board_user` DISABLE KEYS */;
INSERT INTO `board_user` VALUES ('123','123','123'),('admin','1234','최고관리자'),('btkim','1234','김병탁'),('hospital','1234','좋은삼정병원'),('kimbt','1234','병탁김'),('newUser','1234','새유저'),('test','1234','테스트');
/*!40000 ALTER TABLE `board_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardtest`
--

DROP TABLE IF EXISTS `boardtest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boardtest` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `writer` varchar(100) DEFAULT '좋은삼정병원',
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `reg_date` datetime DEFAULT current_timestamp(),
  `cnt` int(11) DEFAULT 0,
  `option` varchar(100) DEFAULT NULL,
  `setting` varchar(100) DEFAULT NULL,
  `link1` varchar(100) DEFAULT NULL,
  `link2` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardtest`
--

LOCK TABLES `boardtest` WRITE;
/*!40000 ALTER TABLE `boardtest` DISABLE KEYS */;
INSERT INTO `boardtest` VALUES (1,'좋은삼정병원','으아','한글','2021-04-12 00:00:00',33,NULL,'complete','https://www.naver.com','https://www.daum.net'),(2,'좋은삼정병원','미처리','입력!','2021-04-12 00:00:00',17,NULL,'untreated','',''),(3,'좋은삼정병원','처리중','입니다.','2021-04-12 00:00:00',3,NULL,'processing','',''),(4,'좋은삼정병원','공지사항','으아','2021-04-12 00:00:00',8,NULL,'untreated','',''),(5,'김병탁','아직 안됐네','하하\n됐겠지 뭐','2021-04-15 00:00:00',7,NULL,'processing','',''),(6,'김병탁','스택테스트2','ㄹㅇㅎㄴㄷㄱ흎','2021-04-15 00:00:00',4,NULL,'processing','',''),(7,'병탁김','이번에 진짜 완료','이번에 진짜 완료21312','2021-04-15 00:00:00',23,NULL,'complete','',''),(8,'김병탁','global test complete','test complete','2021-04-15 00:00:00',33,NULL,'complete','',''),(9,'좋은삼정병원','타임테스트','timetest','2021-04-16 09:23:19',24,NULL,'processing','',''),(10,'좋은삼정병원','default test','디폴트 테스트','2021-04-16 09:24:37',13,NULL,'complete','',''),(11,'좋은삼정병원','redirect test','리다이렉트 테스트','2021-04-16 09:28:40',23,NULL,'processing','',''),(12,'병탁김','작성자 tㄷㅁㅇ','writer 테스ㄹㅊ','2021-04-16 09:31:05',118,NULL,'hold','',''),(13,'좋은삼정병원','???','테스트중','2021-04-19 10:47:03',71,NULL,'untreated','https://www.daum.net',''),(14,'좋은삼정병원','공지','테스스트','2021-04-19 11:07:13',20,'','notice','',''),(15,'최고관리자','공지 테스트 안내','성공적으로 끝났다','2021-04-19 11:32:32',9,NULL,'notice','',''),(16,'좋은삼정병원','4월 20일 글','포린키 테스트를 위한 게시글입니다.','2021-04-20 16:31:30',178,NULL,'processing','https://www.naver.com',''),(17,'좋은삼정병원','링크 테스트','링크 테스트 과연?','2021-04-21 16:15:25',35,NULL,'complete','https://www.google.com',''),(18,'좋은삼정병원','22일 새 글','ㅇㅎㅀ\n추가','2021-04-22 14:23:54',18,NULL,'complete','',''),(19,'김병탁','세션 작업 후 작성 테스트','김병탁으로 작성되어야 함','2021-04-22 16:55:02',22,NULL,'complete','',''),(20,'병탁김','이번거는 병탁김으로다가','작성되어야 함','2021-04-22 16:55:19',55,NULL,'complete','',''),(21,'최고관리자','최고관리자 글','작성','2021-04-23 09:09:54',39,NULL,'processing','',''),(22,'최고관리자','test3','test3','2021-04-26 14:35:48',34,NULL,'untreated','',''),(23,'김병탁','22','222222','2021-04-27 08:51:42',64,NULL,'complete','',''),(24,'좋은삼정병원','무작정 긴 제목으로 글자수 넘치게하기','ㄴㅇㄹㄴㅁㅈㄺㄴ','2021-04-30 11:04:50',0,NULL,'untreated','',''),(25,'김병탁','댓글 실험용 게시글','댓글 러쉬','2021-05-04 11:29:12',0,NULL,'untreated','',''),(26,'최고관리자','어드민 글','작성완료','2021-05-04 14:51:07',0,NULL,'processing','',''),(27,'김병탁','스택 테스트','가즈아','2021-05-04 14:55:25',0,NULL,'untreated','',''),(28,'김병탁','으아','3432413','2021-05-04 14:56:26',1,NULL,'complete','',''),(29,'김병탁','ㅇㄴㄹㅇㄴ','ㅇㄹxcxc','2021-05-04 15:30:21',2,NULL,'untreated','',''),(30,'김병탁','필터와 더보기 테스트','ㅇㄴㄻㄴㅇㄹ','2021-05-06 16:57:16',2,NULL,'complete','',''),(31,'김병탁','모바일로 글 작성','하하하하\n=> 링크 수정 테스트','2021-05-07 09:22:58',6,NULL,'untreated','https://www.naver.com','https://www.google.com'),(32,'최고관리자','가나다라마바사아자차카타파하','가나다라마바사아자차카타파하가나다라마바사가나다라마바사아자차카타파하가나다라마바사','2021-05-07 11:20:10',1,NULL,'untreated','',''),(33,'최고관리자','링크 작성 테스트','하하ㅏ','2021-05-10 10:55:56',29,NULL,'processing','https://www.google.com','https://www.naver.com'),(34,'김병탁','으아','으아','2021-05-11 14:25:15',16,NULL,'complete','',''),(35,'김병탁','하하하하하','하하하','2021-05-11 14:54:26',20,NULL,'complete','http://www.naver.com',''),(36,'김병탁','dirnenej','jfjfjrj3','2021-05-11 14:58:01',42,NULL,'untreated','https://www.naver.com',''),(37,'김병탁','upload','upload','2021-05-14 09:28:53',64,NULL,'complete','',''),(38,'김병탁','취소 테스트','ㅌㅅㅌ','2021-05-17 11:51:17',51,NULL,'untreated','',''),(39,'김병탁','취소 테스트 다시','무야호','2021-05-17 14:11:56',70,NULL,'complete','',''),(40,'김병탁','수정함','과연????','2021-05-20 10:55:30',27,NULL,'notice','','');
/*!40000 ALTER TABLE `boardtest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `TABLE_NAME` varchar(16) NOT NULL,
  `NEXT_ID` decimal(30,0) NOT NULL,
  PRIMARY KEY (`TABLE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample` (
  `ID` varchar(16) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `DESCRIPTION` varchar(100) DEFAULT NULL,
  `USE_YN` char(1) DEFAULT NULL,
  `REG_USER` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample`
--

LOCK TABLES `sample` WRITE;
/*!40000 ALTER TABLE `sample` DISABLE KEYS */;
INSERT INTO `sample` VALUES ('SAMPLE-00035','Runtime Environment','Integration Layer','Y','eGov');
/*!40000 ALTER TABLE `sample` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-14  8:22:50
