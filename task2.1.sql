use internet_market;

select `name` from seller
union
select `name` from byer;

select `name` from seller
union all
select `name` from byer;

#select `name` from seller
#minus
#select `name` from byer;

select product.`name`, category.`name` from product 
	inner join product_has_category on product.id=product_has_category.product_id
    inner join category on product_has_category.category_id=category.id;
    
select product.`name`, category.`name` from product 
	left outer join product_has_category on product.id=product_has_category.product_id
    left outer join category on product_has_category.category_id=category.id;
    
