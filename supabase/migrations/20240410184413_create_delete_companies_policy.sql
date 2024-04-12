DROP POLICY IF EXISTS "Superusers can delete companies" on public.companies;

-- Create policy, the rules are:
-- 1. User must be a superuser
CREATE POLICY "Superusers can delete companies" ON public.companies FOR DELETE to service_role USING (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
);