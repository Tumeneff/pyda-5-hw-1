--=============== МОДУЛЬ 2. РАБОТА С БАЗАМИ ДАННЫХ =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите уникальные названия регионов из таблицы адресов
SELECT distinct address.district AS "adress" from public.address;




--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания, чтобы запрос выводил только те регионы, 
--названия которых начинаются на "K" и заканчиваются на "a", и названия не содержат пробелов
SELECT distinct address.district
AS "adress" 
from public.address
where
address.district like 'K%' and address.district like '%a';




--ЗАДАНИЕ №3
--Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись 
--в промежуток с 17 марта 2007 года по 19 марта 2007 года включительно, 
--и стоимость которых превышает 1.00.
--Платежи нужно отсортировать по дате платежа.

SELECT payment.* 
from public.payment
where
payment_date between '03-17-2007' and '03-20-2007'
and amount > 1
order by payment_date desc;




--ЗАДАНИЕ №4
-- Выведите информацию о 10-ти последних платежах за прокат фильмов.
SELECT payment.* 
from public.payment
order by payment_date desc limit 10;




--ЗАДАНИЕ №5
--Выведите следующую информацию по покупателям:
--  1. Фамилия и имя (в одной колонке через пробел)
--  2. Электронная почта
--  3. Длину значения поля email
--  4. Дату последнего обновления записи о покупателе (без времени)
--Каждой колонке задайте наименование на русском языке.
select customer.first_name ||' '|| customer.last_name as "Фамилия и имя",
length(email) as "длина мыла",
date_trunc('day', last_update) as "Дата"
from public.customer




--ЗАДАНИЕ №6
--Выведите одним запросом активных покупателей, имена которых Kelly или Willie.
--Все буквы в фамилии и имени из нижнего регистра должны быть переведены в высокий регистр.


select upper(customer.first_name), activebool 
from public.customer
where first_name = 'Kelly' and activebool = True or first_name = 'Willie' and activebool = True;


--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите одним запросом информацию о фильмах, у которых рейтинг "R" 
--и стоимость аренды указана от 0.00 до 3.00 включительно, 
--а также фильмы c рейтингом "PG-13" и стоимостью аренды больше или равной 4.00.

select film.title, film.rating, film.rental_rate
from public.film 
where rating = 'R' and rental_rate <=3.01 or rating = 'PG-13' and rental_rate >=4.00




--ЗАДАНИЕ №2
--Получите информацию о трёх фильмах с самым длинным описанием фильма.
select film.title, film.description, length(description) as length
from public.film 
order by length(description)  desc limit 3



--ЗАДАНИЕ №3
-- Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
--в первой колонке должно быть значение, указанное до @, 
--во второй колонке должно быть значение, указанное после @.

select split_part(customer.email, '@', 1) as "name", split_part(customer.email, '@', 2) as "domain"
from public.customer



--ЗАДАНИЕ №4
--Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: 
--первая буква должна быть заглавной, остальные строчными.
select initcap(split_part(customer.email, '@', 1)) as "name", initcap(split_part(customer.email, '@', 2)) as "domain"
from public.customer



