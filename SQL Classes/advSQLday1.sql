--Tek satirli yorum
/*
cok satirli yorum

*/



--*************************************
--*********Degisken tanimlama**********
--*************************************

do $$--anonim bir block oldugunu gosterir
     --dolar ozel isaretler icin--tirnak kullanmamak icin

declare
counter integer :=1;
first_name varchar(50) :='Ahmet';
last_name varchar(50) :='Gok';
payment numeric(4,2) :=20.5;--1-si toplam rakam sayisini,2.si de virgulden sonra kac rakam olacagini verir


begin
raise notice '% % % has ben paid %USD',
          counter,
          first_name,
          last_name,
          payment;

end $$


DO $$
DECLARE
	counter integer := 1;
	name1 varchar(50) := 'Ahmet';
	name2 varchar(50) := 'Mehmet';
	payment integer:= 120;
BEGIN
RAISE NOTICE '% ve % beyler % tl ye bilet aldilar',	
				name1,
				name2,
				payment;
END $$;

do $$
declare
	create_at time :=now();  --atama yapıldı
begin
	raise notice '%', create_at;
	perform pg_sleep(5);  --5 sn bekle
	raise notice '%',create_at;
end $$;





1:56
--*************************************************	
-- ******** TABLODAN DATA TİPİNİ KOPYALAMA ********
--*************************************************

do $$
declare
film_title film.title%type; --film tablosunda title headerindaki datatypeini secer

begin
   --1 id li filmin ismini getirelim
   select title
   from film
   into film_title
   where id = 1 ;
       
	   raise notice 'Film title with id : 1%',film_title;
	   
	   end $$;
	   
	   
	   do $$
declare
	film_type film.type%type;
begin
	SELECT type
	FROM film
	INTO film_type
	WHERE id=1;
	
	raise notice 'Film type with id 1: %',film_type;
	
end $$;
	   
	   
























