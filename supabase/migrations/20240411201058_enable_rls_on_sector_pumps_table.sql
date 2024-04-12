-- enable rls policy on sector_pumps table
alter table public.sector_pumps enable row level security;

-- drop SELECT policy if it already exists before recreating it
drop policy if exists "User can access sector pumps of sector they can read" on public.sector_pumps;

create policy "User can access sector pumps of sector they can read" on public.sector_pumps for
select
  to authenticated using (
    exists (
      select
        1
      from
        sectors
      where
        id = sector_pumps.sector_id
    )
  );

-- drop INSERT policy if it already exists before recreating it
drop policy if exists "Superusers can insert new sector pumps" on public.sector_pumps;

create policy "Superusers can insert new sector pumps" on public.sector_pumps for insert to authenticated
with
  check (
    (
      check_if_user_is_superuser (get_user_email (auth.uid ()))
    )
  );

-- drop UPDATE policy if it already exists before recreating it
drop policy if exists "Superusers can update existing sector pumps" on public.sector_pumps;

create policy "Superusers can update existing sector pumps" on public.sector_pumps
for update
  to authenticated using (
    (
      check_if_user_is_superuser (get_user_email (auth.uid ()))
    )
  );

-- drop UPDATE policy if it already exists before recreating it
drop policy if exists "Superusers can delete existing sector pumps" on public.sector_pumps;

create policy "Superusers can delete existing sector pumps" on public.sector_pumps for delete to authenticated using (
  (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  )
);
