--- Create db function that checks if the current user is a superuser
CREATE
OR REPLACE FUNCTION check_if_user_is_superuser (user_email TEXT) RETURNS BOOLEAN AS $$
DECLARE
  superuser_email TEXT;
BEGIN
  SELECT email INTO superuser_email FROM superusers WHERE email = user_email;
  RETURN (superuser_email is not null);
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;