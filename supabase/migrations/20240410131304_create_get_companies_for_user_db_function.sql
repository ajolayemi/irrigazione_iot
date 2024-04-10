DROP FUNCTION IF exists get_companies_for_user(TEXT);

--- Gets the ids of the companies that are associated with the user with the provided email
CREATE
OR REPLACE FUNCTION get_companies_ids_for_user (user_email TEXT) RETURNS SETOF bigint AS $$
BEGIN
  RETURN  QUERY SELECT company_id FROM company_users WHERE email = user_email;
END
$$ STABLE LANGUAGE plpgsql SECURITY DEFINER;