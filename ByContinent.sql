-- Comparing death rate to percent of population vaccinated by continent.

with cte as (select cd.location,
		    cd.continent,
		    max(cv.people_vaccinated) as total_vax,
		    max(cv.people_fully_vaccinated) as full_vax,
		    max(cd.population) as pop,
		    max(total_deaths) as deaths,
		    max(total_cases) as tc
             from covidvaccinations cv join coviddeaths cd
             on cv.iso_code = cd.iso_code and cv.date = cd.date 
             and cd.continent is not null
             group by 1,2)

select continent,
       round(sum(full_vax)/sum(pop)*100,4)||'%' as pct_full_vax,
       round(sum(total_vax)/sum(pop)*100,4)||'%' as pct_part_vax,
       round(sum(deaths)/sum(tc)*100,4)||'%' as death_rate
from cte
