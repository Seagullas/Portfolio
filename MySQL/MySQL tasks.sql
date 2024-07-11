-- 1. 
/*
Naudoti: sql_invoicing.invoices;
Pateikti 'client_id', 'invoice_total', 'number' stulpelius. Surūšiuokite duomenis pagal 'client_id'
nuo mažiausios reikšmės ir pagal 'invoice_total' nuo didžiausios reikšmės (1t);
*/
select * from sql_invoicing.invoices;
select client_id, invoice_total, number from sql_invoicing.invoices order by client_id, invoice_total desc;

-- 2. 
/*
Naudoti: sql_invoicing.invoices; 
Pateikite visus unikalias 'client_id' reikšmes ir jas išrikiuokit
nuo didžiausios mažėjančia reikšme. (1t);
*/
select * from sql_invoicing.invoices;
select distinct client_id from sql_invoicing.invoices order by client_id desc;

-- 3.
/*
Naudoti: sql_invoicing.payments;
Parašykite SQL užklausą, kuri paskaičiuoja bendrą visų mokėjimų ('amount') sumą.
Rezultatą pateikite stulpelyje 'iš viso'. Taip pat paskaičiuokite mokėjimų vidurkį - 
pavadinkite stulpelį 'mokėjimų vidurkis'. Paskaičiuokite mažiausią ir didžiausią mokėjimą.
Šiuos stulpelius pavadinkite savo parinktais pavadinimais.
Taip pat paskaičiuokite unikalių pirkėjų ('client_id') skaičių, bei unikalių sąskaitų faktūrų kiekį ('invoice_id').
Šiuos stulpelius taip pat pavadinkite savo parinktais pavadinimais. (2t);
*/
select * from sql_invoicing.payments;
select sum(amount) as 'iš viso', avg(amount) as 'mokėjimų vidurkis', min(amount) as min_mokėjimas, max(amount) as max_mokėjimas, count(distinct client_id) as unikalūs_klientai, count(distinct invoice_id) as unikalūs_invoisai from sql_invoicing.payments;

-- 4.
/*
Naudoti: sql_hr.employees; 
Parašykite SQL užklausą, kuri ištrauktų visus įrašus, kur stulpelio 'salary' 
reikšmė yra mažesnė už 40 000. Išrikiuokite įrašus nuo dižiausios algos ('salary') mažėjančia tvarka.
Prie šitų išfiltruotų įrašu pateikite papildomą stulpelį (užvadinkite jį 'new_salary'), kur 
alga būtų padidinta 15 procentų. (2t);
*/

select * from sql_hr.employees;
select *, salary*1.15 as new_salary from sql_hr.employees where salary> 40000 order by salary desc;

-- 5. 
/*
Naudoti: sql_store.products;
Ištirkite produkto pavadinimo ('name') stulpelį. Kelinta raidė yra 'e'. 
Išrikiuokite rezultatą nuo toliausiai esančios 'e' raidės. (1t);
*/
select * from sql_store.products;
select name, locate('e', name) as e_pozicija from sql_store.products where locate('e', name)!=0 order by e_pozicija desc;

-- 6. 
/*
Naudoti: sql_store.customers; 
Parašykite SQL užklausą, kuri ištrauktų visus įrašus, kurių miestas ('city') yra Vilnius, Klaipėda ir Alytus,
o lojalumo taškų ('points') pirkėjas yra surinkęs mažiau nei 1000.
Išrikiuoti rezultatus pagal lojalumo taškus didėjančia tvarka. (1t);
*/
select * from sql_store.customers;
select * from sql_store.customers where (city = 'Vilnius' or city = 'Alytus' or city= 'Klaipėda') and points <1000 order by points;


-- 7.
/*
Naudoti: sql_hr.employees;
Parašykite SQL užklausą, kuri suskaičiuotų algų sumą darbuotojų, 
kurių 'job_title' stulpelyje yra reikšmė 'Operacijų'.
Stulpelį pavadinkite `sum_salary` (1t);
*/
select * from sql_hr.employees;
select sum(salary) as sum_salary from sql_hr.employees where job_title like 'Operacijų%';



-- 8.
/*
Naudoti: sql_store.shippers,
         sql_store.orders,
         sql_store.order_items;
Parašykite užklausą, kuri pateiktų tiekėjų (SHIPPERS lentelė) pavadinimus, 
kiekį skirtingų prekių ('product_id') ir kiekį skirtingų užsakymų ('order_id') tiekėjas yra tiekęs.
Stulpelius pavadinkite atitinkamai 'Cnt_unique_products', 'Cnt_unique_orders'.
Išrikiuokite rezultatą pagal tiekėjo pavadinimą abacėlės tvarka. (3t);
*/
select * from sql_store.shippers;
select * from sql_store.orders where shipper_id is not null;
select * from sql_store.order_items;
select 
	t1.name
    ,count(distinct t2.product_id) as Cnt_unique_products
    ,count(distinct t3.order_id) as Cnt_unique_orders
from sql_store.order_items as t2
join sql_store.orders as t3 using(order_id)
join sql_store.shippers as t1 using(shipper_id)
group by name ;




-- 9.
/*
Naudoti: sakila.film;
Parašykite SQL užklausą, kuri pateiktų filmų pavadinimus ('title'), reitingus ('rating'), bei 
suskirstytų filmus pagal jų reitingus ('rating') į tokias kategorijas:
Jei reitingas yra 'PG' arba 'G' tada 'PG_G'
Jei reitingas yra 'NC-17' arba „PG-13“ tada „NC-17_PG-13“
Visus kitus reitingus priskirkite kategorijai 'Nesvarbu'
Kategorijas atvaizduokite stulpelyje 'Reitingo_grupė' (2t)
*/
select * from sakila.film;
select
	title
    ,rating
    ,case (rating)
		when 'PG' Then 'PG_G'
        when 'G' then 'PG_G'
        when 'NC-17' then 'NC-17_PG-13'
        when 'PG-13' then 'NC-17_PG-13'
        else 'nesvarbu'
	end as reitingo_grupė
