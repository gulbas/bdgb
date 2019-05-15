DROP SCHEMA IF EXISTS  `social_network`; 
CREATE SCHEMA `social_network`
  DEFAULT CHAR SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE `social_network`;

-- таблица пользователей
CREATE TABLE `users` (
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(25) NOT NULL
);

ALTER TABLE `users`
	ADD KEY `INDEX` (`name`);
    
INSERT INTO `users` (`name`) VALUES ('Sergei'), ('Olya'), ('Petya'), ('Kolya');

-- создадим сервисы
CREATE TABLE `servises` (
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `title` VARCHAR(25) NOT NULL UNIQUE 
);

ALTER TABLE `servises`
	ADD KEY `INDEX` (`title`);
    
INSERT INTO `servises` (`title`) VALUES ('comment'), ('photo'), ('profile');

-- создадим профили (в профиле будут храниться используемые сервисы )
CREATE TABLE `profiles` (
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `servise_id` INT NOT NULL
);

ALTER TABLE `profiles`
  ADD CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT `servise_id_fk`
    FOREIGN KEY (`servise_id`) REFERENCES `servises` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT;
      
INSERT INTO `profiles` (`user_id`, `servise_id`) VALUES
 (1, 1),
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
CREATE TABLE `likes` (
	`id` INT,
    `user_id` INT NOT NULL,
    `servise_id` INT NOT NULL,
    PRIMARY KEY (`user_id`, `servise_id`)
);

ALTER TABLE `likes`
  ADD CONSTRAINT `user_id_likes_fk`
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT,
  ADD CONSTRAINT `servise_id_likes_fk`
    FOREIGN KEY (`servise_id`) REFERENCES `servises` (`id`)
      ON UPDATE CASCADE ON DELETE RESTRICT;