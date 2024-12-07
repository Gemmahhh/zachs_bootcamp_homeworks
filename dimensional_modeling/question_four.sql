-- backfill query for the actors_history_scd table 

insert into actors_history_scd
with with_previous as (
select actorid,
		actor,
	current_year,
	quality_class,
	is_active,
	lag(quality_class, 1) over (partition by actorid order by current_year) as previous_quality_class, 
	lag(is_active, 1) over (partition by actorid order by current_year) as previous_is_active
from actors 
where current_year <= 1973
),
with_indicators as (
select *,
		case 
			when quality_class <> previous_quality_class then 1
			when is_active <> previous_is_active then 1
			else 0
		end as change_indicator
from with_previous
),
with_streaks as (
select *,
	sum(change_indicator) over (partition by actorid order by current_year) as streak_identifier
from with_indicators
)
select actorid,
		actor,
		quality_class,
		is_active,
		min(current_year) as start_year,
		max(current_year) as end_year,
		1973 as current_year,
		streak_identifier
from with_streaks
group by actorid, actor, streak_identifier, is_active, quality_class
order by actorid, streak_identifier
