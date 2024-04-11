-- enable rls on pump_pressures table
ALTER TABLE public.pump_pressures enable row level security;

-- All other operations aside from SELECT are allowed just for service_roles (which is the default)
-- drop policy if it already exists
DROP POLICY IF EXISTS "Authenticated user who are member of a company and superusers can read pump pressures data" on public.pump_pressures;


-- create policy
create policy "Authenticated user who are member of a company and superusers can read pump pressures data" on public.pump_pressures for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = get_pump_company_id (pump_pressures.pump_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );