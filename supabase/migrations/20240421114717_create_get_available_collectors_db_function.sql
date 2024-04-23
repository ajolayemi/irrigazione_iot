DROP FUNCTION IF EXISTS get_collectors_not_connected_to_a_board (bigint, bigint);

CREATE
OR REPLACE FUNCTION get_collectors_not_connected_to_a_board (
  company_id_input bigint,
  id_already_connected bigint default null
) returns setof collectors language sql as $$
SELECT
  *
FROM
  collectors as c
where
  (c.id = id_already_connected and c.company_id = company_id_input)
  or (c.company_id = company_id_input)
  and not exists (
    select
      1
    from
      boards as b
    where
      b.collector_id = c.id
  );
$$;