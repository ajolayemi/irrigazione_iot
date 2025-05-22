drop function IF exists latest_sector_status_data (company_id_input bigint);

create or replace function latest_sector_status_data (company_id_input bigint) RETURNS SETOF sector_statuses LANGUAGE sql as $$
  SELECT DISTINCT ON (sector_id) *
  FROM sector_statuses
  WHERE company_id = latest_sector_status_data.company_id_input
  ORDER BY sector_id, created_at DESC;
$$;