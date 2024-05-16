--- Adds new sectors to available_sectors table each time a new row is inserted
--- in sectors table
CREATE
OR REPLACE FUNCTION insert_sector_on_creation () returns trigger language plpgsql as $$ begin 
insert into available_sectors(sector_id, company_id)
values (new.id, new.company_id);
return new;
end; $$;

-- create trigger
create
or replace trigger available_sectors_insert_trigger
after insert on sectors for each row
execute function insert_sector_on_creation ();

--- removes record from available_sectors table each time a new value
CREATE
OR REPLACE FUNCTION remove_sector_on_connection () returns trigger language plpgsql as $$ begin
delete from available_sectors where sector_id = new.sector_id;
return old; end; $$;

-- create trigger for insert / delete
create
or replace trigger available_sectors_delete_trigger
after insert
or
update on collector_sectors for each row
execute function remove_sector_on_connection ();
