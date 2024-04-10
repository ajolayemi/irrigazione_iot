CREATE
OR REPLACE FUNCTION check_if_user_is_admin_or_owner (user_email TEXT, current_company_id bigint) RETURNS BOOLEAN AS $$
DECLARE
  user_role_from_db TEXT;
BEGIN
  SELECT role INTO user_role_from_db FROM company_users WHERE email = user_email and id = current_company_id;
  RETURN (user_role_from_db is not null and (user_role_from_db = 'admin' or user_role_from_db = 'owner'));
END;
$$ LANGUAGE plpgsql STABLE SECURITY DEFINER;