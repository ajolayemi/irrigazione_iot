-- enable rls policy on sector_statuses table
alter table public.sector_statuses enable row level security;

-- drop existing policy before recreating it
drop policy if exists "Authenticated users who are members of a company and superusers can read sector statuses data" on public.sector_statuses;

-- create policy
create policy "Authenticated users who are members of a company and superusers can read sector statuses data" on public.sector_statuses for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = get_sector_company_id (sector_statuses.sector_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );