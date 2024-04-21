DROP policy if exists update_companies_policy on public.companies;

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
    ) AND check_if_user_is_admin_or_owner (get_user_email (auth.uid ()), id)
    OR check_if_user_is_superuser (get_user_email (auth.uid ()))
  );