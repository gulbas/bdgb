-- 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.
CREATE VIEW `how_much_money_the_department_receives` AS
SELECT `depart`.`name` AS `Отдел`, COUNT(`staff`.`id`) AS `Колисчество сотрудников`, SUM(`staff`.`salary`) AS `ФОТ`
FROM `depart` 
LEFT JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;

CREATE VIEW `number_of_employees_in_departments` AS
SELECT `depart`.`name` AS `Отдел`, COUNT(`staff`.`id`) AS `Колисчество сотрудников` FROM `depart` 
LEFT JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;

CREATE VIEW `average_salary_by_department` AS
SELECT `depart`.`name` AS `Отдел`, AVG(`staff`.`salary`) AS `Средняя зарплата` FROM `depart` 
INNER JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;

-- 2. Создать функцию, которая найдет менеджера по имени и фамилии.
DELIMITER $$
CREATE PROCEDURE `manager_search_by_last_name_and_first_name` (lastname VARCHAR(40), firstname VARCHAR(40)) 
	BEGIN
		SELECT `staff`.`id`, CONCAT(`staff`.`name`, ' ', `staff`.`lastname`) AS `Имя Фамилия`, `depart`.`name`
		AS `Отдел`, `staff`.`position` AS `Должность`, `staff`.`salary` AS `Зарплата` FROM `depart`
		INNER JOIN `staff` ON  `staff`.`depart` = `depart`.`id` 
		WHERE `staff`.`name` = firstname AND `staff`.`lastname` = lastname;
	END$$
DELIMITER ;

-- 3. Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.
#Сначала создадим таблицу
CREATE TABLE IF NOT EXISTS `salary` (
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`bonus` INT NOT NULL,
	`id_staff` INT NOT NULL
);

CREATE TRIGGER `added_bonus`
AFTER INSERT ON `staff`
FOR EACH ROW
INSERT INTO `salary` (`salary`.`bonus`, `salary`.`id_staff`) VALUES (5000, NEW.id);
