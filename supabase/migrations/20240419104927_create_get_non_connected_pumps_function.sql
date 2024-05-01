DROP FUNCTION IF EXISTS get_pumps_not_connected_to_sector (bigint, bigint);

DROP FUNCTION IF EXISTS get_pumps_not_connected_to_sector (bigint, bigint, bigint);

CREATE
OR REPLACE FUNCTION get_pumps_not_connected_to_sector (
  company_id_input bigint,
  sector_id_input bigint,
  pump_id_already_connected bigint default null
) returns setof pumps language sql as $$
SELECT * from pumps as ps 
where ps.id = pump_id_already_connected union
    SELECT
    p.*
  from
    sector_pumps as sc
    join pumps as p on not sc.pump_id = p.id
    and p.company_id = company_id_input
  where
    sc.sector_id = sector_id_input;
  $$;