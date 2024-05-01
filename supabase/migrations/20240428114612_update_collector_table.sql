alter table "public"."collectors"
drop column "connected_filter_name";

alter table "public"."collectors"
add column "has_filter" boolean not null default false;