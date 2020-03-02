use internet_market;

select all amount from product;
select distinct amount from product;
select name,
	case
    when amount = 0
    then "нет в наличии"
    else cast(amount as char(20))
    end amount
from product;

select count(id) as "количество продавцов" from seller;

select * from product where amount between 10 and 200;
select * from product where id is not null;
select upper(`name`) from product where name like "%к";
select lower(`name`) from seller;
select * from product where name in ("холодильник", "диван");
select * from product as p where 
	exists (select product_id from product_has_category 
    where product_id = p.id);

select * from product order by price asc;
select * from product order by amount desc;

select sum(price), max(price), min(price), avg(price) from product;

select seller_id, sum(price), max(price), min(price), avg(price) 
	from product group by seller_id;

select seller_id, sum(price), max(price), min(price), avg(price) 
	from product group by seller_id having sum(price) > 4500000;