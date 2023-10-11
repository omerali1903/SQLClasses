--------------DAY'8---------------------
--------tekrar------------
​
--LIKE/ILIKE:%,_
--regexp_like:~/~*
--[],[-],^,$
-- .* => 0 veya daha fazla karakter
--  . => tek bir karakter
-36-devam:regexp_like
​
--y ile başlayıp f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
​
SELECT *
FROM words
WHERE word ~* '^y.*f$';
​
SELECT *
FROM words
WHERE word ~* '^y(.*)f$';
​
--NOT LIKE: verilen desen şeklinde olmayanları getir.
-- !~ :verilen desen(regex) şeklinde olmayanları getir.
​
-- ilk harfi h ve H olmayan kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
​
SELECT *
FROM words
WHERE word NOT ILIKE 'h%';
​
​
SELECT *
FROM words
WHERE word !~* '^h';
​
--2. harfi e,i ve o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin.ÖDEV
​
​
-37-String fonk.
​
--developers tablosunda tüm isimlere 'Developer ' ekleyiniz.
​
UPDATE developers
SET name=concat('Developer ',name);
​
--developers tablosunda tüm isimleri büyük harfe çevirerek görüntüleyiniz.
SELECT UPPER(name)
FROM developers;
​
--developers tablosunda tüm isimleri küçük harfe çevirerek görüntüleyiniz.
SELECT LOWER(name)
FROM developers;
​
--words tablosunda tüm kelimeleri(word) ilk harfini büyük diğerleri küçük harfe çevirerek görüntüleyiniz.
​
SELECT INITCAP(word)
FROM words
​
--developers tablosunda isim ve isimlerin ilk 3 harfini listeleyiniz.
​
SELECT name, SUBSTRING(name,1,3)
FROM developers;
​
--developers tablosunda isim ve isimlerin uzunluklarını listeleyiniz.
​
SELECT name, LENGTH(name)
FROM developers;
​
/*
-38.FETCH NEXT n ROW ONLY:sadece ilk n satırı gösterir
    LIMIT n:sadece ilk n satırı gösterir
    OFFSET n:ilk n satırı atla sonrakileri göster 
*/
​
--developers tablosundan ekleme sırasına göre ilk 3 kaydı getiriniz.
SELECT * 
FROM developers
FETCH NEXT 3 ROW ONLY;
​
SELECT * 
FROM developers
LIMIT 3;
​
--developers tablosundan ilk 2 kayıttan sonraki ilk 3 kaydı getiriniz.
​
SELECT * 
FROM developers
OFFSET 2 ROW
FETCH NEXT 3 ROW ONLY;
​
SELECT * 
FROM developers
OFFSET 2 ROW
LIMIT 3;
​
--developers tablosundan maaşı en düşük ilk 3 kaydı getiriniz.
​
SELECT * 
FROM developers
ORDER BY salary ASC
LIMIT 3;
​
--developers tablosundan maaşı en yüksek 2. developerın tüm bilgilerini getiriniz.ÖDEVV
​
SELECT * 
FROM developers
ORDER BY salary DESC
OFFSET 1 
LIMIT 1
		
-39-ALTER TABLE:tabloyu güncellemek için kullanılır.->DDL
add column ==> yeni sutun ekler
drop column ==> mevcut olan sutunu siler
rename column.. to.. ==> sutunun ismini degistirir      
rename.. to.. ==> tablonun ismini degistirir
​
SYNTAX: ALTER TABLE tablo_adı ADD COLUMN sutun_adı data tipi
​
​
​
--calisanlar3 tablosuna yas (int) seklinde yeni sutun ekleyiniz.
ALTER TABLE calisanlar3
ADD COLUMN yas int;
​
--calisanlar3 tablosuna remote( boolean ) seklinde yeni sutun ekleyiniz
​
ALTER TABLE calisanlar3
ADD COLUMN remote boolean;
​
--calisanlar3 tablosuna prog_dili (varchar) seklinde yeni sutun ekleyiniz
-- default degeri 'java' olsun 
​
ALTER TABLE calisanlar3
ADD COLUMN prog_dili varchar(20) DEFAULT 'java';
​
--calisanlar3 tablosundan yas sutununu siliniz.
​
ALTER TABLE calisanlar3
DROP COLUMN yas;
​
--calisanlar3 tablosundaki maas sutununun ismini gelir olarak güncelleyiniz.
​
ALTER TABLE calisanlar3
RENAME COLUMN maas TO gelir;
​
--calisanlar3 tablosunun ismini employees olarak güncelleyiniz.
​
ALTER TABLE calisanlar3 RENAME TO employees; 
​
​
​
--employees tablosunda gelir sütunun data tipini real olarak güncelleyiniz.
​
ALTER TABLE employees
ALTER COLUMN gelir TYPE real; 
​
--employees tablosunda id sütunun data tipini varchar olarak güncelleyiniz.
​
ALTER TABLE employees
ALTER COLUMN id TYPE VARCHAR(20);
​
--employees tablosunda id sütunun data tipini int olarak güncelleyiniz.
​
ALTER TABLE employees
ALTER COLUMN id TYPE int USING id::integer ;--otomatik casting yapmadığı için zorluyoruz
​
--employees tablosunda isim sütununa NOT NULL constrainti ekleyiniz.
​
ALTER TABLE employees
ALTER COLUMN isim SET NOT NULL;
​
INSERT INTO employees(sehir) VALUES('Bursa');--isim null olamaz
INSERT INTO employees(isim,sehir) VALUES('Jack Sparrow','Bursa');
​
--NOT:bir sütuna not null,PK veya UNIQUE gibi const. ekleyebilmek için önce
--bu sütundaki mevcut kayıtların bu const. sağlıyor olması gerekir.  
​
​
--employees tablosunda id sütununa PRIMARY KEY constrainti ekleyiniz.
​
UPDATE employees
SET id=1
WHERE id=456789012 and isim='Veli Yilmaz'
​
UPDATE employees
SET id=2
WHERE id IS NULL
​
ALTER TABLE employees
ADD PRIMARY KEY(id);
​
/*
ALTER TABLE employees
ADD UNIQUE(isim);
​
ALTER TABLE employees
ADD FOREIGN KEY(id) REFERENCES digertablo(PKsütunu);
*/
​
--SYNTAX:ALTER TABLE tablo_adı ADD constraintadı(sütunadı)
​
​
SELECT * FROM employees;
​
​
-40-TRANSACTION-ROLLBACK
--TRANSACTION:Databasede en küçük işlem birimi
--BEGIN:transaction
--COMMIT:transaction onaylamak için kullanılır, transactionı sonlandırılır, yapılan değişiklikler kalıcı hale gelir.
​
BEGIN;
CREATE TABLE hesaplar
(
hesap_no int UNIQUE,
isim VARCHAR(50),
bakiye real       
);
COMMIT;
​
BEGIN;
INSERT INTO hesaplar VALUES(1234,'Harry Potter',5500.3);
INSERT INTO hesaplar VALUES(5678,'Jack Sparrow',8500.5);
​
savepoint x;--hata oluşursa geri dönmek istediğimiz noktayı belirlemek için kulanılır.
​
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
--HATA OLUŞTU, işlem yarım kaldı.
ROLLBACK TO x;
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
​
UPDATE hesaplar SET bakiye=bakiye-1000 WHERE hesap_no=1234;
UPDATE hesaplar SET bakiye=bakiye+1000 WHERE hesap_no=5678;
--transfer işlemi başarılı
COMMIT;
​
​
SELECT * FROM hesaplar;
















