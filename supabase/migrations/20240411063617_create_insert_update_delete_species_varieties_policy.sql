--- Drop the INSERT rls on varieties if it already exists
DROP POLICY IF EXISTS "Superusers can insert a new variety" on public.varieties;

--- Create policy for INSERT requests on varieties table
CREATE POLICY "Superusers can insert a new variety" ON public.varieties FOR INSERT TO authenticated
WITH
  CHECK (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  );


-- DROP the INSERT rls on species table if it already exists
DROP POLICY IF EXISTS "Superusers can insert a new specie" on public.species;

--- Create policy for INSERT requests on species table
CREATE POLICY "Superusers can insert a new specie" ON public.species FOR INSERT TO authenticated
WITH
  CHECK (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  );



-- DROP the SELECT rlS on varieties table if it already exists
DROP POLICY IF EXISTS "Authenticated users can read all varieties" ON public.varieties;

-- Create policy for SELECT requests on varieties table
CREATE POLICY "Authenticated users can read all varieties" ON public.varieties FOR
SELECT
  TO authenticated USING (TRUE);



-- DROP the SELECT rlS on species table if it already exists
DROP POLICY IF EXISTS "Authenticated users can read all species" ON public.species;

-- Create policy for SELECT requests on varieties table
CREATE POLICY "Authenticated users can read all species" ON public.species FOR
SELECT
  TO authenticated USING (TRUE);



-- DROP the UPDATE rls on varieties table if it already exists
DROP POLICY IF EXISTS "Superusers can update an existing variety" on public.varieties;

-- Create policy for UPDATE requests on varieties table
CREATE POLICY "Superusers can update an existing variety" ON public.varieties
FOR UPDATE
  TO authenticated USING (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  );



  -- DROP the UPDATE rls on species table if it already exists
DROP POLICY IF EXISTS "Superusers can update an existing specie" on public.species;

-- Create policy for UPDATE requests on varieties table
CREATE POLICY "Superusers can update an existing specie" ON public.species
FOR UPDATE
  TO authenticated USING (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  );



-- DROP the DELETE rls on varieties table if it already exists
DROP POLICY IF EXISTS "Superusers can delete an existing variety" on public.varieties;

-- Create policy for UPDATE requests on varieties table
CREATE POLICY "Superusers can delete an existing variety" ON public.varieties
FOR DELETE
  TO authenticated USING (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  );


-- DROP the DELETE rls on species table if it already exists
DROP POLICY IF EXISTS "Superusers can delete an existing specie" on public.species;

-- Create policy for UPDATE requests on species table
CREATE POLICY "Superusers can delete an existing specie" ON public.species
FOR DELETE
  TO authenticated USING (
    check_if_user_is_superuser (get_user_email (auth.uid ()))
  );