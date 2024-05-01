alter table "public"."collectors"
alter column "has_filter"
drop default;

alter table "public"."companies"
alter column "mqtt_topic_name"
drop default;

CREATE UNIQUE INDEX companies_mqtt_topic_name_key ON public.companies USING btree (mqtt_topic_name);

alter table "public"."companies" add constraint "companies_mqtt_topic_name_key" UNIQUE using index "companies_mqtt_topic_name_key";