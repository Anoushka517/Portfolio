create schema TourismProject;
use TourismProject;

-- here is the order to drop the tables so that there are no FK issues while re-populating
DROP TABLE IF EXISTS `PlannedLocationSelection` ;
DROP TABLE IF EXISTS `Waypoint` ;
DROP TABLE IF EXISTS `ViewingInstructions` ;
DROP TABLE IF EXISTS `PlannedRouteSelection` ;
DROP TABLE IF EXISTS `RouteStartTime` ;
DROP TABLE IF EXISTS `Route` ;
DROP TABLE IF EXISTS `Location` ;
DROP TABLE IF EXISTS `Plan` ;
DROP TABLE IF EXISTS `PointOfInterest` ;
DROP TABLE IF EXISTS `Person` ;

-- -----------------------------------------------------
-- Table `Location`
-- -----------------------------------------------------

CREATE TABLE `Location` (
  `locationID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `description` TEXT NOT NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PointOfInterest`
-- -----------------------------------------------------

CREATE TABLE `PointOfInterest` (
  `pointOfInterestID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `mapReference` VARCHAR(2048) NOT NULL,
  `samplePhoto` BLOB NOT NULL,
  `description` TEXT NOT NULL,
  `typeOfPOI` VARCHAR(20) NOT NULL,
  `animalDescription` TEXT NULL DEFAULT NULL,
  `animalClassification` VARCHAR(20) NULL DEFAULT NULL,
  `animalEndangeredStatus` VARCHAR(20) NULL DEFAULT NULL,
  `plantDescription` TEXT NULL DEFAULT NULL,
  `plantIsPoisonous` TINYINT NULL DEFAULT NULL,
  `plantIsEdible` TINYINT NULL DEFAULT NULL,
  `plantAllergyNote` TEXT NULL DEFAULT NULL,
  `shopName` VARCHAR(500) NULL DEFAULT NULL,
  `shopSecondMapReference` VARCHAR(2048) NULL DEFAULT NULL,
  `shopBargainBarcode` BLOB NULL DEFAULT NULL,
  `placeSamplePhoto` BLOB NULL DEFAULT NULL,
  `placeDescription` TEXT NULL DEFAULT NULL,
  `placeEstimatedExistanceInYears` BIGINT UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`pointOfInterestID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ViewingInstructions`
-- -----------------------------------------------------

CREATE TABLE `ViewingInstructions` (
  `locationID` INT UNSIGNED NOT NULL,
  `pointOfInterestID` INT UNSIGNED NOT NULL,
  `instructionDetails` TEXT NOT NULL,
  PRIMARY KEY (`locationID`, `pointOfInterestID`),
  CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location` (`locationID`),
  CONSTRAINT FOREIGN KEY (`pointOfInterestID`) REFERENCES `PointOfInterest` (`pointOfInterestID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Route`
-- -----------------------------------------------------

CREATE TABLE `Route` (
  `routeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `estimatedWalkingTime` SMALLINT UNSIGNED NOT NULL COMMENT 'in minutes',
  `routeName` VARCHAR(200) NOT NULL,
  `routeDescription` TEXT NOT NULL,
  `startsAt` INT UNSIGNED NOT NULL,
  `endsAt` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`routeID`),
  CONSTRAINT FOREIGN KEY (`startsAt`) REFERENCES `Location` (`locationID`),
  CONSTRAINT FOREIGN KEY (`endsAt`) REFERENCES `Location` (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------

CREATE TABLE `Person` (
  `personID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`personID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Plan`
-- -----------------------------------------------------

CREATE TABLE `Plan` (
    -- TODO: complete the Plan definition
  `planID` INT NOT NULL AUTO_INCREMENT,
  `planName` VARCHAR(200) NOT NULL,
  `whenCreated` DATETIME NOT NULL,
  `whenLastUpdated` DATETIME NOT NULL,
  `isCreatedBy` INT NOT NULL,
  PRIMARY KEY (`planID`),
  CONSTRAINT FOREIGN KEY (`isCreatedBy`) REFERENCES `Person` (`personID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PlannedLocationSelection`
-- -----------------------------------------------------

CREATE TABLE `PlannedLocationSelection` (
  -- TODO: complete the PlannedLocationSelection definition
  `planID` INT NOT NULL,
  `locationID` INT UNSIGNED NOT NULL,
  `dateSelected` DATE NOT NULL,
  `timeSelected` TIME NOT NULL,
  PRIMARY KEY (`planID`, `locationID`),
  CONSTRAINT FOREIGN KEY (`planID`) REFERENCES `Plan` (`planID`),
  CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location` (`locationID`)
)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PlannedRouteSelection`
-- -----------------------------------------------------

CREATE TABLE `PlannedRouteSelection` (
    -- TODO: complete the PlannedRouteSelection definition
  `planID` INT NOT NULL,
  `routeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dateSelected` DATE NOT NULL,
  `timeSelected` TIME NOT NULL,
  PRIMARY KEY (`planID`, `routeID`),
  CONSTRAINT FOREIGN KEY (`planID`) REFERENCES `Plan` (`planID`),
  CONSTRAINT FOREIGN KEY (`routeID`) REFERENCES `Route` (`routeID`)
    

)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `RouteStartTime`
-- -----------------------------------------------------

CREATE TABLE `RouteStartTime` (
    -- TODO: complete the RouteStartTime definition
  `routeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dayAndTimeStart` CHAR(8) NOT NULL,
  PRIMARY KEY (`routeID`),
  CONSTRAINT FOREIGN KEY (`routeID`) REFERENCES `Route` (`routeID`)

)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Waypoint`
-- -----------------------------------------------------

CREATE TABLE `Waypoint` (
    -- TODO: complete the Waypoint definition
  `routeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `locationID` INT UNSIGNED NOT NULL,
  `relativeArrivalTime` SMALLINT NOT NULL COMMENT 'in minutes from route start',
  `relativeDepartureTime` SMALLINT NOT NULL COMMENT 'in minutes from route start',
  PRIMARY KEY (`routeID`, `locationID`),
  CONSTRAINT FOREIGN KEY (`routeID`) REFERENCES `Route` (`routeID`),
  CONSTRAINT FOREIGN KEY (`locationID`) REFERENCES `Location` (`locationID`)

)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Your insert into statements below here
-- -----------------------------------------------------
-- -----------------------------------------------------
-- -----------------------------------------------------

-- Location data insert statements below here
INSERT INTO `Location` (`name`, `description`, `image`) VALUES
('Federation Square', 'A famous cultural precinct in the heart of Melbourne.', 'Fed Sq'),
('Royal Botanic Gardens', 'Large public garden known for its diverse plant species.', 'Gardens'),
('Melbourne Zoo', 'A popular zoo with a wide range of animals.', 'Zoo'),
('Eureka Skydeck', 'The highest public observation deck in the southern hemisphere.', 'Skydeck');

-- -----------------------------------------------------
-- PointOfInterest data insert statements below here
INSERT INTO `PointOfInterest` (
  `name`, `mapReference`, `samplePhoto`, `description`, `typeOfPOI`,
  `animalDescription`, `animalClassification`, `animalEndangeredStatus`,
  `plantDescription`, `plantIsPoisonous`, `plantIsEdible`, `plantAllergyNote`,
  `shopName`, `shopSecondMapReference`, `shopBargainBarcode`, `placeSamplePhoto`,
  `placeDescription`, `placeEstimatedExistanceInYears`
) VALUES
-- Point of interest with animal information
('Koala Exhibit', 'MZ-001', 'Sample Koala Photo', 'A close encounter with koalas.', 'Animal',
 'Koalas are native to Australia.', 'Marsupial', 'Vulnerable', 'N/A', 0, 0, 'N/A', 
 'N/A', 'N/A', 'Sample Koala Bargain Barcode', 'Sample Place Photo', 'Koala viewing area with educational signage.', 100),
 
-- Point of interest with plant information
('Orchid Display', 'RBG-205', 'Sample Orchid Photo', 'A wide variety of orchids from around the world.', 'Plant',
 'N/A', 'N/A', 'N/A', 'Orchids are non-poisonous.', 0, 1, 'No known allergies for orchids.', 
 'Orchid Shop', 'Orchid Second Map Reference', 'Sample Orchid Bargain Barcode', 'Sample Orchid Place Photo', 
 'Beautiful display of rare orchids.', 50),

-- Point of interest for a shop
('Federation Square Information Center', 'FSQ-100', 'Sample Info Center Photo', 'Main tourist information center at Fed Square.', 'Information',
 'N/A', 'N/A', 'N/A', 'N/A', 0, 0, 'N/A', 
 'Fed Square Shop', 'Second Fed Square Map Reference', 'Sample Shop Bargain Barcode', 'Sample Shop Place Photo', 
 'Tourist information and events center with maps and brochures.', 20);
-- -----------------------------------------------------
-- ViewingInstructions data insert statements below here
INSERT INTO `ViewingInstructions` (`locationID`, `pointOfInterestID`, `instructionDetails`) VALUES
(3, 1, 'View the Koalas from a safe distance.'),
(2, 2, 'The orchids are located in the tropical house.'),
(1, 3, 'Visit the info center for maps and brochures.');

-- -----------------------------------------------------
-- Route data insert statements below here
INSERT INTO `Route` (`estimatedWalkingTime`, `routeName`, `routeDescription`, `startsAt`, `endsAt`) VALUES
(60, 'City Walking Tour', 'A walking tour through Melbourne\'s most famous landmarks.', 1, 4),
(90, 'Botanic Gardens Loop', 'A scenic route through the Royal Botanic Gardens.', 2, 2);

-- -----------------------------------------------------
-- Person data insert statements below here
INSERT INTO `Person` (`name`, `password`, `email`) VALUES
('John Doe', 'password123', 'john.doe@example.com'),
('Jane Smith', 'password456', 'jane.smith@example.com');

-- -----------------------------------------------------
-- Plan data insert statements below here
INSERT INTO `Plan` (`planName`, `whenCreated`, `whenLastUpdated`, `isCreatedBy`) VALUES
('Nature Walk Plan', '2024-09-01 10:00:00', '2024-09-01 12:00:00', 1),
('City Tour Plan', '2024-09-02 09:00:00', '2024-09-02 11:00:00', 2);

-- -----------------------------------------------------
-- PlannedLocationSelection data insert statements below here
INSERT INTO `PlannedLocationSelection` (`planID`, `locationID`, `dateSelected`, `timeSelected`) VALUES
(1, 1, '2024-09-03', '09:30:00'),
(2, 2, '2024-09-04', '10:45:00');

-- -----------------------------------------------------
-- PlannedRouteSelection data insert statements below here
INSERT INTO `PlannedRouteSelection` (`planID`, `routeID`, `dateSelected`, `timeSelected`) VALUES
(1, 1, '2024-09-03', '09:00:00'),
(2, 2, '2024-09-04', '10:30:00');

-- -----------------------------------------------------
-- RouteStartTime data insert statements below here
INSERT INTO `RouteStartTime` (`routeID`, `dayAndTimeStart`) VALUES
(1, 'mon09:00'),
(2, 'thu17:30');

-- -----------------------------------------------------
-- Waypoint data insert statements below here
INSERT INTO `Waypoint` (`routeID`, `locationID`, `relativeArrivalTime`, `relativeDepartureTime`) VALUES
(1, 1, 45, 75),
(2, 2, 60, 90);

