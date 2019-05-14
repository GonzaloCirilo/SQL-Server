USE MASTER
GO
DROP DATABASE IF EXISTS [cAS];

CREATE DATABASE [cAS]
GO
GO
USE [cAS]
Go

DROP TABLE IF EXISTS [user_apply];
DROP TABLE IF EXISTS [audit];
DROP TABLE IF EXISTS [user_roles]

DROP TABLE IF EXISTS [role]

DROP TABLE IF EXISTS [job_offer];

DROP TABLE IF EXISTS [work_reference];
DROP TABLE IF EXISTS [course];
DROP TABLE IF EXISTS [background_experience];
DROP TABLE IF EXISTS [knowledge];
DROP TABLE IF EXISTS [degree];

DROP TABLE IF EXISTS [users];

DROP TABLE IF EXISTS [disability_type];
DROP TABLE IF EXISTS [tuition];
DROP TABLE IF EXISTS [district];
DROP TABLE IF EXISTS [province];
DROP TABLE IF EXISTS [department];
DROP TABLE IF EXISTS [document_type];
DROP TABLE IF EXISTS [driving_category];
DROP TABLE IF EXISTS [driving_clASs];

CREATE TABLE tuition (
  [id] INT NOT NULL IDENTITY,
  [school_name] VARCHAR(255) DEFAULT NULL,
  [register_number] VARCHAR(255) DEFAULT NULL,
  [document_path] VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ([id])
)   ;

CREATE TABLE driving_clASs (
  [id] INT NOT NULL,
  [name] VARCHAR(200) DEFAULT NULL,
  PRIMARY KEY ([id])
)   ;

CREATE TABLE driving_category (
  [id] INT NOT NULL,
  [name] VARCHAR(100) DEFAULT NULL,
  [driving_clASs_id] INT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [driving_category_driving_clASs] FOREIGN KEY ([driving_clASs_id]) REFERENCES driving_clASs ([id])
)   ;

CREATE INDEX [i_driving_category_driving_clASs] ON driving_category ([driving_clASs_id]);

CREATE TABLE document_type (
  [id] INT NOT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ([id])
)   ;


CREATE TABLE department (
  [id] INT NOT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ([id])
)   ;

CREATE TABLE province (
  [id] INT NOT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  [department_id] INT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [province_department] FOREIGN KEY ([department_id]) REFERENCES department ([id])
)   ;

CREATE INDEX [i_province_department] ON province ([department_id]);

CREATE TABLE district (
  [id] INT NOT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  [province_id] INT DEFAULT NULL,
  [ubigeo] VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [district_province] FOREIGN KEY ([province_id]) REFERENCES province ([id])
)   ;

CREATE INDEX [i_district_province] ON district ([province_id]);

CREATE TABLE disability_type (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ([id])
)  ;

CREATE TABLE [users] (
  [id] BIGINT NOT NULL,
  [pASsword] VARBINARY(MAX) NOT NULL,
  [document_number] VARCHAR(255) DEFAULT NULL,
  [email] VARCHAR(255) DEFAULT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  [lASt_name] VARCHAR(255) DEFAULT NULL,
  [sur_name] VARCHAR(255) DEFAULT NULL,
  [gender] VARCHAR(255) DEFAULT NULL,
  [telephone] VARCHAR(255) DEFAULT NULL,
  [cellphone] VARCHAR(255) DEFAULT NULL,
  [birthdate] DATE DEFAULT NULL,
  [nationality] VARCHAR(255) DEFAULT NULL,
  [home_address] VARCHAR(255) DEFAULT NULL,
  [home_district_id] INT DEFAULT NULL,
  [birthplace_district_id] INT DEFAULT NULL,
  [document_type_id] INT DEFAULT NULL,
  [disability_document_path] VARCHAR(255) DEFAULT NULL,
  [armed_forces_document_path] VARCHAR(255) DEFAULT NULL,
  [driving_license_document_path] VARCHAR(255) DEFAULT NULL,
  [tuition_id] INT DEFAULT NULL,
  [driving_category_id] INT DEFAULT NULL,
  [disability_type_id] INT DEFAULT NULL,
  [username] VARCHAR(70) NOT NULL,
  [hAS_disability] INT DEFAULT NULL,
  [belongs_to_army] INT DEFAULT NULL,
  [drives] INT DEFAULT NULL,
  [driving_number] VARCHAR(25) DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_disability_type] FOREIGN KEY ([disability_type_id]) REFERENCES disability_type ([id]),
  CONSTRAINT [user_district_birthdate] FOREIGN KEY ([birthplace_district_id]) REFERENCES district ([id]),
  CONSTRAINT [user_district_home] FOREIGN KEY ([home_district_id]) REFERENCES district ([id]),
  CONSTRAINT [user_document_type] FOREIGN KEY ([document_type_id]) REFERENCES document_type ([id]),
  CONSTRAINT [user_driving_category] FOREIGN KEY ([driving_category_id]) REFERENCES driving_category ([id]),
  CONSTRAINT [user_tuition] FOREIGN KEY ([tuition_id]) REFERENCES tuition ([id])
)   ;

CREATE INDEX [user_disability_type] ON [users] ([disability_type_id]);
CREATE INDEX [user_district_home] ON [users] ([home_district_id]);
CREATE INDEX [user_document_type] ON [users] ([document_type_id]);
CREATE INDEX [user_driving_category] ON [users] ([driving_category_id]);
CREATE INDEX [user_tuition] ON [users] ([tuition_id]);
CREATE INDEX [user_district_birthdate] ON [users] ([birthplace_district_id]);

