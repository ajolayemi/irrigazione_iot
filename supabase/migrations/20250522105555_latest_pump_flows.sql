drop function IF exists latest_pump_flow_data();

create or replace function latest_pump_flow_data() RETURNS SETOF pump_flows LANGUAGE sql as $$
  SELECT DISTINCT ON (pump_id) *
  FROM pump_flows
  ORDER BY pump_id, created_at DESC;
$$;