-- enable rls policy on sectors table
alter table public.sectors enable row level security;

-- drop SELECT policy if it already exists
drop policy if exists "Company members and generic superusers can read sectors" on public.sectors;

-- create / recreate SELECT policy
-- the rules is basically that user is either a member of the current company or that they're a generic superuser
create policy "Company members and generic superusers can read sectors" on public.sectors for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = sectors.company_id
    )
  );

-- drop UPDATE policy if it already exists
drop policy if exists "Superusers can update sectors" on public.sectors;

-- create policy with the following rules
-- User is authenticated
-- Is a general superuser
create policy "Superusers can update sectors" on public.sectors
for update
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = sectors.company_id
    )
    and check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- drop DELETE policy if it already exists
drop policy if exists "Superusers can delete sectors" on public.sectors;

-- create policy with the following rules
-- User is authenticated
-- Is a general superuser
create policy "Superusers can delete sectors" on public.sectors for delete to authenticated using (
  exists (
    select
      1
    from
      companies
    where
      companies.id = sectors.company_id
  )
  and check_if_user_is_superuser (get_user_email (auth.uid ()))
);

-- drop INSERT policy if it already exists
drop policy if exists "Superusers can create sectors" on public.sectors;

create policy "Superusers can create sectors" on public.sectors for insert to authenticated
with
  check (
    exists (
      select
        1
      from
        companies
      where
        companies.id = sectors.company_id
    )
    and check_if_user_is_superuser (get_user_email (auth.uid ()))
  );
