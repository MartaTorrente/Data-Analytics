select * from transaction;
select * from company;

select distinct country from company
join transaction
on company.id = transaction.company_id;


select count(distinct country) from company
join transaction
on company.id = transaction.company_id;

#Identifica la companyia amb la mitjana més gran de vendes.

select count(distinct country) from company
join transaction
on company.id = transaction.company_id;

select company_name, avg(amount) as media_gasto from company
join transaction
on company.id = transaction.company_id
group by company_name order by media_gasto limit 1;


#Mostra totes les transaccions realitzades per empreses d'Alemanya.

select * from transaction
where transaction.company_id in
	(select company.id from company where country = 'Germany');


#Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.

select company_name, amount from company
join transaction
on company.id = transaction.company_id
where amount > (select avg(amount) from transaction);

#Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.

select * from company 
left join  transaction
on company.id = transaction.company_id
where transaction.id is NUll;

select distinct company_id from transaction;

# Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. Mostra la data de cada transacció juntament amb el total de les vendes.
select * from transaction;


select date(timestamp) as fecha, sum(amount)as suma_total_ventas from transaction
group by date(timestamp)
order by suma_total_ventas desc limit 5;

# Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.

select country, avg(amount) as Media_ventas from company
join transaction
on company.id = transaction.company_id
group by country
order by Media_ventas desc;

# En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia "Non Institute". 
# Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.
# Mostra el llistat aplicant JOIN i subconsultes.

select * from transaction
join company
on company.id = transaction.company_id
where country = (
select country from company
where company_name = "Non Institute");

# Mostra el llistat aplicant solament subconsultes.


