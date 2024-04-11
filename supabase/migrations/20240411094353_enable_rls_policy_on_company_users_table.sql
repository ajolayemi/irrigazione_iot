-- Since this script is runned after some functions in this were already created and some policies already depend
-- on them, drop them
-- drop update_companies_policy which was referencing the function that will be dropped
DROP policy if exists update_companies_policy on public.companies;

-- the same here
drop policy if exists "Authenticated users who are members of a company and are either an admin or owner of the company and generic superusers can create new users for a company" on public.company_users;

-- drop old check_if_user_is_admin_or_owner function, it will be renamed
DROP FUNCTION IF EXISTS check_if_user_is_admin_or_owner (TEXT, BIGINT);

-- recreate the function with a new name
-- Check to see if user is privileged (admin, owner or superuser)
CREATE
OR REPLACE FUNCTION check_if_user_is_privileged (user_email TEXT, current_company_id bigint) RETURNS BOOLEAN AS $$
DECLARE
  user_role_from_db TEXT;
BEGIN
  SELECT role INTO user_role_from_db FROM company_users WHERE email = user_email and company_id = current_company_id;
  RETURN (user_role_from_db is not null and user_role_from_db != 'user');
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;

-- recreate update_companies_policy
-- Create policy, the rules are:
-- 1. User must be authenticated
-- 2. If the user is a superuser, they can update all companies
-- 3. If the user is not a superuser, they can only update companies that they are associated with
-- 4. If the user is an admin or owner of the company, they can update the company
CREATE POLICY update_companies_policy ON public.companies
FOR UPDATE
  to authenticated,
  service_role USING (
    id in (
      select
        *
      from
        get_companies_ids_for_user (get_user_email (auth.uid ()))
    )
    AND check_if_user_is_privileged (get_user_email (auth.uid ()), id)
    OR check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- enable rls policy on company_users table
alter table public.company_users enable row level security;

-- drop SELECT rls policy if it already exists
drop policy if exists "Authenticated users who are members of a company and superusers can read company users data" on public.company_users;

drop policy if exists "Company members and generic superusers can read company users" on public.company_users;

-- create policy
-- the rules are:
-- 1. User is authenticated
-- 2. User is a member of the current company
-- 3. Or user is a superuser (even though he/she isn't a member of the current company)
create policy "Company members and generic superusers can read company users" on public.company_users for
select
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = company_users.company_id
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- drop INSERT policy if it already exists
drop policy if exists "Authenticated users who are members of a company and are either an admin or owner of the company and generic superusers can create new users for a company" on public.company_users;

drop policy if exists "Privileged company members and generic superusers can create new company user" on public.company_users;

-- create policy. the rules are:
-- 1. User is authenticated
-- 2. And the authenticated user is either an admin or owner of the current company
-- 3. OR User is a superuser (even when they aren't member of the current company)
create policy "Privileged company members and generic superusers can create new company user" on public.company_users for insert to authenticated
with
  check (
    exists (
      select
        1
      from
        companies
      where
        companies.id = company_users.company_id
    )
    AND check_if_user_is_privileged (
      get_user_email (auth.uid ()),
      company_users.company_id
    )
    OR check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- drop UPDATE policy if it already exists
drop policy if exists "Privileged company members and generic superusers can update" on public.company_users;

create policy "Privileged company members and generic superusers can update" on public.company_users
for update
  to authenticated using (
    exists (
      select
        1
      from
        companies
      where
        companies.id = company_users.company_id
    )
    and check_if_user_is_privileged (
      get_user_email (auth.uid ()),
      company_users.company_id
    )
    or check_if_user_is_superuser (get_user_email (auth.uid ()))
  );

-- drop DELETE policy if it already exists
drop policy if exists "Privileged company members and generic superusers can delete" on public.company_users;

create policy "Privileged company members and generic superusers can delete" on public.company_users for delete to authenticated using (
  exists (
    select
      1
    from
      companies
    where
      companies.id = company_users.company_id
  )
  and check_if_user_is_privileged (
    get_user_email (auth.uid ()),
    company_users.company_id
  )
  or check_if_user_is_superuser (get_user_email (auth.uid ()))
);