from sakila.film;
-- 10.
/*
Naudoti: sakila.film;
Parašykite SQL užklausą, kuri suskaičiuotų kiek filmų priklauso reitingo grupėms, kurios buvo sukurtos 9-ame uždavinyje.
Rezultate pateikite tik tokias reitingo grupes, kurioms priklausantis filmų kiekis yra 250 - 450 intervale. 
Išrikiuokite rezultatą nuo didžiausio filmų kiekio mažėjančia tvarka. (4t)
*/
select
	reitingo_grupė
	,kiekis
from (select
    case (rating)
		when 'PG' Then 'PG_G'
        when 'G' then 'PG_G'
        when 'NC-17' then 'NC-17_PG-13'
        when 'PG-13' then 'NC-17_PG-13'
        else 'nesvarbu'
	end as reitingo_grupė
    , count('PG_G') as 'kiekis'
from sakila.film
group by reitingo_grupė) as dt
where kiekis between 250 and 450;


-- 11. 
/*
Naudoti: sakila.customer, 
		 sakila.rental, 
         sakila.inventory, 
         sakila.film;
Pateikite klientų vardus ('first_name') ir pavardes ('last_name') iš CUSTOMER lentelės, kurie išsinuomavo filmą 'AGENT TRUMAN'. 
Užduotį atlikite naudodami subquery konstruktus. Išrikiuokite rezultą pagal kliento vardą (first_name) abecėlės tvarka.
Užduotis atlikta teisingai be subquery vertinama (2t). 
P.S. teisingame subquery konsrtukte turi būti 4 x SELECT sakiniai. (4t);
*/
select * from sakila.customer; -- customer_id
select * from sakila.rental; -- inventory_id
select * from sakila.inventory; -- film_id
select * from sakila.film; -- 6

select
	first_name 
	,last_name 
from sakila.customer where customer_id in (select customer_id from sakila.rental where inventory_id in (select inventory_id from sakila.inventory where film_id = (select film_id from sakila.film where title = 'AGENT TRUMAN')));
   
   /*
select first_name from sakila.customer where customer_id in (select customer_id from sakila.rental where inventory_id in (select inventory_id from sakila.inventory where film_id = (select film_id from sakila.film where title = 'AGENT TRUMAN')));
select customer_id from sakila.rental where inventory_id in (select inventory_id from sakila.inventory where film_id = (select film_id from sakila.film where title = 'AGENT TRUMAN'));    
select inventory_id from sakila.inventory where film_id = (select film_id from sakila.film where title = 'AGENT TRUMAN');
select film_id from sakila.film where title = 'AGENT TRUMAN';
*/
-- 12.
/*
Naudoti: sql_invoicing.clients, 
		 sql_invoicing.invoices;
Parašykite užklausą, kuri pateiktų clientų id ('client_id'), klientų pavadinimą ('name') ir kiek tie klientai 
turi neapmokėtų sąskaitų. Neapmokėtom sąskaitom ieškoti naudokite 'payment_date' stulpelį.
Išrikiuokite rezultatą pagal kliento id nuo diždiausios reikšmės mažėjančia tvarka. (3t);
*/
select * from sql_invoicing.clients;
select * from sql_invoicing.invoices;
select
	t1.client_id
    ,t1.name
    ,count(*) as neapmoketos_sask
from sql_invoicing.clients as t1
join sql_invoicing.invoices as t2 using(client_id)
where (t2.payment_date) is null
group by name,client_id;


-- 13.
/*
Naudoti: sql_store.products;
Iš products lentelės pateikite produkto pavadinimą ('name').
Šalia pateikite ir kitą stulpelį, kuriame suformuotumėte naują produkto pavadinimo rašymo struktūrą ir pavadinkite jį 'new_name'.
Sąlyga: jei produkto pavadinimas turi tarpelį, tuomet naujoje struktūroje jį pakeiskite į tris žvaigždutes '***';
		jei produkto pavadinimas tarpelio neturi, tuomet pridėkite prieš pavadinimą trys šauktukus '!!!'. (2t);
*/
select * from sql_store.products;
select 
	name
    ,case(name)
		when name like '% %' then concat('!!!', name)
        else '***'
    end as new_name
from sql_store.products;


-- 14.
/*
Naudoti: sql_store.customers;
Pateikite įrašus iš CUSTOMERS lentelės jei pirkėjas turi daugiau lojalumo taškų ('points') už visų  
esančių pirkėjų lojalumo taškų vidurkį. Naudokite tokiai paieškai SUBQUERY konstruktą.
Išrikiuokite įrašus nuo daugiausiai lojalumo taškų turinčio pirkėjo. (2t);
*/
select * from sql_store.customers;
select points from sql_store.customers where points> (select avg(points) from sql_store.customers) order by points desc;


-- 15.
/*
Parašykite SELECT užklausą, kuri atvaizduotų Jūsų vardą kaip reikšmę stulpelyje pavadinimu 'Vardas',
stulpelį 'VCS MySQL kursas' su reikšme 'Labai patiko :)' ir stulpelį 'Surinkau taškų' su taškų skaičiumi, kurį 
manote jog surinkote spręsdami šį testą. :)))
(1t);
*/

select
	'German' as vardas
    ,'Labai patiko ;)'as'VCS MySQL kuras'
    ,'28' as 'Surinkau taškų'
    
