--------------DAY'6---------------------
--28-GROUP BY clause:sonuçları bir veya daha fazla sütuna göre gruplamak için kullanılır.
​
​
CREATE TABLE manav
(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);
​
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);  
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);  
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);  
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);
​
​
SELECT * FROM manav;
​
​
--Manav tablosundaki tüm isimleri her bir isim için toplam ürün miktarını görüntüleyiniz.
​
SELECT isim,SUM(urun_miktar)
FROM manav
GROUP BY isim;
​
--Manav tablosundaki tüm isimleri her bir isim için toplam ürün miktarını görüntüleyiniz.
--toplam ürün miktarına göre azalan sıralayın.
​
SELECT isim,SUM(urun_miktar) toplam_urun_mik
FROM manav
GROUP BY isim
ORDER BY SUM(urun_miktar) DESC;
​
​
--Her bir ismin aldığı her bir ürünün toplam miktarını isme göre sıralı görüntüleyiniz.
​
SELECT isim,urun_adi, SUM(urun_miktar) toplam_urun_mik
FROM manav
GROUP BY isim,urun_adi
ORDER BY isim;
​
--!!! NOT: Group By komutu kullanıldığında Selectten sonra sadece Group By daki field
-- yada aggregate fonk. kullanılabilir
​
SELECT isim,urun_adi
FROM manav
GROUP BY isim,urun_adi
ORDER BY isim;
​
SELECT isim,SUM(urun_miktar)
FROM manav
GROUP BY isim
ORDER BY isim;
​
--ürün ismine göre her bir ürünü alan toplam kişi sayısı gösteriniz.
​
​
SELECT urun_adi, COUNT(DISTINCT isim) kisi_sayisi
FROM manav
GROUP BY urun_adi
​
​
--Isme göre alınan toplam ürün miktarı ve ürün çeşit miktarını bulunuz
​
SELECT isim, SUM(urun_miktar) toplam_urun_mik, COUNT(DISTINCT urun_adi) cesit_sayisi
FROM manav
GROUP BY isim;
​
​
--Alinan ürün miktarina gore musteri sayisinı görüntüleyiniz.
--musteri sayisina göre artan sıralayınız.
​
SELECT urun_miktar, COUNT(DISTINCT isim) musteri_sayisi
FROM manav
GROUP BY urun_miktar
ORDER BY COUNT(DISTINCT isim);
​
​
​
​
--29-HAVING clause:group by dan sonra koşul belirtmek için kullanılır.
​
DROP TABLE personel;
​
CREATE TABLE personel  (
id int,
isim varchar(50),
sehir varchar(50), 
maas int,  
sirket varchar(20)
);
​
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');
​
​
SELECT * FROM personel;
​
--Her bir şirketin MIN maas bilgisini eğer 4000den fazla ise görüntüleyiniz.
​
SELECT sirket , MIN(maas)
FROM personel
GROUP BY sirket
HAVING MIN(maas)>4000;
​
--Her bir ismin aldığı toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gösteren sorgu yaziniz.
​
SELECT isim, SUM(maas)
FROM personel
GROUP BY isim
HAVING SUM(maas)>10000;
​
--Eğer bir şehirde çalışan personel(isim) sayısı 1’den çoksa sehir ismini ve personel sayısını veren sorgu yazınız
​
​
SELECT sehir, COUNT(DISTINCT isim) personel_sayisi 
FROM personel
GROUP BY sehir
HAVING COUNT(DISTINCT isim) >1;
​
--Eğer bir şehirde alınan MAX maas 5000’den düşükse sehir ismini ve MAX maasi veren sorgu yazınız.
​
SELECT sehir, MAX(maas) max_maas
FROM personel
GROUP BY sehir
HAVING MAX(maas)<5000;
​
​
--30-UNION/UNION ALL operator:
​
--UNION:iki farklı sorgunun sonucu birleştirerek görüntülememizi sağlar.
       --tekrarlı verileri göstermez.
