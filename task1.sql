use internet_market;


delete from product;
delete from seller;

insert into seller values(null, "Дмитрий");
SET @lastID := LAST_INSERT_ID();
insert into product values(null, "ноутбук", 100, 3000000, @lastID);
insert into product values(null, "телевизор", 200, 2000000, @lastID);
insert into product values(null, "диван", 50, 1000000, @lastID);
insert into product values(null, "подушка", 9999, 10000, @lastID);

insert into seller values(null, "Владимир");
SET @lastID := LAST_INSERT_ID();
insert into product values(null, "холодильник", 10, 3000000, @lastID);
insert into product values(null, "печь", 1, 2000000, @lastID);

insert into seller values(null, "Константин");
SET @lastID := LAST_INSERT_ID();
insert into product values(null, "умные часы", 10, 3000000, @lastID);
insert into product values(null, "пылесос", 0, 1000000, @lastID);

select distinct amount from product;
select count(id) as "количество продавцов" from seller;


