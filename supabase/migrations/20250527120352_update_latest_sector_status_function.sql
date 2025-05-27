drop function IF exists latest_sector_status_data (company_id_input bigint);

drop function IF exists latest_sector_status_data ();

create or replace function latest_sector_status_data () RETURNS SETOF sector_statuses LANGUAGE sql as $$
  SELECT DISTINCT ON (sector_id) *
  FROM sector_statuses
  ORDER BY sector_id, created_at DESC;
$$;