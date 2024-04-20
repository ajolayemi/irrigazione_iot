DROP FUNCTION IF EXISTS get_pumps_not_connected_to_sector (bigint, bigint);

DROP FUNCTION IF EXISTS get_pumps_not_connected_to_sector (bigint, bigint, bigint);

CREATE
OR REPLACE FUNCTION get_pumps_not_connected_to_sector (
  company_id_input bigint,
  pump_id_already_connected bigint default null
) returns setof pumps language sql as $$
SELECT
  *
FROM
  pumps AS p
WHERE
  p.id = pump_id_already_connected
  OR (
    p.company_id = company_id
    AND NOT EXISTS (
      SELECT
        1
      FROM
        sector_pumps AS sp
      WHERE
        sp.pump_id = p.id
    )
  );
$$;