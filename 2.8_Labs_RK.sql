-- 1. Write a query to display for each store its store ID, city, and country.

SELECT 
	st.store_id, 
    c.city,
    co.country
FROM store as st
LEFT JOIN address as a
ON st.address_id = a.address_id
LEFT JOIN city as c
ON a.city_id = c.city_id
LEFT JOIN country as co
ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT 
	st.store_id,
    sum(amount)
FROM payment as p
JOIN staff as s
ON p.staff_id = s.staff_id
JOIN store as st
ON s.store_id = st.store_id
GROUP BY st.store_id; 


-- 3. Which film categories are longest?

SELECT
    cat.name as 'category',
    round(avg(f.length),2)
FROM film as f
JOIN film_category as fc
ON	f.film_id = fc.film_id
JOIN category as cat
ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY round(avg(f.length),2)DESC;

-- 4. Display the most frequently rented movies in descending order.

SELECT 
	f.title,
	count(r.rental_id)
FROM rental as r
JOIN inventory as i
ON r.inventory_id = i.inventory_id
JOIN film as f
ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY count(r.rental_id) DESC;

-- 5. List the top five genres in gross revenue in descending order.

SELECT 
	c.name,
    round(sum(amount),2) as revenue
FROM sakila.payment as p
JOIN rental as r
ON p.rental_id = r.rental_id
JOIN inventory as i
ON r.inventory_id = i.inventory_id
JOIN film as f
ON i.film_id = f.film_id
JOIN film_category as fc
ON f.film_id = fc.film_id
JOIN category as c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT
	i.store_id,
    i.inventory_id,
    f.title
FROM inventory as i
RIGHT JOIN film as f
ON i.film_id = f.film_id
AND f.title = 'ACADEMY DINOSAUR'
RIGHT JOIN rental as r
ON i.inventory_id = r.inventory_id
WHERE i.store_id= 1 and isnull(return_date)=0
GROUP BY i.inventory_id;

-- movie is available - not only one but 4 copies

-- 7. Get all pairs of actors that worked together. -> Forget pairs. New Question: Get all actors, that worked in every movie


-- > No Solution yet
film_actor
fa.actor_id
fa.film_id



-- 8. Get all customers that have rented the same film more than 3 times.
-- Wasn't able to solve 7 properly -> therefor return all customers who rented any movie more than 3 times

SELECT 
	concat(c.first_name," ",c.last_name) as full_name,
    count(r.rental_id) as num_rent
FROM rental as r
LEFT JOIN customer as c
ON r.customer_id = c.customer_id
JOIN inventory as i
ON r.inventory_id = i.inventory_id
GROUP BY i.film_id, concat(c.first_name," ",c.last_name)
HAVING num_rent =3;


-- 9. For each film, list actor that has acted in more films.

SELECT
	concat(a.first_name," ",a.last_name),
    count(fa.film_id)
FROM film_actor as fa
JOIN actor as a
ON fa.actor_id = a.actor_id
GROUP BY a.actor_id
HAVING count(fa.film_id)>1;


