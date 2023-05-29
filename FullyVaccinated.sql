-- finding the percent of each country's population that are vaccinated

with cte as (select cd.continent,
	   cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   sum(cv.new_vaccinations) over(partition by cd.location
	   order by cd.location, cd.date) as total_vaccinations
from coviddeaths cd
join covidvaccinations cv
on cd.date = cv.date and cd.location = cv.location
where cd.continent is not null
order by 2,3)

select *,
round(total_vaccinations/population::numeric*100,4)||'%' as percent_vaccinated
from cte
