SELECT * FROM sakila.actor;
/*Consulta store_id, first_name y last_name de la tabla customer de la base de datos sakila.*/
SELECT store_id, first_name, last_name FROM sakila.customer;

/*Cambia el nombre de las columnas store_id, first_name y last_name a Tienda, Nombre y Apellido respectivamente.*/
SELECT store_id Tienda, first_name nombre, last_name apellido FROM sakila.customer;

/*¿Qué actores tienen el primer nombre 'Scarlett'?*/
SELECT * FROM sakila.actor WHERE first_name = 'Scarlett';
/*¿Qué actores tienen el apellido "Johansson"?*/
SELECT * FROM sakila.actor WHERE last_name = 'Johansson';

/*¿Cuántos apellidos de actores distintos hay?*/
SELECT distinct count(last_name) FROM sakila.actor;

/*¿Qué apellidos no se repiten?*/
SELECT last_name, count(*) FROM sakila.actor
GROUP BY last_name
HAVING count(*) = 1;

/*Ordena de manera descendente la columna Apellido*/
SELECT last_name as apellido FROM sakila.customer ORDER BY 1 desc;

/*Consulta la tabla payment de la base de datos sakila.*/
SELECT * FROM sakila.payment;

/*¿Cuál es la cantidad mas baja y mas alta de la columna amount?*/
SELECT MIN(amount) FROM sakila.payment;
SELECT MAX(amount) FROM sakila.payment;

/*Consulta description, release_year de la tabla film de la base de datos sakila.*/
SELECT description, release_year FROM sakila.film;

/*Filtra la información donde title sea IMPACT ALADDIN*/
SELECT description FROM sakila.film WHERE title = 'IMPACT ALADDIN';

/*Consulta la tabla payment de la base de datos sakila.*/
SELECT * FROM sakila.payment;

/*Filtra la información donde amount sea mayor a 0.99.*/
SELECT amount FROM sakila.payment WHERE amount > 0.99 ORDER BY 1;

/*Consulta la tabla payment de la base de datos sakila.
Filtra la información donde customer_id sea igual a 36, amount sea mayor a 0.99 y staff_id sea igual a 1.*/
SELECT * FROM sakila.payment;
SELECT * FROM sakila.payment WHERE (customer_id = 36 AND amount > 0.99 AND staff_id = 1);

/*Consulta la tabla rental de la base de datos sakila.
Filtra la información donde staff_id no sea 1, customer_id sea mayor a 250 y inventory_id sea menor de 100.*/
SELECT * FROM sakila.rental;
SELECT * FROM sakila.rental WHERE (staff_id <> 1 AND customer_id > 250 AND inventory_id < 100);

/*Consulta la tabla film_text de la base de datos sakila.
Filtra la información donde title  sea ZORRO ARK, VIRGIN DAISY, UNITED PILOT*/
SELECT * FROM sakila.film_text WHERE title IN ('ZORRO ARK', 'VIRGIN DAISY', 'UNITED PILOT');

/*Consulta la tabla city de la base de datos sakila.
Filtra la información donde city sea Chiayi, Dongying, Fukuyama y Kilis.*/
SELECT * FROM sakila.city WHERE city IN ('Chiayi', 'Dongying', 'Fukuyama', 'Kilis');

/*Consulta la tabla payment de la base de datos sakila.
Filtra la información donde amount esté entre 2.99 y 4.99,  staff_id sea igual a 2 y customer_id sea 1 y 2.*/
SELECT * FROM sakila.payment WHERE (amount BETWEEN 2.99 AND 4.99) AND staff_id = 2 AND customer_id BETWEEN 1 AND 2;
SELECT * FROM sakila.payment WHERE (rental_id BETWEEN 7273 AND 8033);

/*Filtra la información donde rental_rate esté entre 0.99 y 2.99, length sea menor igual de 50  y 
replacement_cost sea menor de 20.*/
SELECT * FROM sakila.film WHERE (rental_rate BETWEEN 0.99 AND 2.99) AND length <= 50 AND replacement_cost < 20;

/*Consulta la tabla film de la base de datos sakila.
Filtra la información donde release_year sea igual a 2006  y title empiece con ALI.*/
SELECT * FROM sakila.film WHERE release_year = 2006 AND title LIKE 'ALI%';

/*Consulta la tabla address de la base de datos sakila.
Realiza un INNER JOIN con las tablas city y country
Mostrar las columnas address, city, country*/
SELECT * FROM sakila.city;
SELECT * FROM sakila.country;
SELECT ad.address a, ci.city b, cou.country c FROM sakila.address ad
INNER JOIN sakila.city ci ON (ad.city_id = ci.city_id)
INNER JOIN sakila.country cou ON (cou.country_id = ci.country_id); 

/*Consulta la tabla customer de la base de datos sakila.
Realiza un LEFT JOIN con las tablas store y address
Mostrar las columnas first_name, address, store_id*/
SELECT cu.first_name nombre, ad.address direccion, cu.store_id FROM sakila.customer cu
LEFT JOIN sakila.address ad ON (ad.address_id = cu.address_id);

/*Consulta la tabla rental de la base de datos sakila.
Realiza un INNER JOIN con la tabla staff
Mostrar las columnas rental_id, first_name*/
SELECT re.rental_id, first_name FROM  sakila.rental re
INNER JOIN sakila.staff st ON (re.staff_id  = st.staff_id);

/*Consulta la tabla rental de la base de datos sakila.
Realiza un MAX de  la columna rental_date */
SELECT customer_id, MAX(rental_date) FROM sakila.rental
GROUP BY 1;

/*Consulta la tabla actor de la base de datos sakila.
Realiza un COUNT de  last_name
Mostrar cuando el COUNT sea mayor de 2*/
SELECT last_name, COUNT(*) veces_repetidas

FROM sakila.actor

GROUP BY last_name

HAVING COUNT(*) > 3;

/*Mostrar el nombre de los clientes con más de 5 montos*/
SELECT c.first_name Nombre, COUNT(*) Montos FROM sakila.payment p
INNER JOIN sakila.customer c ON (p.customer_id = c.customer_id)
GROUP BY amount
HAVING COUNT(*) > 5;

/*Mostrar el cliente con más montos*/
SELECT distinct c.first_name, c.last_name, COUNT(p.amount) Montos FROM sakila.payment p
INNER JOIN sakila.customer c ON (p.customer_id = c.customer_id)
GROUP BY c.customer_id
HAVING COUNT(p.amount) >=  ALL 
(SELECT distinct COUNT(*) FROM sakila.payment p
INNER JOIN sakila.customer c ON (p.customer_id = c.customer_id)
GROUP BY c.customer_id);

/*¿Qué actor ha aparecido en la mayoría de las películas?*/
SELECT a.first_name, a.last_name, count(*) FROM sakila.actor a
INNER JOIN sakila.film_actor f ON (a.actor_id = f.actor_id)
GROUP BY a.actor_id
HAVING COUNT(*) >= ALL (SELECT count(*) FROM sakila.actor a
INNER JOIN sakila.film_actor f ON (a.actor_id = f.actor_id)
GROUP BY a.actor_id);

/*¿Se puede alquilar ‘Academy Dinosaur’ en la tienda 1?*/
SELECT film.film_id, film.title, store.store_id, inventory.inventory_id
FROM sakila.inventory JOIN sakila.store using (store_id) JOIN sakila.film using (film_id)
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;
