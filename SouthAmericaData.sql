-- gathering information on South America to try and better understand why
-- the continent has the highest vaccination rate and highest death rate.

select cv.location,
	   max(cd.population) population,
	   max(cv.gdp_per_capita) gdp,
	   max(cv.extreme_poverty) pct_extreme_poverty,
	   max(cv.hospital_beds_per_thousand) beds_per_k,
	   max(cv.population_density_people_per_km2) people_per_km2,
	   max(cv.handwashing_facilities) handwashing_facilities,
	   max(cv.aged_65_older) sixty_five_plus,
	   max(cv.aged_70_older) seventy_plus,
	   round(max(cd.total_deaths)/max(cd.total_cases),3) death_rate
from covidvaccinations cv join coviddeaths cd
on cv.iso_code = cd.iso_code and cv.date = cd.date
where cv.continent = 'South America'
group by 1;

