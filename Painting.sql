CREATE DATABASE painting;

BULK INSERT [Painting].[dbo].[artist]
FROM 'E:\SQL PROJECT\Painting\artist.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR='\n' );

--1) Fetch all the paintings which are not displayed on any museums?
     select * from work where museum_id is null;

--2)Are there museuems without any paintings?
select *from [dbo].[museum] where museum_id not in (select museum_id from work)

--3) How many paintings have an asking price of more than their regular price? 
	select * from product_size
	where sale_price > regular_price;

--4) Identify the paintings whose asking price is less than 50% of its regular price
	select * 
	from product_size
	where sale_price < (regular_price*0.5);

--5)Which canva size costs the most?
--Method 1
	select cs.[label] as canva, ps.sale_price
	from (select *
		  , rank() over(order by sale_price desc) as rnk 
		  from product_size) ps
	join canvas_size cs on cs.size_id=ps.size_id
	where ps.rnk=1;	

--Method 2
	SELECT        TOP (1) dbo.canvas_size.label, dbo.product_size.sale_price
FROM            dbo.canvas_size INNER JOIN
                         dbo.product_size ON dbo.canvas_size.size_id = dbo.product_size.size_id
ORDER BY dbo.product_size.sale_price DESC

--Method 3
	with CTE as(
	select top 1 size_id,sale_price from product_size order by sale_Price desc)
	select canvas_size.[label],CTE.sale_price from canvas_size inner join CTE on 
	CTE.size_id=canvas_size.size_id

--7) Identify the museums with invalid city information in the given dataset
	select * from museum 
	--where ISNUMERIC( city )=1
	where city not LIKE '%[^0-9]%';

--9) Fetch the top 10 most famous painting subject

	select top 10 SUBject,COUNT(*) noOfPainting from subject
	group by subject order by noOfPainting desc

--10) Identify the museums which are open on both Sunday and Monday. Display museum name, city,state,country.
--Method1
select distinct m.name as museum_name, m.city, m.state,m.country 
	from museum_hours mh 
	join museum m on m.museum_id=mh.museum_id
	where day='Sunday'
	and exists (select 1 from museum_hours mh2 
				where mh2.museum_id=mh.museum_id 
			    and mh2.day='Monday') order by museum_name;
 --Method2
 with cte as(
SELECT  dbo.museum.name as MuseumName, dbo.museum.city, dbo.museum.state, dbo.museum.country, dbo.museum_hours.day
FROM            dbo.museum INNER JOIN
        dbo.museum_hours ON dbo.museum.museum_id = dbo.museum_hours.museum_id
WHERE       museum_hours.day in (N'Sunday',N'Monday')  )
select MuseumName,city,[state],country  from cte group by MuseumName,city,[state],country having count(day)=2 order by MuseumName

--11) How many museums are open every single day?
	WITH CTE as (select museum_id, count(*) as Countno
		  from museum_hours
		  group by museum_id
		  having count(*) = 7)
		  select COUNT(*) as NoOfmuseums from CTE
--12) Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)
	--Method1
	select m.name as museum, m.city,m.country,x.no_of_painintgs
	from (	select m.museum_id, count(1) as no_of_painintgs
			, rank() over(order by count(1) desc) as rnk
			from work w
			join museum m on m.museum_id=w.museum_id
			group by m.museum_id) x
	join museum m on m.museum_id=x.museum_id
	where x.rnk<=5;
--Method2
	with cte as(
	select top 5 museum_id,COUNT(museum_id) noOfCount from work group by museum_id order by COUNT(museum_id) desc)
	select museum.name as museum,museum.city,museum.country,cte.noOfCount  from cte inner join museum on cte.museum_id=museum.museum_id order by noOfCount desc


--13) Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)
	select a.full_name as artist, a.nationality,x.no_of_painintgs
	from (	select a.artist_id, count(1) as no_of_painintgs
			, rank() over(order by count(1) desc) as rnk
			from work w
			join artist a on a.artist_id=w.artist_id
			group by a.artist_id) x
	join artist a on a.artist_id=x.artist_id
	where x.rnk<=5;

--Method2
	with cte as(
	select top 5 artist_id,COUNT(artist_id) noOfCount from work group by artist_id order by COUNT(artist_id) desc)
	select artist.full_name as full_name,artist.nationality,cte.noOfCount  from cte inner join artist on cte.artist_id=artist.artist_id order by noOfCount desc

--14) Display the 3 least popular canva sizes
	select label,ranking,no_of_paintings
	from (
		select cs.size_id,cs.label,count(ps.work_id) as no_of_paintings
		, dense_rank() over(order by count(ps.work_id) ) as ranking
		from work w
		join product_size ps on ps.work_id=w.work_id
		join canvas_size cs on cs.size_id  = ps.size_id
		group by cs.size_id,cs.label) x
	where x.ranking<=3;

