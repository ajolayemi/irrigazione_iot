drop function IF exists latest_collector_pressure_data();

create or replace function latest_collector_pressure_data() RETURNS SETOF collector_pressures LANGUAGE sql as $$
  SELECT DISTINCT ON (collector_id) *
  FROM collector_pressures
  ORDER BY collector_id, created_at DESC;
$$;

select * from latest_collector_pressure_data();