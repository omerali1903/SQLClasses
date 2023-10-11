-------------------Day 2 -----------------
-----------tekrar-------
CREATE TABLE sairler(
id int,
name varchar(50),
email varchar(50)	
);

INSERT INTO sairler VALUES(1001,'Cemal Sureyya','sair@gmail.com');
INSERT INTO sairler VALUES(1002,'Rasim Ozdenoren','sair@gmail.com');
INSERT INTO sairler VALUES(1003,'','sair@gmail.com');
INSERT INTO sairler (name,email) VALUES('Akif Ersoy','')

SELECT * FROM sairler;

--9-tabloya unique constrainti ekleme
CREATE TABLE devolopers(
id SERIAL,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20));

INSERT INTO devolopers(name,email,salary,prog_lang) VALUES('Yavuz Bey','dev@email.com',5000,'Java');
INSERT INTO devolopers(name,email,salary,prog_lang) VALUES('Enes Bey','devoloper@email.com',5000,'Java');--Email olustururken unique yazdigimiz icin ayni emaili kabul etmez
INSERT INTO devolopers(email,salary,prog_lang) VALUES('dev2@email.com',5000,'JavaScript');

SELECT * FROM devolopers;

--10-NOT NULL constrainti ekleme
CREATE TABLE doctors(
id SERIAL,
name varchar(50) NOT NULL,	
email varchar(50) UNIQUE,
salary real
);

INSERT INTO doctors(name,email,salary) VALUES('Jack Sparrow','dr@gmail.com',5000);
INSERT INTO doctors(email,salary) VALUES('doctor@gmail.com',5000);
INSERT INTO doctors(name,email,salary) VALUES('','doctor2@gmail.com',5000);--isim empty, empty null değildir.



SELECT * FROM doctors;

--11-Primary Key tanimlama 

CREATE TABLE students2(
id int PRIMARY KEY,
name varchar(50) NOT NULL,
grade real,
register_date DATE);

SELECT * FROM students2;

CREATE TABLE students3(
id int,
name varchar(50) NOT NULL,
grade real,
register_date DATE,
CONSTRAINT std_pk PRIMARY KEY(id)	
);

SELECT * FROM students3;

CREATE TABLE students4(
id int,
name varchar(50) NOT NULL,
grade real,
register_date DATE,
CONSTRAINT student_pk PRIMARY KEY(id,name));

SELECT * FROM students4;

--12-Foreign Key tanimlama

CREATE TABLE address3(
address_id int,
street varchar(50),
city varchar(20),
student_id int,	
CONSTRAINT add_fk FOREIGN KEY(student_id) REFERENCES students3(id)	
);

SELECT * FROM address3;

--13-CHECK cons ekleme
CREATE TABLE personel(
id int,
name varchar(50) NOT NULL CHECK(name <> ''),--<> not equals
salary real,
age int CHECK(age>0)	
);

INSERT INTO personel VALUES(1,'',5000,12);--isim bos diye kabul etmedi
INSERT INTO personel VALUES(1,'Burhanettin Bey',5000,-2);--yas eksi diye kabul etmedi
INSERT INTO personel VALUES(1,'Burhanettin Bey',5000,22);--bu sekilde kabul etti 





















