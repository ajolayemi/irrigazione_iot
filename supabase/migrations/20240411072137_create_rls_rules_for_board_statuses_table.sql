-- Function to get the id of the company that a board belongs to
CREATE
OR REPLACE FUNCTION get_board_company_id (board_id_input bigint) RETURNS bigint AS $$
declare
  result bigint;
begin
  SELECT company_id INTO result FROM boards WHERE id = board_id_input;
  return result;
  END;
  $$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- All other operations aside from SELECT are allowed just for service_roles (which is the default)
-- drop policy if it already exists
DROP POLICY IF EXISTS "Authenticated user who are member of a company and superusers can read board status data" ON public.board_statuses;

-- create policy
CREATE POLICY "Authenticated user who are member of a company and superusers can read board status data" ON public.board_statuses FOR
SELECT
  TO authenticated USING (
    EXISTS (
      SELECT
        1
      FROM
        companies
      where
        companies.id = get_board_company_id (board_statuses.board_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );