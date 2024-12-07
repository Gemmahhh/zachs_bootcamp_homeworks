-- creating the type for the quality_class column
CREATE TYPE quality_class AS ENUM ('star', 'good', 'average', 'bad')

-- creating the films array 
create type films as (
			film text,
			votes INTEGER,
			rating real, 
			filmid text
)

-- the DDL for the actors table
create table actors (
		actor text,
		actorid text,
		films films[],
		quality_class quality_class,
		is_active boolean,
		current_year integer,
		primary key (actorid, current_year)
)

