DROP POLICY IF EXISTS "Everyone can insert a new company" on public.companies;

-- The rules are:
-- 1. All user can create a company
CREATE POLICY "Everyone can insert a new company" on public.companies FOR INSERT to anon,
authenticated WITH CHECK (TRUE);
