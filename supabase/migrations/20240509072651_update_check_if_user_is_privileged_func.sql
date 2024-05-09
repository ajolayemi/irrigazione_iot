CREATE OR REPLACE FUNCTION public.check_if_user_is_privileged(user_email text, current_company_id bigint)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$DECLARE
  user_role_from_db TEXT;
BEGIN
  SELECT role INTO user_role_from_db FROM company_users WHERE email = user_email and company_id = current_company_id;
  RETURN (user_role_from_db is not null);
END;$function$
;

