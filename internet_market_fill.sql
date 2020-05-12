use internet_market;

-- Очистка таблицы проводится таким образом, чтобы она работала даже в безопасном режиме
-- Безопасный режим позволяет удалять записи только с условием на ключевой атрибут

delete from product_has_category where product_id != 0;
delete from product where id != 0;
delete from seller where id != 0;
delete from category where id != 0;
delete from byer where id != 0;
delete from trade where id != 0;
delete from product_in_trade where id != 0;
delete from log where id != 0;


-- Заполнение таблицы. Вынес всё это в отдельный файл, чтобы не пересоздавать таблицу при экстренной перезагрузке данных

insert into seller values(1, "Дмитрий");
insert into product values(1, "ноутбук", 100, 3000000, 1);
insert into product values(2, "телевизор", 200, 2000000, 1);
insert into product values(3, "диван", 50, 1000000, 1);
insert into product values(4, "подушка", 9999, 10000, 1);
insert into product values(5, "ручка", 9999, 1, 1);

insert into seller values(2, "Владимир");
insert into product values(6, "холодильник", 10, 3000000, 2);
insert into product values(7, "печь", 1, 2000000, 2);
insert into product values(8, "ручка", 9999, 1, 2);

insert into seller values(3, "Константин");
insert into product values(9, "умные часы", 10, 3000000, 3);
insert into product values(10, "пылесос", 0, 1000000, 3);
insert into product values(11, "ручка", 9999, 1, 3);

insert into category values(1, "для дома");
insert into category values(2, "техника");
insert into category values(3, "посуда");

insert into product_has_category values(3, 1);
insert into product_has_category values(6, 1);
insert into product_has_category values(6, 2);
insert into product_has_category values(9, 2);

insert into byer values(1, "Дмитрий", 10);
insert into byer values(2, "Анна", 20000);
insert into byer values(3, "Виктория", 1000000);

