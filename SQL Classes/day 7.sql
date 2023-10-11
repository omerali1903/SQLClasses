--------------DAY'7---------------------
--JOINS--BİRLEŞTİRME
--JOIN:ilişkili tablolarda ortak bir sütun baz alınarak(tipik olarak PK ve FK)
--bir veya daha fazla tablodaki sütunların birleştirilmesini sağlar.
​
--NOT: UNION ile sorguların sonucunu birleştiririz.
   --  JOIN de bir veya daha fazla tablodaki sütunları birleştiririz.
​
CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'IBM');
INSERT INTO sirketler VALUES(101, 'GOOGLE');
INSERT INTO sirketler VALUES(102, 'MICROSOFT');
INSERT INTO sirketler VALUES(103, 'APPLE');
​
CREATE TABLE siparis (
siparis_id int,
sirket_id int,
siparis_tarihi date
);
INSERT INTO siparis VALUES(11, 101, '2023-02-17');  
INSERT INTO siparis VALUES(22, 102, ' 2023-02-18');  
INSERT INTO siparis VALUES(33, 103, ' 2023-01-19');  
INSERT INTO siparis VALUES(44, 104, ' 2023-01-20');  
INSERT INTO siparis VALUES(55, 105, ' 2022-12-21');
​
​
​
-32-INNER JOIN:baz aldığımız sütundaki ortak değerleri gösterir
​
--iki tablodaki şirket id'si aynı olanların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini  listeleyiniz.
​
​
SELECT sirketler.sirket_id, sirket_isim, siparis_tarihi , siparis_id
FROM sirketler
INNER JOIN siparis
ON sirketler.sirket_id=siparis.sirket_id
​
SELECT sirketler.sirket_id, sirket_isim, siparis_tarihi , siparis_id
FROM siparis
INNER JOIN sirketler
ON sirketler.sirket_id=siparis.sirket_id
​
​
--NOT:inner joınde tabloların sırası farketmez.
​
​
-33-LEFT JOIN:sol tablodaki(ilk tablodaki) tüm kayıtları getirir.
   -RIGHT JOIN:sağ tablodaki(ikinci tablodaki) tüm kayıtları getirir.
   
--şirketler tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini listeleyiniz.   
   
SELECT sirketler.sirket_id, sirket_isim, siparis_id, siparis_tarihi
FROM sirketler LEFT JOIN siparis   
ON sirketler.sirket_id=siparis.sirket_id;
   
--sipariş tablosundaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini listeleyiniz.      
   
SELECT siparis.sirket_id, sirket_isim, siparis_id, siparis_tarihi
FROM sirketler RIGHT JOIN siparis   
ON sirketler.sirket_id=siparis.sirket_id; 
​
​
SELECT siparis.sirket_id, sirket_isim, siparis_id, siparis_tarihi
FROM siparis LEFT JOIN sirketler  
ON sirketler.sirket_id=siparis.sirket_id;
​
--NOT:tabloların sırasını değiştirerek RIGHT JOIN yerine LEFT JOIN kullanılabilir.
​
   
--34-FULL JOIN:birleştirilen tablolardaki tüm kayıtları tekrarsız gösterir.
​
--her iki tablodaki tüm kayıtların şirket id,şirket ismi,
--sipariş tarihini,sipariş idsini listeleyiniz.  
​
SELECT siparis.sirket_id AS siparis_tbl_id ,sirketler.sirket_id AS sirketler_tbl_id,  sirket_isim, siparis_id, siparis_tarihi
FROM siparis FULL JOIN sirketler  
ON sirketler.sirket_id=siparis.sirket_id;
​
​
--35-SELF JOIN:tablonun kendi içerisinde bir sütuna göre INNER JOIN yapılmasıdır.
​
​
CREATE TABLE personeller  (
id int,
isim varchar(20),  
title varchar(60), 
yonetici_id int
);
INSERT INTO personeller VALUES(1, 'Ali Can', 'SDET',     2);
INSERT INTO personeller VALUES(2, 'Veli Cem', 'QA',      3);
INSERT INTO personeller VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personeller VALUES(4, 'Fatma Can', 'CEO',    5);
​
--her bir personelin isminin yanında yöneticisinin de ismini yazdıran SORGU oluşturunuz.
​
SELECT p.isim personel_isim, m.isim yonetici_isim
FROM personeller p
INNER JOIN personeller m
ON p.yonetici_id=m.id;
​
​
--36-LIKE Cond.:WHERE komutundan sonra kullanılır
--Sorgularda belirli bir karakter dizisini(pattern-desen) kullanabilmemizi sağlar.
​
--ILIKE:LIKE ile aynı şekilde çalışır, case-INSENSITIVE  
​
SELECT * FROM developers;
SELECT * FROM developers WHERE name='Emrah Bey';
​
--wildcard(joker) % -->0 veya daha fazla karakteri temsil eder.
​
--Ismi E harfi ile başlayan developerların tüm bilgilerini listeleyiniz.
​
SELECT *
FROM developers
WHERE name LIKE 'E%';
​
--a harfi ile biten şehirde çalışan dev isimlerini ve şehirlerini yazdiran QUERY yazin
​
SELECT name,city
FROM developers
WHERE city LIKE '%a';--ANKARA yı göstermez.
​
SELECT name,city
FROM developers
WHERE city ILIKE '%a'--ANKARA yı gösterir.
​
​
--Ismi E ile başlayıp y harfi ile biten dev isimlerini ve maaşlarını yazdiran QUERY yazin
SELECT name,salary
FROM developers
WHERE name ILIKE 'E%y';--ey-->gösterir
​
--Ismi içinde 'an' olan dev isimlerini ve maaşlarını yazdiran QUERY yazin
​
SELECT name,salary
FROM developers
WHERE name ILIKE '%an%';
​
SELECT name,salary
FROM developers
WHERE name ~~* '%an%';
​
--LIKE:~~
--ILIKE:~~*
​
--Ismi içinde e ve a olan devlerin tüm bilgilerini yazdiran QUERY yazin
​
SELECT *
FROM developers
WHERE name ILIKE '%e%a%' OR name ILIKE '%a%e%';--hande,kemal,hANDe
​
--LIKE hAnde datasını göstermez.
​
SELECT *
FROM developers
WHERE name ILIKE '%e%' AND name ILIKE '%a%';--hande,kemal
​
-- underscore _:sadece tek bir karakteri temsil eder.
​
--Isminin ikinci harfi ü olan devlerin tum bilgilerini yazdiran QUERY yazin
​
SELECT *
FROM developers
WHERE name ILIKE '_ü%';
​
--Kullandığı prog. dili 4 harfli ve üçüncü harfi v olan devlerin tum bilgilerini yazdiran QUERY yazin
​
SELECT *
FROM developers
WHERE prog_lang ILIKE '__v_';
​
​
--Kullandığı prog. dili en az 5 harfli ve ilk harfi J olan devlerin tum bilgilerini yazdiran QUERY yazin.ÖDEVVV
--HINT:sonuşlarda sadece JavaScript olacak
--Isminin 2. harfi e,4. harfi y olan devlerin tum bilgilerini yazdiran QUERY yazin. ÖDEVV
--ismi boşluk içeren devlerin tum bilgilerini yazdiran QUERY yazin:ÖDEVVVV( % % )
​
​
--REGEXP_LIKE:(~)belirli bir desen(kalıp ifade) içeren dataları görüntülemek için
--regex kullanmamızı sağlar.
​
CREATE TABLE words
( 
  word_id int UNIQUE,
  word varchar(50) NOT NULL,
  number_of_letters int
);
​
INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'Hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selim', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);
INSERT INTO words VALUES (1009, 'hAt', 3);
INSERT INTO words VALUES (1010, 'yaf', 5);
INSERT INTO words VALUES (1011, 'ahata', 3);
​
SELECT * FROM words;
​
--[]:içindeki harflerden en az birini içeren
​
--h harfinden sonra a veya i harfini sonra ise t harfini 
--içeren kelimelerin tum bilgilerini yazdiran QUERY yaziniz.
​
SELECT * 
FROM words
WHERE word ~ 'h[ai]t';--hat,hit gösterir. hbt,hait,haat,ht göstermez
​
--küçük-büyük harf hassasiyeti olmasın
​
SELECT * 
FROM words
WHERE word ~* 'h[ai]t';
​
--[-]:iki harf arasındaki harflerden en az birini içeren
​
​
 --h harfinden sonra, a ile k arasindaki harflerden birini, sonra da t harfini
-- içeren kelimelerin  tum bilgilerini  yazdiran QUERY yaziniz.
-- ÖRN:hkt,ahbt
​
SELECT * 
FROM words
WHERE word ~* 'h[a-k]t';--habt göstermez
​
​
-- Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
--absdsamasdas,asdiasd
SELECT * 
FROM words
WHERE word ~* '[mi]';
​
-^: başlangıcı belirtir, $:bitişi gösterir.
​
--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
​
SELECT * 
FROM words
WHERE word ~* '^[as]';
​
-- m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
​
SELECT * 
FROM words
WHERE word ~* '[mf]$';