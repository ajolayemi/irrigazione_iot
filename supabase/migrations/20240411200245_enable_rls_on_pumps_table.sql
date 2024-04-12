-- enable rls policy on pumps table
alter table public.pumps enable row level security;

-- drop SELECT policy if it already exists
drop policy if exists "Company members and generic superusers can read pumps" on public.pumps;

-- create / recreate SELECT policy
-- the rules is basically that user is either a member of the current company or that they're a generic superuser
create policy "Company members and generic superusers can read pumps" on public.pumps for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = pumps.company_id
    )
  );

-- drop UPDATE policy if it already exists
drop policy if exists "Superusers can update pumps" on public.pumps;

-- create policy with the following rules
-- User is authenticated
-- Is a general superuser
create policy "Superusers can update pumps" on public.pumps
for update
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = pumps.company_id
    )
    and check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- drop DELETE policy if it already exists
drop policy if exists "Superusers can delete pumps" on public.pumps;

-- create policy with the following rules
-- User is authenticated
-- Is a general superuser
create policy "Superusers can delete pumps" on public.pumps for delete to authenticated using (
  exists (
    select
      1
    from
      companies
    where
      companies.id = pumps.company_id
  )
  and check_if_user_is_superuser (get_user_email (auth.uid ()))
);

-- drop INSERT policy if it already exists
drop policy if exists "Superusers can create pumps" on public.pumps;

create policy "Superusers can create pumps" on public.pumps for insert to authenticated
with
  check (
    exists (
      select
        1
      from
        companies
      where
        companies.id = pumps.company_id
    )
    and check_if_user_is_superuser (get_user_email (auth.uid ()))
  );
