alter table "public"."collectors"
alter column "has_filter"
drop default;

alter table "public"."companies"
alter column "mqtt_topic_name"
drop default;