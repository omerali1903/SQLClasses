do $$
declare
	sayi integer :=0;
begin
	select count(*)
	from film
	into sayi;
	
	if sayi<10 then
		raise notice 'Film sayisi 10 dan az';
		
	else
		raise notice 'Film sayisi yeterli';
	end if;
end $$;
12:44
-- Task 2: user_age isminde integer data turunde bir degisken tanimlayip default olarak bir deger verelim,
--If yapisi ile girilen deger 18 den buyuk ise Access Granted, kucuk ise Access Denied yazdiralim


do $$
declare
	user_age integer :=25;
	
begin
	if user_age>18 then
	raise notice 'Access Granted';
	end if;
	if user_age<18 then
	raise notice 'Access Denied';
	end if;
end $$;

-- Task : 1 dan 4 e kadar counter degerlerini ekrana basalim


do $$

declare
n integer :=4;
counter integer :=0;
begin

while counter<n loop
counter= counter+1;
raise notice '%',counter;
end loop;

end $$;


-- Task : sayac isminde bir degisken olusturun ve dongu icinde sayaci birer artirin,
--	her dongude sayacin degerini ekrana basin ve sayac degeri 5 e esit olunca donguden cikin


do $$
begin
	for counter in 1..10 by 2 loop
		raise notice 'counter : %',counter;
	end loop;
end $$;

--ornek : DB de for loop kullanimi
--syntax :
FOR target IN query loop --target hedef degisken targeta atanıyor
	statements
END LOOP;
1:37
-- Task : Filmleri suresine gore siraladigimizda en uzun 2 filmi gosterelim

DO $$
declare
 	f record;
begin
	for f in select title,length
		from film
		order by length desc
		limit 3
	loop
		raise notice '% % dakika',f.title,f.length;
	end loop;
end $$;





1:50
CREATE TABLE employees (
  employee_id serial PRIMARY KEY,
  full_name VARCHAR NOT NULL,
  manager_id INT
);
1:51
INSERT INTO employees (
  employee_id,
  full_name,
  manager_id
)
VALUES
  (1, 'M.S Dhoni', NULL),
  (2, 'Sachin Tendulkar', 1),
  (3, 'R. Sharma', 1),
  (4, 'S. Raina', 1),
  (5, 'B. Kumar', 1),
  (6, 'Y. Singh', 2),
  (7, 'Virender Sehwag ', 2),
  (8, 'Ajinkya Rahane', 2),
  (9, 'Shikhar Dhawan', 2),
  (10, 'Mohammed Shami', 3),
  (11, 'Shreyas Iyer', 3),
  (12, 'Mayank Agarwal', 3),
  (13, 'K. L. Rahul', 3),
  (14, 'Hardik Pandya', 4),
  (15, 'Dinesh Karthik', 4),
  (16, 'Jasprit Bumrah', 7),
  (17, 'Kuldeep Yadav', 7),
  (18, 'Yuzvendra Chahal', 8),
  (19, 'Rishabh Pant', 8),
  (20, 'Sanju Samson', 8);
  
  -- Task :  manager ID si en buyuk ilk 10 kisiyi ekrana yazalim
  
  do $$
declare
    f_record;
  
  begin
   for f in select full_name,menager_id
   from employees
   order by menager_id desc
   limit 10
   
   loop
   
      raise notice '% - %',f.menager_id,f.full_name;
	  end loop;
	  
	  end $$;
	  
	  
	  exit when counter > 10;
	  
	  2.yol
	  if counter > 10 then
	  exit;
	  end if;
	  
	  
	  --Syntax :
continue {loop_label} {when condition}....--verilen condition saglandiginda gecer
-- Task : continue yapisi kullanarak 1 dahil 10 a kadar olan tek sayilari ekrana basalim

do $$

declare 

counter integer :=0;
begin

    loop
	counter:=counter+1;
	exit when counter>10
	continue when mod (counter,2)=0;
	raise notice '%',counter;
	end loop;
	
end $$;












 

 
 
 
 
 
 
 
 
 
 
 





