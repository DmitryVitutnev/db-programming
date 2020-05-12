use internet_market;


-- Выборка без WHERE
select all amount from product;
select distinct amount from product;
select name,
	case
    when amount = 0
    then "нет в наличии"
    else amount
    end amount
from product;

-- Выборка вычисляемых значений. Использование псевдонимов
select *, (price * amount) as "total price" from product;

-- Синтаксис фразы WHERE. BETWEEN, IS [NOT] NULL, LIKE, UPPER, LOWER. IN, EXISTS
select * from product where amount between 10 and 200;
select * from product where id is not null;
select upper(`name`) from product where name like "%к";
select lower(`name`) from seller;
select * from product where name in ("холодильник", "диван");
select * from product as p where 
	exists (select product_id from product_has_category 
    where product_id = p.id);

-- Выборка с упорядочением. ORDER BY, ASC, DESC
select * from product order by price asc;
select * from product order by amount desc;

-- Агрегирование данных. Агрегатные SQL-функции (COUNT, SUM, AVG, MIN, MAX).
select count(*), sum(price), max(price), min(price), avg(price) from product;

-- Агрегирование данных без и с использованием фразы GROUP BY. Фраза HAVING.
select seller_id, count(*), sum(price), max(price), min(price), avg(price) 
	from product group by seller_id;
select seller_id, sum(price), max(price), min(price), avg(price) 
	from product group by seller_id having sum(price) > 4500000;
