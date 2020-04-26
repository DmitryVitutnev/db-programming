use internet_market;

delete from product_has_category where product_id != 0;
delete from product where id != 0;
delete from seller where id != 0;
delete from category where id != 0;
delete from byer where id != 0;
delete from trade where id != 0;
delete from product_in_trade where id != 0;


insert into seller values(1, "Дмитрий");
insert into product values(1, "ноутбук", 100, 3000000, 1);
insert into product values(2, "телевизор", 200, 2000000, 1);
insert into product values(3, "диван", 50, 1000000, 1);
insert into product values(4, "подушка", 9999, 10000, 1);

insert into seller values(2, "Владимир");
insert into product values(5, "холодильник", 10, 3000000, 2);
insert into product values(6, "печь", 1, 2000000, 2);

insert into seller values(3, "Константин");
insert into product values(7, "умные часы", 10, 3000000, 3);
insert into product values(8, "пылесос", 0, 1000000, 3);

insert into category values(1, "для дома");
insert into category values(2, "техника");

insert into product_has_category values(3, 1);
insert into product_has_category values(5, 1);
insert into product_has_category values(5, 2);
insert into product_has_category values(7, 2);

insert into byer values(1, "Дмитрий");
insert into byer values(2, "Виктория");
insert into byer values(3, "Анна");
