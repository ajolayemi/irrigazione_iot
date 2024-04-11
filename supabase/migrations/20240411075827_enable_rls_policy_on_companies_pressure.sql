-- Function to get the id of the company that a collector belongs to
CREATE
OR REPLACE FUNCTION get_collector_company_id (collector_id_input bigint) RETURNS bigint AS $$
DECLARE
  result bigint;
begin
  SELECT company_id INTO result FROM collectors WHERE id = collector_id_input;
  return result;
END;
$$ language plpgsql stable security definer;

-- enable rls on collector_pressures table
ALTER TABLE public.collector_pressures enable row level security;

-- All other operations aside from SELECT are allowed just for service_roles (which is the default)
-- drop policy if it already exists
DROP POLICY IF EXISTS "Authenticated user who are member of a company and superusers can read collector pressure data" on public.collector_pressures;

-- create policy
CREATE POLICY "Authenticated user who are member of a company and superusers can read collector pressure data" ON public.collector_pressures for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = get_collector_company_id (collector_pressures.collector_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );