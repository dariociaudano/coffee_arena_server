--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `question_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'Providing expert advice and solutions to businesses.',1),(2,'McKinsey & Company.',2),(3,'Strong analytical skills, problem-solving abilities, and effective communication.',3),(4,'It enables companies to leverage technology for improved efficiency and decision-making.',4),(5,'Balancing client demands, managing tight deadlines, and adapting to diverse industries.',5),(6,'Data analytics helps in identifying trends, making informed decisions, and improving performance.',6),(7,'Consultants help businesses identify opportunities, optimize operations, and develop strategies.',7),(8,'Management consulting, IT consulting, financial consulting, and human resources consulting.',8),(9,'It has accelerated digital transformation and increased the demand for remote consulting.',9),(10,'Maintaining confidentiality, avoiding conflicts of interest, and adhering to professional standards.',10),(11,'Providing administrative support to businesses.',1),(12,'Designing marketing campaigns for businesses.',1),(13,'Developing new products and services for businesses.',1),(14,'Assessing the environmental impact of businesses.',1),(15,'Boston Consulting Group.',2),(16,'Bain & Company.',2),(17,'Deloitte.',2),(18,'Accenture.',2),(19,'Public speaking skills and event planning abilities.',3),(20,'Foreign language proficiency and translation skills.',3),(21,'Physical fitness and sports-related knowledge.',3),(22,'Graphic design skills and creative problem-solving.',3),(23,'Leadership and team management skills.',3),(24,'It reduces the need for human interaction in business processes.',4),(25,'It has no impact on the consulting industry.',4),(26,'It increases the complexity of consulting engagements.',4),(27,'It leads to job losses in the consulting field.',4),(28,'It enables companies to automate decision-making processes.',4),(29,'It improves the accuracy of financial forecasting.',4),(30,'Keeping up with the latest fashion trends.',5),(31,'Negotiating contracts with suppliers.',5),(32,'Managing social media accounts for clients.',5),(33,'Handling customer support requests.',5),(34,'Adapting to different organizational cultures.',5),(35,'Creating marketing strategies for clients.',5),(36,'Developing innovative solutions for clients.',5),(37,'Data analytics is not relevant to consulting.',6),(38,'Data analytics only applies to large corporations.',6),(39,'Data analytics is used primarily for financial analysis.',6),(40,'Data analytics is a manual and time-consuming process.',6),(41,'Data analytics is only useful for historical data analysis.',6),(42,'Data analytics can help identify customer behavior patterns.',6),(43,'Consulting has no impact on business growth and strategy.',7),(44,'Consulting focuses only on short-term goals and objectives.',7),(45,'Consulting is limited to operational improvements.',7),(46,'Consulting cannot provide actionable insights to businesses.',7),(47,'Consulting is not aligned with organizational goals and objectives.',7),(48,'Consulting lacks industry expertise and market knowledge.',7),(49,'Business transformation consulting and logistics consulting.',8),(50,'Environmental consulting and event planning consulting.',8),(51,'Supply chain consulting and talent management consulting.',8),(52,'Real estate consulting and hospitality consulting.',8),(53,'Healthcare consulting and education consulting.',8),(54,'Technology consulting and marketing consulting.',8),(55,'Legal consulting and cybersecurity consulting.',8),(56,'The consulting industry has remained unaffected by the pandemic.',9),(57,'The pandemic has increased the demand for traditional consulting services.',9),(58,'The pandemic has led to a decline in remote consulting engagements.',9),(59,'The pandemic has resulted in a shortage of consulting talent.',9),(60,'The pandemic has limited the scope of consulting projects.',9),(61,'The pandemic has shifted consulting services towards digital platforms.',9),(62,'Consultants are not bound by any ethical considerations.',10),(63,'Consultants prioritize their personal interests over client interests.',10),(64,'Consultants often engage in unethical competitive practices.',10),(65,'Consultants are not accountable for their advice and recommendations.',10),(66,'Consultants lack transparency in their billing and pricing models.',10),(67,'Consultants face no legal consequences for unethical behavior.',10);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leadboard`
--

DROP TABLE IF EXISTS `leadboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leadboard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `point` int NOT NULL,
  `order_pos` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leadboard`
--

