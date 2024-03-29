-- Sorting data by percent of population vaccinated. Removed African, Asian, and small countries (by population)
-- to elemenate some of the inconsistent reporting issues. The countries with the highest and lowest percent
-- vaccinated were removed as outliers.

with cte as (select cv.location,
	   		round(max(cv.people_fully_vaccinated)/max(cd.population::numeric)*100,2) 
				as pct_people_fully_vaccinated,
	   		round(max(cd.total_deaths)/max(cd.total_cases::numeric),4) as death_rate
			from covidvaccinations cv join coviddeaths cd
	 			on cv.iso_code = cd.iso_code and cv.date = cd.date
			where (cv.continent, cv.people_fully_vaccinated) is not null
	  			and cv.continent in ('North America', 'South America', 'Europe', 'Oceania')
			 	and cd.population > 10000000
			group by 1),

cte2 as (select *,
		row_number() over(order by pct_people_fully_vaccinated desc) as rn
		from cte),
		
cte3 as (select *,
		row_number() over(order by pct_people_fully_vaccinated asc) as rn
		from cte)

(select location,
	   pct_people_fully_vaccinated,
	   death_rate
from cte2
where rn > 1
order by 2 desc
limit 6)

union

(select location,
	   pct_people_fully_vaccinated,
	   death_rate
from cte3
where rn > 1
order by 2 
limit 6)

order by pct_people_fully_vaccinated desc;
