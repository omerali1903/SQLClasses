--Burasi Yorum Satiri--
--DAY 1 --
--1--data base olusturma--DDL
CREATE DATABASE techpro;	

--2--data base'i silme--DDL
DROP DATABASE techpro;

--3--tablo olusturma--DDL
CREATE TABLE students(
id char(4),
name varchar(50),
grade real,
register_date date		
);

--4-var olan tablodan yeni tablo olusturma
CREATE TABLE grades AS SELECT name,grade FROM students;

--5-tabloya tum fieldlariyla data ekleme
INSERT INTO students VALUES('1001','Sherlock Holmes',99.9,'2023-04-23');
INSERT INTO students VALUES('1002','Jack Sparrow',98,now());

--6-tabloya sadece bazi fieldlariyla data ekleme
INSERT INTO students(name,grade) VALUES('Harry Potter',99.9);

--7-tablodan tum kayitlari tum fieldlariyla data okuma/cekme
SELECT * FROM students;

--8-tablodan tum kayitlari belirli fieldlariyla data okuma/cekme
SELECT name,grade FROM students;



