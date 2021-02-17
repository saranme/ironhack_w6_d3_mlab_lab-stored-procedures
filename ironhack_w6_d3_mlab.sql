/*
In the previous lab we wrote a query to find first name, 
last name, and emails of all the customers who rented Action movies. 
Convert the query into a simple stored procedure. Use the following query:

*/
use sakila;

drop procedure if exists first_name_email_last;

delimiter //
create procedure first_name_email_last (out param1 float)
begin
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = "Action"
group by first_name, last_name, email;
end;
//
delimiter ;

call first_name_email_last(@x);

/*
Now keep working on the previous stored procedure to make it more dynamic. 
Update the stored procedure in a such manner that it can take a string argument 
for the category name and return the results for all customers that rented movie of that category/genre. 
For eg., it could be action, animation, children, classics, etc.
*/
drop procedure if exists first_name_email_last;

delimiter //
create procedure first_name_email_last (in param2 char(50))
begin
select first_name, last_name, email
from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on film.film_id = inventory.film_id
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name = param2
group by first_name, last_name, email;
end;
//
delimiter ;

call first_name_email_last('Action');

/*
Write a query to check the number of movies released in each movie category. 
Convert the query into a stored procedure to filter only those categories 
that have movies released greater than a certain number. Pass that number 
as an argument in the stored procedure.
*/
drop procedure if exists n_movies_per_category;

delimiter //
create procedure n_movies_per_category(in param1 int)
begin
SELECT COUNT(fc.film_id) n_movies, c.category_id, c.name category
FROM film_category fc
JOIN category c
ON c.category_id = fc.category_id
GROUP BY c.category_id
HAVING COUNT(fc.film_id) > param1;
end;
//
delimiter ;

call n_movies_per_category(56);