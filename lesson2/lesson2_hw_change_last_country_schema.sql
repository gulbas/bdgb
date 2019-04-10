USE `country`;

ALTER TABLE `countries`
  RENAME TO `_countries`,
  MODIFY COLUMN `title` VARCHAR(150) NOT NULL,
  ADD INDEX `title` (`title`),
  DROP INDEX `name_UNIQUE`;

ALTER TABLE `regions`
  RENAME TO `_regions`,
  MODIFY COLUMN `title` VARCHAR(150) NOT NULL AFTER `country_id`,
  ADD INDEX `title` (`title`);

ALTER TABLE `cities`
  RENAME TO `_cities`,
  DROP COLUMN `population`,
  MODIFY COLUMN `title` VARCHAR(150) NOT NULL AFTER `region_id`,
  ADD COLUMN `important` TINYINT(1) NOT NULL AFTER `country_id`,
  ADD INDEX `title` (`title`);