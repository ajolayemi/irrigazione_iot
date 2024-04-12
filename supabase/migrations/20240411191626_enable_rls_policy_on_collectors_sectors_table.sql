-- enable rls policy on collector_sectors table
alter table public.collector_sectors enable row level security;

-- drop SELECT policy if it already exists before recreating it
drop policy if exists "User can access collector sectors of collector they can read" on public.collector_sectors;

create policy "User can access collector sectors of collector they can read" on public.collector_sectors for
select
  to authenticated using (
    exists (
      select
        1
      from
        collectors
      where
        id = collector_sectors.collector_id
    )
  );

-- drop INSERT policy if it already exists before recreating it
drop policy if exists "Superusers can insert new collector sectors" on public.collector_sectors;

create policy "Superusers can insert new collector sectors" on public.collector_sectors for insert to authenticated
with
  check (
    (
      check_if_user_is_superuser (get_user_email (auth.uid ()))
    )
  );

-- drop UPDATE policy if it already exists before recreating it
drop policy if exists "Superusers can update existing collector sectors" on public.collector_sectors;

create policy "Superusers can update existing collector sectors" on public.collector_sectors
for update
  to authenticated using (
    (
      check_if_user_is_superuser (get_user_email (auth.uid ()))
    )
  );

-- drop UPDATE policy if it already exists before recreating it
drop policy if exists "Superusers can delete existing collector sectors" on public.collector_sectors;

create policy "Superusers can delete existing collector sectors" on public.collector_sectors for delete to authenticated using (
  (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  )
);
