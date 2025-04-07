drop policy "Superusers and company members can select" on "public"."boards";

drop policy "Superusers can create boards" on "public"."boards";

drop policy "Superusers can delete boards" on "public"."boards";

drop policy "Superusers can update boards" on "public"."boards";

drop policy "Superusers can create pumps" on "public"."pumps";

CREATE UNIQUE INDEX collector_pressure_pkey ON public.collector_pressures USING btree (id);

-- CREATE UNIQUE INDEX sector_pumps_pump_id_key ON public.sector_pumps USING btree (pump_id);

CREATE UNIQUE INDEX terminal_pressure_pkey ON public.terminal_pressures USING btree (id);

alter table "public"."collector_pressures" add constraint "collector_pressure_pkey" PRIMARY KEY using index "collector_pressure_pkey";

alter table "public"."terminal_pressures" add constraint "terminal_pressure_pkey" PRIMARY KEY using index "terminal_pressure_pkey";

-- alter table "public"."sector_pumps" add constraint "sector_pumps_pump_id_key" UNIQUE using index "sector_pumps_pump_id_key";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.check_if_user_is_superuser(user_email text)
 RETURNS boolean
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$DECLARE
  superuser_email TEXT;
BEGIN
  SELECT email INTO superuser_email FROM superusers WHERE email = user_email;


  RETURN (superuser_email is not null);
END;$function$
;

CREATE OR REPLACE FUNCTION public.reinsert_on_disconnection()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  sector sectors%ROWTYPE;
  begin 
    SELECT * INTO sector FROM sectors WHERE id = old.sector_id;

    --- This trigger could be fired when user deletes a sector from sector list screen of the app, 
    --- When this is done, the above statement doesn't return any value and when that happens
    --- As such, the insert statement should be run only when the filtered value isn't null
    IF sector IS NOT NULL THEN
        insert into available_sectors(sector_id, company_id)
values (sector.id, sector.company_id);
    END IF;
return OLD;
 end; $function$
;

CREATE OR REPLACE FUNCTION public.track_sector_statuses()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$DECLARE
  -- Will hold already saved record for the sector whose status is being updated
  existing_sector_record sectors_switched_on%ROWTYPE;

  -- Will hold the id of the company this sector belongs to
  sector_company_id bigint;
BEGIN
  -- Get already saved record for the current sector
  SELECT * INTO existing_sector_record FROM sectors_switched_on WHERE sector_id = NEW.sector_id;

  -- Get the id of the company this sector belongs to
  SELECT get_sector_company_id(NEW.sector_id) into sector_company_id;

  -- If a record was found, meaning that a previous record was already saved in the helper table
  IF existing_sector_record is not null THEN
    UPDATE sectors_switched_on SET status_boolean = NEW.status_boolean where id = existing_sector_record.id;
  ELSE
    -- When no record was found, meaning this is the first time here
    -- Insert new record
    INSERT INTO sectors_switched_on(status_boolean, sector_id, company_id) 
    VALUES (NEW.status_boolean, NEW.sector_id, sector_company_id);
  END IF;

  RETURN NEW;
END;$function$
;

create policy "Company members can create boards"
on "public"."boards"
as permissive
for insert
to authenticated
with check ((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = boards.company_id))));


create policy "Company members can delete boards"
on "public"."boards"
as permissive
for delete
to authenticated
using ((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = boards.company_id))));


create policy "Company members can select"
on "public"."boards"
as permissive
for select
to authenticated
using ((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = boards.company_id))));


create policy "Company members can update boards"
on "public"."boards"
as permissive
for update
to authenticated
using ((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = boards.company_id))));


create policy "Superusers can create pumps"
on "public"."pumps"
as permissive
for insert
to authenticated
with check ((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = pumps.company_id))));



