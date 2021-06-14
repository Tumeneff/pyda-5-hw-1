--=============== ������ 3. ������ SQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--�������� ��� ������� ���������� ��� ����� ����������, 
--����� � ������ ����������.

select 
customer.first_name ||' '|| customer.last_name as "������� � ���",
address.address  as "����� ����������",
city.city as "�����",
country.country as "������"
from public.customer
join address  on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id 




--������� �2
--� ������� SQL-������� ���������� ��� ������� �������� ���������� ��� �����������.
select customer.store_id as "�������", count(customer.customer_id) as "���������� �����������"
from public.customer
group by store_id




--����������� ������ � �������� ������ �� ��������, 
--� ������� ���������� ����������� ������ 300-��.
--��� ������� ����������� ���������� �� ��������������� ������� 
--� �������������� ������� ���������.

select customer.store_id as "�������", count(customer.customer_id) as "���������� �����������"
from public.customer
group by store_id
Having count(customer.customer_id) > 300




-- ����������� ������, ������� � ���� ���������� � ������ ��������, 
--� ����� ������� � ��� ��������, ������� �������� � ���� ��������.
select c.store_id as "�������", count(c.customer_id) as "���������� �����������",
(select x.city from city x where a.city_id = x.city_id)  as "����� ������",
b.first_name ||' '|| b.last_name as "��� ��������"
from customer c, staff b, address a 
where c.store_id = b.store_id
and b.address_id = a.address_id 
group by c.store_id, b.first_name, b.last_name, a.city_id 
 



--������� �3
--�������� ���-5 �����������, 
--������� ����� � ������ �� �� ����� ���������� ���������� �������

select 
customer.first_name ||' '|| customer.last_name as "������� � ���",
count(rental.rental_id) as "���������� ������������ �������"
from customer
join rental on customer.customer_id = rental.customer_id
group by first_name, last_name 



--������� �4
--���������� ��� ������� ���������� 4 ������������� ����������:
--  1. ���������� �������, ������� �� ���� � ������
--  2. ����� ��������� �������� �� ������ ���� ������� (�������� ��������� �� ������ �����)
--  3. ����������� �������� ������� �� ������ ������
--  4. ������������ �������� ������� �� ������ ������

select 
customer.first_name ||' '|| customer.last_name as "������� � ���",
count(rental.rental_id) as "���������� ������������ �������",
round(sum(payment.amount)) as "����� C��������",
min(payment.amount) as "����������� ���������",
max(payment.amount) as "������������ ���������"
from customer
join rental on customer.customer_id = rental.customer_id
join payment on customer.customer_id = payment.customer_id
group by first_name, last_name 



--������� �5
--��������� ������ �� ������� ������� ��������� ����� �������� ������������ ���� ������� ����� �������,
 --����� � ���������� �� ���� ��� � ����������� ���������� �������. 
 --��� ������� ���������� ������������ ��������� ������������.
 select a.city as "����� 1", b.city as "����� 2"  
 from city a, city b 
 where a.city_id != b.city_id




--������� �6
--��������� ������ �� ������� rental � ���� ������ ������ � ������ (���� rental_date)
--� ���� �������� ������ (���� return_date), 
--��������� ��� ������� ���������� ������� ���������� ����, �� ������� ���������� ���������� ������.
select c.first_name ||' '|| c.last_name as "������� � ���",
avg(a.return_date - a.rental_date) as "���� ��������"
from rental a, customer c 
where a.customer_id = c.customer_id 
group by c.first_name, c.last_name



--======== �������������� ����� ==============

--������� �1
--���������� ��� ������� ������ ������� ��� ��� ����� � ������ � �������� ����� ��������� ������ ������ �� �� �����.
select f.title, count(distinct p.rental_id) as "����������  ��� � ������", sum(p.amount) as "����� ���������"
from film f, inventory i, payment p, rental r
where f.film_id = i.film_id
and i.inventory_id = r.inventory_id 
and r.rental_id = p.rental_id
group by f.title
order by 3 desc


--������� �2
--����������� ������ �� ����������� ������� � �������� � ������� ������� ������, ������� �� ���� �� ����� � ������.

select f.title, 
count(distinct p.rental_id) 
as "����������  ��� � ������", 
sum(p.amount) as "����� ���������"
from film f left join (inventory i 
join rental r on i.inventory_id = r.inventory_id  
join payment p on r.rental_id = p.rental_id) on f.film_id = i.film_id
group by f.title 
having count(distinct p.rental_id)=0



--������� �3
--���������� ���������� ������, ����������� ������ ���������. �������� ����������� ������� "������".
--���� ���������� ������ ��������� 7300, �� �������� � ������� ����� "��", ����� ������ ���� �������� "���".


select b.first_name ||' '|| b.last_name as "��� ��������",
count(x.payment_id) as "���������� ������",
	case 
		when count(x.payment_id) > 7300 then '��'
		else '���'
	end as "������"
from staff b
join payment x on b.staff_id = x.staff_id
group by b.first_name, b.last_name 






