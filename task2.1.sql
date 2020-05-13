use internet_market;

-- UNION
select `name` from seller
union
select `name` from byer;

-- INTERSECT
select seller.name as name from seller
inner join byer on seller.name = byer.name;

-- MINUS
select seller.name as name from seller
where name not in (select byer.name from byer);

-- Деление (товары, которые продают все продавцы)
select distinct p1.name from product as p1
where not exists (
	select p2.seller_id from product as p2
	where p2.seller_id not in (
		select p3.seller_id from product as p3
        where p3.name = p1.name));

-- Естественное соединение
select * from seller natural join byer;

-- Композиция
select product.name as `продукт`, amount as `количество`, price as `цена`, seller.name as `продавец`, category.name as `патегория` from product
	join product_has_category on product.id = product_id
    join category on category_id = category.id
    join seller on seller_id = seller.id;

-- Эквисоединение
select * from seller join product on seller.id = product.seller_id;

-- INNER JOIN
select product.`name`, category.`name` from product 
	inner join product_has_category on product.id=product_has_category.product_id
    inner join category on product_has_category.category_id=category.id;

-- LEFT    
select product.`name`, category.`name` from product 
	left outer join product_has_category on product.id=product_has_category.product_id
    left outer join category on product_has_category.category_id=category.id;
    
-- RIGHT    
select product.`name`, category.`name` from product 
	right outer join product_has_category on product.id=product_has_category.product_id
    right outer join category on product_has_category.category_id=category.id;

-- Декатрово произведение
select * from byer, seller;
select * from byer cross join seller;

-- Тета-соединение
select byer.`name`, product.`name`, seller_id from byer
	inner join product on byer.money >= product.price;

-- Удаление дубликатов имён. Из-за тонкостей MySQL пришлось хитрить
insert into seller values(4, "Дмитрий");
select * from seller;
delete from seller where id <> 0 and id not in (
	select * from (
		select min(s2.id) from seller as s2 group by s2.name) as s3);        
select * from seller;
