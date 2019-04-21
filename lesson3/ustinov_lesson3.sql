USE `country`;

-- 1. Сделать запрос, в котором мы выберем все данные о городе – регион, страна.
SELECT `_cities`.`title` as `Город`, `_regions`.`title` as `Регион`, `_countries`.`title` as `Страна` from `_cities` 
JOIN `_countries` ON `_cities`.`country_id` = `_countries`.`id` JOIN `_regions` ON `_cities`.`region_id` = `_regions`.`id`;

-- 2. Выбрать все города из Краснодарского края.
SELECT `_cities`.`title` as `Город`, `_regions`.`title` as `Регион`, `_countries`.`title` as `Страна` from `_cities` 
JOIN `_countries` ON `_countries`.`id` = `_cities`.`country_id` 
JOIN `_regions` ON  `_regions`.`id` = `_cities`.`region_id` 
HAVING `Регион` LIKE 'Краснодарский край';

USE `lesson3`;

-- 1. Выбрать среднюю зарплату по отделам.
SELECT `depart`.`name` AS `Отдел`, AVG(`staff`.`salary`) AS `Средняя зарплата` FROM `depart` 
INNER JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;

-- 2. Выбрать максимальную зарплату у сотрудника.
SELECT CONCAT(`lastname`, ' ', `name`) AS `Фамилия Имя`, `salary` AS `Зарплата` FROM `staff` 
WHERE `salary` = (SELECT MAX(`salary`) FROM `staff`);

-- 3. Удалить одного сотрудника, у которого максимальная зарплата.
#1-й способ:
DELETE FROM `staff` WHERE `id` = 
	(SELECT * FROM 
		(SELECT `id` FROM `staff` WHERE `salary` = 
			(SELECT MAX(`salary`) FROM `staff`) 
		LIMIT 1) 
	AS `temp_table`);
#2-й способ:
DELETE FROM `staff`
ORDER BY `salary` DESC LIMIT 1;
#3-й способ c переменной:
SET @id = (SELECT `id` FROM `staff` WHERE `salary` = (SELECT MAX(`salary`) FROM `staff`));
DELETE FROM `staff` WHERE `id` = @id;

-- 4. Посчитать количество сотрудников во всех отделах.
SELECT `depart`.`name` AS `Отдел`, COUNT(`staff`.`id`) AS `Колисчество сотрудников` FROM `depart` 
LEFT JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;

-- 5. Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT `depart`.`name` AS `Отдел`, COUNT(`staff`.`id`) AS `Колисчество сотрудников`, SUM(`staff`.`salary`) AS `ФОТ` FROM `depart` 
LEFT JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;