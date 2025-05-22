drop function IF exists latest_pump_pressure_data();

create or replace function latest_pump_pressure_data() RETURNS SETOF pump_pressures LANGUAGE sql as $$
  SELECT DISTINCT ON (pump_id) *
  FROM pump_pressures
  ORDER BY pump_id, created_at DESC;
$$;

select * from latest_pump_pressure_data();