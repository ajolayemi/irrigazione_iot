-- Update function
CREATE
OR REPLACE FUNCTION reinsert_on_disconnection () RETURNS trigger LANGUAGE plpgsql AS $$
declare
  sector sectors%ROWTYPE;
  existing_available_sector available_sectors%ROWTYPE;
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
 end; $$ security definer;
