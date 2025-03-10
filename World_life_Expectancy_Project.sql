# World life expectancy ( Data Cleaning)

# Remove Duplicates

Select country, year, concat( country,year), count(concat( country,year))
from world_life_expectancy_backup
group by country, year, concat( country,year)
having count(concat( country,year)) > 1;

SELECT*
	FROM (
	select Row_ID, 
	concat( country,year),
	ROW_NUMBER() OVER (PARTITION BY concat( country,year) ORDER BY concat( country,year)) AS ROW_NUM
	from world_life_expectancy_backup) AS ROW_TABLE
    WHERE ROW_NUM > 1;
    
    DELETE FROM world_life_expectancy_backup
WHERE ROW_ID IN ( 
				SELECT
                ROW_ID
				FROM (
				select Row_ID, 
				concat( country,year),
				ROW_NUMBER() OVER (PARTITION BY concat( country,year) ORDER BY concat( country,year)) AS ROW_NUM
				from world_life_expectancy_backup) AS ROW_TABLE 
				WHERE ROW_NUM > 1);
                
		UPDATE world_life_expectancy_backup t1
		JOIN world_life_expectancy_backup t2
			on t1.Country = t2.Country
		set t1.Status = 'Developing'
		where t1.Status = ''
		and t2.Status <> ''
		and t2.Status = 'Developing'
        ;
    
    select*
    from world_life_expectancy_backup;
    
    select*
    from world_life_expectancy_backup
    where Status = '';
    
    	UPDATE world_life_expectancy_backup t1
		JOIN world_life_expectancy_backup t2
			on t1.Country = t2.Country
		set t1.Status = 'Developed'
		where t1.Status = ''
		and t2.Status <> ''
		and t2.Status = 'Developed'
        ;
        
	select country, year, Life expectancy
    from world_life_expectancy_backup;
    
    select*
    from world_life_expectancy_backup
    where `Life expectancy` = '';
    
     select t1.country, t1.Year, t1.`Life expectancy`,
			t2.country, t2.Year, t2.`Life expectancy`,
            t3.country, t3.Year, t3.`Life expectancy`,
		round((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
    from world_life_expectancy_backup t1
	join world_life_expectancy_backup t2
		on t1.country = t2.country
        and t1.Year = t2.Year - 1
	join world_life_expectancy_backup t3
		on t1.country = t3.country
        and t1.Year = t3.Year + 1
	where t1.`Life expectancy` = '';
    
    update world_life_expectancy_backup t1
	join world_life_expectancy_backup t2
		on t1.country = t2.country
        and t1.Year = t2.Year - 1
	join world_life_expectancy_backup t3
		on t1.country = t3.country
        and t1.Year = t3.Year + 1
	set t1.`Life expectancy` = round((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
	where t1.`Life expectancy` = '' ;
    
    select*
    from world_life_expectancy_backup;
    
    
    #World Life expectancy Exploratory Data Analysis
    
        select country, 
        Min(`Life expectancy`),
        max(`Life expectancy`),
        round((`Life expectancy`) - Min(`Life expectancy`),2) as Life_Increase_15_Years
        from world_life_expectancy_backup
        group by country
        having min(`Life expectancy`) <> 0
        AND max(`Life expectancy`) <> 0
        order by Life_Increase_15_Years DESC;
        
        select year, round(avg(`Life Expectancy`),2)
        from world_life_expectancy_backup
        where `Life Expectancy` <> 0
        group by year
        order by year ;
        
        select country, ROUND(AVG(`Life Expectancy`),2) AS Life_Expectancy ,ROUND(AVG(GDP),2) AS GDP
        from world_life_expectancy_backup
        GROUP BY COUNTRY
        having Life_Expectancy <>0
        and GDP <>0
        order by GDP DESC;
        
		SELECT
        SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) HIGH_GDP_COUNT,
        AVG(CASE WHEN GDP >= 1500 THEN `Life Expectancy` ELSE NULL END) HIGH_GDP_LIFE_EXPECTANCY,
		SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) LOW_GDP_COUNT,
        AVG(CASE WHEN GDP <= 1500 THEN `Life Expectancy` ELSE NULL END) LOW_GDP_LIFE_EXPECTANCY
	    from world_life_expectancy_backup;
        
        SELECT status,count(distinct country), round(avg(`Life Expectancy`),1)
        FROM world_life_expectancy_backup
        group by status ;
        
        select country, ROUND(AVG(`Life Expectancy`),2) AS Life_Expectancy ,ROUND(AVG(BMI),2) AS BMI
        from world_life_expectancy_backup
        GROUP BY COUNTRY
        having Life_Expectancy <>0
        and BMI <>0
        order by BMI DESC;
        
		SELECT COUNTRY,
        YEAR,
        `Life Expectancy`, 
        `Adult Mortality`,
        SUM(`Adult Mortality`) OVER(PARTITION BY COUNTRY ORDER BY YEAR) AS ROLLING_TOTAL
        FROM world_life_expectancy_backup;
        
        
        
    
    
    