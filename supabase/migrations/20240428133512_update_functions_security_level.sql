-- update security levels
CREATE
OR REPLACE FUNCTION insert_sector_on_creation () returns trigger language plpgsql as $$ begin 
insert into available_sectors(sector_id, company_id)
values (new.id, new.company_id);
return new;
end;
 $$ security definer;

CREATE
OR REPLACE FUNCTION remove_sector_on_connection () returns trigger language plpgsql as $$ begin
delete from available_sectors where sector_id = new.sector_id;
return old; end; $$ security definer;

CREATE
OR REPLACE FUNCTION reinsert_on_disconnection () RETURNS trigger LANGUAGE plpgsql AS $$
declare
  sector sectors;
  begin 
    select * into sector from sectors where id = old.sector_id;
    insert into available_sectors(sector_id, company_id)
values (sector.id, sector.company_id);
return old;
 end; $$ security definer;
