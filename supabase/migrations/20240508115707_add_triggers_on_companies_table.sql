--- inserts a new record to company_users table each time a new company is created
CREATE OR REPLACE FUNCTION public.insert_company_user_on_creation()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$ BEGIN
INSERT into company_users(email, full_name, "role", company_id, updated_at) VALUES (new.email, new.name, 'owner', new.id, new.updated_at);
return new;
end; $function$
;


--- create trigger that fires upon each insert
create
or replace trigger company_users_insert_trigger
after insert on companies for each row
execute function insert_company_user_on_creation ();

--- when a company info is updated, this function updates the email address associated with 
--- this company owner role in company_users table

CREATE OR REPLACE FUNCTION public.update_company_user_on_company_updated()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    id_of_existing_record bigint;
BEGIN
    -- Assume "role" is a column and we are checking for a role named 'owner'
    SELECT id INTO id_of_existing_record
    FROM company_users
    WHERE company_id = NEW.id AND "role" = 'owner';

    -- Use the variable properly in the UPDATE statement
    IF id_of_existing_record IS NOT NULL THEN
        UPDATE company_users
        SET email = NEW.email
        WHERE id = id_of_existing_record;
    END IF;

    RETURN NEW;
END;
$function$
;

--- create trigger
CREATE
OR REPLACE TRIGGER company_users_update_trigger
AFTER
UPDATE ON companies FOR EACH ROW
EXECUTE FUNCTION update_company_user_on_company_updated ();
