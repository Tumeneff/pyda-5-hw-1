--=============== МОДУЛЬ 4. УГЛУБЛЕНИЕ В SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--База данных: если подключение к облачной базе, то создаете новые таблицы в формате:
--таблица_фамилия, 
--если подключение к контейнеру или локальному серверу, то создаете новую схему и в ней создаете таблицы.


-- Спроектируйте базу данных для следующих сущностей:
-- 1. язык (в смысле английский, французский и тп)
-- 2. народность (в смысле славяне, англосаксы и тп)
-- 3. страны (в смысле Россия, Германия и тп)


--Правила следующие:
-- на одном языке может говорить несколько народностей
-- одна народность может входить в несколько стран
-- каждая страна может состоять из нескольких народностей

 
--Требования к таблицам-справочникам:
-- идентификатор сущности должен присваиваться автоинкрементом
-- наименования сущностей не должны содержать null значения и не должны допускаться дубликаты в названиях сущностей
 
--СОЗДАНИЕ ТАБЛИЦЫ ЯЗЫКИ
CREATE TABLE Languages_Tumenev(
lang_id serial primary key, 
lang_title varchar(100) NOT null unique
);
--drop table Languages_Tumenev


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ ЯЗЫКИ
insert into Languages_Tumenev(
lang_title)
values('Russian'),
('English'),
('French'),
('Spanish')


--СОЗДАНИЕ ТАБЛИЦЫ НАРОДНОСТИ
CREATE TABLE Nations_Tumenev(
Nations_id serial primary key, 
Nations_title varchar(100) NOT null unique 
);
--drop table Nations_Tumenev


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ НАРОДНОСТИ
insert into Nations_Tumenev(
Nations_title)
values('Russian'),
('Belorussian'),
('Ukrainian'),
('British'),
('Irish'),
('French'),
('Belgian'),
('Canadian'),
('Spanish'),
('Mexican'),
('Chilian')


--СОЗДАНИЕ ТАБЛИЦЫ СТРАНЫ
CREATE TABLE Countries_Tumenev(
Countries_id serial primary key, 
Countries_title varchar(100) NOT null unique
);
--drop table Countries_Tumenev


--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СТРАНЫ

insert into Countries_Tumenev(
Countries_title)
values('Russia'),
('Belorussia'),
('Ukrain'),
('Great Britain'),
('Ireland'),
('France'),
('Belgium'),
('Canada'),
('Spain'),
('Mexica'),
('Chili')

--СОЗДАНИЕ ПЕРВОЙ ТАБЛИЦЫ СО СВЯЗЯМИ

create table native_speakers_tumenev(
nationality_id serial primary key,
nationality int2 references Nations_Tumenev(Nations_id),
native_languages int2 references Languages_Tumenev(lang_id)
);
drop table native_speakers_tumenev

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ
insert into native_speakers_tumenev(nationality, native_languages)
values
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 3),
(7, 3),
(8, 3),
(9, 4),
(10, 4),
(11, 4)

--СОЗДАНИЕ ВТОРОЙ ТАБЛИЦЫ СО СВЯЗЯМИ
create table countries_and_nations_tumenev(
nationality_id serial primary key,
country int2 references Countries_Tumenev(Countries_id),
nations int2 references Nations_Tumenev(Nations_id)
);
--drop table countries_and_nations_tumenev

--ВНЕСЕНИЕ ДАННЫХ В ТАБЛИЦУ СО СВЯЗЯМИ

insert into countries_and_nations_tumenev(country, nations)
values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11)

--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============


--ЗАДАНИЕ №1 
--Создайте новую таблицу film_new со следующими полями:
--·   	film_name - название фильма - тип данных varchar(255) и ограничение not null
--·   	film_year - год выпуска фильма - тип данных integer, условие, что значение должно быть больше 0
--·   	film_rental_rate - стоимость аренды фильма - тип данных numeric(4,2), значение по умолчанию 0.99
--·   	film_duration - длительность фильма в минутах - тип данных integer, ограничение not null и условие, что значение должно быть больше 0
--Если работаете в облачной базе, то перед названием таблицы задайте наименование вашей схемы.



--ЗАДАНИЕ №2 
--Заполните таблицу film_new данными с помощью SQL-запроса, где колонкам соответствуют массивы данных:
--·       film_name - array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']
--·       film_year - array[1994, 1999, 1985, 1994, 1993]
--·       film_rental_rate - array[2.99, 0.99, 1.99, 2.99, 3.99]
--·   	  film_duration - array[142, 189, 116, 142, 195]



--ЗАДАНИЕ №3
--Обновите стоимость аренды фильмов в таблице film_new с учетом информации, 
--что стоимость аренды всех фильмов поднялась на 1.41



--ЗАДАНИЕ №4
--Фильм с названием "Back to the Future" был снят с аренды, 
--удалите строку с этим фильмом из таблицы film_new



--ЗАДАНИЕ №5
--Добавьте в таблицу film_new запись о любом другом новом фильме



--ЗАДАНИЕ №6
--Напишите SQL-запрос, который выведет все колонки из таблицы film_new, 
--а также новую вычисляемую колонку "длительность фильма в часах", округлённую до десятых



--ЗАДАНИЕ №7 
--Удалите таблицу film_new