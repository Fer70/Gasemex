-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: gasemex
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.20.04.1

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
-- Table structure for table `CheckoutPendiente`
--

DROP TABLE IF EXISTS `CheckoutPendiente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CheckoutPendiente` (
  `id_checkout` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `direccion_envio` varchar(255) NOT NULL,
  `carrito_json` json NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `id_preferencia` varchar(150) DEFAULT NULL,
  `estado` enum('pendiente','pagado','cancelado','expirado') NOT NULL DEFAULT 'pendiente',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_checkout`),
  KEY `fk_checkout_usuario` (`id_usuario`),
  CONSTRAINT `fk_checkout_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CheckoutPendiente`
--

LOCK TABLES `CheckoutPendiente` WRITE;
/*!40000 ALTER TABLE `CheckoutPendiente` DISABLE KEYS */;
INSERT INTO `CheckoutPendiente` VALUES (1,1,'Calle miasuadi #211, Col. adnafohad, C.P. 15730, Ciudad de México','{\"25\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Microalambre Sólido ER70S-6 1 kg 0.035\\\"\", \"precio\": 250.0, \"cantidad\": 1}}',250.00,'3509885978-0aeb5ca1-6f2d-4330-a042-b2cb36283480','pendiente','2026-07-08 20:59:25',0.00),(2,1,'Calle miasuadi #24234, Col. 4 arboles, C.P. 23423, Estado de México','{\"15\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Electrodo E6010 3/32\\\" 20KG\", \"precio\": 2600.0, \"cantidad\": 1}}',2600.00,'3509885978-fc9517d1-8553-4ad6-8dc5-de69c1d461b4','pendiente','2026-07-08 21:03:46',0.00),(3,1,'Calle secretaria del trabajo #211, Col. adnafohad, C.P. 54564, Ciudad de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}}',1806.00,'3509885978-185e1f91-be30-471e-9e22-da6f68dcea4c','pendiente','2026-07-08 21:11:17',0.00),(4,1,'Calle Ghijhhi #5575, Col. Guigfg, C.P. 35677, Ciudad de México','{\"25\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Microalambre Sólido ER70S-6 1 kg 0.035\\\"\", \"precio\": 250.0, \"cantidad\": 1}}',250.00,'3509885978-5c178095-caf9-4c01-9b90-704b544ed225','pendiente','2026-07-08 21:22:43',0.00),(5,1,'Calle dfdsfdsfs #234242, Col. dfsdfaf, C.P. 24234, Estado de México','{\"15\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Electrodo E6010 3/32\\\" 20KG\", \"precio\": 2600.0, \"cantidad\": 1}}',2600.00,'3509885978-d2fc250b-da0b-4ced-8964-d539c26c561c','pagado','2026-07-08 21:25:19',0.00),(6,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 21213, Ciudad de México','{\"15\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Electrodo E6010 3/32\\\" 20KG\", \"precio\": 2600.0, \"cantidad\": 1}}',2600.00,'3509885978-d517a9e0-f36f-4a54-b405-74608748c1f0','pagado','2026-07-08 21:36:47',0.00),(7,1,'Calle gomas  #43535, Col. 4 aeroses, C.P. 15432, Ciudad de México','{\"24\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Microalambre Sólido ER70S-6 5 kg 0.030\\\"\", \"precio\": 850.0, \"cantidad\": 2}}',1700.00,'3509885978-f10d897d-c9be-4916-bbfb-5944c8ca4c48','pendiente','2026-07-09 23:22:38',0.00),(8,1,'Calle Ahorarldl #672, Col. Los arroyos, C.P. 62883, Ciudad de México','{\"22\": {\"imagen\": \"soldadura.png\", \"nombre\": \"Microalambre Sólido ER70S-6 15 kg 0.045\\\"\", \"precio\": 980.0, \"cantidad\": 2}}',1960.00,'3509885978-5349b19b-666d-460b-bcc2-4794323a6418','pendiente','2026-07-09 23:30:37',0.00),(9,1,'Calle Bdjdisid #627, Col. Yujydud, C.P. 72737, Ciudad de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}}',1806.00,'3509885978-94834a18-838c-4944-bdea-0f4f694a5faa','pendiente','2026-07-09 23:35:20',0.00),(10,13,'Calle Paseo de las Flores  #Mz 15, Col. San Buenaventura, C.P. 56536, Estado de México','{\"2\": {\"imagen\": \"esab.png\", \"nombre\": \"Electrodo E7018 1/8\\\" 20KG\", \"precio\": 1800.0, \"cantidad\": 1}, \"22\": {\"imagen\": \"solido.png\", \"nombre\": \"Microalambre Sólido ER70S-6 15 kg 0.045\\\"\", \"precio\": 980.0, \"cantidad\": 1}}',2780.00,'3509885978-8683e4b8-5917-45fd-ac7b-ebcfbc1c4a54','pendiente','2026-07-10 20:53:56',0.00),(11,13,'Calle Paseo de las flores #mz 15, Col. San Buenaventura, C.P. 56536, Estado de México','{\"74\": {\"imagen\": \"fund.png\", \"nombre\": \"Fundente para Aluminio Flex Arc 100 g\", \"precio\": 1.0, \"cantidad\": 1}}',1.00,'3509885978-c7da1b03-a21e-45be-af44-d4e12cbe1638','pendiente','2026-07-10 20:58:11',0.00),(12,13,'Calle Paseo de las flores  #mz 15, Col. San Buenaventura, C.P. 56536, Estado de México','{\"74\": {\"imagen\": \"fund.png\", \"nombre\": \"Fundente para Aluminio Flex Arc 100 g\", \"precio\": 1.0, \"cantidad\": 1}}',1.00,'3509885978-de04db11-e37e-47dd-a48a-4b7709790a40','pendiente','2026-07-10 21:03:37',0.00),(13,13,'Calle Paseo de las Flores #Mz 15, Col. Sa Buenaventura, C.P. 56536, Estado de México','{\"74\": {\"imagen\": \"fund.png\", \"nombre\": \"Fundente para Aluminio Flex Arc 100 g\", \"precio\": 1.0, \"cantidad\": 1}}',1.00,'3509885978-b9793122-e68c-4e6a-a3a5-701afa96befc','pendiente','2026-07-10 21:06:01',0.00),(14,13,'Calle Hortencia #43, Col. Las flores, C.P. 43224, Estado de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}, \"74\": {\"imagen\": \"fund.png\", \"nombre\": \"Fundente para Aluminio Flex Arc 100 g\", \"precio\": 1.0, \"cantidad\": 1}}',1807.00,'3509885978-4e1a442d-cea2-42d9-96d0-1cc14b379a96','pendiente','2026-07-10 21:10:11',0.00),(15,13,'Calle Hortencia #32, Col. Las flores, C.P. 32546, Estado de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}, \"74\": {\"imagen\": \"fund.png\", \"nombre\": \"Fundente para Aluminio Flex Arc 100 g\", \"precio\": 1.0, \"cantidad\": 1}}',1807.00,'3509885978-ba173946-275b-4d2f-9983-3122ba0ceacd','pagado','2026-07-10 21:11:49',0.00),(16,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}, \"48\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 3/32\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',1300.00,NULL,'pendiente','2026-07-14 22:57:26',1300.00),(17,1,'Calle secretaria del trabajo #211, Col. adnafohad, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}, \"48\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 3/32\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',1300.00,NULL,'pendiente','2026-07-14 22:59:13',1300.00),(18,1,'Calle 232 #23434, Col. 2131, C.P. 23422, Ciudad de México','{\"40\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla TIG 316L 1/8\\\" 1KG\", \"precio\": 500.0, \"cantidad\": 2}}',1000.00,NULL,'pendiente','2026-07-14 23:02:19',1000.00),(19,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"82\": {\"imagen\": \"micalum.png\", \"nombre\": \"Microalambre Aluminio ER4043 0.5 kg 0.035\\\"\", \"precio\": 450.0, \"cantidad\": 1}}',450.00,NULL,'pendiente','2026-07-14 23:04:52',450.00),(20,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"82\": {\"imagen\": \"micalum.png\", \"nombre\": \"Microalambre Aluminio ER4043 0.5 kg 0.035\\\"\", \"precio\": 450.0, \"cantidad\": 1}}',450.00,NULL,'pendiente','2026-07-14 23:17:18',407.00),(21,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 56757, Ciudad de México','{\"82\": {\"imagen\": \"micalum.png\", \"nombre\": \"Microalambre Aluminio ER4043 0.5 kg 0.035\\\"\", \"precio\": 450.0, \"cantidad\": 1}}',450.00,NULL,'pendiente','2026-07-14 23:18:41',407.00),(23,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"74\": {\"imagen\": \"micalum.png\", \"nombre\": \"Fundente para Aluminio Flex Arc 100 g\", \"precio\": 1.0, \"cantidad\": 1}}',1.00,NULL,'pagado','2026-07-23 20:35:33',0.00),(24,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 20:40:28',2408.00),(25,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 20:41:05',2408.00),(26,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 20:43:00',2408.00),(27,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 20:44:22',2408.00),(28,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"9\": {\"imagen\": \"tanque.png\", \"nombre\": \"Bióxido de carbono portátil 9KG\", \"precio\": 900.0, \"cantidad\": 1}}',900.00,NULL,'pendiente','2026-07-23 20:46:20',858.00),(29,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"65\": {\"imagen\": \"micalum.png\", \"nombre\": \"Tungsteno 1.5% Lantano 1/16\\\" PZA\", \"precio\": 175.0, \"cantidad\": 1}}',175.00,NULL,'pagado','2026-07-23 20:49:12',175.00),(30,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',650.00,NULL,'pagado','2026-07-23 20:53:10',608.00),(31,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"13\": {\"imagen\": \"esab.png\", \"nombre\": \"Electrodo E6010 1/8\\\" 20KG\", \"precio\": 2400.0, \"cantidad\": 1}}',2400.00,NULL,'pagado','2026-07-23 20:55:06',2400.00),(32,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"8\": {\"imagen\": \"tanque.png\", \"nombre\": \"Bioxido de Carbono Linde 25KG\", \"precio\": 1400.0, \"cantidad\": 1}}',1400.00,NULL,'pagado','2026-07-23 20:56:10',1400.00),(33,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"67\": {\"imagen\": \"micalum.png\", \"nombre\": \"Tungsteno 1.5% Lantano 1/8\\\" PZA\", \"precio\": 275.0, \"cantidad\": 1}}',275.00,NULL,'pagado','2026-07-23 21:12:43',275.00),(34,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"64\": {\"imagen\": \"micalum.png\", \"nombre\": \"Tungsteno 2% Cerio 1/8\\\" PZA\", \"precio\": 275.0, \"cantidad\": 1}}',275.00,NULL,'pagado','2026-07-23 21:15:40',275.00),(35,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}}',1806.00,NULL,'pendiente','2026-07-23 21:24:43',1806.00),(36,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 21:25:31',2450.00),(37,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 21:25:31',2450.00),(38,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}}',1806.00,NULL,'pendiente','2026-07-23 21:26:39',1806.00),(39,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pendiente','2026-07-23 21:29:33',2450.00),(40,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"3\": {\"imagen\": \"tanque.png\", \"nombre\": \"Argon Linde 9.5m3\", \"precio\": 2450.0, \"cantidad\": 1}}',2450.00,NULL,'pagado','2026-07-23 21:31:28',2450.00),(41,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"82\": {\"imagen\": \"micalum.png\", \"nombre\": \"Microalambre Aluminio ER4043 0.5 kg 0.035\\\"\", \"precio\": 450.0, \"cantidad\": 1}}',450.00,NULL,'pagado','2026-07-23 21:32:47',389.00),(42,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"35\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla TIG 309L 1/8\\\" 1KG\", \"precio\": 500.0, \"cantidad\": 1}}',500.00,NULL,'pendiente','2026-07-23 21:41:05',500.00),(43,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"35\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla TIG 309L 1/8\\\" 1KG\", \"precio\": 500.0, \"cantidad\": 1}}',500.00,NULL,'pendiente','2026-07-23 21:41:07',500.00),(44,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"76\": {\"imagen\": \"micalum.png\", \"nombre\": \"Fundente para Bronce PV700\", \"precio\": 1.0, \"cantidad\": 1}}',1.00,NULL,'pagado','2026-07-23 22:14:25',0.00),(45,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"82\": {\"imagen\": \"micalum.png\", \"nombre\": \"Microalambre Aluminio ER4043 0.5 kg 0.035\\\"\", \"precio\": 450.0, \"cantidad\": 1}}',450.00,NULL,'pagado','2026-07-23 22:19:08',271.00),(46,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"6\": {\"imagen\": \"tanque.png\", \"nombre\": \"Mezcla Stargold C-25 7.93m3\", \"precio\": 2384.31, \"cantidad\": 1}}',2384.31,NULL,'pagado','2026-07-23 22:24:07',2204.31),(47,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"22\": {\"imagen\": \"solido.png\", \"nombre\": \"Microalambre Sólido ER70S-6 15 kg 0.045\\\"\", \"precio\": 980.0, \"cantidad\": 1}}',980.00,NULL,'pendiente','2026-07-23 22:35:22',800.00),(48,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"7\": {\"imagen\": \"tanque.png\", \"nombre\": \"Acetileno Linde 4.2KG\", \"precio\": 1806.0, \"cantidad\": 1}}',1806.00,NULL,'pagado','2026-07-23 22:37:01',1626.00),(49,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"75\": {\"imagen\": \"micalum.png\", \"nombre\": \"Fundente para Plata Flex Arc\", \"precio\": 1.0, \"cantidad\": 1}}',1.00,NULL,'pagado','2026-07-23 22:47:28',0.00),(50,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',650.00,NULL,'pendiente','2026-07-23 22:50:32',650.00),(51,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',650.00,NULL,'pagado','2026-07-23 22:50:32',650.00),(52,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"18\": {\"imagen\": \"esab.png\", \"nombre\": \"Electrodo E6013 3/32\\\" 10KG\", \"precio\": 1100.0, \"cantidad\": 1}}',1100.00,NULL,'pendiente','2026-07-23 23:00:14',1100.00),(53,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"1\": {\"imagen\": \"tanque.png\", \"nombre\": \"Oxígeno industrial Linde 9.5m3\", \"precio\": 800.0, \"cantidad\": 1}}',800.00,NULL,'pagado','2026-07-23 23:04:24',800.00),(54,1,'Calle hotel 23 #34, Col. los arcos, C.P. 54332, Estado de México','{\"89\": {\"imagen\": \"electrodo308.png\", \"nombre\": \"Electrodo 308 3/32\\\" 5KG\", \"precio\": 1000.0, \"cantidad\": 1}}',1000.00,NULL,'pendiente','2026-08-28 02:29:05',1000.00),(55,1,'Calle cerro #667, Col. hortencias, C.P. 43221, Estado de México','{\"89\": {\"imagen\": \"electrodo308.png\", \"nombre\": \"Electrodo 308 3/32\\\" 5KG\", \"precio\": 1000.0, \"cantidad\": 1}}',1000.00,NULL,'pagado','2026-08-28 02:31:30',1000.00),(56,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Estado de México','{\"43\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" PZA\", \"precio\": 55.0, \"cantidad\": 1}}',55.00,NULL,'pagado','2026-08-28 02:33:13',0.00),(57,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',650.00,NULL,'pagado','2026-08-28 02:34:50',490.00),(58,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"26\": {\"imagen\": \"solido.png\", \"nombre\": \"Microalambre Sólido ER70S-6 1 kg 0.030\\\"\", \"precio\": 250.0, \"cantidad\": 1}}',250.00,NULL,'pagado','2026-09-02 00:03:51',0.00),(59,1,'Calle miasuadi #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"26\": {\"imagen\": \"solido.png\", \"nombre\": \"Microalambre Sólido ER70S-6 1 kg 0.030\\\"\", \"precio\": 250.0, \"cantidad\": 1}}',250.00,NULL,'pagado','2026-09-02 00:21:57',0.00),(60,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"26\": {\"imagen\": \"solido.png\", \"nombre\": \"Microalambre Sólido ER70S-6 1 kg 0.030\\\"\", \"precio\": 250.0, \"cantidad\": 1}}',250.00,NULL,'pagado','2026-09-02 00:25:01',0.00),(61,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',650.00,NULL,'pendiente','2026-09-02 00:29:55',650.00),(62,1,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','{\"47\": {\"imagen\": \"micalum.png\", \"nombre\": \"Varilla de Bronce 1/8\\\" 1KG\", \"precio\": 650.0, \"cantidad\": 1}}',650.00,NULL,'pagado','2026-09-02 00:32:03',650.00);
/*!40000 ALTER TABLE `CheckoutPendiente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Factura`
--

DROP TABLE IF EXISTS `Factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Factura` (
  `id_factura` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `codigo_postal` varchar(5) NOT NULL,
  `regimen_fiscal` varchar(100) NOT NULL,
  `uso_cfdi` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `fecha_factura` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_factura`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `Factura_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Factura`
--

LOCK TABLES `Factura` WRITE;
/*!40000 ALTER TABLE `Factura` DISABLE KEYS */;
INSERT INTO `Factura` VALUES (1,19,'4523453466546','amigos','45434','601','G01','gasemex@gmail.com','2026-07-09 17:20:47');
/*!40000 ALTER TABLE `Factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pago`
--

DROP TABLE IF EXISTS `Pago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pago` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `estado_pago` varchar(30) NOT NULL DEFAULT 'pendiente',
  `metodo_pago` varchar(50) DEFAULT NULL,
  `id_transaccion` varchar(100) DEFAULT NULL,
  `fecha_pago` datetime DEFAULT NULL,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_pedido` (`id_pedido`),
  CONSTRAINT `Pago_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pago`
--

LOCK TABLES `Pago` WRITE;
/*!40000 ALTER TABLE `Pago` DISABLE KEYS */;
INSERT INTO `Pago` VALUES (1,3,'Pendiente','Mercado Pago',NULL,NULL,1400.00),(2,4,'Pendiente','Mercado Pago',NULL,NULL,1400.00),(3,5,'Pendiente','Mercado Pago',NULL,NULL,1400.00),(4,6,'Pendiente','Mercado Pago',NULL,NULL,1400.00),(5,7,'Pendiente','Mercado Pago',NULL,NULL,1400.00),(6,8,'Pendiente','Mercado Pago',NULL,NULL,1400.00),(7,9,'Rechazado','Mercado Pago',NULL,NULL,1400.00),(8,10,'Rechazado','Mercado Pago',NULL,NULL,2600.00),(9,11,'Rechazado','Mercado Pago',NULL,NULL,2600.00),(10,12,'Pendiente','Mercado Pago',NULL,NULL,2600.00),(11,13,'Pendiente','Mercado Pago',NULL,NULL,2600.00),(12,14,'Pendiente','Mercado Pago',NULL,NULL,2600.00),(13,15,'Aprobado','account_money','165935360981','2026-07-02 04:01:57',2450.00),(14,16,'Aprobado','visa','166714189768','2026-07-02 04:07:08',1806.00),(15,17,'Pendiente','Mercado Pago',NULL,NULL,980.00),(16,18,'Aprobado','Mercado Pago',NULL,'2026-07-02 19:16:48',650.00),(17,19,'Aprobado','visa','167022299415','2026-07-08 21:27:35',2600.00),(18,20,'Aprobado','visa','167879922192','2026-07-08 21:55:41',2600.00),(19,21,'Aprobado','account_money','168206473634','2026-07-10 21:12:24',1807.00),(20,22,'Aprobado','Puntos',NULL,'2026-07-23 20:35:34',0.00),(21,23,'Aprobado','Puntos + account_money','169347114481','2026-07-23 20:53:27',608.00),(22,24,'Aprobado','account_money','170228833430','2026-07-23 20:55:28',2400.00),(23,25,'Aprobado','account_money','170230340408','2026-07-23 20:56:30',1400.00),(24,26,'Aprobado','account_money','169345389303','2026-07-23 21:06:58',175.00),(25,27,'Aprobado','account_money','169349181489','2026-07-23 21:13:03',275.00),(26,28,'Aprobado','account_money','170231660042','2026-07-23 21:15:58',275.00),(27,29,'Aprobado','account_money','170236074764','2026-07-23 21:31:53',2450.00),(28,30,'Aprobado','account_money','170236074764','2026-07-23 21:31:53',2450.00),(29,31,'Aprobado','Puntos + account_money','169354506113','2026-07-23 21:33:05',389.00),(30,32,'Aprobado','account_money','169354506113','2026-07-23 21:33:05',450.00),(31,33,'Aprobado','Puntos',NULL,'2026-07-23 22:14:26',0.00),(32,34,'Aprobado','Puntos + account_money','169360967339','2026-07-23 22:19:28',271.00),(33,35,'Aprobado','account_money','169360967339','2026-07-23 22:19:28',450.00),(34,36,'Aprobado','Puntos + account_money','170243705882','2026-07-23 22:24:27',2204.31),(35,37,'Aprobado','account_money','170243705882','2026-07-23 22:24:28',2384.31),(36,38,'Aprobado','Puntos + account_money','169364626883','2026-07-23 22:37:19',1626.00),(37,39,'Aprobado','Puntos',NULL,'2026-07-23 22:47:28',0.00),(38,40,'Aprobado','account_money','169367724425','2026-07-23 22:51:04',650.00),(39,41,'Aprobado','account_money','170250927616','2026-07-23 23:04:41',800.00),(40,42,'Aprobado','account_money','175032205201','2026-08-28 02:31:59',1000.00),(41,43,'Aprobado','Puntos',NULL,'2026-08-28 02:33:14',0.00),(42,44,'Aprobado','Puntos + account_money','175032560667','2026-08-28 02:35:32',490.00),(43,45,'Aprobado','Puntos',NULL,'2026-09-02 00:03:52',0.00),(44,46,'Aprobado','Puntos',NULL,'2026-09-02 00:21:58',0.00),(45,47,'Aprobado','Puntos',NULL,'2026-09-02 00:25:02',0.00),(46,48,'Aprobado','account_money','176790373816','2026-09-02 00:32:23',650.00);
/*!40000 ALTER TABLE `Pago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pedido`
--

DROP TABLE IF EXISTS `Pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pedido` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `fecha_pedido` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `direccion_envio` varchar(255) NOT NULL,
  `estado_pedido` varchar(255) NOT NULL DEFAULT 'Creado',
  `factura` tinyint(1) NOT NULL DEFAULT '0',
  `puntos_usados` int NOT NULL,
  `puntos_generado` int NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `Pedido_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pedido`
--

LOCK TABLES `Pedido` WRITE;
/*!40000 ALTER TABLE `Pedido` DISABLE KEYS */;
INSERT INTO `Pedido` VALUES (3,1,'2026-07-01 23:34:16',1400.00,'Pendiente','Pendiente de pago',0,0,0),(4,1,'2026-07-02 00:33:42',1400.00,'Pendiente','Pendiente de pago',0,0,0),(5,1,'2026-07-02 00:40:24',1400.00,'Pendiente','Pendiente de pago',0,0,0),(6,1,'2026-07-02 00:56:15',1400.00,'Pendiente','Pendiente de pago',0,0,0),(7,1,'2026-07-02 02:52:36',1400.00,'Pendiente','Pendiente de pago',0,0,0),(8,1,'2026-07-02 02:57:16',1400.00,'Pendiente','Pendiente de pago',0,0,0),(9,1,'2026-07-02 03:03:46',1400.00,'Pendiente','Pendiente de pago',0,0,0),(10,1,'2026-07-02 03:29:15',2600.00,'Pendiente','Pendiente de pago',0,0,0),(11,1,'2026-07-02 03:30:18',2600.00,'Pendiente','Pendiente de pago',0,0,0),(12,1,'2026-07-02 03:34:53',2600.00,'Pendiente','Pendiente de pago',0,0,0),(13,1,'2026-07-02 03:37:28',2600.00,'Pendiente','Pendiente de pago',0,0,0),(14,1,'2026-07-02 03:46:12',2600.00,'Pendiente','Pendiente de pago',0,0,0),(15,1,'2026-07-02 03:59:57',2450.00,'Pendiente','En preparación',0,0,0),(16,1,'2026-07-02 04:05:05',1806.00,'Pendiente','En preparación',0,0,0),(17,1,'2026-07-02 04:13:11',980.00,'Pendiente','Pendiente de pago',0,0,0),(18,1,'2026-07-02 19:13:19',650.00,'Pendiente','En preparación',0,0,0),(19,1,'2026-07-08 21:27:33',2600.00,'Calle dfdsfdsfs #234242, Col. dfsdfaf, C.P. 24234, Estado de México','En ruta',1,0,0),(20,1,'2026-07-08 21:55:41',2600.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 21213, Ciudad de México','Entregado',1,0,0),(21,13,'2026-07-10 21:12:24',1807.00,'Calle Hortencia #32, Col. Las flores, C.P. 32546, Estado de México','En preparación',0,0,0),(22,1,'2026-07-23 20:35:33',1.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,1,0),(23,1,'2026-07-23 20:53:26',650.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,42,0),(24,1,'2026-07-23 20:55:27',2400.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,0),(25,1,'2026-07-23 20:56:29',1400.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,0),(26,1,'2026-07-23 21:06:58',175.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,0),(27,1,'2026-07-23 21:13:02',275.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,0),(28,1,'2026-07-23 21:15:57',275.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,0),(29,1,'2026-07-23 21:31:52',2450.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,0),(30,1,'2026-07-23 21:31:52',2450.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,61),(31,1,'2026-07-23 21:33:04',450.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,61,0),(32,1,'2026-07-23 21:33:04',450.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,61,0),(33,1,'2026-07-23 22:14:25',1.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,1,0),(34,1,'2026-07-23 22:19:27',450.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,179,0),(35,1,'2026-07-23 22:19:27',450.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,179,0),(36,1,'2026-07-23 22:24:27',2384.31,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,180,0),(37,1,'2026-07-23 22:24:27',2384.31,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,180,0),(38,1,'2026-07-23 22:37:18',1806.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,180,0),(39,1,'2026-07-23 22:47:28',1.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,1,0),(40,1,'2026-07-23 22:51:04',650.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,13),(41,1,'2026-07-23 23:04:41',800.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En ruta',0,0,16),(42,1,'2026-08-28 02:31:58',1000.00,'Calle cerro #667, Col. hortencias, C.P. 43221, Estado de México','En preparación',0,0,20),(43,1,'2026-08-28 02:33:14',55.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Estado de México','En ruta',0,55,0),(44,1,'2026-08-28 02:35:32',650.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,160,0),(45,1,'2026-09-02 00:03:51',250.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','Entregado',0,250,0),(46,1,'2026-09-02 00:21:57',250.00,'Calle miasuadi #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,250,0),(47,1,'2026-09-02 00:25:01',250.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,250,0),(48,1,'2026-09-02 00:32:22',650.00,'Calle secretaria del trabajo #211, Col. 4 arboles, C.P. 15730, Ciudad de México','En preparación',0,0,13);
/*!40000 ALTER TABLE `Pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Producto`
--

DROP TABLE IF EXISTS `Producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Producto` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(255) NOT NULL,
  `descripcion_producto` varchar(2000) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `imagen` varchar(255) DEFAULT 'default.png',
  `tipo_fk` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_producto`),
  KEY `tipo_fk` (`tipo_fk`),
  CONSTRAINT `tipo_fk` FOREIGN KEY (`tipo_fk`) REFERENCES `Tipo` (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Producto`
--

LOCK TABLES `Producto` WRITE;
/*!40000 ALTER TABLE `Producto` DISABLE KEYS */;
INSERT INTO `Producto` VALUES (1,'Oxígeno industrial Linde 9.5m3','El oxígeno industrial es un gas incoloro, inodoro e insípido con una pureza generalmente superior al 95 %. No es inflamable, pero favorece y acelera la combustión de otros materiales. Es ampliamente utilizado en procesos de soldadura, corte de metales, fabricación de acero, tratamiento de aguas y diversas aplicaciones industriales debido a su capacidad para aumentar la eficiencia de las reacciones de oxidación y combustión.',800.00,1000000,'2026-06-17 15:58:12','tanque.png',1,0),(2,'Electrodo E7018 1/8\" 20KG','El electrodo E7018 de 1/8\" (3.2 mm) es un electrodo revestido de bajo hidrógeno utilizado en soldadura por arco eléctrico (SMAW). Produce cordones de alta resistencia y buena calidad, con baja salpicadura y excelente acabado. Está diseñado para soldar aceros al carbono y de baja aleación, ofreciendo una resistencia mínima a la tracción de 70,000 psi. Puede utilizarse en varias posiciones de soldadura y requiere mantenerse seco para conservar sus propiedades mecánicas y evitar defectos en la unión soldada.',1800.00,1000000,'2026-06-18 23:03:18','esab.png',2,1),(3,'Argon Linde 9.5m3','El argón industrial es un gas inerte, incoloro, inodoro e insípido que no reacciona químicamente con la mayoría de las sustancias. Se obtiene principalmente del aire mediante procesos de separación criogénica y se suministra en cilindros a alta presión o en estado líquido. Es ampliamente utilizado como gas de protección en procesos de soldadura (TIG y MIG), corte de metales, fabricación de componentes electrónicos y otras aplicaciones industriales donde se requiere una atmósfera libre de contaminación y oxidación.',2450.00,1000000,'2026-06-19 18:15:15','tanque.png',1,0),(4,'Oxígeno industrial Linde 6m3','El oxígeno industrial es un gas incoloro, inodoro e insípido con una pureza generalmente superior al 95 %. No es inflamable, pero favorece y acelera la combustión de otros materiales. Es ampliamente utilizado en procesos de soldadura, corte de metales, fabricación de acero, tratamiento de aguas y diversas aplicaciones industriales debido a su capacidad para aumentar la eficiencia de las reacciones de oxidación y combustión.',550.00,1000000,'2026-06-19 18:22:30','tanque.png',1,0),(5,'Nitrógeno Industrial Linde 8.5m3','El nitrógeno industrial es un gas incoloro, inodoro e insípido que constituye aproximadamente el 78 % de la atmósfera terrestre. Es químicamente estable y no inflamable, por lo que se utiliza para crear atmósferas inertes que previenen la oxidación, la combustión y la contaminación de productos. Se emplea ampliamente en las industrias alimentaria, química, electrónica, farmacéutica y metalúrgica, además de utilizarse para purga de tuberías, presurización de sistemas y conservación de materiales.',900.00,1000000,'2026-06-19 18:25:30','tanque.png',1,0),(6,'Mezcla Stargold C-25 7.93m3','La mezcla 75 % argón y 25 % dióxido de carbono (CO₂) es un gas de protección ampliamente utilizado en procesos de soldadura MIG/MAG de aceros al carbono. Combina la estabilidad del arco y la baja generación de salpicaduras que proporciona el argón con la buena penetración y capacidad de fusión que aporta el CO₂. Esta mezcla permite obtener cordones de soldadura de buena calidad, con excelente apariencia, menor proyección de material y un equilibrio adecuado entre penetración y productividad.',2384.31,1000000,'2026-06-19 18:31:06','tanque.png',1,0),(7,'Acetileno Linde 4.2KG','El acetileno industrial (C₂H₂) es un gas incoloro y altamente combustible, conocido por producir una de las llamas más calientes cuando se combina con oxígeno. Se utiliza principalmente en procesos de soldadura, corte y calentamiento de metales mediante equipos oxiacetilénicos. Debido a su alta reactividad e inestabilidad a presiones elevadas, se almacena en cilindros especiales con material poroso y solventes que garantizan su manejo seguro. Su elevada temperatura de combustión lo hace ideal para aplicaciones que requieren un calentamiento rápido y eficiente.',1806.00,1000000,'2026-06-19 18:34:51','tanque.png',1,0),(8,'Bioxido de Carbono Linde 25KG','El dióxido de carbono (CO₂) industrial es un gas incoloro, inodoro y no inflamable que se obtiene como subproducto de diversos procesos industriales. Se utiliza ampliamente en soldadura MIG/MAG como gas de protección, ya que proporciona una buena penetración y favorece la fusión del material base. También se emplea en la industria alimentaria para la carbonatación de bebidas, en sistemas de extinción de incendios, en procesos de refrigeración y en aplicaciones químicas e industriales que requieren control de atmósferas o enfriamiento.',1400.00,1000000,'2026-06-19 18:37:33','tanque.png',1,0),(9,'Bióxido de carbono portátil 9KG','El dióxido de carbono (CO₂) industrial es un gas incoloro, inodoro y no inflamable que se obtiene como subproducto de diversos procesos industriales. Se utiliza ampliamente en soldadura MIG/MAG como gas de protección, ya que proporciona una buena penetración y favorece la fusión del material base. También se emplea en la industria alimentaria para la carbonatación de bebidas, en sistemas de extinción de incendios, en procesos de refrigeración y en aplicaciones químicas e industriales que requieren control de atmósferas o enfriamiento.',900.00,1000000,'2026-06-22 21:50:18','tanque.png',1,0),(10,'Electrodo E7018 5/32\" 20KG','Electrodo de bajo hidrógeno para aceros al carbono y de baja aleación. Alta resistencia mecánica y excelente acabado.',1900.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(11,'Electrodo E7018 3/16\" 20KG','Electrodo de bajo hidrógeno ideal para estructuras y aplicaciones de alta resistencia.',1800.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(12,'Electrodo E7018 3/32\" 18KG','Electrodo de bajo hidrógeno para trabajos de precisión y espesores delgados.',2200.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(13,'Electrodo E6010 1/8\" 20KG','Electrodo de penetración profunda, ideal para tuberías y soldaduras de raíz.',2400.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(14,'Electrodo E6010 5/32\" 20KG','Electrodo celulósico de alta penetración para trabajos industriales exigentes.',2400.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(15,'Electrodo E6010 3/32\" 20KG','Electrodo de penetración profunda adecuado para espesores reducidos.',2600.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(16,'Electrodo E7024 1/8\" 20KG','Electrodo de alta deposición para soldaduras horizontales y planas de alta productividad.',2800.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(17,'Electrodo E6013 1/8\" 10KG','Electrodo de uso general con arco suave y excelente apariencia del cordón.',900.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(18,'Electrodo E6013 3/32\" 10KG','Electrodo versátil para trabajos ligeros y mantenimiento general.',1100.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(19,'Electrodo E6013 5/32\" 10KG','Electrodo de uso general para fabricación y reparación de estructuras metálicas.',900.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(20,'Electrodo E6011 1/8\" 10KG','Electrodo de alta penetración que puede utilizarse en corriente alterna o directa.',1200.00,1000000,'2026-06-22 22:16:35','esab.png',2,1),(21,'Microalambre Sólido ER70S-6 15 kg 0.035\"','Microalambre sólido ER70S-6 para soldadura MIG/MAG, ideal para aceros al carbono. Ofrece excelente estabilidad del arco y baja salpicadura.',980.00,1000000,'2026-06-26 23:13:18','solido.png',2,1),(22,'Microalambre Sólido ER70S-6 15 kg 0.045\"','Microalambre sólido ER70S-6 para aplicaciones industriales que requieren alta deposición y excelente calidad de soldadura.',980.00,1000000,'2026-06-26 23:13:18','solido.png',2,1),(23,'Microalambre Sólido ER70S-6 5 kg 0.035\"','Microalambre sólido ER70S-6 para trabajos de fabricación y mantenimiento con excelente acabado.',650.00,1000000,'2026-06-26 23:13:18','solido.png',2,1),(24,'Microalambre Sólido ER70S-6 5 kg 0.030\"','Microalambre sólido ER70S-6 de diámetro fino, ideal para láminas y espesores reducidos.',650.00,1000000,'2026-06-26 23:13:18','solido.png',2,1),(25,'Microalambre Sólido ER70S-6 1 kg 0.035\"','Microalambre sólido ER70S-6 en presentación de 1 kg para trabajos ligeros y mantenimiento.',250.00,1000000,'2026-06-26 23:13:18','solido.png',2,1),(26,'Microalambre Sólido ER70S-6 1 kg 0.030\"','Microalambre sólido ER70S-6 de diámetro 0.030\", recomendado para soldadura de materiales delgados.',250.00,1000000,'2026-06-26 23:13:18','solido.png',2,1),(27,'Microalambre Tubular E71T-GS 15 kg 0.045\"','Microalambre tubular E71T-GS de alta productividad para aplicaciones industriales.',980.00,1000000,'2026-06-26 23:13:18','tubular.png',2,1),(28,'Microalambre Tubular E71T-GS 15 kg 1/16\"','Microalambre tubular E71T-GS de gran diámetro para altos índices de deposición.',980.00,1000000,'2026-06-26 23:13:18','tubular.png',2,1),(29,'Microalambre Tubular E71T-GS 5 kg 0.035\"','Microalambre tubular autoprotegido para trabajos de fabricación y reparación.',1350.00,1000000,'2026-06-26 23:13:18','tubular.png',2,1),(30,'Microalambre Tubular E71T-GS 5 kg 0.030\"','Microalambre tubular E71T-GS con excelente penetración y buena apariencia del cordón.',1350.00,1000000,'2026-06-26 23:13:18','tubular.png',2,1),(31,'Microalambre Tubular E71T-GS 1 kg 0.035\"','Microalambre tubular autoprotegido en presentación de 1 kg para trabajos ligeros.',350.00,1000000,'2026-06-26 23:13:18','tubular.png',2,1),(32,'Microalambre Tubular E71T-GS 1 kg 0.030\"','Microalambre tubular E71T-GS de 1/16\" para aplicaciones de mayor deposición.',350.00,1000000,'2026-06-26 23:13:18','tubular.png',2,1),(33,'Varilla TIG 309L 1/16\" 1KG','Varilla de aporte de acero inoxidable 309L para soldadura TIG de aceros inoxidables y uniones entre acero inoxidable y acero al carbono.',440.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(34,'Varilla TIG 309L 3/32\" 1KG','Varilla TIG 309L con excelente resistencia a la corrosión y al agrietamiento, ideal para soldaduras disímiles.',480.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(35,'Varilla TIG 309L 1/8\" 1KG','Varilla de aporte 309L para aplicaciones industriales que requieren unir aceros inoxidables con aceros al carbono o de baja aleación.',500.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(36,'Varilla TIG 308L 3/32\" 1KG','Varilla de aporte de acero inoxidable 308L con excelente resistencia a la corrosión.',380.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(37,'Varilla TIG 308L 1/8\" 1KG','Varilla TIG 308L para aplicaciones industriales y fabricación de acero inoxidable.',415.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(38,'Varilla TIG 316L 1/16\" 1KG','Varilla de aporte de acero inoxidable 316L con alta resistencia a la corrosión y ambientes agresivos.',440.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(39,'Varilla TIG 316L 3/32\" 1KG','Varilla TIG 316L ideal para soldar aceros inoxidables tipo 316 y 316L.',480.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(40,'Varilla TIG 316L 1/8\" 1KG','Varilla de aporte para soldaduras de alta calidad en acero inoxidable.',500.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(41,'Varilla TIG 4043 3/32\" 1KG','Varilla de aluminio ER4043 con excelente fluidez y acabado.',550.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(42,'Varilla TIG 4043 1/8\" 1KG','Varilla ER4043 para reparación y fabricación de componentes de aluminio.',550.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(43,'Varilla de Bronce 1/8\" PZA','Varilla de bronce para soldadura fuerte y reparación de piezas metálicas.',55.00,1000000,'2026-06-30 16:43:22','micalum.png',2,0),(44,'Varilla de Bronce 3/32\" PZA','Varilla de bronce para aplicaciones de soldadura y recubrimiento.',50.00,1000000,'2026-06-30 16:43:22','micalum.png',2,0),(45,'Varilla de Bronce con Fundente 1/8\" PZA','Varilla de bronce con fundente incorporado para facilitar la soldadura fuerte.',1.00,1000000,'2026-06-30 16:43:22','micalum.png',2,0),(46,'Varilla de Bronce con Fundente 3/32\" PZA','Varilla de bronce con fundente para uniones limpias y de excelente calidad.',1.00,1000000,'2026-06-30 16:43:22','micalum.png',2,0),(47,'Varilla de Bronce 1/8\" 1KG','Varilla de bronce para soldadura fuerte y reparación de piezas metálicas.',650.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(48,'Varilla de Bronce 3/32\" 1KG','Varilla de bronce para aplicaciones de soldadura y recubrimiento.',650.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(49,'Varilla de Bronce con Fundente 1/8\" 1KG','Varilla de bronce con fundente incorporado para facilitar la soldadura fuerte.',0.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(50,'Varilla de Bronce con Fundente 3/32\" 1KG','Varilla de bronce con fundente para uniones limpias y de excelente calidad.',0.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(51,'Varilla de Plata 35% 1/16\" PZA','Varilla de aporte con 35% de plata para soldadura fuerte de cobre, acero e inoxidables.',200.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(52,'Varilla Phoscopper 1/16\" PZA','Varilla de fósforo-cobre para soldadura fuerte de cobre y sus aleaciones sin necesidad de fundente en uniones cobre-cobre.',30.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(53,'Varilla TIG ER70S-6 1/16\" 1KG','Varilla de aporte ER70S-6 para soldadura TIG de aceros al carbono. Proporciona excelente estabilidad del arco y soldaduras de alta calidad.',150.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(54,'Varilla TIG ER70S-6 3/32\" 1KG','Varilla de aporte ER70S-6 ideal para fabricación, mantenimiento y reparación de estructuras de acero al carbono.',150.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(55,'Varilla TIG ER70S-6 1/8\" 1KG','Varilla TIG ER70S-6 de alta resistencia para soldadura de aceros al carbono con excelente acabado y mínima porosidad.',150.00,1000000,'2026-06-30 16:43:22','micalum.png',2,1),(56,'Tungsteno 2% Torio 1/16\" PZA','Electrodo de tungsteno con 2% de torio, ideal para soldadura TIG en corriente directa (DC), con excelente capacidad de encendido y estabilidad del arco.',175.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(57,'Tungsteno 2% Torio 3/32\" PZA','Electrodo de tungsteno 2% torio para aplicaciones de alta precisión y excelente duración.',225.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(58,'Tungsteno 2% Torio 1/8\" PZA','Electrodo de tungsteno 2% torio recomendado para soldadura TIG de aceros al carbono e inoxidables.',275.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(59,'Tungsteno Puro 1/16\" PZA','Electrodo de tungsteno puro para soldadura TIG en corriente alterna (AC), especialmente en aluminio y magnesio.',175.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(60,'Tungsteno Puro 3/32\" PZA','Electrodo de tungsteno puro con excelente desempeño en aplicaciones AC.',225.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(61,'Tungsteno Puro 1/8\" PZA','Electrodo de tungsteno puro para soldadura TIG de aluminio y sus aleaciones.',275.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(62,'Tungsteno 2% Cerio 1/16\" PZA','Electrodo de tungsteno con 2% de cerio, excelente para aplicaciones TIG en AC y DC con fácil encendido.',175.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(63,'Tungsteno 2% Cerio 3/32\" PZA','Electrodo de tungsteno 2% cerio de larga vida útil y arco estable.',225.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(64,'Tungsteno 2% Cerio 1/8\" PZA','Electrodo de tungsteno 2% cerio recomendado para soldadura TIG de precisión.',275.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(65,'Tungsteno 1.5% Lantano 1/16\" PZA','Electrodo de tungsteno con 1.5% de lantano, ideal para soldadura TIG en AC y DC con excelente estabilidad del arco.',175.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(66,'Tungsteno 1.5% Lantano 3/32\" PZA','Electrodo de tungsteno 1.5% lantano con gran capacidad de encendido y larga duración.',225.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(67,'Tungsteno 1.5% Lantano 1/8\" PZA','Electrodo de tungsteno 1.5% lantano para aplicaciones industriales de alto rendimiento.',275.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(68,'Tungsteno 3 Tierras 1/16\" PZA','Electrodo de tungsteno con mezcla de tierras raras, ofrece excelente encendido, estabilidad del arco y larga vida útil en AC y DC.',175.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(69,'Tungsteno 3 Tierras 3/32\" PZA','Electrodo de tungsteno de tierras raras para aplicaciones TIG de alta productividad.',225.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(70,'Tungsteno 3 Tierras 1/8\" PZA','Electrodo de tungsteno 3 tierras con excelente resistencia al desgaste y desempeño en AC y DC.',275.00,1000000,'2026-06-30 17:04:25','micalum.png',2,1),(71,'Desmoldante Weld 500','Desmoldante y protector para procesos de soldadura que evita la adherencia de salpicaduras sobre las superficies de trabajo.',190.00,1000000,'2026-06-30 17:14:21','micalum.png',2,1),(72,'Fundente para Aluminio Harris 200 g','Fundente en pasta para soldadura fuerte de aluminio y sus aleaciones. Favorece la limpieza y mejora la humectación del material de aporte.',900.00,1000000,'2026-06-30 17:14:21','fundharris.png',2,1),(73,'Fundente para Plata Harris','Fundente para soldadura fuerte con aleaciones de plata. Facilita el flujo del material de aporte y reduce la oxidación durante el calentamiento.',350.00,1000000,'2026-06-30 17:14:21','plataharris.png',2,1),(74,'Fundente para Aluminio Flex Arc 100 g','Fundente para soldadura fuerte de aluminio, diseñado para mejorar la adherencia y la calidad de la unión.',450.00,1000000,'2026-06-30 17:14:21','fundarc.png',2,1),(75,'Fundente para Plata Flex Arc','Fundente para aplicaciones de soldadura fuerte con aleaciones de plata, proporcionando uniones limpias y de alta calidad.',245.00,1000000,'2026-06-30 17:14:21','micalum.png',2,1),(76,'Fundente para Bronce PV700','Fundente para soldadura fuerte con varillas de bronce. Ayuda a eliminar óxidos y mejora la calidad de la unión.',285.00,1000000,'2026-06-30 17:14:21','pv700.png',2,1),(77,'Líquido Revelador','Revelador para inspección por líquidos penetrantes. Permite visualizar discontinuidades superficiales después de aplicar el penetrante.',325.00,1000000,'2026-06-30 17:14:21','revelador.png',2,1),(78,'Líquido Limpiador','Limpiador para sistemas de inspección por líquidos penetrantes. Elimina residuos antes y después del proceso de inspección.',325.00,1000000,'2026-06-30 17:14:21','limpiador.png',2,1),(79,'Líquido Penetrante','Penetrante de alta sensibilidad para la detección de grietas y defectos superficiales mediante ensayos no destructivos.',325.00,1000000,'2026-06-30 17:14:21','penetrante.png',2,1),(80,'Gel Antisalpicaduras Weld500','Gel protector que evita la adherencia de salpicaduras durante procesos de soldadura, prolongando la vida útil de boquillas y herramientas.',190.00,1000000,'2026-06-30 17:14:21','micalum.png',2,1),(81,'Decapante UTP Gel 2 L','Gel decapante para limpieza y pasivado de cordones de soldadura en acero inoxidable, eliminando óxidos y decoloraciones superficiales.',980.00,1000000,'2026-06-30 17:14:21','micalum.png',2,1),(82,'Microalambre Aluminio ER4043 0.5 kg 0.035\"','Microalambre de aluminio ER4043 para soldadura MIG de aleaciones de aluminio. Ofrece excelente fluidez, baja generación de salpicaduras y un acabado uniforme, siendo ideal para aplicaciones en la industria automotriz, fabricación y reparación de componentes de aluminio.',450.00,1000000,'2026-07-10 20:30:18','micalum.png',2,1),(83,'Electrodo E9018 1/8\" 20kg','Electrodo revestido de bajo hidrógeno para soldadura de aceros de alta resistencia. Ofrece excelentes propiedades mecánicas y buena resistencia al agrietamiento.',4600.00,1000000,'2026-08-27 23:27:52','esab.png',2,1),(84,'Electrodo E9018 5/32\" 20KG','Electrodo revestido de bajo hidrógeno para aplicaciones que requieren alta resistencia y excelente calidad de soldadura.',4600.00,1000000,'2026-08-27 23:27:52','esab.png',2,1),(85,'Microalambre 308L 15 kg 0.045\"','Microalambre de acero inoxidable 308L para soldadura MIG de aceros inoxidables. Proporciona excelente resistencia a la corrosión y buena estabilidad del arco.',5133.00,1000000,'2026-08-27 23:27:52','IMG_2631.jpeg',2,1),(86,'Microalambre 316L 15 kg 0.045\"','Microalambre de acero inoxidable 316L para soldadura MIG. Ideal para aplicaciones que requieren alta resistencia a la corrosión y excelente calidad de unión.',6873.00,1000000,'2026-08-27 23:27:52','mic316.png',2,1),(87,'Microalambre de Aluminio 4043 7.27 KG 3/64\"','Microalambre de aluminio ER4043 para soldadura MIG. Ofrece buena fluidez, excelente acabado y es adecuado para diversas aleaciones de aluminio.',3350.00,1000000,'2026-08-27 23:27:52','micalum15.png',2,1),(88,'Spray Antisalpicaduras de Cerámica','Spray cerámico antisalpicaduras que protege boquillas, puntas de contacto y superficies cercanas al área de soldadura contra la adherencia de salpicaduras.',260.00,1000000,'2026-08-27 23:27:52','ceramica.png',2,1),(89,'Electrodo 308L 3/32\" 1KG','Electrodo revestido de acero inoxidable 308 para soldadura de aceros inoxidables. Proporciona buena resistencia a la corrosión y excelente acabado.',415.00,1000000,'2026-08-27 23:27:52','electrodo308.png',2,1),(90,'Electrodo 308L 1/8\" 1KG','Electrodo revestido de acero inoxidable 308 para fabricación, mantenimiento y reparación de estructuras de acero inoxidable.',380.00,1000000,'2026-08-27 23:27:52','electrodo308.png',2,1),(91,'Electrodo 309L 3/32\" 1KG','Electrodo revestido de acero inoxidable 309 para soldaduras entre acero inoxidable y acero al carbono, así como aplicaciones de alta temperatura.',485.00,1000000,'2026-08-27 23:27:52','electrodo309.png',2,1),(92,'Electrodo 309L 1/8\" 1KG','Electrodo revestido 309 para uniones de metales disímiles y aplicaciones que requieren buena resistencia a la oxidación.',465.00,1000000,'2026-08-27 23:27:52','electrodo309.png',2,1),(93,'Electrodo 316L 3/32\" 1KG','Electrodo revestido de acero inoxidable 316 con excelente resistencia a la corrosión, recomendado para ambientes agresivos.',465.00,1000000,'2026-08-27 23:27:52','316electrodo.png',2,1),(94,'Electrodo 316L 1/8\" 1KG','Electrodo revestido 316 para soldadura de aceros inoxidables en aplicaciones industriales y de alta resistencia a la corrosión.',440.00,1000000,'2026-08-27 23:27:52','316electrodo.png',2,1),(95,'Electrodo de Aluminio Sureweld 34 4043 1KG','Electrodo revestido para soldadura y reparación de aluminio y sus aleaciones. Permite realizar reparaciones en piezas y componentes de aluminio.',1600.00,1000000,'2026-08-27 23:27:52','electrodoalum.png',2,1),(96,'Electrodo Hierro Colado Maquinable NI-ARC 99 1KG','Electrodo de níquel para reparación de hierro colado, diseñado para producir depósitos maquinables y facilitar trabajos de mantenimiento y reparación.',2300.00,1000000,'2026-08-27 23:27:52','niarc99.png',2,1),(97,'Electrodo UTP 65 1/8\" KG','Electrodo especial para reparación y unión de hierro colado y materiales de difícil soldabilidad, ofreciendo depósitos de alta resistencia.',950.00,1000000,'2026-08-27 23:27:52','utp65.png',2,1),(98,'Electrodo DUR 600 1/8\" 1KG','Electrodo de revestimiento duro para proteger superficies sometidas a desgaste, abrasión e impacto.',315.00,1000000,'2026-08-27 23:27:52','dur600.png',2,1),(99,'Electrodo UTP 68 H 1KG','Electrodo especial para aplicaciones de reparación y mantenimiento que requieren depósitos resistentes al desgaste y a condiciones de trabajo exigentes.',315.00,1000000,'2026-08-27 23:27:52','68h.png',2,1),(100,'Electrodo Chamfer ESAB 1/8\" 1KG','Electrodo de ranurado y biselado para preparación de juntas, remoción de material y trabajos de mantenimiento industrial.',340.00,1000000,'2026-08-27 23:27:52','esab.png',2,1),(101,'Electrodo bronsomatic A 1/8\" 1KG','Electrodo de bronce para soldadura de cobre y sus aleaciones. Proporciona uniones fuertes y resistentes a la corrosión.',2500.00,1000000,'2026-08-31 04:04:36','bronsomatic.png',2,1);
/*!40000 ALTER TABLE `Producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reparacion`
--

DROP TABLE IF EXISTS `Reparacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reparacion` (
  `id_reparacion` int NOT NULL AUTO_INCREMENT,
  `fecha_reparacion` date DEFAULT NULL,
  `nombre_reparacion` varchar(255) NOT NULL,
  `estado_reparacion` varchar(255) NOT NULL,
  `cotizacion` varchar(255) DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `descripcion_reparacion` varchar(255) NOT NULL DEFAULT 'Sin descripción',
  PRIMARY KEY (`id_reparacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `Reparacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reparacion`
--

LOCK TABLES `Reparacion` WRITE;
/*!40000 ALTER TABLE `Reparacion` DISABLE KEYS */;
INSERT INTO `Reparacion` VALUES (1,'2026-07-09','regulador harris oxigeno','En revisión',NULL,1,'x<xzdjsdfsf'),(2,'2026-07-09','regulador harris oxigeno','Recibido',NULL,1,'x<xzdjsdfsf'),(3,'2026-07-10','Soplete Smith But','En revisión',NULL,13,'Fuga en tuerca');
/*!40000 ALTER TABLE `Reparacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tipo`
--

DROP TABLE IF EXISTS `Tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tipo` (
  `id_tipo` int NOT NULL AUTO_INCREMENT,
  `nombre_tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tipo`
--

LOCK TABLES `Tipo` WRITE;
/*!40000 ALTER TABLE `Tipo` DISABLE KEYS */;
INSERT INTO `Tipo` VALUES (1,'Gases'),(2,'Soldaduras'),(3,'Consumibles'),(4,'Accesorios'),(5,'Seguridad'),(6,'Abrasivos'),(7,'Equipos'),(8,'Plasma'),(9,'Medicinal');
/*!40000 ALTER TABLE `Tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(255) NOT NULL,
  `nombre_usuario` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `contrasena_usuario` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `puntos` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES (1,'cliente','fer','ferorybon7@hotmail.com','5513506906','scrypt:32768:8:1$uH7IlseoMozY3cxw$5ca96f479b4f97658d2ea11f56d14ecc14b3815d1ecfbbdc3dc685f54b7ac9b1df2421059983cc2e6fe03eb7bd13045f6e046b1d810b3ce07eed4ab64e016e10','2026-06-06 20:57:09',1595),(2,'cliente','fer1','ferorybon6@hotmail.com','5513506907','scrypt:32768:8:1$IqpJNuSYxpOTx9RF$e79fdcadcab5f9c57172c15a4c3c55752945845a7488e769a7cf7bfc27fda5861367362950b0896e160ca6521697c4b6ed03c28c8484836b96ff4955ff6a7937','2026-06-06 20:59:13',180),(3,'cliente','fer2','ferorybon5@hotmail.com','5513506907','scrypt:32768:8:1$kJoYFFD9j2ITUAI3$51e961d5362afcd711a5f918d87ce2273daf6e18f4d4447f4a4c910592be02dfd54a1ddea18c855738572fdfd50babd2a9771a23a453db99cc631dc0fe21db3a','2026-06-06 21:00:09',180),(4,'cliente','fer3','ferorybon4@hotmail.com','5513506907','scrypt:32768:8:1$DZDVDejnAEMSMI9M$561718e332eff173ed263dad866437ed5311e7e18bdb463ac518349a575c9abec274455ccdf863c7fd797b47ac971f99ba9bf82a57713d5314ede1309ae9f4d1','2026-06-06 21:01:07',180),(5,'cliente','fer4','ferorybon3@hotmail.com','5513506907','scrypt:32768:8:1$5hvNSM2gz5oweYFc$f80374c0356df945730b50264bfa58d22236493c76ffb59353924fc5a7d49059d601a7de78dac54cfc1b5dec400912d667a8a0fe8571328b4f98989b9dc6083f','2026-06-06 21:10:14',180),(6,'cliente','gato','ferorybon9@hotmail.com','5513506907','scrypt:32768:8:1$sLKjPa93GTLYMkfo$c4d40d1869898ac0cacc4176c96244c0cc73b65c8598d4d0f98c194c88dbbb119ce153d4a0dd20c3e7fe3cd247ba74399011d457ebf38b8583adc6ca0bd4ad8e','2026-06-15 19:09:22',180),(11,'admin','admin1','admin@gasemex.com','1234567890','scrypt:32768:8:1$PgIkwMrH9SpSwDt1$a1975ec5a83f55745946eeb1b18c265962457f80a458c56dfe10c4b6da7c48afe5a2562edaaaace3ba7b57374d7dffeac468612bfcf4d6c1ec22b70b91343ea0','2026-07-09 20:39:22',180),(12,'admin','admin1','admin@gasemex.com','1234567890','scrypt:32768:8:1$2fuAstlL4wRosCcF$b04fef959e45054308448d7c77cd925d3d21d1e6b9ba6477f930d717d56675800ae557902566b65baaf876c35d06e521d8d3db976400e474a0e140d7a2d0d59d','2026-07-09 20:39:23',180),(13,'cliente','Ramirez Zacarias Ederik Ernesto','ernestogasemex@gmail.com','5561368743','scrypt:32768:8:1$VsZnRiDDZdLFJSjX$ec7b03f06fecfe164ccaf8b5b50e9c7f40be0c9e7a91c13fa8c580bf512a07e5bb03df3ece447015e8b711bc14e7495cbc5b8993832a01bbbb6982d92602e3c5','2026-07-10 20:45:18',180),(14,'cliente','fer023','fer@kiko.com','4534958439','scrypt:32768:8:1$I0FQWQMZ4yrNSZgu$4834ed8dc097630c6d5c92c35cf44b61e74056b684fb924090733cf22556e0a655f3aeabdaca70da956144a31f98b76605893b73610cccc77a8444ed17a90925','2026-08-27 20:33:36',0),(15,'cliente','toby','tobo@sasll.com','3334343233','scrypt:32768:8:1$0xtzAZlvVCX4YjSy$dcc3381c371951061ffdc81d7873a293b04f843c53381edf89079458b047fc3392cfb8c2ed436e5ab5ce2b0469dcc48b6ddab05aa52606262e1d1cd32aded238','2026-08-28 03:15:15',0);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_precios`
--

DROP TABLE IF EXISTS `historico_precios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_precios` (
  `id_historico` int NOT NULL AUTO_INCREMENT,
  `id_producto` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `fecha_cambio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historico`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `historico_precios_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `Producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_precios`
--

LOCK TABLES `historico_precios` WRITE;
/*!40000 ALTER TABLE `historico_precios` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_precios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_pedido`
--

DROP TABLE IF EXISTS `producto_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto_pedido` (
  `id_pedido` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_pedido`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `producto_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`),
  CONSTRAINT `producto_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `Producto` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_pedido`
--

LOCK TABLES `producto_pedido` WRITE;
/*!40000 ALTER TABLE `producto_pedido` DISABLE KEYS */;
INSERT INTO `producto_pedido` VALUES (3,47,1,650.00),(3,49,1,750.00),(4,47,1,650.00),(4,49,1,750.00),(5,47,1,650.00),(5,49,1,750.00),(6,47,1,650.00),(6,49,1,750.00),(7,47,1,650.00),(7,49,1,750.00),(8,47,1,650.00),(8,49,1,750.00),(9,47,1,650.00),(9,49,1,750.00),(10,15,1,2600.00),(11,15,1,2600.00),(12,15,1,2600.00),(13,15,1,2600.00),(14,15,1,2600.00),(15,3,1,2450.00),(16,7,1,1806.00),(17,22,1,980.00),(18,47,1,650.00),(19,15,1,2600.00),(20,15,1,2600.00),(21,7,1,1806.00),(21,74,1,1.00),(22,74,1,1.00),(23,47,1,650.00),(24,13,1,2400.00),(25,8,1,1400.00),(26,65,1,175.00),(27,67,1,275.00),(28,64,1,275.00),(29,3,1,2450.00),(30,3,1,2450.00),(31,82,1,450.00),(32,82,1,450.00),(33,76,1,1.00),(34,82,1,450.00),(35,82,1,450.00),(36,6,1,2384.31),(37,6,1,2384.31),(38,7,1,1806.00),(39,75,1,1.00),(40,47,1,650.00),(41,1,1,800.00),(42,89,1,1000.00),(43,43,1,55.00),(44,47,1,650.00),(45,26,1,250.00),(46,26,1,250.00),(47,26,1,250.00),(48,47,1,650.00);
/*!40000 ALTER TABLE `producto_pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-01 21:05:04
