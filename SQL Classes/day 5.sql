------------DAY'5-----------------
--25-UPDATE KOMUTU:Veriyi güncelleme

SELECT * FROM calisanlar3;

SELECT * FROM markalar;

--SYNTAX: UPDATE table_name SET column_name=yeni değer,column2=yeni değer2  WHERE condition

--  idsi 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyeniz.
UPDATE calisanlar3
SET isyeri='Trendyol'
WHERE id=123456789;

-- id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve 
--sehirini 'Bursa' olarak güncelleyiniz.

UPDATE calisanlar3
SET isim='Veli Yıldırım', sehir='Bursa'
WHERE id=567890123;

--  markalar tablosundaki marka_id değeri 102 ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.

UPDATE markalar
SET marka_id=marka_id*2
WHERE marka_id>=102;

-- markalar tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.
UPDATE markalar 
SET calisan_sayisi=calisan_sayisi+marka_id;

--calisanlar3 tablosundan Ali Seker’in isyerini, 'Veli Yıldırım' ın isyeri ismi ile güncelleyiniz.

UPDATE calisanlar3
SET isyeri=(SELECT isyeri FROM calisanlar3 WHERE isim='Veli Yıldırım')
WHERE isim='Ali Seker'

--calisanlar3 tablosunda maasi 1500 olanların isyerini, markalar tablosunda
--calisan_sayisi 20000 den fazla olan markanın ismi ile değiştiriniz.

UPDATE calisanlar3
SET isyeri=(SELECT marka_isim FROM markalar WHERE calisan_sayisi>20000 )
WHERE maas=1500;

--calisanlar3 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.

UPDATE calisanlar3
SET sehir=sehir || ' Şubesi'
WHERE isyeri='Vakko';

SELECT * FROM calisanlar3;

SELECT * FROM markalar;

--26-IS NULL Condition
CREATE TABLE people
(
ssn char(9),
name varchar(50),
address varchar(50)
);
INSERT INTO people VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO people VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO people VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO people (ssn, address) VALUES(456789012, 'Bursa');
INSERT INTO people (ssn, address) VALUES(567890123, 'Denizli');
INSERT INTO people (ssn, name) VALUES(567890123, 'Veli Han');

SELECT * FROM people;

--people tablosundaki name sütununda NULL olan değerleri listleyiniz.
SELECT * 
FROM people
WHERE name IS NULL;
--people tablosundaki name sütununda NULL olmayan değerleri listleyiniz.
SELECT * 
FROM people
WHERE name IS NOT NULL;

--people tablosunda name sütunu null olanların name değerini 
--'MISSING...' olarak güncelleyiniz..

UPDATE people
SET name='MISSING...'
WHERE name IS NULL;

--people tablosunda address sütunu null olanların adress değerini
 --'MISSING...' olarak güncelleyiniz..

UPDATE people
SET address='MISSING...'
WHERE address IS NULL;

SELECT * FROM people;

--27-ORDER BY komutu:kayıtları belirli bir fielda göre defaultta NATURAL(artan sıralı,ASCENDING) sıralar..

CREATE TABLE person
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

SELECT * FROM person;

--person tablosundaki kayıtlari adres’e gore siralayarak listeleyiniz.
SELECT * 
FROM person
ORDER BY adres ASC;--ASC(artan) sıralar

--person tablosundaki ismi Mine olanlari soyisim azalan sirali olarak listeleyin

SELECT * 
FROM person
WHERE isim='Mine'
ORDER BY soyisim DESC;--DESC:azalan

--person tablosundaki soyismi Bulut olanlari isim sirali(artan) olarak listeleyiniz. 

SELECT * 
FROM person
WHERE soyisim='Bulut'
ORDER BY isim;


SELECT * 
FROM person
WHERE soyisim='Bulut'
ORDER BY 2;--not recommend--tavsiye edilmez

--person tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayiniz

SELECT * 
FROM person
ORDER BY ssn DESC;

--person tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyiniz

SELECT * 
FROM person
ORDER BY isim ASC, soyisim DESC;

--İsim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.

SELECT isim,soyisim, LENGTH(soyisim) soyisim_uzunluk
FROM person
ORDER BY LENGTH(soyisim); 

SELECT isim,soyisim, LENGTH(soyisim) AS soyisim_uzunluk
FROM person
ORDER BY LENGTH(soyisim); 

--Tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak her bir isim ve 
--soyisim değerinin toplam uzunluğuna göre sıralayınız.

SELECT isim||' '||soyisim isim_soyisim , LENGTH(isim)+LENGTH(soyisim) uzunluk
FROM person
ORDER BY LENGTH(isim)+LENGTH(soyisim);

--alternatif
SELECT CONCAT(isim,' ',soyisim) isim_soyisim , LENGTH(isim)+LENGTH(soyisim) uzunluk
FROM person
ORDER BY LENGTH(isim||soyisim);