drop function IF exists latest_terminal_pressure_data();

create or replace function latest_terminal_pressure_data() RETURNS SETOF terminal_pressures LANGUAGE sql as $$
  SELECT DISTINCT ON (collector_id) *
  FROM terminal_pressures
  ORDER BY collector_id, created_at DESC;
$$;

select * from latest_terminal_pressure_data();