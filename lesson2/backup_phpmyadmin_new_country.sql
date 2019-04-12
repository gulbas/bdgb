-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 10 2019 г., 22:13
-- Версия сервера: 8.0.15
-- Версия PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `country`
--

-- --------------------------------------------------------

--
-- Структура таблицы `_cities`
--

CREATE TABLE `_cities` (
  `id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `important` tinyint(1) NOT NULL,
  `region_id` int(11) NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `_cities`
--

INSERT INTO `_cities` (`id`, `country_id`, `important`, `region_id`, `title`) VALUES
(1, 1, 0, 1, 'Краснодар'),
(2, 1, 0, 2, 'Ростов'),
(3, 2, 0, 3, 'Гомель'),
(4, 2, 0, 4, 'Минск'),
(5, 4, 0, 5, 'Кордова'),
(6, 4, 0, 5, 'Малага'),
(7, 4, 0, 6, 'Вальядолид'),
(8, 3, 0, 7, 'Аоста'),
(9, 3, 0, 8, 'Венеция');

-- --------------------------------------------------------

--
-- Структура таблицы `_countries`
--

CREATE TABLE `_countries` (
  `id` int(11) NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `_countries`
--

INSERT INTO `_countries` (`id`, `title`) VALUES
(2, 'Belarus'),
(3, 'Italy'),
(1, 'Russia'),
(4, 'Spain');

-- --------------------------------------------------------

--
-- Структура таблицы `_regions`
--

CREATE TABLE `_regions` (
  `id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `_regions`
--

INSERT INTO `_regions` (`id`, `country_id`, `title`) VALUES
(1, 1, 'Краснодарский край'),
(2, 1, 'Ростовская область'),
(3, 2, 'Гомельская область'),
(4, 2, 'Минская область'),
(5, 4, 'Андалусия'),
(6, 4, 'Кастилия-Леон'),
(7, 3, 'Валле-д’Аоста'),
(8, 3, 'Венеция');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `_cities`
--
ALTER TABLE `_cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cities_regions__fk` (`region_id`),
  ADD KEY `cities_countries__fk` (`country_id`),
  ADD KEY `title` (`title`);

--
-- Индексы таблицы `_countries`
--
ALTER TABLE `_countries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `title` (`title`);

--
-- Индексы таблицы `_regions`
--
ALTER TABLE `_regions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `regions_countries__fk` (`country_id`),
  ADD KEY `title` (`title`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `_cities`
--
ALTER TABLE `_cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `_countries`
--
ALTER TABLE `_countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `_regions`
--
ALTER TABLE `_regions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `_cities`
--
ALTER TABLE `_cities`
  ADD CONSTRAINT `cities_countries__fk` FOREIGN KEY (`country_id`) REFERENCES `_countries` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cities_regions__fk` FOREIGN KEY (`region_id`) REFERENCES `_regions` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `_regions`
--
ALTER TABLE `_regions`
  ADD CONSTRAINT `regions_countries__fk` FOREIGN KEY (`country_id`) REFERENCES `_countries` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
