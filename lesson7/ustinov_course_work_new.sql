DROP SCHEMA IF EXISTS `social_network`;
CREATE SCHEMA `social_network`
    DEFAULT CHAR SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE `social_network`;

-- таблица пользователей
CREATE TABLE `users`
(
    `id`   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(25) NOT NULL
);

ALTER TABLE `users`
    ADD KEY `INDEX` (`name`);

INSERT INTO `users` (`name`)
VALUES ('Sergei'),
       ('Olya'),
       ('Petya'),
       ('Kolya');

-- создадим сервисы
CREATE TABLE `services`
(
    `id`    INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(25) NOT NULL UNIQUE
);

ALTER TABLE `services`
    ADD KEY `INDEX` (`title`);

INSERT INTO `services` (`title`)
VALUES ('comment'),
       ('photo'),
       ('profile');

-- создадим профили (в профиле будут храниться используемые сервисы )
CREATE TABLE `profiles`
(
    `id`         INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id`    INT NOT NULL,
    `service_id` INT NOT NULL
);

ALTER TABLE `profiles`
    ADD CONSTRAINT `user_id_fk`
        FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    ADD CONSTRAINT `service_id_fk`
        FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT;

INSERT INTO `profiles` (`user_id`, `service_id`)
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (2, 1),
       (1, 2),
       (2, 2),
       (3, 2),
       (2, 2),
       (2, 3),
       (3, 3),
       (4, 3),
       (2, 3),
       (1, 2),
       (2, 2),
       (3, 2),
       (2, 2),
       (2, 3),
       (3, 3),
       (2, 3);

-- создадим лайки
CREATE TABLE `likes`
(
    `id`         INT,
    `user_id`    INT NOT NULL,
    `service_id` INT NOT NULL,
    PRIMARY KEY (`user_id`, `service_id`)
);

ALTER TABLE `likes`
    ADD CONSTRAINT `user_id_likes_fk`
        FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    ADD CONSTRAINT `services_id_likes_fk`
        FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT;

INSERT INTO likes (user_id, service_id)
VALUES (4,2);

# Сохраним запрос
CREATE VIEW services_view AS
SELECT `profiles`.`id`, `users`.`name`, `services`.`title` AS `servises`
FROM `users`
         LEFT JOIN profiles
                   ON `users`.id = `profiles`.`user_id`
         JOIN `services`
              ON `profiles`.`service_id` = `services`.`id`;