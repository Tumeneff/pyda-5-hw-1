--=============== ������ 5. ������ � POSTGRESQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--�������� ������ � ������� payment � � ������� ������� ������� �������� ����������� ������� �������� ��������:
--	������������ ��� ������� �� 1 �� N �� ����
SELECT pa.*, rank() over (order by pa.payment_date) as num_pay FROM payment pa

--	������������ ������� ��� ������� ����������, ���������� �������� ������ ���� �� ����
SELECT pa.*, rank() over (partition by pa.customer_id order by pa.payment_date) as num_cust_pay FROM payment pa
  
--	���������� ����������� ������ ����� ���� �������� ��� ������� ����������, ���������� ������ ���� ������ �� ���� �������, � ����� �� ����� ������� �� ���������� � �������
SELECT pa.*, sum(pa.amount) over (partition by pa.customer_id order by cast(pa.payment_date as date), pa.amount) as sum_by_cust FROM payment pa
  
--	������������ ������� ��� ������� ���������� �� ��������� ������� �� ���������� � ������� ���, ����� ������� � ���������� ��������� ����� ���������� �������� ������.
SELECT pa.*, dense_rank()  over (partition by pa.customer_id order by pa.amount desc) as num_cust_sum FROM payment pa
  
  -- ����� ��������� �� ������ ����� ��������� SQL-������, � ����� ���������� ��� ������� � ����� �������.





--������� �2
-- � ������� ������� ������� �������� ��� ������� ���������� ��������� ������� 
-- � ��������� ������� �� ���������� ������ �� ��������� �� ��������� 0.0 � ����������� �� ����.
SELECT pa.*, sum(pa.amount) over(partition by pa.customer_id) as sum_cust,
  lag(pa.amount,1,0.00) over(partition by pa.customer_id order by pa.payment_date) 
FROM payment pa

-- �� ����� ����� ���� ���������, ������� ������ �������
-- ������� ��� ������� ���������� ����� �������� � ��������� ���� ������� 
-- � ��� �� ��� ������ ��������� ������� 
select pa2.customer_id, pa2.sum_cust_amount, pa2.last_cust_date,
  lag(pa2.sum_cust_amount,1,0.00) over(order by pa2.last_cust_date)
from (select pa.customer_id, pa.payment_date,
  sum(pa.amount) over(partition by pa.customer_id) as sum_cust_amount,
  max(pa.payment_date) over(partition by pa.customer_id) as last_cust_date
  from payment pa) as pa2
where pa2.payment_date=pa2.last_cust_date




--������� �3
-- � ������� ������� ������� ����������, �� ������� ������ 
-- ��������� ������ ���������� ������ ��� ������ ��������.
SELECT pa.*, lead(pa.amount,1,pa.amount) over(partition by pa.customer_id order by pa.payment_date) - pa.amount as delta_of_next_amount
FROM payment pa





--������� �4
-- � ������� ������� ������� ��� ������� ���������� �������� ������ � ��� ��������� ������ ������.
select pa2.*
from (select pa.*, max(pa.payment_date) over(partition by pa.customer_id) max_date
	from payment pa) as pa2
where pa2.payment_date=pa2.max_date


--======== �������������� ����� ==============

--������� �1
--� ������� ������� ������� �������� ��� ������� ���������� ����� ������ �� ���� 2007 ����
-- � ����������� ������ �� ������� ���������� � 
-- �� ������ ���� ������� (��� ����� �������) � ����������� �� ����.




--������� �2
--10 ������ 2007 ���� � ��������� ��������� �����: ����������, ����������� ������ 100�� ������
-- ������� �������������� ������ �� ��������� ������.
-- � ������� ������� ������� �������� ���� �����������, ������� � ���� ���������� ����� �������� ������.




--������� �3
--��� ������ ������ ���������� � �������� ����� SQL-�������� �����������, ������� �������� ��� �������:
-- 1. ����������, ������������ ���������� ���������� �������
-- 2. ����������, ������������ ������� �� ����� ������� �����
-- 3. ����������, ������� ��������� ��������� �����






