CREATE
OR REPLACE FUNCTION get_user_email_v2 () RETURNS TEXT AS $$
declare
user_email text;
BEGIN
   SELECT email into user_email FROM auth.users WHERE id = (select auth.uid());
   return user_email;
END
$$ STABLE LANGUAGE plpgsql SECURITY DEFINER;
