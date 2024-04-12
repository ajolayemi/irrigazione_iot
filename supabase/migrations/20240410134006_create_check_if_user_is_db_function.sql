--- Create db function that checks if the current user has the specified role
CREATE OR REPLACE FUNCTION check_if_user_is(user_email TEXT, current_company_id bigint, this_role TEXT)
RETURNS BOOLEAN AS $$
DECLARE
  user_role TEXT;
BEGIN
  SELECT ROLE INTO user_role FROM COMPANY_USERS WHERE email = user_email and company_id = current_company_id;
  RETURN (user_role = this_role);
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;