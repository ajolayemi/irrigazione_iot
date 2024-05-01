-- create trigger for insert / update
create
or replace trigger available_sectors_delete_trigger after insert
or
update on collector_sectors for each row execute function remove_sector_on_connection ();

-- drop old trigger
drop trigger if exists available_sectors_delete_trigger on public.available_sectors;

-- recreate the trigger with new name
create
or replace trigger available_sectors_insert_update_trigger after insert
or
update on collector_sectors for each row execute function remove_sector_on_connection ();

-- create trigger for delete
create
or replace trigger available_sectors_delete_trigger after delete on collector_sectors for each row execute function insert_sector_on_creation ();


drop trigger if exists "available_sectors_delete_trigger" on "public"."collector_sectors";

CREATE OR REPLACE FUNCTION public.reinsert_on_disconnection()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
  sector sectors;
  begin 
    select * into sector from sectors where id = old.sector_id;
    insert into available_sectors(sector_id, company_id)
values (sector.id, sector.company_id);
return old;
 end; $function$
;

CREATE TRIGGER available_sectors_delete_trigger AFTER DELETE ON public.collector_sectors FOR EACH ROW EXECUTE FUNCTION reinsert_on_disconnection();