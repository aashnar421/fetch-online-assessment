-- Create DB
CREATE DATABASE `mydb`;
USE `mydb`;

-- Create all tables
CREATE TABLE `Brands` (
  `brand_id` varchar(25) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `cpg` varchar(25) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `brandCode` varchar(45) DEFAULT NULL,
  `topBrand` tinyint DEFAULT NULL,
  PRIMARY KEY (`brand_id`),
  UNIQUE KEY `brand_id_UNIQUE` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;

CREATE TABLE `Users` (
  `user_id` varchar(25) NOT NULL,
  `active` tinyint DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `signUpSource` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;

CREATE TABLE `Items` (
  `barcode` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `itemPrice` decimal(2,0) NOT NULL,
  `rewardsGroup` varchar(45) DEFAULT NULL,
  `rewardsProductPartnerId` varchar(45) DEFAULT NULL,
  `Brands_brand_id` varchar(25) NOT NULL,
  PRIMARY KEY (`barcode`),
  UNIQUE KEY `barcode_UNIQUE` (`barcode`),
  KEY `fk_Items_Brands1_idx` (`Brands_brand_id`),
  CONSTRAINT `fk_Items_Brands1` FOREIGN KEY (`Brands_brand_id`) REFERENCES `Brands` (`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;

CREATE TABLE `Receipts` (
  `receipt_id` varchar(25) NOT NULL,
  `purchaseDate` datetime NOT NULL,
  `dateScanned` datetime NOT NULL,
  `finishedDate` datetime DEFAULT NULL,
  `modifyDate` datetime DEFAULT NULL,
  `pointsAwardedDate` datetime DEFAULT NULL,
  `rewardsReceiptStatus` varchar(45) NOT NULL,
  `user_id` varchar(25) NOT NULL,
  `purchasedItemCount` int DEFAULT NULL,
  PRIMARY KEY (`receipt_id`),
  UNIQUE KEY `_id_UNIQUE` (`receipt_id`),
  KEY `fk_Receipts_Users_idx` (`user_id`),
  CONSTRAINT `fk_Receipts_Users` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;

CREATE TABLE `receiptitems` (
  `Receipts_receipt_id` varchar(25) NOT NULL,
  `Items_barcode` int NOT NULL,
  `quantityPurchased` int DEFAULT NULL,
  `PointsEarned` int DEFAULT NULL,
  `itemPrice` decimal(2,0) DEFAULT NULL,
  `pointsNotAwardedReason` varchar(45) DEFAULT NULL,
  `user_id` varchar(25) NOT NULL,
  `dateScanned` datetime DEFAULT NULL,
  PRIMARY KEY (`Receipts_receipt_id`,`Items_barcode`),
  KEY `fk_RewardItems_Items1` (`Items_barcode`),
  KEY `fk_RewardItems_Users1` (`user_id`),
  CONSTRAINT `fk_RewardItems_Items1` FOREIGN KEY (`Items_barcode`) REFERENCES `Items` (`barcode`),
  CONSTRAINT `fk_RewardItems_Receipts1` FOREIGN KEY (`Receipts_receipt_id`) REFERENCES `Receipts` (`receipt_id`),
  CONSTRAINT `fk_RewardItems_Users1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
;



-- Seed all tables
INSERT INTO mydb.brands
VALUES
    ('601c5460be37ce2ead43755f', "Starbucks", "5332f5fbe4b03c9a25efd0ba", "BEVERAGES", "STARBUCKS", 0),
    ('601ac142be37ce2ead43755d', "test brand @1612366146176", "601ac142be37ce2ead437559", "Baking", "TEST BRANDCODE @1612366146176", 0),
    ('601ac142be37ce2ead43755a', "test brand @1612366146051", "601ac142be37ce2ead437559", "Baking", "TEST BRANDCODE @1612366146051", 0),
    ('5cdad0f5166eb33eb7ce0faa', "J.L. Kraft", "559c2234e4b06aca36af13c6", "Condiments & Sauces", "J.L. KRAFT", NULL),
    ('57c08106e4b0718ff5fcb02c',"MorningStar", "5332f5f2e4b03c9a25efd0aa", NULL, NULL, NULL),
    ('585a9611e4b03e62d1ce0e74', "AUNT JEMIMA Syrup", "5332f5fbe4b03c9a25efd0ba", "Breakfast & Cereal", "AUNT JEMIMA SYRUP", 0),
    ('585a9611e4b05212d1ce0e65', "Wendys", "5332f5fbe4b03c9a25efd0ba", "Restaurant", "Wendys", 0),
    ('57c08106e4b0718268fcb096', "test brand @1612396346176", "601ac142be37ce2ead437559", "Baking", "TEST BRANDCODE @1612396346176", 1),
    ('601ac142be37ce2ea6427585', "test brand @2102352146051", "601ac142be37ce2ead437559", "Baking", "TEST BRANDCODE @2102352146051", 0),
    ('5cdad0f5166eb34eb7ce0dge', "Velveeta", "559c2234e4b06aca36af13c6", "Condiments & Sauces", "J.L. KRAFT", NULL),
    ('745ac142be37ce964d4375ij',"Impossible", "5332f5f2e4b03c9a25efd0aa", "Meat", NULL, 1),
    ('585a9611e4b03e62d1596324', "Happy Belly pickles", "5332f5fbe4b03c9a25efd0ba", "Breakfast", NULL, 1)
;

INSERT INTO mydb.Users
VALUES 
	('5ff1e1e4cfcf6c399c274ac3', 1, FROM_UNIXTIME(1609788675973 * POWER(10, 9 - FLOOR(LOG10(1609788675973)))), FROM_UNIXTIME(1609687524694 * POWER(10, 9 - FLOOR(LOG10(1609687524694)))), 'Email'),
    ('5ff36d0362fde912123a5535', 1, FROM_UNIXTIME(1609687524656 * POWER(10, 9 - FLOOR(LOG10(1609687524656)))), FROM_UNIXTIME(1609788882944 * POWER(10, 9 - FLOOR(LOG10(1609788882944)))), 'Email'),
    ('5ff370c562fde912123a5e0e', 1, FROM_UNIXTIME(1609789637776 * POWER(10, 9 - FLOOR(LOG10(1609789637776)))), FROM_UNIXTIME(1609789850563 * POWER(10, 9 - FLOOR(LOG10(1609789850563)))), 'Email'),
    ('5ff36a3862fde912123a4460', 1, FROM_UNIXTIME(1609787960352 * POWER(10, 9 - FLOOR(LOG10(1609787960352)))), FROM_UNIXTIME(1609788185340 * POWER(10, 9 - FLOOR(LOG10(1609788185340)))), 'Email'),
    ('5ff4ce3dc3d63511e2a484dc', 1, FROM_UNIXTIME(1609879101887 * POWER(10, 9 - FLOOR(LOG10(1609879101887)))), FROM_UNIXTIME(1609879101938 * POWER(10, 9 - FLOOR(LOG10(1609879101938)))), 'Email'),
    ('5ff5d15aeb7c7d12096d91a2', 1, FROM_UNIXTIME(1609945434680 * POWER(10, 9 - FLOOR(LOG10(1609945434680)))), FROM_UNIXTIME(1609945690009 * POWER(10, 9 - FLOOR(LOG10(1609945690009)))), 'Email'),
    ('5ff4ce33c3d63511e2a484b6', 1, FROM_UNIXTIME(1609879091229 * POWER(10, 9 - FLOOR(LOG10(1609879091229)))), FROM_UNIXTIME(1609879195131 * POWER(10, 9 - FLOOR(LOG10(1609879195131)))), 'Email'),
    ('5fff55dabd4dff11dda8f5f1', 1, FROM_UNIXTIME(1610569178721 * POWER(10, 9 - FLOOR(LOG10(1610569178721)))), FROM_UNIXTIME(1610569406975 * POWER(10, 9 - FLOOR(LOG10(1610569406975)))), 'Email'),
	('8411e1e4cfcf6c399c27d8f5', 1, '2022-07-15', '2022-10-22', 'Email'),
    ('dg536d0362fde912123a9df1', 1, '2022-08-19', '2022-11-08', 'Email'),
    ('96d370c562fde912123a6d47', 1, '2022-09-23', '2022-10-03', 'Google'),
    ('e8d36a3862fde912123a8d3e', 1, '2022-10-15', '2022-12-15', 'Email'),
    ('k5p4ce3dc3d63511e2a48d5f', 1, '2022-11-15', '2022-11-27', 'Email'),
    ('6bc5d15aeb7c7d12096dd2d3', 1, '2022-12-01', '2022-12-10', 'Google'),
    ('8d64ce33c3d63511e2a4e9d5', 1, '2022-06-30', '2022-07-26', 'Email'),
    ('6s4f55dabd4dff11dda8j2u5', 1, '2022-07-29', '2022-09-30', 'Email')
;

INSERT INTO mydb.items
VALUES
	(25306254, NULL, 1, "KRAFT NATURAL CHEESE - SHREDDED", "559c2234e4b06aca36af13c6", "585a9611e4b03e62d1ce0e74"),
    (00573065, "MILLER LITE 24 PACK 12OZ CAN", 29, "MILLER LITE 24 PACK 12OZ CAN", NULL, "57c08106e4b0718ff5fcb02c"),
    (00045006, "SARGENTO NATURAL SHREDDED CHEESE", 1, NULL, NULL, '601ac142be37ce2ead43755a'),
    (00642255, "DORITOS TORTILLA CHIP SPICY SWEET CHILI", 10, NULL, NULL, "5cdad0f5166eb33eb7ce0faa"),
    (00009263, NULL, 9.99, 'GULDENS MUSTARD', "5e825d64f221c312e698a62a", '601ac142be37ce2ead43755d'),
	(25352654, NULL, 34, "Pepsi", "961c22a36af13c6", "585a9611e4b05212d1ce0e65"),
    (00596165, "Gatorade", 2.9, "Sports", NULL, "57c08106e4b0718268fcb096"),
    (00014806, "Sliced cheese", 1.99, "Dairy", NULL, '601ac142be37ce2ea6427585'),
    (00663455, "Broccoli", 5.66, NULL, NULL, "5cdad0f5166eb34eb7ce0dge"),
    (00065463, "eggs organic 24 ct", 9.74, 'Clover', "825c312e698a62a", '745ac142be37ce964d4375ij')
;

INSERT INTO mydb.receipts
VALUES 
	("5ff1e1eb0a720f0523000575", "2021/05/12 14:39:52", "2021/05/13 14:24:52", "2021/05/13 15:24:52", NULL, "2021/05/13 15:24:52", 'ACCEPTED', '5ff4ce3dc3d63511e2a484dc', 5),
    ("5ff1e1e40a7214ada1000566", "2021/12/16 03:09:26", "2021/12/16 04:09:26", "2021/12/16 04:15:26", NULL, "2021/12/16 04:15:26", 'ACCEPTED', '5ff4ce33c3d63511e2a484b6', 7),
    ("5f9c74f70a7214ad07000037", "2021/05/17 08:43:39", "2021/05/17 10:43:39", "2021/05/17 11:40:39", NULL, "2021/05/17 11:40:39", 'REJECTED', '5ff1e1e4cfcf6c399c274ac3', 3),
    ("6018a12c0a720f05f4000067", "2021/10/09 17:31:51", "2021/10/09 20:30:03", "2021/10/09 20:30:03", NULL, "2021/10/09 20:30:03", 'REJECTED', '5ff36d0362fde912123a5535', 4),
    ("5ff1e1e40a7214ada1985632", "2022/10/16 03:09:26", "2022/10/16 04:09:26", "2022/10/16 04:15:26", NULL, "2022/10/16 04:15:26", 'ACCEPTED', '5ff5d15aeb7c7d12096d91a2', 7),
    ("5ff1e1e40a7214ada1004852", "2022/11/17 08:43:39", "2022/11/17 10:43:39", "2022/11/17 11:40:39", NULL, "2022/11/17 11:40:39", 'REJECTED', '5fff55dabd4dff11dda8f5f1', 3),
    ("5f9c74f70a7214ad07006329", "2022/11/09 17:31:51", "2022/11/10 20:30:03", "2022/11/11 20:30:03", NULL, "2022/11/11 20:30:03", 'REJECTED', '5ff4ce33c3d63511e2a484b6', 4),
	("jsu1e1eb0a720f0523008854", "2022/08/12 14:39:52", "2022/08/13 14:24:52", "2022/10/13 15:24:52", NULL, "2022/10/13 15:24:52", 'ACCEPTED', '8411e1e4cfcf6c399c27d8f5', 4),
    ("2s41e1e40a7214ada1985656", "2022/06/16 03:09:26", "2022/07/16 04:09:26", "2022/10/16 04:15:26", NULL, "2022/10/16 04:15:26", 'ACCEPTED', 'dg536d0362fde912123a9df1', 3),
    ("8dc1e1e40a7214ada1004463", "2022/11/17 08:43:39", "2022/11/19 10:43:39", "2022/11/17 11:40:39", NULL, "2022/11/17 11:40:39", 'ACCEPTED', '8411e1e4cfcf6c399c27d8f5', 8),
    ("9d6c74f70a7214ad07006964", "2022/09/09 17:31:51", "2022/11/01 20:30:03", "2022/11/11 20:30:03", NULL, "2022/11/11 20:30:03", 'REJECTED', 'k5p4ce3dc3d63511e2a48d5f', 10)
;


INSERT INTO mydb.receiptitems
VALUES
	('5ff1e1eb0a720f0523000575', 25306254, 2, 25, 1, NULL, '5ff1e1e4cfcf6c399c274ac3', '2022-11-05'),
    ('5ff1e1e40a7214ada1000566', 00573065, 3, 290, 29, NULL, '5ff36d0362fde912123a5535', '2022-11-28'),
    ('5ff1e1e40a7214ada1000566', 00045006, 1, 10, 1, NULL, '5ff370c562fde912123a5e0e', '2022-11-28'),
    ('5f9c74f70a7214ad07000037', 00642255, 1, 10, 10, NULL, '5ff1e1e4cfcf6c399c274ac3', '2022-11-23'),
    ('5ff1e1e40a7214ada1985632', 00596165, 2, 20, 30, NULL, '5ff5d15aeb7c7d12096d91a2', '2022-10-23'),
    ('5ff1e1e40a7214ada1004852', 00014806, 1, 10, 1, NULL, '5ff4ce33c3d63511e2a484b6', '2022-10-12'),
    ('5f9c74f70a7214ad07006329', 00663455, 1, 10, 10, NULL, 'e8d36a3862fde912123a8d3e', '2022-10-01'),
	('jsu1e1eb0a720f0523008854', 00014806, 1, 10, 1, NULL, '8411e1e4cfcf6c399c27d8f5', '2022/08/13'),
    ('2s41e1e40a7214ada1985656', 00663455, 2, 20, 30, NULL, 'dg536d0362fde912123a9df1', '2022/07/16' ),
    ('8dc1e1e40a7214ada1004463', 25352654, 1, 10, 1, NULL, '8411e1e4cfcf6c399c27d8f5', '2022/11/19'),
    ('9d6c74f70a7214ad07006964', 00663455, 1, 10, 10, NULL, 'k5p4ce3dc3d63511e2a48d5f', '2022/11/01')
;