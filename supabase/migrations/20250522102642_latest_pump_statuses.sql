drop function IF exists latest_pump_status_data (company_id_input bigint);

create or replace function latest_pump_status_data (company_id_input bigint) RETURNS SETOF pump_statuses LANGUAGE sql as $$
  SELECT DISTINCT ON (pump_id) *
  FROM pump_statuses
  WHERE company_id = latest_pump_status_data.company_id_input
  ORDER BY pump_id, created_at DESC;
$$;