CREATE TABLE [audit] (
  [id] BIGINT NOT NULL IDENTITY,
  [user_id] BIGINT DEFAULT NULL,
  [table_type] INT DEFAULT NULL,
  [created_at] DATETIME2(0) DEFAULT NULL,
  [action] VARCHAR(MAX),
  [row_id] INT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [users_fk] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)  ;

CREATE INDEX [user_idxa] ON [audit] ([user_id]);


CREATE TABLE background_experience (
  [id] INT NOT NULL IDENTITY,
  [company_name] VARCHAR(255) DEFAULT NULL,
  [position] VARCHAR(255) DEFAULT NULL,
  [starting_date] DATE DEFAULT NULL,
  [conclusion_date] DATE DEFAULT NULL,
  [document_path] VARCHAR(255) DEFAULT NULL,
  [specifics] VARCHAR(55) DEFAULT NULL,
  [user_id] BIGINT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_background_experience] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)  ;

CREATE INDEX [user_background_experience] ON background_experience ([user_id]);

CREATE TABLE course (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(255) DEFAULT NULL,
  [starting_date] DATE DEFAULT NULL,
  [conclusion_date] DATE DEFAULT NULL,
  [completed_hours] INT DEFAULT NULL,
  [document_path] VARCHAR(255) DEFAULT NULL,
  [user_id] BIGINT DEFAULT NULL,
  [institution] VARCHAR(255) DEFAULT NULL,
  [location] VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_course] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)   ;

CREATE INDEX [user_course] ON course ([user_id]);

CREATE TABLE degree (
  [id] INT NOT NULL IDENTITY,
  [institute_name] VARCHAR(255) DEFAULT NULL,
  [country] VARCHAR(255) DEFAULT NULL,
  [document_path] VARCHAR(255) DEFAULT NULL,
  [institute_type] VARCHAR(255) DEFAULT NULL,
  [issue_date] DATE DEFAULT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  [degree_type] VARCHAR(255) DEFAULT NULL,
  [user_id] BIGINT DEFAULT NULL,
  [from_sunedu] VARCHAR(4) DEFAULT NULL,
  [starting_date] VARCHAR(10) DEFAULT NULL,
  [conclusion_date] VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_studies] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)   ;

CREATE INDEX [i_user_studies] ON degree ([user_id]);


CREATE TABLE job_offer (
  [id] INT NOT NULL IDENTITY,
  [description] VARCHAR(MAX),
  [requirements_doc_path] VARCHAR(255) DEFAULT NULL,
  [first_stage_doc_path] VARCHAR(255) DEFAULT NULL,
  [second_stage_doc_path] VARCHAR(255) DEFAULT NULL,
  [third_stage_doc_path] VARCHAR(255) DEFAULT NULL,
  [observation] VARCHAR(255) DEFAULT NULL,
  [published_at] DATE DEFAULT NULL,
  [name] VARCHAR(255) DEFAULT NULL,
  [from_date] DATE DEFAULT NULL,
  [to_date] DATE DEFAULT NULL,
  [dj_conv_path] VARCHAR(255) DEFAULT NULL,
  [status_job] INT DEFAULT '1',
  [erratum_path] VARCHAR(255) DEFAULT NULL,
  [fs_starting_date] DATE DEFAULT NULL,
  [fs_conclusion_date] DATE DEFAULT NULL,
  [ss_starting_date] DATE DEFAULT NULL,
  [ss_conclusion_date] DATE DEFAULT NULL,
  [ts_starting_date] DATE DEFAULT NULL,
  [ts_conclusion_date] DATE DEFAULT NULL,
  PRIMARY KEY ([id])
)   ;

CREATE TABLE knowledge (
  [id] INT NOT NULL IDENTITY,
  [name] VARCHAR(255) DEFAULT NULL,
  [user_id] BIGINT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_knowledge] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)   ;

CREATE INDEX [user_knowledge] ON knowledge ([user_id]);


CREATE TABLE [role] (
  [id] INT NOT NULL,
  [name] VARCHAR(255) NOT NULL,
  PRIMARY KEY ([id])
)   ;

CREATE TABLE work_reference (
  [id] BIGINT NOT NULL IDENTITY,
  [company_name] VARCHAR(255) DEFAULT NULL,
  [reference_position] VARCHAR(255) DEFAULT NULL,
  [reference_name] VARCHAR(255) DEFAULT NULL,
  [phone] VARCHAR(15) DEFAULT NULL,
  [user_id] BIGINT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_work_references] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)   ;

CREATE INDEX [user_work_references_idx] ON work_reference ([user_id]);

CREATE TABLE user_apply (
  [id] INT NOT NULL IDENTITY,
  [job_offer_id] INT DEFAULT NULL,
  [user_id] BIGINT DEFAULT NULL,
  [dj_cons_path] VARCHAR(255) DEFAULT NULL,
  [dj_conv_path] VARCHAR(255) DEFAULT NULL,
  [cv_path] VARCHAR(255) DEFAULT NULL,
  [status] INT DEFAULT NULL,
  [application_date] DATE DEFAULT NULL,
  [dj_cons_review] INT DEFAULT NULL,
  [dj_conv_review] INT DEFAULT NULL,
  [cv_review] INT DEFAULT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_apply_job_offer] FOREIGN KEY ([job_offer_id]) REFERENCES job_offer ([id]),
  CONSTRAINT [user_apply_user] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)   ;

CREATE INDEX [user_apply_job_offer] ON user_apply ([job_offer_id]);
CREATE INDEX [user_apply_user] ON user_apply ([user_id]);


CREATE TABLE user_roles (
  [id] INT NOT NULL,
  [user_id] BIGINT NOT NULL,
  [role_id] INT NOT NULL,
  PRIMARY KEY ([id])
 ,
  CONSTRAINT [user_roles_role] FOREIGN KEY ([role_id]) REFERENCES [role] ([id]),
  CONSTRAINT [user_roles_user] FOREIGN KEY ([user_id]) REFERENCES [users] ([id])
)   ;

CREATE INDEX [user_roles_role] ON user_roles ([role_id]);
CREATE INDEX [user_roles_user] ON user_roles ([user_id]);

INSERT INTO department VALUES (1,'AMAZONAS'),(2,'ANCASH'),(3,'APURIMAC'),(4,'AREQUIPA'),(5,'AYACUCHO'),(6,'CAJAMARCA'),(7,'CALLAO'),(8,'CUSCO'),(9,'HUANCAVELICA'),(10,'HUANUCO'),(11,'HUANUCO '),(12,'ICA'),(13,'JUNIN'),(14,'LA LIBERTAD'),(15,'LAMBAYEQUE'),(16,'LIMA'),(17,'LORETO'),(18,'MADRE DE DIOS'),(19,'MOQUEGUA'),(20,'PASCO'),(21,'PIURA'),(22,'PUNO'),(23,'SAN MARTIN'),(24,'TACNA'),(25,'TUMBES'),(26,'UCAYALI');

INSERT INTO province VALUES (1,'CHACHAPOYAS',1),(2,'BAGUA',1),(3,'BONGARA',1),(4,'CONDORCANQUI',1),(5,'LUYA',1),(6,'RODRIGUEZ DE MENDOZA',1),(7,'UTCUBAMBA',1),(8,'HUARAZ',2),(9,'AIJA',2),(10,'ANTONIO RAYMONDI',2),(11,'ASUNCION',2),(12,'BOLOGNESI',2),(13,'CARHUAZ',2),(14,'CARLOS F. FITZCARRAL',2),(15,'CASMA',2),(16,'CORONGO',2),(17,'HUARI',2),(18,'HUARMEY',2),(19,'HUAYLAS',2),(20,'MARISCAL LUZURIAGA',2),(21,'OCROS',2),(22,'PALLASCA',2),(23,'POMABAMBA',2),(24,'RECUAY',2),(25,'SANTA',2),(26,'SIHUAS',2),(27,'YUNGAY',2),(28,'ABANCAY',3),(29,'ANDAHUAYLAS',3),(30,'ANTABAMBA',3),(31,'AYMARAES',3),(32,'COTABAMBAS',3),(33,'CHINCHEROS',3),(34,'GRAU',3),(35,'AREQUIPA',4),(36,'CAMANA',4),(37,'CARAVELI',4),(38,'CASTILLA',4),(39,'CAYLLOMA',4),(40,'CONDESUYOS',4),(41,'ISLAY',4),(42,'LA UNION',4),(43,'HUAMANGA',5),(44,'CANGALLO',5),(45,'HUANCA SANCOS',5),(46,'HUANTA',5),(47,'LA MAR',5),(48,'LUCANAS',5),(49,'PARINACOCHAS',5),(50,'PAUCAR DEL SARASARA',5),(51,'SUCRE',5),(52,'VICTOR FAJARDO',5),(53,'VILCAS HUAMAN',5),(54,'CAJAMARCA',6),(55,'CAJABAMBA',6),(56,'CELENDIN',6),(57,'CHOTA',6),(58,'CONTUMAZA',6),(59,'CUTERVO',6),(60,'HUALGAYOC',6),(61,'JAEN',6),(62,'SAN IGNACIO',6),(63,'SAN MARCOS',6),(64,'SAN MIGUEL',6),(65,'SAN PABLO',6),(66,'SANTA CRUZ',6),(67,'CALLAO',7),(68,'CUSCO',8),(69,'ACOMAYO',8),(70,'ANTA',8),(71,'CALCA',8),(72,'CANAS',8),(73,'CANCHIS',8),(74,'CHUMBIVILCAS',8),(75,'ESPINAR',8),(76,'LA CONVENCION',8),(77,'PARURO',8),(78,'PAUCARTAMBO',8),(79,'QUISPICANCHI',8),(80,'URUBAMBA',8),(81,'HUANCAVELICA',9),(82,'ACOBAMBA',9),(83,'ANGARAES',9),(84,'CASTROVIRREYNA',9),(85,'CHURCAMPA',9),(86,'HUAYTARA',9),(87,'TAYACAJA',9),(88,'HUANUCO',10),(89,'HUÁNUCO',10),(90,'AMBO',10),(91,'DOS DE MAYO',10),(92,'HUACAYBAMBA',10),(93,'HUAMALIES',10),(94,'LEONCIO PRADO',10),(95,'LEONCIO PRADO',11),(96,'MARAŃON',10),(97,'PACHITEA',10),(98,'PUERTO INCA',10),(99,'LAURICOCHA',10),(100,'YAROWILCA',10),(101,'ICA',12),(102,'CHINCHA',12),(103,'NAZCA',12),(104,'PALPA',12),(105,'PISCO',12),(106,'HUANCAYO',13),(107,'CONCEPCION',13),(108,'CHANCHAMAYO',13),(109,'JAUJA',13),(110,'JUNIN',13),(111,'SATIPO',13),(112,'SATIPO ',13),(113,'TARMA',13),(114,'YAULI',13),(115,'CHUPACA',13),(116,'TRUJILLO',14),(117,'ASCOPE',14),(118,'BOLIVAR',14),(119,'CHEPEN',14),(120,'JULCAN',14),(121,'OTUZCO',14),(122,'PACASMAYO',14),(123,'PATAZ',14),(124,'SANCHEZ CARRION',14),(125,'SANTIAGO DE CHUCO',14),(126,'GRAN CHIMU',14),(127,'VIRU',14),(128,'CHICLAYO',15),(129,'FERREŃAFE',15),(130,'LAMBAYEQUE',15),(131,'LIMA',16),(132,'BARRANCA',16),(133,'CAJATAMBO',16),(134,'CANTA',16),(135,'CAŃETE',16),(136,'HUARAL',16),(137,'HUAROCHIRI',16),(138,'HUAURA',16),(139,'OYON',16),(140,'YAUYOS',16),(141,'MAYNAS',17),(142,'MAYNAS ',17),(143,'ALTO AMAZONAS',17),(144,'LORETO',17),(145,'MARISCAL RAMON CASTILLA',17),(146,'REQUENA',17),(147,'UCAYALI',17),(148,'DATEM DEL MARAŃÓN ',17),(149,'TAMBOPATA',18),(150,'MANU',18),(151,'TAHUAMANU',18),(152,'MARISCAL NIETO',19),(153,'GENERAL SANCHEZ CERRO',19),(154,'ILO',19),(155,'PASCO',20),(156,'DANIEL ALCIDES CARRION',20),(157,'OXAPAMPA',20),(158,'OXAPAMPA ',20),(159,'PIURA',21),(160,'AYABACA',21),(161,'HUANCABAMBA',21),(162,'MORROPON',21),(163,'PAITA',21),(164,'SULLANA',21),(165,'TALARA',21),(166,'SECHURA',21),(167,'PUNO',22),(168,'AZANGARO',22),(169,'CARABAYA',22),(170,'CHUCUITO',22),(171,'EL COLLAO',22),(172,'HUANCANE',22),(173,'LAMPA',22),(174,'MELGAR',22),(175,'MOHO',22),(176,'SAN ANTONIO DE PUTINA',22),(177,'SAN ROMAN',22),(178,'SANDIA',22),(179,'YUNGUYO',22),(180,'MOYOBAMBA',23),(181,'BELLAVISTA',23),(182,'EL DORADO',23),(183,'HUALLAGA',23),(184,'LAMAS',23),(185,'MARISCAL CACERES',23),(186,'PICOTA',23),(187,'RIOJA',23),(188,'SAN MARTIN',23),(189,'TOCACHE',23),(190,'TACNA',24),(191,'CANDARAVE',24),(192,'JORGE BASADRE',24),(193,'TARATA',24),(194,'TUMBES',25),(195,'CONTRALMIRANTE VILLA',25),(196,'CONTRALMIRANTE VILLAR ',25),(197,'ZARUMILLA',25),(198,'CORONEL PORTILLO',26),(199,'ATALAYA',26),(200,'PADRE ABAD',26),(201,'PURUS',26);

INSERT INTO district VALUES (1,'CHACHAPOYAS',1,'10101'),
(2,'ASUNCION',1,'10102'),
(3,'BALSAS',1,'10103'),
(4,'CHETO',1,'10104'),
(5,'CHILIQUIN',1,'10105'),
(6,'CHUQUIBAMBA',1,'10106'),
(7,'GRANADA',1,'10107'),
(8,'HUANCAS',1,'10108'),
(9,'LA JALCA',1,'10109'),
(10,'LEIMEBAMBA',1,'10110'),
(11,'LEVANTO',1,'10111'),
(12,'MAGDALENA',1,'10112'),
(13,'MARISCAL CASTILLA',1,'10113'),
(14,'MOLINOPAMPA',1,'10114'),
(15,'MONTEVIDEO',1,'10115'),
(16,'OLLEROS',1,'10116'),
(17,'QUINJALCA',1,'10117'),
(18,'SAN FRANCISCO DE DAGUAS',1,'10118'),
(19,'SAN ISIDRO DE MAINO',1,'10119'),
(20,'SOLOCO',1,'10120'),
(21,'SONCHE',1,'10121'),
(22,'BAGUA',2,'10201'),
(23,'ARAMANGO',2,'10202'),(24,'COPALLIN',2,'10203'),
(25,'EL PARCO',2,'10204'),(26,'IMAZA',2,'10205'),(27,'LA PECA',2,'10206'),
(28,'JUMBILLA',3,'10301'),(29,'CHISQUILLA',3,'10302'),(30,'CHURUJA',3,'10303'),(31,'COROSHA',3,'10304'),(32,'CUISPES',3,'10305'),
(33,'FLORIDA',3,'10306'),(34,'JAZAN',3,'10307'),(35,'RECTA',3,'10308'),(36,'SAN CARLOS',3,'10309'),(37,'SHIPASBAMBA',3,'10310'),
(38,'VALERA',3,'10311'),(39,'YAMBRASBAMBA',3,'10312'),(40,'NIEVA',4,'10401'),(41,'EL CENEPA',4,'10402'),(42,'RIO SANTIAGO',4,'10403'),
(43,'LAMUD',5,'10501'),(44,'CAMPORREDONDO',5,'10502'),(45,'COCABAMBA',5,'10503'),(46,'COLCAMAR',5,'10504'),(47,'CONILA',5,'10505'),
(48,'INGUILPATA',5,'10506'),(49,'LONGUITA',5,'10507'),(50,'LONYA CHICO',5,'10508'),(51,'LUYA',5,'10509'),(52,'LUYA VIEJO',5,'10510'),
(53,'MARIA',5,'10511'),(54,'OCALLI',5,'10512'),(55,'OCUMAL',5,'10513'),(56,'PISUQUIA',5,'10514'),(57,'PROVIDENCIA',5,'10515'),
(58,'SAN CRISTOBAL',5,'10516'),(59,'SAN FRANCISCO DEL YESO',5,'10517'),(60,'SAN JERONIMO',5,'10518'),(61,'SAN JUAN DE LOPECANCHA',5,'10519'),
(62,'SANTA CATALINA',5,'10520'),(63,'SANTO TOMAS',5,'10521'),(64,'TINGO',5,'10522'),(65,'TRITA',5,'10523'),(66,'SAN NICOLAS',6,'10601'),
(67,'CHIRIMOTO',6,'10602'),(68,'COCHAMAL',6,'10603'),(69,'HUAMBO',6,'10604'),(70,'LIMABAMBA',6,'10605'),(71,'LONGAR',6,'10606'),
(72,'MARISCAL BENAVIDES',6,'10607'),(73,'MILPUC',6,'10608'),(74,'OMIA',6,'10609'),(75,'SANTA ROSA',6,'10610'),(76,'TOTORA',6,'10611'),
(77,'VISTA ALEGRE',6,'10612'),(78,'BAGUA GRANDE',7,'10701'),(79,'CAJARURO',7,'10702'),(80,'CUMBA',7,'10703'),(81,'EL MILAGRO',7,'10704'),
(82,'JAMALCA',7,'10705'),(83,'LONYA GRANDE',7,'10706'),(84,'YAMON',7,'10707'),(85,'HUARAZ',8,'20101'),(86,'COCHABAMBA',8,'20102'),
(87,'COLCABAMBA',8,'20103'),(88,'HUANCHAY',8,'20104'),(89,'INDEPENDENCIA',8,'20105'),(90,'JANGAS',8,'20106'),(91,'LA LIBERTAD',8,'20107'),
(92,'OLLEROS',8,'20108'),(93,'PAMPAS',8,'20109'),(94,'PARIACOTO',8,'20110'),(95,'PIRA',8,'20111'),(96,'TARICA',8,'20112'),
(97,'AIJA',9,'20201'),(98,'CORIS',9,'20202'),(99,'HUACLLAN',9,'20203'),(100,'LA MERCED',9,'20204'),(101,'SUCCHA',9,'20205'),
(102,'LLAMELLIN',10,'20301'),(103,'ACZO',10,'20302'),(104,'CHACCHO',10,'20303'),(105,'CHINGAS',10,'20304'),(106,'MIRGAS',10,'20305'),
(107,'SAN JUAN DE RONTOY',10,'20306'),(108,'CHACAS',11,'20401'),(109,'ACOCHACA',11,'20402'),(110,'CHIQUIAN',12,'20501'),
(111,'ABELARDO PARDO LEZAMETA',12,'20502'),(112,'ANTONIO RAYMONDI',12,'20503'),(113,'AQUIA',12,'20504'),(114,'CAJACAY',12,'20505'),
(115,'CANIS',12,'20506'),(116,'COLQUIOC',12,'20507'),(117,'HUALLANCA',12,'20508'),(118,'HUASTA',12,'20509'),(119,'HUAYLLACAYAN',12,'20510'),
(120,'LA PRIMAVERA',12,'20511'),(121,'MANGAS',12,'20512'),(122,'PACLLON',12,'20513'),(123,'SAN MIGUEL DE CORPANQUI',12,'20514'),
(124,'TICLLOS',12,'20515'),(125,'CARHUAZ',13,'20601'),(126,'ACOPAMPA',13,'20602'),(127,'AMASHCA',13,'20603'),(128,'ANTA',13,'20604'),
(129,'ATAQUERO',13,'20605'),(130,'MARCARA',13,'20606'),(131,'PARIAHUANCA',13,'20607'),(132,'SAN MIGUEL DE ACO',13,'20608'),
(133,'SHILLA',13,'20609'),(134,'TINCO',13,'20610'),(135,'YUNGAR',13,'20611'),(136,'SAN LUIS',14,'20701'),(137,'SAN NICOLAS',14,'20702'),
(138,'YAUYA',14,'20703'),(139,'CASMA',15,'20801'),(140,'BUENA VISTA ALTA',15,'20802'),(141,'COMANDANTE NOEL',15,'20803'),
(142,'YAUTAN',15,'20804'),(143,'CORONGO',16,'20901'),(144,'ACO',16,'20902'),(145,'BAMBAS',16,'20903'),(146,'CUSCA',16,'20904'),
(147,'LA PAMPA',16,'20905'),(148,'YANAC',16,'20906'),(149,'YUPAN',16,'20907'),(150,'HUARI',17,'21001'),(151,'ANRA',17,'21002'),
(152,'CAJAY',17,'21003'),(153,'CHAVIN DE HUANTAR',17,'21004'),(154,'HUACACHI',17,'21005'),(155,'HUACCHIS',17,'21006'),
(156,'HUACHIS',17,'21007'),(157,'HUANTAR',17,'21008'),(158,'MASIN',17,'21009'),(159,'PAUCAS',17,'21010'),(160,'PONTO',17,'21011'),
(161,'RAHUAPAMPA',17,'21012'),(162,'RAPAYAN',17,'21013'),(163,'SAN MARCOS',17,'21014'),(164,'SAN PEDRO DE CHANA',17,'21015'),
(165,'UCO',17,'21016'),(166,'HUARMEY',18,'21101'),(167,'COCHAPETI',18,'21102'),(168,'CULEBRAS',18,'21103'),(169,'HUAYAN',18,'21104'),
(170,'MALVAS',18,'21105'),(171,'CARAZ',19,'21201'),(172,'HUALLANCA',19,'21202'),(173,'HUATA',19,'21203'),(174,'HUAYLAS',19,'21204'),
(175,'MATO',19,'21205'),(176,'PAMPAROMAS',19,'21206'),(177,'PUEBLO LIBRE',19,'21207'),(178,'SANTA CRUZ',19,'21208'),
(179,'SANTO TORIBIO',19,'21209'),(180,'YURACMARCA',19,'21210'),(181,'PISCOBAMBA',20,'21301'),(182,'CASCA',20,'21302'),
(183,'ELEAZAR GUZMAN BARRON',20,'21303'),(184,'FIDEL OLIVAS ESCUDERO',20,'21304'),(185,'LLAMA',20,'21305'),(186,'LLUMPA',20,'21306'),
(187,'LUCMA',20,'21307'),(188,'MUSGA',20,'21308'),(189,'OCROS',21,'21401'),(190,'ACAS',21,'21402'),(191,'CAJAMARQUILLA',21,'21403'),
(192,'CARHUAPAMPA',21,'21404'),(193,'COCHAS',21,'21405'),(194,'CONGAS',21,'21406'),(195,'LLIPA',21,'21407'),(196,'SAN CRISTOBAL DE RAJAN',21,'21408'),
(197,'SAN PEDRO',21,'21409'),(198,'SANTIAGO DE CHILCAS',21,'21410'),(199,'CABANA',22,'21501'),(200,'BOLOGNESI',22,'21502'),
(201,'CONCHUCOS',22,'21503'),(202,'HUACASCHUQUE',22,'21504'),(203,'HUANDOVAL',22,'21505'),(204,'LACABAMBA',22,'21506'),
(205,'LLAPO',22,'21507'),(206,'PALLASCA',22,'21508'),(207,'PAMPAS',22,'21509'),(208,'SANTA ROSA',22,'21510'),(209,'TAUCA',22,'21511'),
(210,'POMABAMBA',23,'21601'),(211,'HUAYLLAN',23,'21602'),(212,'PAROBAMBA',23,'21603'),(213,'QUINUABAMBA',23,'21604'),(214,'RECUAY',24,'21701'),
(215,'CATAC',24,'21702'),(216,'COTAPARACO',24,'21703'),(217,'HUAYLLAPAMPA',24,'21704'),(218,'LLACLLIN',24,'21705'),
(219,'MARCA',24,'21706'),(220,'PAMPAS CHICO',24,'21707'),(221,'PARARIN',24,'21708'),(222,'TAPACOCHA',24,'21709'),
(223,'TICAPAMPA',24,'21710'),(224,'CHIMBOTE',25,'21801'),(225,'CACERES DEL PERU',25,'21802'),(226,'COISHCO',25,'21803'),
(227,'MACATE',25,'21804'),(228,'MORO',25,'21805'),(229,'NEPEŃA',25,'21806'),(230,'SAMANCO',25,'21807'),(231,'SANTA',25,'21808')


INSERT INTO document_type VALUES (1,'DNI'),(2,'CE');

INSERT INTO driving_clASs VALUES (1,'A'),(2,'B'),(3,'C');

INSERT INTO driving_category VALUES (1,'I',1),(2,'II',1),(3,'III',2),(4,'IV',2),(5,'V',3),(6,'VI',3);

INSERT INTO [role] VALUES (1,'ROLE_USER'),(2,'ROLE_ADMIN');


INSERT INTO [users] VALUES 
(1,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin1',NULL,NULL,NULL,NULL),
(2,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin2',NULL,NULL,NULL,NULL),
(3,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin3',NULL,NULL,NULL,NULL),
(4,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin4',NULL,NULL,NULL,NULL),
(5,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin5',NULL,NULL,NULL,NULL),
(6,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin6',NULL,NULL,NULL,NULL),
(7,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin7',NULL,NULL,NULL,NULL),
(8,CAST('$2a$10$RVm6ib4IelrZ.XD7gbNH2OAhOcYWZMgxPXGZRkbX9Rf.hSLeyP5De' AS VARBINARY(MAX)),NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'admin8',NULL,NULL,NULL,NULL)

INSERT INTO [job_offer] ([name],[description]) VALUES
('convocatoria 1','programador'),
('convocatoria 2','programador'),
('convocatoria 3','programador'),
('convocatoria 4','programador'),
('convocatoria 5','programador')

INSERT INTO [user_apply] (job_offer_id,[user_id],[application_date]) VALUES
(1,1,GETDATE()),
(1,2,GETDATE()),
(1,3,GETDATE()),
(1,4,GETDATE()),
(1,5,GETDATE()),
(1,6,GETDATE()),
(1,7,GETDATE()),
(1,8,GETDATE()),
(2,1,GETDATE()),
(2,2,GETDATE()),
(3,1,GETDATE()),
(3,2,GETDATE()),
(3,6,GETDATE()),
(3,4,GETDATE()),
(3,5,GETDATE()),
(4,2,GETDATE()),
(4,3,GETDATE()),
(4,4,GETDATE()),
(4,1,GETDATE()),
(5,1,GETDATE()),
(5,3,GETDATE()),
(5,5,GETDATE()),
(5,7,GETDATE())

INSERT INTO knowledge ([name], [user_id]) VALUES ('Utilization', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('SV', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('OTA', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Trading', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('ILOG', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Xbox One', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('VMware VTSP', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('iHotelier', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('DQL', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Space Planning', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Oxygen', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Video Games', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('GCF', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Kondor+', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('HST', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('RFP', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('RMX', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('EssbASe', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('IT Law', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('TPX', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('SAP HR', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('jQuery Mobile', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('PDMS', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Home Health Agencies', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Rhythm Guitar', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Storage', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('CNC Programing', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('PMAs', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Tablet PC', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Background Checks', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Railway', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Japanese Culture', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('VBScript', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Strategic Thinking', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('PKI', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('FTIR', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('FWSM', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Geomatics', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('JUnit', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Vocal', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Tomcat', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('FDDI', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('HBA', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('CMS', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('HW/SW INTegration', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Fertility', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('PMO Services', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Animal Nutrition', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Brand AmbASsadorship', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Process Optimization', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('RTLS', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('DLL', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('CSLA', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('WSRR', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Pro II', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Ultra Low Latency', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Ruby on Rails', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('eCTD', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('HTTPWatch', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Alternative Medicine', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Water', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('EEO Compliance', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('PVST+', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Practice CS', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('RSView', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('QPST', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Typo3', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Skin', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('VCT', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('PTT', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Environmental Science', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('xCAT', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Biostatistics', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('EKG', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Science', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Cardiac MRI', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Corporate Branding', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('MBOX', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('CNOR', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('JNI', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Zuora', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Guest Service Management', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Big 4', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('CP', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Powers of Attorney', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('JAX-RPC', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('CASh Flow', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('RDFa', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('DFSS', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Ulcerative Colitis', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('FTTH', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('NHS', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Psychometrics', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('DLL', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('KWP2000', 1);
INSERT INTO knowledge ([name], [user_id]) VALUES ('RF Circuits', 2);
INSERT INTO knowledge ([name], [user_id]) VALUES ('ETFs', 3);
INSERT INTO knowledge ([name], [user_id]) VALUES ('VPM', 4);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Intercollegiate Athletics', 5);
INSERT INTO knowledge ([name], [user_id]) VALUES ('Medical Nutrition Therapy', 1);

INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Dabvine', 2, 'China', 'doctorado');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Riffwire', 3, 'Switzerland', 'doctorado');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Photojam', 4, 'China', 'titulo');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Gigaclub', 5, 'China', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Trudoo', 1, 'Norway', 'doctorado');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Livefish', 2, 'China', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Thoughtblab', 3, 'Armenia', 'titulo');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Thoughtmix', 4, 'Indonesia', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Youopia', 5, 'Japan', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Yodel', 1, 'Democratic Republic of the Congo', 'titulo');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Skibox', 2, 'Colombia', 'doctorado');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Demimbu', 3, 'China', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Twitterworks', 4, 'Peru', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Zoovu', 5, 'China', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Skidoo', 1, 'United Kingdom', 'doctorado');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Ntags', 2, 'Slovenia', 'meAStria');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Jazzy', 3, 'Kenya', 'titulo');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Blogtags', 4, 'Taiwan', 'titulo');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Tazzy', 5, 'Dominican Republic', 'doctorado');
INSERT INTO degree (institute_name, [user_id], country, [name]) VALUES ('Browsedrive', 1, 'China', 'titulo');

INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('ZoomcASt', 'Cunha', 'maestria', 78, 1, '1/3/2016', '12/30/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Fivechat', 'Bhamdoûn el Mhatta', 'titulo', 34, 4, '7/23/2014', '2/21/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Jetwire', 'Mosquée', 'doctorado', 50, 2, '4/20/2017', '4/9/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Yambee', 'Tafí del Valle', 'doctorado', 35, 2, '9/24/2015', '12/28/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Linkbuzz', 'Kazimierz Dolny', 'titulo', 70, 5, '8/7/2014', '3/12/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Devshare', 'Valence', 'titulo', 55, 1, '5/21/2014', '8/18/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Edgeblab', 'Bieniewice', 'maestria', 44, 5, '8/18/2015', '11/20/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Kare', 'Douz', 'titulo', 35, 4, '10/5/2014', '8/25/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Demimbu', 'Jamaica', 'bachiller', 11, 4, '7/2/2016', '6/27/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Kazu', 'LimASsol', 'maestria', 77, 2, '11/17/2014', '12/4/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('DabZ', 'Ramat Yishay', 'doctorado', 57, 1, '8/30/2014', '1/6/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Yakitri', 'Shatian', 'doctorado', 83, 4, '1/11/2016', '9/3/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Rhyloo', 'Pesucen', 'titulo', 35, 1, '8/4/2016', '11/7/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Flipbug', 'Can-ASujan', 'bachiller', 83, 3, '11/17/2016', '1/3/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Thoughtblab', 'Brzeg Dolny', 'bachiller', 23, 3, '5/24/2016', '6/7/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Quimba', 'Gornji Breg', 'doctorado', 29, 3, '3/3/2017', '8/18/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Avavee', 'Oslo', 'bachiller', 56, 5, '8/8/2016', '7/9/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('FlAShdog', 'Tuen Mun', 'maestria', 43, 3, '10/2/2016', '7/7/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Kwilith', 'La Plata', 'maestria', 36, 2, '11/17/2015', '3/29/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Cogibox', 'KrASna', 'bachiller', 43, 2, '5/5/2016', '1/30/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Wikizz', 'Kindu', 'titulo', 66, 4, '6/6/2016', '8/9/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Avamm', 'Falënki', 'titulo', 17, 5, '8/17/2015', '9/29/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Wikivu', 'Rangmanten', 'doctorado', 84, 4, '11/12/2015', '3/22/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Kanoodle', 'Shangtianba', 'bachiller', 62, 4, '12/7/2014', '2/14/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Twitterbridge', 'Fort Lauderdale', 'titulo', 38, 3, '7/29/2014', '8/13/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Mita', 'Bayeman', 'titulo', 59, 1, '9/29/2015', '3/22/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Topicstorm', 'Andop', 'titulo', 69, 5, '12/6/2016', '2/18/2019');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Fivespan', 'Llusco', 'titulo', 66, 3, '11/18/2014', '6/23/2017');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Topiczoom', 'Telengsari', 'doctorado', 54, 3, '9/10/2016', '11/5/2018');
INSERT INTO course (institution, [location], [name], completed_hours, [user_id], starting_date, conclusion_date) VALUES ('Rhycero', 'Changping', 'doctorado', 33, 1, '8/12/2014', '10/25/2017');

INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Camido', 'Pharmacist', 1, '12/22/2015', '5/9/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Eabox', 'Assistant Manager', 1, '11/7/2015', '3/5/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Linkbridge', 'VP Product Management', 2, '7/2/2015', '6/4/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('FlAShpoINT', 'Civil Engineer', 3, '7/7/2015', '3/26/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Blogspan', 'DatabASe Administrator II', 1, '11/15/2015', '11/4/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Dabshots', 'Help Desk Technician', 3, '9/11/2014', '12/3/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Wordtune', 'Food Chemist', 4, '4/25/2017', '10/12/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Jabbercube', 'Technical Writer', 4, '6/16/2014', '2/4/2019');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Gigazoom', 'Geologist III', 2, '12/8/2014', '10/3/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Jabbersphere', 'Junior Executive', 4, '11/7/2015', '8/28/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Gevee', 'Health Coach I', 1, '9/25/2014', '3/6/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Brightdog', 'Computer Systems Analyst III', 1, '12/4/2014', '10/22/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Jayo', 'Structural Analysis Engineer', 2, '9/12/2014', '6/4/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Browsetype', 'Paralegal', 5, '9/19/2015', '8/9/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Yodo', 'Chief Design Engineer', 2, '11/24/2015', '9/24/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Cogidoo', 'Biostatistician III', 4, '5/24/2016', '8/6/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Jabbersphere', 'Nurse', 4, '11/20/2015', '7/10/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Ntags', 'Registered Nurse', 3, '9/28/2015', '6/16/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Ozu', 'VP Product Management', 2, '4/22/2015', '5/25/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Rhycero', 'Environmental Tech', 2, '3/3/2016', '3/16/2019');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Trudoo', 'Product Engineer', 2, '8/19/2016', '8/13/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Jatri', 'Systems Administrator IV', 1, '11/27/2015', '11/4/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Voolia', 'Professor', 4, '5/27/2014', '8/5/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Twiyo', 'GIS Technical Architect', 4, '12/30/2014', '11/4/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Skaboo', 'Internal Auditor', 2, '11/23/2015', '11/8/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Browsecat', 'Web Designer III', 1, '3/16/2016', '8/23/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Browsetype', 'Health Coach I', 1, '3/30/2015', '5/11/2019');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Feedspan', 'Structural Engineer', 2, '11/19/2016', '2/27/2018');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Avavee', 'VP Sales', 2, '1/2/2017', '9/14/2017');
INSERT INTO background_experience (company_name, position, [user_id], starting_date, conclusion_date) VALUES ('Realcube', 'Registered Nurse', 4, '7/24/2014', '2/11/2019');

INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Fivebridge', 'DatabASe Administrator III', 'Genni Rosel', '908-245-6916', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('BlogXS', 'Data Coordiator', 'Allin Bywater', '278-595-2144', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Tambee', 'Senior Sales Associate', 'Felita Welbrock', '881-858-1447', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Livepath', 'Business Systems Development Analyst', 'Robinia Syred', '316-704-1415', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Eidel', 'Assistant Manager', 'SebAStian Frizzell', '820-269-4276', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Thoughtstorm', 'Legal Assistant', 'Barbee Kendrew', '951-943-0203', 2);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Meemm', 'Environmental Specialist', 'Arnold Whyke', '157-217-4793', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Quinu', 'Pharmacist', 'Rube Riehm', '440-144-2187', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Aivee', 'Social Worker', 'Sarita Mattheis', '473-937-7302', 5);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Eamia', 'Occupational Therapist', 'Nancey Burford', '781-439-6033', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Gabtune', 'VP Quality Control', 'Janka Auguste', '144-168-3090', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Reallinks', 'VP Sales', 'Joseito Carhart', '891-813-7901', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Aimbu', 'Help Desk Operator', 'Homere Knok', '522-940-2772', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Photojam', 'Occupational Therapist', 'Erena Romi', '606-362-6544', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Abatz', 'Software Consultant', 'Frederique Wolland', '232-520-6035', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Twitterbeat', 'Registered Nurse', 'Maximilianus Desouza', '904-523-9922', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Quamba', 'Recruiter', 'Marlyn Backshaw', '143-290-8029', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Zoomlounge', 'Civil Engineer', 'Irene North', '638-577-9558', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Kazio', 'Marketing Assistant', 'Delaney Abrahart', '814-143-5192', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Photobean', 'Electrical Engineer', 'Aluino McClunaghan', '879-889-8492', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Flipstorm', 'Statistician II', 'Danita Burke', '995-290-7031', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Cogidoo', 'VP Marketing', 'Agnella Brimelow', '330-685-0744', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Fanoodle', 'Physical Therapy Assistant', 'Godwin TeASe', '569-264-5166', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Twitterbridge', 'Occupational Therapist', 'Sophia Cornewell', '976-507-7633', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Oyoloo', 'Research Associate', 'Mireielle Bellwood', '628-710-6919', 4);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Demimbu', 'Tax Accountant', 'Ettie Faveryear', '838-746-6842', 5);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Meedoo', 'Civil Engineer', 'Katharine Sedge', '687-139-7930', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Chatterbridge', 'Executive Secretary', 'Irvin Gaitone', '430-592-1145', 1);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Realcube', 'Technical Writer', 'Ryon Sawley', '608-883-6328', 3);
INSERT INTO work_reference (company_name, [reference_position], [reference_name], phone, user_id) VALUES ('Feedmix', 'Data Coordiator', 'Jacob Claque', '107-326-1154', 4);


INSERT INTO user_roles VALUES (1,1,2);
GO