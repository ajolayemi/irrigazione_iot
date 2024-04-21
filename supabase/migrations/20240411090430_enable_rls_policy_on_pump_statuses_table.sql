-- enable rls on pump_statuses table
ALTER TABLE public.pump_statuses enable row level security;

-- All other operations aside from SELECT are allowed just for service_roles (which is the default)
-- drop policy if it already exists
DROP POLICY IF EXISTS "Authenticated users who are member of a company and superusers can read pump statuses data" on public.pump_statuses;

-- create policy
create policy "Authenticated users who are member of a company and superusers can read pump statuses data" on public.pump_statuses for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = get_pump_company_id (pump_statuses.pump_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );