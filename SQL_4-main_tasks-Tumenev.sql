--=============== ������ 4. ���������� � SQL =======================================
--= �������, ��� ���������� ���������� ������ ���������� � ������� ����� PUBLIC===========
SET search_path TO public;

--======== �������� ����� ==============

--������� �1
--���� ������: ���� ����������� � �������� ����, �� �������� ����� ������� � �������:
--�������_�������, 
--���� ����������� � ���������� ��� ���������� �������, �� �������� ����� ����� � � ��� �������� �������.


-- ������������� ���� ������ ��� ��������� ���������:
-- 1. ���� (� ������ ����������, ����������� � ��)
-- 2. ���������� (� ������ �������, ���������� � ��)
-- 3. ������ (� ������ ������, �������� � ��)


--������� ���������:
-- �� ����� ����� ����� �������� ��������� �����������
-- ���� ���������� ����� ������� � ��������� �����
-- ������ ������ ����� �������� �� ���������� �����������

 
--���������� � ��������-������������:
-- ������������� �������� ������ ������������� ���������������
-- ������������ ��������� �� ������ ��������� null �������� � �� ������ ����������� ��������� � ��������� ���������
 
--�������� ������� �����
CREATE TABLE Languages_Tumenev(
lang_id serial primary key, 
lang_title varchar(100) NOT null unique
);
--drop table Languages_Tumenev


--�������� ������ � ������� �����
insert into Languages_Tumenev(
lang_title)
values('Russian'),
('English'),
('French'),
('Spanish')


--�������� ������� ����������
CREATE TABLE Nations_Tumenev(
Nations_id serial primary key, 
Nations_title varchar(100) NOT null unique 
);
--drop table Nations_Tumenev


--�������� ������ � ������� ����������
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


--�������� ������� ������
CREATE TABLE Countries_Tumenev(
Countries_id serial primary key, 
Countries_title varchar(100) NOT null unique
);
--drop table Countries_Tumenev


--�������� ������ � ������� ������

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

--�������� ������ ������� �� �������

create table native_speakers_tumenev(
nationality_id serial primary key,
nationality int2 references Nations_Tumenev(Nations_id),
native_languages int2 references Languages_Tumenev(lang_id)
);
drop table native_speakers_tumenev

--�������� ������ � ������� �� �������
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

--�������� ������ ������� �� �������
create table countries_and_nations_tumenev(
nationality_id serial primary key,
country int2 references Countries_Tumenev(Countries_id),
nations int2 references Nations_Tumenev(Nations_id)
);
--drop table countries_and_nations_tumenev

--�������� ������ � ������� �� �������

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

--======== �������������� ����� ==============


--������� �1 
--�������� ����� ������� film_new �� ���������� ������:
--�   	film_name - �������� ������ - ��� ������ varchar(255) � ����������� not null
--�   	film_year - ��� ������� ������ - ��� ������ integer, �������, ��� �������� ������ ���� ������ 0
--�   	film_rental_rate - ��������� ������ ������ - ��� ������ numeric(4,2), �������� �� ��������� 0.99
--�   	film_duration - ������������ ������ � ������� - ��� ������ integer, ����������� not null � �������, ��� �������� ������ ���� ������ 0
--���� ��������� � �������� ����, �� ����� ��������� ������� ������� ������������ ����� �����.



--������� �2 
--��������� ������� film_new ������� � ������� SQL-�������, ��� �������� ������������� ������� ������:
--�       film_name - array['The Shawshank Redemption', 'The Green Mile', 'Back to the Future', 'Forrest Gump', 'Schindlers List']
--�       film_year - array[1994, 1999, 1985, 1994, 1993]
--�       film_rental_rate - array[2.99, 0.99, 1.99, 2.99, 3.99]
--�   	  film_duration - array[142, 189, 116, 142, 195]



--������� �3
--�������� ��������� ������ ������� � ������� film_new � ������ ����������, 
--��� ��������� ������ ���� ������� ��������� �� 1.41



--������� �4
--����� � ��������� "Back to the Future" ��� ���� � ������, 
--������� ������ � ���� ������� �� ������� film_new



--������� �5
--�������� � ������� film_new ������ � ����� ������ ����� ������



--������� �6
--�������� SQL-������, ������� ������� ��� ������� �� ������� film_new, 
--� ����� ����� ����������� ������� "������������ ������ � �����", ���������� �� �������



--������� �7 
--������� ������� film_new