LOCK TABLES `leadboard` WRITE;
/*!40000 ALTER TABLE `leadboard` DISABLE KEYS */;
INSERT INTO `leadboard` VALUES (1,1,80,1),(2,2,88,2),(3,3,98,3),(4,4,25,4),(5,5,30,5),(6,6,75,6),(7,7,87,7),(8,8,6,8),(9,9,71,9),(10,10,35,10),(11,11,60,11),(12,12,97,12),(13,13,3,13),(14,14,24,14);
/*!40000 ALTER TABLE `leadboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lobby`
--

DROP TABLE IF EXISTS `lobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lobby` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `value` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lobby`
--

LOCK TABLES `lobby` WRITE;
/*!40000 ALTER TABLE `lobby` DISABLE KEYS */;
INSERT INTO `lobby` VALUES (1,4,'2023-05-24 07:36:39',1),(2,4,'2023-05-24 07:56:00',1);
/*!40000 ALTER TABLE `lobby` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `correct_answer_id` int NOT NULL,
  `difficulty_point` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'What is the primary goal of consulting firms?',1,1),(2,'Which famous consulting firm was founded in 1963?',2,1),(3,'What are some key skills required for a successful consultant?',4,2),(4,'How does digital transformation impact the consulting industry?',5,2),(5,'What are some common challenges faced by consultants?',7,1),(6,'What is the role of data analytics in consulting?',9,2),(7,'How does consulting contribute to business growth and strategy?',11,2),(8,'What are the different types of consulting services offered by firms?',13,1),(9,'How has the COVID-19 pandemic affected the consulting industry?',15,2),(10,'What are some ethical considerations in the consulting profession?',17,1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `nick` varchar(255) NOT NULL,
  `password_enc` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `qr_code` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'John','Playful Lion','$2a$10$k0NNNSDc/R.JMMV2bTvSPOAfF8Sulhnn/DTOsg/uuibFAI8eRgJ2u','https://picsum.photos/200','fb57ece0-6c72-4dd8-8f54-7be45b5ee5cf'),(2,'Dario','Majestic Elephant','$2a$10$k0NNNSDc/R.JMMV2bTvSPOAfF8Sulhnn/DTOsg/uuibFAI8eRgJ2u','https://picsum.photos/200','fb57ece1-6c72-4dd8-8f54-7be45b5ee5cf'),(3,'Fabio','Playful Zebra','$2a$10$5hVRjWUrQtjK7IF4JVfRTOsAAZxHQNYZ/qhhPnBEXTINJKCWP/wCi','https://picsum.photos/200','a7fae3d1-c4eb-46fa-b108-f4417d24e90e'),(4,'Luca','Quirky Cat','$2a$10$UyU5PGVDTXwgkKUdurARKuvWKcOuAULV/Lf0MCB3LG/d9JKyk2/ey','https://picsum.photos/200','c282dfd1-d560-4a35-b8a0-8fbba3dc4da6'),(5,'Luca','Crazy Cat','$2a$10$MmBzpK7NL3kz21/2QFKwIuV/aZK.77Kb5DSS5unX9go/UlyM.0s1e','https://picsum.photos/200','540c0dd8-23ad-4643-a34a-17b5ba17d972'),(6,'Luca','Awesome Tiger','$2a$10$QdzINy1o.se9BAm7OyCoy.0lHqA/7UUJVSEeXpw1MXB6yCjkmbZ7m','https://picsum.photos/200','ce5fdf68-2ff3-4501-a267-428d5cf7ddc0'),(7,'Amerigo','Playful Elephant','$2a$10$6Ry4ZnFRg0XuVqvaYRvT0u66zzNKk7JKgYZC1Vs67ZXUU5l7rAg0y','https://picsum.photos/200','28d7e88b-5322-4077-b8b2-7785dfbdbb08'),(8,'Gianni','Crazy Penguin','$2a$10$ssFrmWArZdPJCBDECD3vm.DF7wpPNmVXuBG1ttu9GdCG5la6PxUA.','https://picsum.photos/200','0807f97d-1cb0-4e05-bf13-b132e05cbafd'),(9,'Paolo','Rugged Penguin','$2a$10$tGr/GInrto9Q/xxPijD3luGApayljD5BhVlViNXaRaePy.t6Zlb0y','https://picsum.photos/200','bc5a9888-00d2-4104-aeb4-6c9857a9f882'),(10,'Davide','Fierce Monkey','$2a$10$LCY8ujikEbu0uI5jWyGEZOGy9qx9M2WvNltTGiI6Fpbavq/lyIeT2','https://picsum.photos/200','23afa42a-fc5f-4755-8de6-97bbe950e31f'),(11,'Marco','Playful Tiger','$2a$10$9urv0pYGTjaML7ZAQ00SmucAvoSGdSQOjAvoWlzHX/MaroRqdYkFS','https://picsum.photos/200','8dd0e303-4ee3-4fde-b066-3a20d127ff8e'),(12,'Stefania','Fierce Zebra','$2a$10$8958/1.d1Sk8NruSHb907uDbWltkB0pkLE5KCbQ9bA0p/VHBLQu/G','https://picsum.photos/200','cb607300-889b-4724-8f1b-1af73a66d740'),(13,'Martina','Rugged Lion','$2a$10$w33qHEuR9bBEAGrg6FDzPe.SCJU.VGnU4mGhjwE46yUstqCuPmZgq','https://picsum.photos/200','f3b10c81-d37c-40fe-a29c-040b1220b43e'),(14,'Luciana','Hilarious Giraffe','$2a$10$Va7ogyURcJQQg4nz8gQVZutHvp0QZmWCgcT1c.GL7cEo1hhdC43pm','https://picsum.photos/200','49a81da2-66ac-4e3c-980b-df0fc24ec46f');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_log`
--

DROP TABLE IF EXISTS `user_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `jwt_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_log`
--

LOCK TABLES `user_log` WRITE;

UNLOCK TABLES;