--15) Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?
	
	select top 1 m.name as museum_name, m.state, day, [open], [close]  ,DATEDIFF(MINUTE, [open], [close]) as Duration
			,rank() over(order by DATEDIFF(MINUTE, [open], [close]) desc) as Ranking
			from museum_hours mh
		 	join museum m on m.museum_id=mh.museum_id 

--16) Which museum has the most no of most popular painting style?
	--Method1
	with pop_style as 
			(select style
			,rank() over(order by count(1) desc) as rnk
			from work
			group by style),
		cte as
			(select w.museum_id,m.name as museum_name,ps.style, count(1) as no_of_paintings
			,rank() over(order by count(1) desc) as rnk
			from work w
			join museum m on m.museum_id=w.museum_id
			join pop_style ps on ps.style = w.style
			where w.museum_id is not null
			and ps.rnk=1
			group by w.museum_id, m.name,ps.style)
	select museum_name,style,no_of_paintings
	from cte 
	where rnk=1;
--Method2
	with pop_style as(
	select museum_id,style ,COUNT(style) noOfPaintings  from work where museum_id is not null group by museum_id,style )
	select top 1 ms.name as museumName,ps.* from pop_style as ps inner join museum ms on ps.museum_id=ms.museum_id
	order by ps.noOfPaintings desc

--17) Identify the artists whose paintings are displayed in multiple countries

with CTE as (
SELECT  distinct      dbo.artist.full_name, dbo.museum.country
FROM            dbo.artist INNER JOIN
dbo.[work] ON dbo.artist.artist_id = dbo.[work].artist_id INNER JOIN
dbo.museum ON dbo.[work].museum_id = dbo.museum.museum_id)
select full_name as Artist,COUNT(country)  as no_of_countries 
from CTE group by full_name 
having COUNT(country)>=2 
order by COUNT(country) desc

--18) Display the country and the city with most no of museums. Output 2 seperate columns to mention the city and country.
--If there are multiple value, seperate them with comma.
	with cte_country as 
			(select country, count(1) noOfmuesiuminCountry
			, rank() over(order by count(1) desc) as rnk
			from museum
			group by country),
		cte_city as
			(select city, count(1) noOfmuesiuminCity
			, rank() over(order by count(1) desc) as rnk
			from museum
			group by city)
	select ',' +  country.country +',' +city.city
	from cte_country country
	cross join cte_city city
	where country.rnk = 1
	and city.rnk = 1 FOR XML PATH('')

--19) Identify the artist and the museum where the most expensive and least expensive painting is placed. 
--Display the artist name, sale_price, painting name, museum name, museum city and canvas label
	with cte as 
		(select *
		, rank() over(order by sale_price desc) as rnk
		, rank() over(order by sale_price ) as rnk_asc
		from product_size )
	select cte.rnk,cte.rnk_asc, w.work_id,w.museum_id,w.name as painting
	, cte.sale_price
	, a.full_name as artist
	, m.name as museum, m.city
	, cz.label as canvas
	from cte
	join work w on w.work_id=cte.work_id
	join museum m on m.museum_id=w.museum_id
	join artist a on a.artist_id=w.artist_id
	join canvas_size cz on cz.size_id = cte.size_id 
	where rnk=1 or rnk_asc=1;	

--20) Which country has the 5th highest no of paintings?
	with cte as 
		(select m.country, count(w.work_id) as no_of_Paintings
		, rank() over(order by count(w.work_id) desc) as rnk
		from work w
		join museum m on m.museum_id=w.museum_id
		group by m.country)
	select country, no_of_Paintings
	from cte 
	where rnk=5;

--21) Which are the 3 most popular and 3 least popular painting styles?
--Method1
	with cte as 
		(select style, count(*) as cnt
		, rank() over(order by count(1) desc) rnk
		, rank() over(order by count(work_id) ) as rnk_asc
		, count(1) over() as no_of_records
		from work
		where style is not null
		group by style)
	select style
	, case when rnk <=3 then 'Most Popular' else 'Least Popular' end as remarks 
	from cte
	where rnk <=3
	or rnk > no_of_records - 3;

	--Method2
	with cte as (
	select style, count(*) as cnt
		, rank() over(order by count(*) desc) rnk
		, rank() over(order by count(*) asc) as rnk_asc		 
		from work
		where style is not null
		group by style
		)
		select style,cnt,case when rnk<=3 then 'Most Popular' when rnk_asc<=3 then 'Least Popular' end as remarks from CTE where rnk<=3 
		or rnk_asc<=3 order by cnt desc



--22) Which artist has the most no of Portraits paintings outside USA?. Display artist name, no of paintings and the artist nationality.
	
	with CTE as (
		select a.full_name, a.nationality
		,count(*) as no_of_paintings
		,rank() over(order by count(*) desc) as rnk
		from work w
		join artist a on a.artist_id=w.artist_id
		join subject s on s.work_id=w.work_id
		join museum m on m.museum_id=w.museum_id
		where s.subject='Portraits'
		and m.country != 'USA'
		group by a.full_name, a.nationality) 
		select full_name as artist_name, nationality, no_of_paintings from CTE 
	where rnk=1;	
	