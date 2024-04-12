-- Drop existing policy
DROP policy if exists select_companies_policy on public.companies;

-- Create policy, the rules are:
-- 1. User must be authenticated
-- 2. If the user is a superuser, they can see all companies
-- 3. If the user is not a superuser, they can only see companies that they are associated with
CREATE POLICY select_companies_policy ON public.companies FOR
SELECT
    to authenticated,
    service_role USING (
        id in (
            select
                *
            from
                get_companies_ids_for_user (get_user_email (auth.uid ()))
        )
        OR check_if_user_is_superuser (get_user_email (auth.uid ()))
    );