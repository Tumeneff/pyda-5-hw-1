--=============== МОДУЛЬ 3. ОСНОВЫ SQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите для каждого покупателя его адрес проживания, 
--город и страну проживания.

select 
customer.first_name ||' '|| customer.last_name as "Фамилия и имя",
address.address  as "Адрес проживания",
city.city as "Город",
country.country as "Страна"
from public.customer
join address  on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id 




--ЗАДАНИЕ №2
--С помощью SQL-запроса посчитайте для каждого магазина количество его покупателей.
select customer.store_id as "Магазин", count(customer.customer_id) as "Количество покупателей"
from public.customer
group by store_id




--Доработайте запрос и выведите только те магазины, 
--у которых количество покупателей больше 300-от.
--Для решения используйте фильтрацию по сгруппированным строкам 
--с использованием функции агрегации.

select customer.store_id as "Магазин", count(customer.customer_id) as "Количество покупателей"
from public.customer
group by store_id
Having count(customer.customer_id) > 300




-- Доработайте запрос, добавив в него информацию о городе магазина, 
--а также фамилию и имя продавца, который работает в этом магазине.
select c.store_id as "Магазин", count(c.customer_id) as "Количество покупателей",
(select x.city from city x where a.city_id = x.city_id)  as "Город магаза",
b.first_name ||' '|| b.last_name as "ФИО продавца"
from customer c, staff b, address a 
where c.store_id = b.store_id
and b.address_id = a.address_id 
group by c.store_id, b.first_name, b.last_name, a.city_id 
 



--ЗАДАНИЕ №3
--Выведите ТОП-5 покупателей, 
--которые взяли в аренду за всё время наибольшее количество фильмов

select 
customer.first_name ||' '|| customer.last_name as "Фамилия и имя",
count(rental.rental_id) as "Количество арендованных фильмов"
from customer
join rental on customer.customer_id = rental.customer_id
group by first_name, last_name 



--ЗАДАНИЕ №4
--Посчитайте для каждого покупателя 4 аналитических показателя:
--  1. количество фильмов, которые он взял в аренду
--  2. общую стоимость платежей за аренду всех фильмов (значение округлите до целого числа)
--  3. минимальное значение платежа за аренду фильма
--  4. максимальное значение платежа за аренду фильма

select 
customer.first_name ||' '|| customer.last_name as "Фамилия и имя",
count(rental.rental_id) as "Количество арендованных фильмов",
round(sum(payment.amount)) as "Общая Cтоимость",
min(payment.amount) as "Минимальная стоимость",
max(payment.amount) as "Максимальная стоимость"
from customer
join rental on customer.customer_id = rental.customer_id
join payment on customer.customer_id = payment.customer_id
group by first_name, last_name 



--ЗАДАНИЕ №5
--Используя данные из таблицы городов составьте одним запросом всевозможные пары городов таким образом,
 --чтобы в результате не было пар с одинаковыми названиями городов. 
 --Для решения необходимо использовать декартово произведение.
 select a.city as "Город 1", b.city as "Город 2"  
 from city a, city b 
 where a.city_id != b.city_id




--ЗАДАНИЕ №6
--Используя данные из таблицы rental о дате выдачи фильма в аренду (поле rental_date)
--и дате возврата фильма (поле return_date), 
--вычислите для каждого покупателя среднее количество дней, за которые покупатель возвращает фильмы.
select c.first_name ||' '|| c.last_name as "Фамилия и имя",
avg(a.return_date - a.rental_date) as "срок возврата"
from rental a, customer c 
where a.customer_id = c.customer_id 
group by c.first_name, c.last_name



--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Посчитайте для каждого фильма сколько раз его брали в аренду и значение общей стоимости аренды фильма за всё время.
select f.title, count(distinct p.rental_id) as "количество  раз в аренду", sum(p.amount) as "Общая стоимость"
from film f, inventory i, payment p, rental r
where f.film_id = i.film_id
and i.inventory_id = r.inventory_id 
and r.rental_id = p.rental_id
group by f.title
order by 3 desc


--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания и выведите с помощью запроса фильмы, которые ни разу не брали в аренду.

select f.title, 
count(distinct p.rental_id) 
as "количество  раз в аренду", 
sum(p.amount) as "Общая стоимость"
from film f left join (inventory i 
join rental r on i.inventory_id = r.inventory_id  
join payment p on r.rental_id = p.rental_id) on f.film_id = i.film_id
group by f.title 
having count(distinct p.rental_id)=0



--ЗАДАНИЕ №3
--Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку "Премия".
--Если количество продаж превышает 7300, то значение в колонке будет "Да", иначе должно быть значение "Нет".


select b.first_name ||' '|| b.last_name as "ФИО продавца",
count(x.payment_id) as "Количество продаж",
	case 
		when count(x.payment_id) > 7300 then 'Да'
		else 'Нет'
	end as "Премия"
from staff b
join payment x on b.staff_id = x.staff_id
group by b.first_name, b.last_name 






