-- Finding how quickly vaccinations were given by country. This is an attempt to help
-- explain why Peru had both a high percentage of their population fully vaccinated
-- AND a very high death rate.

select cv.location,
	   to_timestamp(avg(extract(epoch from cv.date))
					filter(where cv.people_fully_vaccinated_per_hundred between 24.5 and 25.5))
					::date as approx_25_pct_vaccinated,
	   to_timestamp(avg(extract(epoch from cv.date))
					filter(where cv.people_fully_vaccinated_per_hundred between 49 and 51))
					::date as approx_50_pct_vaccinated,
	   to_timestamp(avg(extract(epoch from cv.date))
					filter(where cv.people_fully_vaccinated_per_hundred between 74 and 76))
					::date as approx_75_pct_vaccinated,
	   to_timestamp(avg(extract(epoch from cv.date))
					filter(where cv.people_fully_vaccinated_per_hundred between 79.5 and 80.5))
					::date as approx_80_pct_vaccinated
from covidvaccinations cv join coviddeaths cd
	 on cv.iso_code = cd.iso_code and cv.date = cd.date
where cv.location in ('Peru', 'Australia', 'Cuba', 'Spain')
group by 1
order by 2;
