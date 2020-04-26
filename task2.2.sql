use task2_2;

-- команды, которые тренировал более чем один тренер
select distinct t1.team from team_trainer as t1 inner join team_trainer as t2 
on t1.team = t2.team and t1.trainer <> t2.trainer;

-- писателей, которые писали во всех жанрах, представленных в таблице
select distinct author from author_genre
where author not in (
	select distinct author from (
		select * from (
			select distinct author from author_genre) as a
		cross join (
			select distinct genre from author_genre) as g
		where not exists (
			select * from author_genre as ag where a.author = ag.author and g.genre = ag.genre)) as wrond_authors);

-- жанры, в которых писали все
select distinct genre from author_genre
where genre not in (
	select distinct genre from (
		select * from (
			select distinct author from author_genre) as a
		cross join (
			select distinct genre from author_genre) as g
		where not exists (
			select * from author_genre as ag where a.author = ag.author and g.genre = ag.genre)) as wrond_authors);
            
-- тренеров, которые не тренировали заданную команду
SET @team = "Первая";
select distinct trainer from team_trainer as t1
where not exists (
	select * from team_trainer as t2
    where t2.team = @team and t1.trainer = t2.trainer);

-- тренеров, для которых среднее количество очков команд, которые они тренировали, больше среднего значения по всем тренерам из таблицы
SET @avg = (SELECT AVG(score) FROM team_trainer_place_score);

select trainer from (
	select trainer, avg(score) as avg_score from team_trainer_place_score
	group by trainer) as temp
where temp.avg_score > @avg;

-- команды, становившиеся чемпионами с разными тренерами
select distinct t1.team from team_trainer_place_score as t1
inner join team_trainer_place_score as t2
on t1.team = t2.team and t1.trainer <> t2.trainer and t1.place = 1 and t2.place = 1;

-- команды, которые тренировали тренеры, выигравшие чемпионат не с этой, а с другими командами
select distinct team from team_trainer_place_score as t1
where place <> 1 and exists (
	select * from team_trainer_place_score as t2
    where t2.trainer = t1.trainer and t2.team <> t1.team and t2.place = 1)

