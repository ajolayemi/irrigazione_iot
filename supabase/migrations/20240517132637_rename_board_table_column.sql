alter table "public"."boards"
drop column "serial_number";

alter table "public"."boards"
add column "eui" character varying not null;