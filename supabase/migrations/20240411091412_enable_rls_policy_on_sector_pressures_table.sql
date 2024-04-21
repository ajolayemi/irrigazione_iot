-- Function to get the id of the company that a sector belongs to
create
or replace function get_sector_company_id (sector_id_input bigint) returns bigint as $$
declare
 result bigint;
begin
  select company_id into result from sectors where id = sector_id_input;
  return result;
end;
$$ language plpgsql stable security definer;

-- enable rls policy on sector_pressures table
alter table public.sector_pressures enable row level security;

-- drop policy if it already exists before recreating it
drop policy if exists "Authenticated users who are member of a company and superusers can read sector pressures data" on public.sector_pressures;

-- create / recreate policy
create policy "Authenticated users who are member of a company and superusers can read sector pressures data" on public.sector_pressures for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = get_sector_company_id (sector_pressures.sector_id)
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );
