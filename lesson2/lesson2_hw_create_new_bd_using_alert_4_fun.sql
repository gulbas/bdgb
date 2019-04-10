CREATE SCHEMA IF NOT EXISTS `country_new`
  DEFAULT CHAR SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

use `country_new`;

CREATE TABLE IF NOT EXISTS `_countries`(
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

ALTER TABLE `_countries`
  ADD COLUMN `title` VARCHAR(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  ADD KEY `INDEX` (`title`);

CREATE TABLE `_regions` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

ALTER TABLE `_regions`
  ADD COLUMN `country_id` INT NOT NULL,
  ADD COLUMN `title` VARCHAR(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  ADD KEY `INDEX` (`title`),
  ADD CONSTRAINT `regions_countries_fk`
    FOREIGN KEY (`country_id`) REFERENCES `_countries` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE TABLE `_cities` (
  `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT
);

ALTER TABLE `_cities`
  ADD COLUMN `country_id` INT NOT NULL,
  ADD COLUMN `important` TINYINT(1) NOT NULL,
  ADD COLUMN `region_id` INT NOT NULL,
  ADD COLUMN `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  ADD KEY `INDEX` (`title`),
  ADD CONSTRAINT `cities_countries_fk`
    FOREIGN KEY (`country_id`) REFERENCES `_countries` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT `cities_region_fk`
    FOREIGN KEY (`region_id`) REFERENCES `_regions` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT;