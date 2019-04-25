# task 1
USE `lesson3`;
LOCK TABLE `salary` READ;
SELECT * FROM `salary`;
INSERT INTO `salary` VALUES (NULL, 10000, 7);
-- запрос "висит" 
-- если блокировать через workbanch то можно получить ошибку Error Code: 1099. Table 'salary' was locked with a READ lock and can't be updated
UNLOCK TABLE;

INSERT INTO `salary` VALUES (NULL, 30000, 7);
-- теперь данные добавились

# task 2
SET AUTOCOMMIT = 0; 

BEGIN;
SET @head_id = (SELECT `id` FROM `staff` WHERE `salary` = (SELECT MAX(`salary`) FROM `staff`) LIMIT 1);
SET @depart_id = (SELECT `depart` FROM `staff` WHERE `id` = @head_id);
UPDATE `depart` SET `head_id` = @head_id WHERE `id` = @depart_id; 
COMMIT;

BEGIN;
SET @id_min_salary := (SELECT `id` FROM `staff` WHERE `salary` = (SELECT MIN(`salary`) FROM `staff`) LIMIT 1);
SET @depart_id := (SELECT `depart` FROM `staff` WHERE `id` = @id_min_salary);
SET @avg_salary := (SELECT AVG(`salary`) FROM `staff`);
SET @min_salary := (SELECT MIN(`salary`) FROM `staff`);
INSERT INTO `salary` (`bonus`, `id_staff`) VALUES  (@avg_salary - @min_salary, @id_min_salary);
COMMIT;

# task 3
EXPLAIN 
SELECT CONCAT(`lastname`, ' ', `name`) AS `Фамилия Имя`, `salary` AS `Зарплата` FROM `staff` 
WHERE `salary` = (SELECT MAX(`salary`) FROM `staff`);

EXPLAIN 
SELECT MAX(`salary`) FROM `staff`;

EXPLAIN
SELECT `depart`.`name` AS `Отдел`, COUNT(`staff`.`id`) AS `Колисчество сотрудников` FROM `depart` 
LEFT JOIN `staff` ON `depart`.`id` = `staff`.`depart` 
GROUP BY `depart`.`name`;


SET @max_salary := (SELECT `id` FROM `staff` WHERE `salary` = (SELECT MAX(`salary`) FROM `staff`) LIMIT 1);
EXPLAIN 
SELECT CONCAT(`lastname`, ' ', `name`) AS `Фамилия Имя`, `salary` AS `Зарплата` FROM `staff` 
WHERE `id` = @max_salary;