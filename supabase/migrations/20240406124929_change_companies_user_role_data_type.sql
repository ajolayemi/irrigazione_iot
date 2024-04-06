ALTER TABLE public.companies_user
ALTER COLUMN ROLE TYPE role USING ROLE::role;