CREATE TABLE calisanlar(
id char(5) PRIMARY KEY,
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(20),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id)	
);

INSERT INTO calisanlar VALUES('10002', 'Donatello' ,12000, '2018-04-14');  
INSERT INTO calisanlar VALUES('10003', null, 5000, '2018-04-14');--isim not null degil,unique null kabul eder ama sadece 1 kere
INSERT INTO calisanlar VALUES('10004', 'Donatello', 5000, '2018-04-14');--isime unique ekledigimiz icin donatello yu iki kere ekleyemeyiz
INSERT INTO calisanlar VALUES('10005', 'Michelangelo', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Leonardo', null, '2019-04-12');--maas NOT NULL oldugu icin kabul etmiyor
INSERT INTO calisanlar VALUES('10007', 'Raphael', '', '2018-04-14');--maas data type'i int oldugu icin bos String data atanamaz
INSERT INTO calisanlar VALUES('', 'April', 2000, '2018-04-14');--Primary key NOT NULL dir o yuzden empty kabul eder
INSERT INTO calisanlar VALUES('', 'Ms.April', 2000, '2018-04-14');--Empty i bir kere kabul eder cunku Primary key otomatik olarak UNIQUE'dir
INSERT INTO calisanlar VALUES('10002', 'Splinter' ,12000, '2018-04-14');--Primary Key UNIQUE'dir bu yuzden 10002 yi kabul etmez
INSERT INTO calisanlar VALUES( null, 'Fred' ,12000, '2018-04-14');--Primary key NOT NULL kabul etmez
INSERT INTO calisanlar VALUES('10008', 'Barnie' ,10000, '2018-04-14');
INSERT INTO calisanlar VALUES('10009', 'Wilma' ,11000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Betty' ,12000, '2018-04-14');

INSERT INTO adresler VALUES('10003','Ninja Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Kaya Sok', '50.Cad.','Ankara');--Foreign key duplicate kabul eder o yuzden ayni id ye farkli adres koyabiliriz
INSERT INTO adresler VALUES('10002','Taş Sok', '30.Cad.','Konya');


INSERT INTO adresler VALUES('10012','Taş Sok', '30.Cad.','Konya');--FOREIGN KEY(adres_id) sutunu calisanlar id'den referans aldigi 
--icin id'de 10012 degeri yok bu yuzden kabul etmez

  
--FOREIGN KEY null kabul eder
INSERT INTO adresler VALUES(NULL,'Taş Sok', '23.Cad.','Konya');
INSERT INTO adresler VALUES(NULL,'Taş Sok', '33.Cad.','Bursa');

SELECT * FROM calisanlar;

SELECT * FROM adresler;	

SELECT isim FROM calisanlar;

--calisanlar tablosundan ismi 'Donatello' olanlari listeleyiniz

--14-WHERE CONDITION

SELECT * FROM calisanlar WHERE isim='Donatello';	

-- calisanlar tablosundan maasi 5000 den fazla olanlari listeleyiniz
SELECT * FROM calisanlar WHERE maas>5000;

--calisanlar tablosundan maasi 5000den fazla olanlarin sadece maas ve isimlerini listeleyiniz

SELECT isim,maas FROM calisanlar WHERE maas>5000;

--adresler tablosundan sehiri 'Konya' ve 
--adres_id si 10002 olan tüm verileri getir

SELECT * FROM adresler WHERE sehir='Konya' AND adres_id='10002';

--sehiri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getir

SELECT cadde,sehir FROM adresler WHERE sehir='Konya' OR sehir='Bursa';


--15-DELETE KOMUTU:Tablodaki verileri siler, tabloyu silmez-->

CREATE TABLE ogrenciler1
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);
INSERT INTO ogrenciler1 VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO ogrenciler1 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler1 VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO ogrenciler1 VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO ogrenciler1 VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO ogrenciler1 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler1 VALUES(129, 'Mehmet Bak', 'Alihan', 89);

--id=124 olan kaydi siliniz

SELECT * FROM ogrenciler1;

DELETE FROM ogrenciler1 WHERE id=124;

--ismi Kemal Tan olan kaydi siliniz.

DELETE FROM ogrenciler1 WHERE isim='Kemal Tan';

--ismi Ahmet Ran veya Ali Can olan kayitlari siliniz.

DELETE FROM ogrenciler1 WHERE isim='Ahmet Ran' OR isim='Ali Can';

--ÖDEV--
-- ismi Mustafa Bak ve id'si 128 olan kaydı siliniz.
-- id'si 122, 125 veya 126 olanları silelim.
-- id 'si 126'dan büyük olan kayıtları silelim.
DELETE FROM ogrenciler1 WHERE isim=‘Mustafa Bak’ AND id=128;
DELETE FROM ogrenciler1 WHERE id=122 OR id=128 OR id=126;
DELETE FROM ogrenciler1 WHERE id>126;


--17-parent child iliskisi tablolardan data silme
SELECT * FROM calisanlar;--referenced table,parent
SELECT * FROM adresler;--child table

DELETE FROM calisanlar;--adresler tablosu tarafindan ref alindigi icin silmez
DELETE FROM calisanlar WHERE id='10002';--adresler tablosu tarafindan ref alindigi icin silmez

DELETE FROM adresler WHERE adres_id ='10002';--child
DELETE FROM calisanlar WHERE id='10002';--iliski koptugu icin siler.

DELETE FROM adresler;--CHILD
DELETE FROM calisanlar;--iliski koptugu icin silmeye izin verir

CREATE TABLE talebeler
(
id int primary key,  
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);--PARENT
CREATE TABLE notlar( 
talebe_id int,
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);--CHILD
INSERT INTO talebeler VALUES(122, 'Kerem Can', 'Fatma',75);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Veli Han', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Tan', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Ahmet Ran', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO talebeler VALUES(128, 'Mustafa Bak', 'Ali', 99);
INSERT INTO talebeler VALUES(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
INSERT INTO notlar VALUES ('127', 'Matematik',90);
INSERT INTO notlar VALUES (null, 'tarih',90);

--notlar tablosundan id-123 olan kaydi siliniz

DELETE FROM notlar WHERE talebe_id='123';
--child tabledan data sildigimizde sadece childdan silinir,parent taki kalir.
DELETE FROM talebeler WHERE id=126;--parent
--parenttan data silersek on delete cascade yazilmissa childdan da kaydi siler.

DELETE FROM talebeler;--parentdaki kayitlar ile birlikte referance alindigi kayitlari da siler



SELECT * FROM notlar;
SELECT * FROM talebeler;

--19-Tabloyu silme:tabloyu SCHEMAdan kaldirma

--sairler tablosunu siliniz.
DROP TABLE sairler;--DDL

--talebeler tablosunu siliniz.
DROP TABLE talebeler;
DROP TABLE talebeler CASCADE;--iliskinin sonlandirip silinmesine izin ver

--talebeler1 tablosunu siliniz.
DROP TABLE IF EXISTS talebeler1;--hata almamak icin

--20-IN CONDITION

CREATE TABLE musteriler  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');
INSERT INTO musteriler VALUES (20, 'John', 'Apple');
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm');
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple');
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange');
INSERT INTO musteriler VALUES (40, 'John', 'Apricot');
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

SELECT * FROM musteriler;

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.

SELECT * FROM musteriler WHERE urun_isim='Orange' OR urun_isim='Apple' OR urun_isim='Apricot';

--2.YOL

SELECT * FROM musteriler WHERE urun_isim IN('Orange','Apple','Apricot');

--Müşteriler tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olmayan verileri listeleyiniz.
SELECT * FROM musteriler WHERE urun_isim NOT IN('Orange','Apple','Apricot');

--21-BETWEEN...AND... Komutu
--Musteriler tablosunda urun_id 20 ile 40(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
SELECT * FROM musteriler WHERE urun_id BETWEEN 20 AND 40;

--Musteriler tablosunda urun_id 20 den kucuk veya 40 dan buyuk olan urunlerin tum bilgilerini listeleyiniz.
SELECT * FROM musteriler WHERE urun_id NOT BETWEEN 20 AND 40;

--22-AGGREGATE Fonks

CREATE TABLE calisanlar3 (
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT * FROM markalar;
SELECT * FROM calisanlar3;

--calisanlar3 tablosunda max ve min maasi gosteriniz
SELECT MAX(maas) FROM calisanlar3;
SELECT MIN(maas) FROM calisanlar3;

--calisanlar3 tablosunda tum calisanlarin toplam maasini gosteriniz

SELECT SUM(maas) FROM calisanlar3;

--tum calisanlarin ortalama maasini bulunuz

SELECT AVG(maas) FROM calisanlar3;

SELECT (AVG(maas),2) FROM calisanlar3;--ondalik kismi 2 basamaga yuvarlayarak sonucu goster

--calisanlar 3 tablosundaki tum calisanlarin sayisini gosterin
SELECT COUNT(*) FROM calisanlar3;

--calisanlar 3 tablosunda maasi 2500 olan calisanlarin sayisini gosteriniz.
SELECT COUNT(*) FROM calisanlar3 WHERE maas=2500;


--ALIASES = ETIKET/RUMUZ--tabloya veya fieldlara gecici olarak isim verebiliriz.

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM workers;

SELECT calisan_id AS id,calisan_isim AS isim FROM workers;

SELECT calisan_id AS id,calisan_isim ||' '|| calisan_dogdugu_sehir AS isim_sehir FROM workers;


