--UNION ALL:tekrarlı verileri de gösterir.
​
​
DROP TABLE developers;
​
CREATE TABLE developers(
id SERIAL PRIMARY KEY,
name varchar(50),
email varchar(50) UNIQUE,
salary real,
prog_lang varchar(20),
city varchar(50),
age int	
);
​
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Yavuz Bey','yavuz@mail.com',4000,'Java','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Emrah Bey','emrah@mail.com',5000,'JavaScript','Istanbul',35);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Ebru Hanım ','ebru@mail.com',5000,'Java','Izmır',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Kübra Hanım','kubra@mail.com',4000,'JavaScript','Istanbul',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Fazıl Bey','fazil@mail.com',6000,'Java','Izmır',25);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Musab Bey','musab@mail.com',6000,'Html','Istanbul',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Enes Bey','enes@mail.com',5500,'Css','Ankara',28);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Meryem Hanım','meryem@mail.com',5000,'Java','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('İrfan Bey','irfan@mail.com',4500,'Html','Izmır',33);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Cemal Bey','cemal@mail.com',4500,'Css','Bursa',32);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Hüseyin Bey','huseyin@mail.com',7000,'C++','Konya',38);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Vehbi Bey','vehbi@mail.com',4000,'C#','Istanbul',30);
INSERT INTO developers(name,email,salary,prog_lang,city,age) VALUES('Belkıs Hanım','developer@mail.com',4000,'C#','Bursa',29);
​
​
CREATE TABLE contact_info(
address_id int,
street varchar(30),
number int,	
city varchar(30),
FOREIGN KEY(address_id) REFERENCES developers(id)	
);
​
INSERT INTO contact_info VALUES(1,'Kaya Sok.',5,'Bursa');
INSERT INTO contact_info VALUES(2,'Kaya Sok.',3,'Ankara');
INSERT INTO contact_info VALUES(3,'Can Sok.',10,'Bursa');
INSERT INTO contact_info VALUES(4,'Gül Sok.',12,'Ankara');
INSERT INTO contact_info VALUES(5,'Can Sok.',4,'Afyon');
INSERT INTO contact_info VALUES(6,'Taş Sok.',6,'Bolu');
INSERT INTO contact_info VALUES(7,'Dev Sok.',6,'Sivas');
INSERT INTO contact_info VALUES(8,'Dev Sok.',8,'Van');
​
​
SELECT * FROM developers;
SELECT * FROM contact_info;
​
​
/*Yaşı 25’den büyük olan developer isimlerini ve 
​
yaşı 30'dan küçük developerların kullandığı prog. dillerini
tekrarsız gösteren sorguyu yaziniz*/
​
SELECT name FROM developers WHERE age>25
UNION
SELECT prog_lang FROM developers WHERE age<30
​
--seçilen field sayısı aynı olmalı, alt alta gelecek olan DATA TİPİ da aynı olmalı
​
​
--aynı sorguyu tekrarlı olacak şekilde yapınız.
​
SELECT name FROM developers WHERE age>25
UNION ALL
SELECT prog_lang FROM developers WHERE age<30
​
/* Java kullananların maaşını ve prog. dilini ve 
JavaScript kullananların yaşını ve prog. dilini
tekrarsız gösteren sorguyu yaziniz*/
​
SELECT salary maas_yas, prog_lang FROM developers WHERE prog_lang='Java'--4
UNION
SELECT age maas_yas, prog_lang FROM developers WHERE prog_lang='JavaScript'--2
​
--numeric data tipinin farklı tiplerinde daha büyük olan data tipine göre sonuçları gösterir. 
​
/* Java kullananların bulunduğu şehir ve maaşını ve 
maaşı 5000 den fazla olanların isim ve yaşını
tekrarsız gösteren sorguyu yaziniz*/--ÖDEV
​
​
--id si 8 olan developerın çalıştığı şehir ve maaşını
--iletişim adresindeki şehir ve kapı nosunu görüntüleyiniz.
​
SELECT city isyeri_ikamet ,salary maas_kapino FROM developers WHERE id=8
UNION
SELECT city isyeri_ikamet ,number maas_kapino FROM contact_info WHERE address_id=8 
​
​
--developers tablosundaki şehirler ve
--calisanlar3 tablosunda sehirlerin
--tümünü tekrarsız olarak listeleyiniz
​
SELECT city FROM developers
UNION
SELECT sehir FROM calisanlar3;
​
​
--31-INTERSECT OPERATOR:iki farklı sorgunun sonuçlarından ortak olanları görüntülenmesini sağlar.
--sadece tekrarsız verileri gösterir.
​
--developers tablosundaki şehirler ve
--calisanlar3 tablosundaki sehirlerden 
--ortak olanlarını listeleyiniz.
​
SELECT city FROM developers
INTERSECT
SELECT sehir FROM calisanlar3;
​
​
--developers tablosunda Java kullananların çalıştıkları şehirler ve
--calisanlar3 tablosunda maaşı 1000 den fazla olanların sehirlerinden 
--ortak olanlarını listeleyiniz.
​
SELECT city FROM developers WHERE prog_lang='Java'
INTERSECT
SELECT sehir FROM calisanlar3 WHERE maas>1000;
​
​
​
--32-EXCEPT OPERATOR: bir sorgunun sonuçlarınım listelerken diğer sorgunun sonuçları hariç tutmak için kullanılır.
​
----developers tablosundaki şehirlerden
--calisanlar3 tablosunda olmayanları listeleyiniz.
​
​
SELECT city FROM developers
EXCEPT
SELECT sehir FROM calisanlar3;
​
--calisanlar3 tablosundaki şehirlerden
--developers tablosunda olmayanları listeleyiniz.
​
SELECT sehir FROM calisanlar3
EXCEPT
SELECT city FROM developers
​
----developers tablosundaki maaşı 4000 den büyük olanların idlerinden
--contact_info tablosunda olmayanları listeleyiniz.
​
SELECT id FROM developers WHERE salary>4000
EXCEPT
SELECT address_id FROM contact_info;
​
 --ÖDEV:mart ve nisan tablolarındaki tüm ürünlerin isimlerini tekrarsız listeleyiniz.  
 --ÖDEV:mart ve nisan tablolarındaki ortak ürünlerin isimlerini listeleyiniz.
 --ÖDEV:mart ayında satılıp nisan ayında satılmayan ürünlerin isimlerini listeleyiniz. 




