-- World Data as of 2023-05-11

select cd.location,
	   max(cd.total_deaths) as total_deaths,
	   round(max(cv.people_fully_vaccinated)/max(cd.population::numeric),2) as fully_vaccinated,
	   round(max(cv.people_vaccinated)/max(cd.population::numeric),2) as vaccinated
from coviddeaths cd join covidvaccinations cv
on cd.iso_code = cv.iso_code and cd.date = cv.date
where cd.location = 'World'
group by 1;
