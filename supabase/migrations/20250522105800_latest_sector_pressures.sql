drop function IF exists latest_sector_pressure_data();

create or replace function latest_sector_pressure_data() RETURNS SETOF sector_pressures LANGUAGE sql as $$
  SELECT DISTINCT ON (sector_id) *
  FROM sector_pressures
  ORDER BY sector_id, created_at DESC;
$$;

select * from latest_sector_pressure_data();