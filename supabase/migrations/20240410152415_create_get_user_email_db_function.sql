--- create function that gets the email of the current user
CREATE
OR REPLACE FUNCTION get_user_email (user_id uuid) RETURNS TEXT AS $$
declare
user_email text;
BEGIN
   SELECT email into user_email FROM auth.users WHERE id = user_id;
   return user_email;
END
$$ STABLE LANGUAGE plpgsql SECURITY DEFINER;