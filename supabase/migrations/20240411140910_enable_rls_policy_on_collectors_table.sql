-- the company_id column in collectors table should not be null
-- it was before this statement was executed
alter table public.collectors
alter column company_id set not null;

-- enable rls policy on collectors table
alter table public.collectors enable row level security;

-- drop SELECT policy if it already exists
drop policy if exists "Company members and generic superusers can read collectors" on public.collectors;

-- create / recreate SELECT policy
-- the rules is basically that user is either a member of the current company or that they're a generic superuser
create policy "Company members and generic superusers can read collectors" on public.collectors for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = collectors.company_id
    )
  );

-- drop UPDATE policy if it already exists
drop policy if exists "Superusers can update collectors" on public.collectors;

-- create policy with the following rules
-- User is authenticated
-- Is a general superuser
create policy "Superusers can update collectors" on public.collectors
for update
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = collectors.company_id
    )
    and check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- drop DELETE policy if it already exists
drop policy if exists "Superusers can delete collectors" on public.collectors;

-- create policy with the following rules
-- User is authenticated
-- Is a general superuser
create policy "Superusers can delete collectors" on public.collectors for delete to authenticated using (
  exists (
    select
      1
    from
      companies
    where
      companies.id = collectors.company_id
  )
  and check_if_user_is_superuser (get_user_email (auth.uid ()))
);

-- drop INSERT policy if it already exists
drop policy if exists "Superusers can create collectors" on public.collectors;

create policy "Superusers can create collectors" on public.collectors for insert to authenticated
with
  check (
    exists (
      select
        1
      from
        companies
      where
        companies.id = collectors.company_id
    )
    and check_if_user_is_superuser (get_user_email (auth.uid ()))
  );
