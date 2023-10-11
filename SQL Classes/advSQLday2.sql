 
 do $$
 
 declare
     selected_film  film%rowtype;
	 input_film_id film.id%type :0;
 
 begin
         select * from film
		 into select_film
		 where id = input_film_id;
		 
		 if not found then
		 raise notice 'Girdiginiz id li film bulunamadi : %',input_film_id;
		 end if;
 
 end $$
 
 do $$
 
 declare
 
 selected_film film%rowtype;
 input_film_id film.id%type :=2;
 
 
 begin
 select * from film
 into select_film
 where id = input_film_id
 
 if not found then
 raise notice 'Girmis oldugunuz id li film bulunamadi : %',input_film_id;
 else
    raise notice 'Filmin ismi : %',selected_film.title;
	end if;
 
 
 end $$
 
 
 do $$
declare
	count_rows integer;
begin
	select count(*)
	from film
	into count_rows;
	
	if count_rows > 0 then
	insert into film (id,title)
	values (5,'Kara Şahin Düştü');
	raise notice 'Yeni film eklendi';
	
	else
		raise notice 'Film tablosu boş';
	end if;
	
end $$;


--syntax
/*
	if condition_1 then
		statement_1;
	elseif condition_2 then
		statement_2;
		...
	elseif condition_n then
		statement_n;
		
	else
		else_statement;
	end if;
*/
/* 	Task : 1 id li film varsa ;
			süresi 50 dakikanın altında ise Short,
			50<length<120 ise Medium,
			length>120 ise Long yazalım
*/


do $$
declare
  selected_film film%rowtype;
  input_film_id film.id%type:=1;
begin 
   select * from film 
   into selected_film
   where id = input_film_id;
  
   if found then 
      raise notice '%',input_film_id;
	  
   elseif selected_film.lenght<50 then
      raise notice 'Short';
   elseif selected_film.lenght>50 and selected_film.lenght<120 then
      raise notice 'Medium'; 
   elseif selected_film.lenght>120 then
      raise notice 'Long';
   else 
     raise notice 'Film bulunamadi';
	 end if;
end $$;


do $$
declare
	tur film.type%type;
	uyari varchar(50);
begin
	select type
	from film
	into tur
	where id=4;
	
	if found then
		case tur
			when 'Korku' then
				uyari='Çocuklar için uygun değil';
			when 'Macera' then
				uyari='Çocuklar için uygun';
			when 'Animasyon' then
				uyari='Çocuklar için tavsiye edilir';
			else
				uyari='Tanimlanmadi';
		end case;
		raise notice '%',uyari;
	end if;
end $$;

--syntax
/*
<<label>> --1.ornek
loop
	statement;
end loop;
--loopu sonlandırmak icin if yapisi kullanilabilir
<<label>>  2.ornek
loop
	statements;
	if condition then
	exit; --loop dan cikilmasini saglar
end loop;
--nested loop --3.ornek
<<outer>>
loop
	statements;
	<<inner>>
	loop
	....
	exit --inner
	end loop --inner loop endi
exit;
end loop; --outer loop endi
*/





2:52
-- Task : Fibonacci serisinde, belli bir sıradaki sayıyı ekrana getirelim





 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 