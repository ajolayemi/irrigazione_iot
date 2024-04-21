-- Function to get the id of the company that a pump belongs to
CREATE
OR REPLACE FUNCTION get_pump_company_id (pump_id_input bigint) RETURNS bigint AS $$
DECLARE
  result bigint;
begin
  SELECT company_id into result from pumps where id = pump_id_input;
  return result;
end;
$$ language plpgsql stable security definer;

-- enable rls on pump_flows table
ALTER TABLE public.pump_flows enable row level security;

-- All other operations aside from SELECT are allowed just for service_roles (which is the default)
-- drop policy if it already exists
DROP POLICY IF EXISTS "Authenticated user who are member of a company and superusers can read pump flow data" on public.pump_flows;

-- create policy
create policy "Authenticated user who are member of a company and superusers can read pump flow data" on public.pump_flows for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = get_pump_company_id (pump_flows.pump_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );
