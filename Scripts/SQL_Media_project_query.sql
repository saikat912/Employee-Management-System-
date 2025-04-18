create database Media_project

use Media_project

-- Check the table that you have imported

select * from Media_projects

---- We are getting error while performing the Import through the import wizard


---- Bulk insert into the structure we have made

-- file location- C:\Users\Crossignite.com\Downloads\Media_projects.csv

-- Bulk insert into Media_proeject table

Bulk insert media_projects
from 'C:\Users\Crossignite.com\Downloads\Media_projects.csv'
with (Fieldterminator=',', Rowterminator='\n' ,firstrow=2)

--- check the data--

select * from Media_projects


---- First we'll the datatype consistency, because we might have used the calculation over the date column, and for Goa, Pledged
-- Check with the ids , are they eligible for Primary key or not
-- and in other columns, do they have same type of data or not

--- for that we need to alter their structure
Select * from Media_projects
Select Column_name,Data_type
from INFORMATION_SCHEMA.columns
where table_name='Media_projects'

--- let's see and compare the data types and create plan to make in a consistent format

--ID- int, (current- varchar)
--Name- Varchar, current- varchar
--Category- varchar, Current- Varchar
--Sub category
-- Country-- 
--Launched- Date, Current- varchar
--Deadlin- Date, Current- varchar
-- GOal- Int, Current- Varchar
--Pledged- Int, C- Varchar
--backers- Int- Varchar
--State - Varchar- Cur- Varchar

--- ID

Alter Table Media_projects
alter column id int

--- Error - Occurence of NON numeric values

-- let's check how many non numeric values are there in the ID column (Media_projects)

select * from Media_projects
where Isnumeric(ID)=0 /* isnumeric func will check the numeric values, =0 means where are non numbers values*/


--- for Imputing these values which are non numeric into 0 

Update Media_projects set Id = Case When ISNUMERIC(id)=0 then 0 Else Id END

Alter Table Media_projects
alter column id int

--- Launched

Alter Table Media_projects
alter column launched date

--  let;s check the non date format

select * from Media_projects
where isdate(launched)=0

-- clean the non date format into dateformat

-- 1st step- extract the time from the launced column

alter table media_projects
alter column timings varchar(100)

/*update Media_projects set timings= left(launched,len(launched)-charindex(' ',Launched))*/

update Media_projects set launched = case when isdate(launched)=0 
								then convert(varchar(30),getdate(),112)
											Else Launched End


select * from Media_projects
where launched like '%2024%'

--Deadline column

select * from Media_projects
where Deadline not like '%[A-Z!@#$%^&*]%' and isdate(deadline)=0 -- 5153, --216714

Alter table Media_projects
Add New_deadline Date

select * from Media_projects
where isdate(deadline)=0

update media_projects set new_deadline= case when isdate(deadline)=0 then Null else deadline end

select * from Media_projects
where new_deadline is not null-- 152985

update media_projects set deadline= case when isdate(deadline)=0 then Null else deadline end

select count(deadline) from Media_projects
--374852, nondate-216714, date-152985
select 216714+152985+5153

update Media_projects set launched=null


create table launche_d
(launched varchar(500))

bulk insert launche_d
from 'C:\Users\Crossignite.com\Downloads\launched.csv'
with (fieldterminator=',',rowterminator='\n', firstrow=2)

Alter Table Media_projects
drop column launched

select * from Launche_d
select * from Media_projects

alter table media_projects
add  launched varchar(500)

---

update media_projects set new_deadline= case when isdate(deadline)=0 then Convert(date,getdate(),121)
											When Deadline not like '%[A-Z!@#$%^&*]%' Then Null 
											Else Deadline End 



select * from Media_projects
where Deadline  like '%[A-Z!@#$%^&*]%' or isdate(deadline)=0 -- 5153, --216714

update media_projects set deadline=Null
where Deadline like '%[A-Z!@#$%^&*]%'

alter table media_projects 
alter column deadline date

select * from Media_projects
where deadline='31-05-2009'

select * from Media_projects
where isdate(deadline)=1

alter table launche_d
add keys int identity(1001,1)

--- update the launched values in launched columns media_projects table

update Media_projects set media_projects.launched= l.launched
from media_projects m
inner join launche_d l on m.keys=l.keys
where m.launched is null

--- Checking non dates in Launched COlumn

Select * from Media_projects
where launched like '%[!@#$%^&*()A_Z]%'

-- Updating Non date value (the characters values)

Update Media_projects set launched=null
where launched like '%[!@#$%^&*()A_Z]%'

Select * from Media_projects
where isdate(launched) = 0

--- Updating non date into date format of Launched column
update Media_projects set launched= case when isdate(launched)=1 then convert(varchar(30),launched,121)
					end
											
--- Converting varchar (launched) column into Date column
alter table media_projects
alter column launched date 

select * from Media_projects
where launched is not null


--Deadline column
-- Updating the non date values
update Media_projects set Deadline= case when isdate(Deadline)=1 then convert(varchar(30),Deadline,121)
					end

--- Changing the deadline varchar into Date 
alter table media_projects
alter column deadline date


Update Media_projects set Deadline=null
where deadline like '%[!@#$%^&*()A_Z]%'

---
Alter Table Media_projects
drop column new_deadline

-- Dropping Timings column

Alter Table Media_projects
drop column timings


select * from media_projects

-- Checking of Non numeric values in numeric column
--- for the Goal field apply the same steps as we did with pledged field
Alter Table Media_projects
alter column Goal int

Update Media_projects set Goal= 0
where isnumeric(Goal)=0

--- Pledged column

select * from Media_projects
where pledged like '%[__/__/___]%'


Alter Table Media_projects
alter column pledged int

Update Media_projects set Pledged= 0
where isnumeric(Pledged)=0 or pledged like '%[!@#$%^&*()A-Z]%' or pledged like '%[__/__/___]%'

-- Backers field

select * from Media_projects
where Backers like '%[__/__/___]%'


Alter Table Media_projects
alter column backers int

Update Media_projects set backers= 0
where isnumeric(backers)=0 or backers like '%[!@#$%^&*()A-Z]%' or backers like '%[__/__/___]%'

-- State field

Select * from Media_projects
where isnumeric(state)=1 or isdate(state)=1

update Media_projects set state='Unknown'
where isnumeric(state)=1 or isdate(state)=1

select * from Media_projects
where state ='Unknown'

--- Name field

Select * from Media_projects
where isnumeric(Name)=1 or isdate(Name)=1

update Media_projects set Name='Name_not_given'
where isnumeric(Name)=1 or isdate(Name)=1

---Day 2

use media_project
-- Total Projects- 374870

select * from Media_projects
where state = 'Canceled'

--- 36265 projects are canceled

select * from Media_projects
where state = 'Successful'

--- 126158 projects are successful

select * from Media_projects
where state = 'failed'

--- 185093 projects are failed

select * from Media_projects
where state = 'Unknown'


--- 30 projects where the information is unknown

select * from Media_projects
where state = 'lIVE'

--THE LIVE PROJECTS ARE 2617 IN NUMBERS

select distinct state from Media_projects

select 185091+30+124436+36624

select count(State) from Media_projects

update Media_projects set state= 

select state, right (state, charindex(',', state)) from Media_projects

select state,charindex(',',state) from Media_project

update media_projects set state= case when state like 'S%' then 'Successful'
									When State like 'L%' Then 'Live'
									When State Like 'C%' Then 'Canceled'
									When State like 'F%' Then 'Failed'
									When State like '__spended%' Then 'Suspended'
									Else 'Unknown' End

--- Checking for category for failed projects

Select Distinct Category from Media_projects

select * from Media_projects
where state = 'failed' and category='Fashion' /* 13361*/

select distinct category from Media_projects
where category not like '%[!@#";:<>,?/\}{$_%&^&*()0-9]%'
 
/* fashion, Film Video,Art, technology, Journalism
Publishing,Theater, Music,Games,Photography
fashion, Film Video,Art, technology, Journalism*/Select Category from Media_projects Where category like  '%Fashion%'Select Category from Media_projects Where category like  '%film%'Select Distinct Category from Media_projects Where category not in  ('Fashion','Film  Video','Art','Technology','Journalism','Publishing','Theater','Music','Photography','Games','Design','Food','Crafts','Comics','Dance','World Music','Video Games','Painting','Product Design','Shorts','Nonfiction','Fiction','Comic Books','Installations','Fine Art','Public Art','Art Books','Apps','Performances','Apparel','Graphic Design','Software','Sound','Academic','Electronic Music','Drama','Digital Art','Mixed Media','Drinks','Experimental','Nature','Photobooks','Documentary','Restaurants','Periodicals','Places','Documentary Film','Young Adult','Jazz','Narrative Film','Horror','Accessories','Classical Music','Music','Music and Art','Television') or category !='Unknown'


select * from Media_projects
where state = 'failed' and category='Fashion'

Update Media_projects set category='unknown'
where category like '%[!@#";:<>,?/\}{$_%&^&*()0-9]%'


Update Media_projects set category='unknown'
Where category not in  ('Fashion','Film  Video','Art','Technology','Journalism','Publishing','Theater','Music','Photography','Games','Design','Food','Crafts','Comics','Dance','World Music','Video Games','Painting','Product Design','Shorts','Nonfiction','Fiction','Comic Books','Installations','Fine Art','Public Art','Art Books','Apps','Performances','Apparel','Graphic Design','Software','Sound','Academic','Electronic Music','Drama','Digital Art','Mixed Media','Drinks','Experimental','Nature','Photobooks','Documentary','Restaurants','Periodicals','Places','Documentary Film','Young Adult','Jazz','Narrative Film','Horror','Accessories','Classical Music','Music','Music and Art','Television') or category !='Unknown'



Update Media_projects set category='unknown'
Where category ('Art','Comics','Crafts','Dance','Design','Fashion','Film video','food','Games',
'Journalism','Photography','Music','Publishing',
				'technology','Theater')

update Media_projects set Category=

select distinct category from sheet1$


update Media_projects set media_projects.category= l.category
from media_projects m
inner join sheet1$ l on m.keys=l.id
where m.category is null

select * from sheet1$

update Media_projects set category=null

select * from Media_projects

select * into M_project
from media_projects
where category is not null


select * from m_project


--- Our First reccommended Analysis is , checking the Successful rate among the luanched project as per the Year and Month wise

select year(launched) as L_year, month(launched) as L_month, count(*) as 'Total_project'
,Sum(case when State='Successful' Then 1 else 0 end) as Successful_Projects,
(Sum(case when State='Successful' Then 1.0 else 0 end)/count(*) )*100 as 'Successful_rate'
from Media_projects 
where launched is not null
group by Year(launched), month(launched)
order by l_year, l_month


select year(launched) as L_year, month(launched) as L_month, count(*) as 'Total_project'
,Sum(case when State='failed' Then 1 else 0 end) as failed_Projects,
(Sum(case when State='failed' Then 1.0 else 0 end)/count(*) )*100 as 'failed_rate'
from Media_projects 
where launched is not null
group by Year(launched), month(launched)
order by l_year, l_month

select sum(case when state='failed' then 1 else 0 End), 
(Sum(case when State='failed' Then 1.0 else 0 end)/count(*) )*100 as 'failed_rate' from Media_projects

select sum(case when state='Successful' then 1 else 0 End), 
(Sum(case when State='Successful' Then 1.0 else 0 end)/count(*) )*100 as 'failed_rate' from Media_projects

select sum(case when state='canceled' then 1 else 0 End), 
(Sum(case when State='canceled' Then 1.0 else 0 end)/count(*) )*100 as 'canceled_rate' from Media_projects


--- Let's Find out the ROI by the category where we need to identify with the highest return
-- Tip- Whenever you required some calculations and comparison with those calculations, in short when we have more
--- multiple calculated fields gives us the complexity for queries then try to use CTE (With clause)

select * from Media_projects

with Project_ROI as( Select category , cast((pledged-Goal)/goal as float) As ROI
from M_project where Goal>0 and pledged>0)
,Project_rank as (select * , row_number() Over (Partition by category order by ROI Desc) as Row_num
 from Project_ROI)

 select * from Project_rank 
 where row_num=1
 order by ROI desc
 

 select  count(*) as 'Total_project'
,Sum(case when State='Successful' Then 1 else 0 end) as Successful_Projects,
(Sum(case when State='Successful' Then 1.0 else 0 end)/count(*) )*100 as 'Successful_rate'
from M_project
where launched is not null and Category like '%Film%'


--Asssignment for this project- I want you to add some analysis for Launched and Deadline (dates) to add you in  the report


--- 
select * from Media_projects

--- Backers are refers to the investors

--- Here let's try to analyse that what would be the avg bakcers for the successful projects in each category

select  category, Avg(backers) as 'Avg_backers', sum(backers) as 'Total_num_backers', sum(pledged) as 'Inv_amount'
from M_project 
where State='Successful'
group by category
order by inv_amount desc

---Let's find out the analysis where we need to identify the projects that have similar goals and are launched on same year and same month
-- but due to somehow some failed some success.

with Comp_of_projects As (
Select t1.Id as 'T1_id',t1.Name as 'T1_name',
		t1.Launched as 't1.launched'
		,t1.Goal as 't1_goal'
		,t1.State as 't1_state',
		 t2.Id as 't2_id', t2.Name as 't2_name',
		 t2.Launched as 't2_launched', 
		 t2.Goal as 't2_goal',
		 t2.State as 't2_state'
		  from Media_projects T1
join Media_projects T2
on t1.category=t2.category 
	AND t1.Subcategory=t2.Subcategory
	and Year(t1.launched)=year(t2.launched)
	And Month(T1.launched)=Month(t2.launched)
	And t1.id<>t2.id)
Select * from Comp_of_projects
where ( t1_state='successful' And t2_state='failed') or (t1_state='failed' And t2_state='successful')

with Project_ROI as( Select category , cast((pledged-Goal)/goal as float) As ROI
from M_project where Goal>0 and pledged>0)
,Project_rank as (select * , row_number() Over (Partition by category order by ROI Desc) as Row_num
 from Project_ROI)

 select * from Project_rank 
 where row_num=1
 order by ROI desc


