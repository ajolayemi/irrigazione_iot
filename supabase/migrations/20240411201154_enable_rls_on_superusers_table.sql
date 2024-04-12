-- enable rls on superusers table
alter table public.superusers enable row level security;

-- drop INSERT policy if it already exists
drop policy if exists "Superusers can insert in superusers table" on public.superusers;

create policy "Superusers can insert in superusers table" on public.superusers for insert to authenticated
with
  check (
    (
      check_if_user_is_superuser (get_user_email (auth.uid()))
    )
  );

-- drop UPDATE policy if it already exists
drop policy if exists "Superusers can update in superusers table" on public.superusers;

create policy "Superusers can update in superusers table" on public.superusers
for update
  to authenticated using (
    (
      check_if_user_is_superuser (get_user_email (auth.uid()))
    )
  );

-- drop DELETE policy if it already exists
drop policy if exists "Superusers can delete in superusers table" on public.superusers;

create policy "Superusers can delete in superusers table" on public.superusers for delete to authenticated using (
  (
    check_if_user_is_superuser (get_user_email (auth.uid()))
  )
);

-- drop SELECT policy if it already exists
drop policy if exists "Superusers can read from superusers table" on public.superusers;

create policy "Superusers can read from superusers table" on public.superusers for
select
  to authenticated using (
    (
      check_if_user_is_superuser (get_user_email (auth.uid()))
    )
  );
