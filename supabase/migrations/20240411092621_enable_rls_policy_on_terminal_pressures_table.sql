-- enable rls policy on terminal_pressures table
alter table public.terminal_pressures enable row level security;

-- drop existing (if exists) policy before creating it
drop policy if exists "Authenticated users who are member of a company and superusers can access terminal pressures data" on public.terminal_pressures;

-- create / recreate policy
create policy "Authenticated users who are member of a company and superusers can access terminal pressures data" on public.terminal_pressures for
select
    to authenticated using (
        exists (
            select
                1
            from
                companies
            where
                companies.id = get_collector_company_id (terminal_pressures.collector_id)
        )
        or check_if_user_is_superuser (get_user_email (auth.uid ()))
    );