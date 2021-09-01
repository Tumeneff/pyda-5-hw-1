--=============== МОДУЛЬ 5. РАБОТА С POSTGRESQL =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Сделайте запрос к таблице payment и с помощью оконных функций добавьте вычисляемые колонки согласно условиям:
--	Пронумеруйте все платежи от 1 до N по дате
SELECT pa.*, rank() over (order by pa.payment_date) as num_pay FROM payment pa

--	Пронумеруйте платежи для каждого покупателя, сортировка платежей должна быть по дате
SELECT pa.*, rank() over (partition by pa.customer_id order by pa.payment_date) as num_cust_pay FROM payment pa
  
--	Посчитайте нарастающим итогом сумму всех платежей для каждого покупателя, сортировка должна быть сперва по дате платежа, а затем по сумме платежа от наименьшей к большей
SELECT pa.*, sum(pa.amount) over (partition by pa.customer_id order by cast(pa.payment_date as date), pa.amount) as sum_by_cust FROM payment pa
  
--	Пронумеруйте платежи для каждого покупателя по стоимости платежа от наибольших к меньшим так, чтобы платежи с одинаковым значением имели одинаковое значение номера.
SELECT pa.*, dense_rank()  over (partition by pa.customer_id order by pa.amount desc) as num_cust_sum FROM payment pa
  
  -- Можно составить на каждый пункт отдельный SQL-запрос, а можно объединить все колонки в одном запросе.





--ЗАДАНИЕ №2
-- С помощью оконной функции выведите для каждого покупателя стоимость платежа 
-- и стоимость платежа из предыдущей строки со значением по умолчанию 0.0 с сортировкой по дате.
SELECT pa.*, sum(pa.amount) over(partition by pa.customer_id) as sum_cust,
  lag(pa.amount,1,0.00) over(partition by pa.customer_id order by pa.payment_date) 
FROM payment pa

-- Не очень понял чего требуется, поэтому второй вариант
-- считает для каждого покупателя сумму платежей и последнюю дату платежа 
-- и уже из них делает требуемую выборку 
select pa2.customer_id, pa2.sum_cust_amount, pa2.last_cust_date,
  lag(pa2.sum_cust_amount,1,0.00) over(order by pa2.last_cust_date)
from (select pa.customer_id, pa.payment_date,
  sum(pa.amount) over(partition by pa.customer_id) as sum_cust_amount,
  max(pa.payment_date) over(partition by pa.customer_id) as last_cust_date
  from payment pa) as pa2
where pa2.payment_date=pa2.last_cust_date




--ЗАДАНИЕ №3
-- С помощью оконной функции определите, на сколько каждый 
-- следующий платеж покупателя больше или меньше текущего.
SELECT pa.*, lead(pa.amount,1,pa.amount) over(partition by pa.customer_id order by pa.payment_date) - pa.amount as delta_of_next_amount
FROM payment pa





--ЗАДАНИЕ №4
-- С помощью оконной функции для каждого покупателя выведите данные о его последней оплате аренды.
select pa2.*
from (select pa.*, max(pa.payment_date) over(partition by pa.customer_id) max_date
	from payment pa) as pa2
where pa2.payment_date=pa2.max_date


--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--С помощью оконной функции выведите для каждого сотрудника сумму продаж за март 2007 года
-- с нарастающим итогом по каждому сотруднику и 
-- по каждой дате продажи (без учёта времени) с сортировкой по дате.




--ЗАДАНИЕ №2
--10 апреля 2007 года в магазинах проходила акция: покупатель, совершивший каждый 100ый платеж
-- получал дополнительную скидку на следующую аренду.
-- С помощью оконной функции выведите всех покупателей, которые в день проведения акции получили скидку.




--ЗАДАНИЕ №3
--Для каждой страны определите и выведите одним SQL-запросом покупателей, которые попадают под условия:
-- 1. покупатель, арендовавший наибольшее количество фильмов
-- 2. покупатель, арендовавший фильмов на самую большую сумму
-- 3. покупатель, который последним арендовал фильм






