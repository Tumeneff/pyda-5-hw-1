--=============== ������ 2. ������ � ������ ������ =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--�������� ���������� �������� �������� �� ������� �������
SELECT distinct address.district AS "adress" from public.address;




--������� �2
--����������� ������ �� ����������� �������, ����� ������ ������� ������ �� �������, 
--�������� ������� ���������� �� "K" � ������������� �� "a", � �������� �� �������� ��������
SELECT distinct address.district
AS "adress" 
from public.address
where
address.district like 'K%' and address.district like '%a';




--������� �3
--�������� �� ������� �������� �� ������ ������� ���������� �� ��������, ������� ����������� 
--� ���������� � 17 ����� 2007 ���� �� 19 ����� 2007 ���� ������������, 
--� ��������� ������� ��������� 1.00.
--������� ����� ������������� �� ���� �������.

SELECT payment.* 
from public.payment
where
payment_date between '03-17-2007' and '03-20-2007'
and amount > 1
order by payment_date desc;




--������� �4
-- �������� ���������� � 10-�� ��������� �������� �� ������ �������.
SELECT payment.* 
from public.payment
order by payment_date desc limit 10;




--������� �5
--�������� ��������� ���������� �� �����������:
--  1. ������� � ��� (� ����� ������� ����� ������)
--  2. ����������� �����
--  3. ����� �������� ���� email
--  4. ���� ���������� ���������� ������ � ���������� (��� �������)
--������ ������� ������� ������������ �� ������� �����.
select customer.first_name ||' '|| customer.last_name as "������� � ���",
length(email) as "����� ����",
date_trunc('day', last_update) as "����"
from public.customer




--������� �6
--�������� ����� �������� �������� �����������, ����� ������� Kelly ��� Willie.
--��� ����� � ������� � ����� �� ������� �������� ������ ���� ���������� � ������� �������.


select upper(customer.first_name), activebool 
from public.customer
where first_name = 'Kelly' and activebool = True or first_name = 'Willie' and activebool = True;


--======== �������������� ����� ==============

--������� �1
--�������� ����� �������� ���������� � �������, � ������� ������� "R" 
--� ��������� ������ ������� �� 0.00 �� 3.00 ������������, 
--� ����� ������ c ��������� "PG-13" � ���������� ������ ������ ��� ������ 4.00.

select film.title, film.rating, film.rental_rate
from public.film 
where rating = 'R' and rental_rate <=3.01 or rating = 'PG-13' and rental_rate >=4.00




--������� �2
--�������� ���������� � ��� ������� � ����� ������� ��������� ������.
select film.title, film.description, length(description) as length
from public.film 
order by length(description)  desc limit 3



--������� �3
-- �������� Email ������� ����������, �������� �������� Email �� 2 ��������� �������:
--� ������ ������� ������ ���� ��������, ��������� �� @, 
--�� ������ ������� ������ ���� ��������, ��������� ����� @.

select split_part(customer.email, '@', 1) as "name", split_part(customer.email, '@', 2) as "domain"
from public.customer



--������� �4
--����������� ������ �� ����������� �������, �������������� �������� � ����� ��������: 
--������ ����� ������ ���� ���������, ��������� ���������.
select initcap(split_part(customer.email, '@', 1)) as "name", initcap(split_part(customer.email, '@', 2)) as "domain"
from public.customer



