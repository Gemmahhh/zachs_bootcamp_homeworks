-- DDL for an actors_history_scd table 

CREATE TYPE quality_class AS ENUM ('star', 'good', 'average', 'bad')

create table actors_history_scd (
		actorid text,
		actor text,
		quality_class quality_class, 
		is_active boolean,
		start_year integer,
		end_year integer,
		current_year integer,
		streak_identifier integer,
		primary key (actorid, start_year)
)