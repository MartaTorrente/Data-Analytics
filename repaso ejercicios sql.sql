# 1) Mostra totes les dades de la taula city.
select * from city;

# 2) Mostra el "name", "continent" i "region" de la taula country.
select name, continent, region from country;

# 3) Mostra els noms dels països i la seva "population" ordenats per la seva "LifeExpectancy" de major a menor.
select name, population, lifeexpectancy from country
order by LifeExpectancy desc;

# 4) Mostra el top10 dels paisos de la consulta anterior.
select name, population, lifeexpectancy from country
order by LifeExpectancy desc limit 10;

#5) Mostra quines són les "GovernmentForm" úniques que hi ha a la taula country.

select DISTINCT (governmentform) from country;

# 6) Mostra tots els llenguatges que es parlen al món.
select distinct (language) from countrylanguage;

# 1) Mostra totes les dades de les ciutats que comencen per "al-", de la taula city.

select * from city
where name like 'al-%';

select * from city;
select * from city
where name like 'b%r';


# 2) De la consulta anterior, mostra els "countryCode" únics.

select distinct countrycode from city
where name like 'al-%';

# 3) Mostra el "name" de les ciutats que tenen menys de 10.000 persones de "population".
select name, population from city
where population < 10000;

# 4) Mostra les ciutats dels "countryCode" AUS, DOM, GMB i SLV.
select id, name, COUNTRYCODE from city
where CountryCode in('AUS','DOM','GMB','SLV');

# 5) Mostra totes les dades dels països que tenen entre 70 i 80 anys de "LifeExpectancy".
select * from country
where LifeExpectancy BETWEEN 70 and 80;

# 6) Mostra els noms dels països que estan al continent europeu i a la regió nòrdica.
select name from country
where Continent = 'europe' and region = 'nordic countries';

# 7) Mostra els 3 països amb més "LifeExpectancy" del grup de països d'europa bàltica i nord amèrica carib.
select name, lifeexpectancy from country
where (continent = 'europe' and region = 'baltic countries') or (continent = 'north america' and region = 'caribbean')
order by LifeExpectancy desc limit 3;

# no le gusta pq si hay cruzados no funcionaria, mejor usar or, debemos usar conjuntos donde se vea que europe va con baltic y nort america con caribbean 
# SELECT * FROM country where (continent = "Europe" and region = "Baltic Countries") or (continent = "North America" and region = "Caribbean") ORDER BY LifeExpectancy DESCLIMIT 3;

# 8) Mostra els països que comencen per lletra "i" o comencen per lletra "o".
select name from country
where name like 'i%' or name like 'o%';

# 9) Mostra tots els llenguatges que es parlen al món (que són llenguatge oficial al seu país).

select distinct language from countrylanguage
where isofficial = 'T';

select * from countrylanguage;

# 1) Mostra la quantitat de ciutats que hi ha a la taula city.

select distinct(count(id)) as total_cities from city;

# 2) Mostra la quantitat de ciutats que té cada "countryCode" de la taula city.
select countrycode , count(id)  as total_cities from city
group by countrycode;


# cuenta cuantas ciudades hay de cada nombre

select name, count(id) as total_cities from city
group by name;

# 3) Mostra la "population" màxima de cada "countryCode" de la taula city.
select max(population) as max_population, countrycode from city
group by countrycode;

# 4) Mostra la "lifeExpentacy" mitja de cada continent i regió de la taula country.

select continent, region, avg(lifeexpectancy) as media_lifeexpectancy from country
group by continent, region
order by continent;

# 5) Mostra la "population" total de cada continent.
select continent, sum(population) as total_population from country
group by continent;

# 6) Mostra la "surfaceArea" més petita de cada regió de cada continent.
select continent, region, min(surfacearea) as min_surfacearea from country
group by continent, region
order by Continent;

# 7) Mostra quants països té cada continent.
select continent, count(code) as total_countries from country
group by Continent;

# 8) Mostra els continents que tenen més de 50 països.

select continent, count(code) as total_countries from country
group by continent
having count(code) > 50 ;

# 9) Mostra la quantitat de països per "language" i per "IsOfficial". És a dir, quants països parlen una llengua en funció de si és oficial o no.
select language, isofficial, count(countrycode) as total_countries from countrylanguage
group by language, isofficial
order by language;

# 1) Mostra el nom del producte i el nom de la categoria dels productes que tenen un preu inferior a 15 euros.
select nombre_producto, nombre_categoria
from productos p
join categorias c
on p.id_categoria = c.id_categoria
where precio < 15;

# 2) Sobre la pregunta anterior, quina és la categoria amb més productes menors de 15 euros?
select nombre_categoria, count(id_producto) as total_productos
from productos p
join categorias c
on p.id_categoria = c.id_categoria
where precio < 15
group by nombre_categoria
order by count(id_producto) desc limit 1;

# 3) Mostra la quantitat de productes diferents que hi ha per comandes, de les comandes del 2023 que tenen 8 productes o més.
select  count(DISTINCT dp.id_producto) as total_productos,  p.id_pedido from detallespedidos dp
join pedidos p
on dp.id_pedido = p.id_pedido
where anio_pedido = 2023
group by id_pedido
having count(DISTINCT id_producto) >= 8;


# 4) De vegades falla el sistema que desa el detall de les comandes, així que mostra la quantitat de comandes que no tenen detall.


select count(p.id_pedido
) as Total_pedidos
from pedidos as p
left join detallespedidos as dp
on p.id_pedido =  dp.id_pedido
where dp.id_detalle is null;

# 5) Mostra el nom dels 3 usuaris que ha fet més comandes.

select u.nombre, count(id_pedido) as total_pedidos
from usuarios u
join pedidos p
on u.id_usuario = p.id_usuario
group by u.id_usuario,u.nombre
order by count(id_pedido) desc limit 3;



# 6) Mostra el nom i l'id dels usuaris que són de Lima, Perú i que han fet alguna comanda que ha tingut un pagament cancel·lat.




# 7) Mostra l'usuari que té una mitja de gast per comanda més alta (només s'han de tenir en compte les comandes finalitzades i no s'han de tenir en compte els pagaments cancel·lats)



# 8) Quina és la categoria de productes que més compren les dones?

