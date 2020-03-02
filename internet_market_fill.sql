use internet_market;

delete from product where id != 0;
delete from seller where id != 0;
delete from category where id != 0;
delete from byer where id != 0;
delete from trade where id != 0;
delete from product_in_trade where id != 0;
delete from product_has_category where product_id != 0;

insert into seller values(null, "Дмитрий");
SET @dimaID := LAST_INSERT_ID();
insert into product values(null, "ноутбук", 100, 3000000, @dimaID);
insert into product values(null, "телевизор", 200, 2000000, @dimaID);
insert into product values(null, "диван", 50, 1000000, @dimaID);
insert into product values(null, "подушка", 9999, 10000, @dimaID);

insert into seller values(null, "Владимир");
SET @vovaID := LAST_INSERT_ID();
insert into product values(null, "холодильник", 10, 3000000, @vovaID);
insert into product values(null, "печь", 1, 2000000, @vovaID);

insert into seller values(null, "Константин");
SET @kostyaID := LAST_INSERT_ID();
insert into product values(null, "умные часы", 10, 3000000, @kostyaID);
insert into product values(null, "пылесос", 0, 1000000, @kostyaID);

insert into category values(null, "для дома");
insert into category values(null, "техника");

insert into product_has_category values((select id from product where `name` = "диван"), (select id from category where `name` = "для дома"));
insert into product_has_category values((select id from product where `name` = "холодильник"), (select id from category where `name` = "для дома"));
insert into product_has_category values((select id from product where `name` = "холодильник"), (select id from category where `name` = "техника"));
insert into product_has_category values((select id from product where `name` = "умные часы"), (select id from category where `name` = "техника"));
