alter table "public"."companies" add column "mqtt_topic_name" text not null default ''::text;

-- CREATE UNIQUE INDEX companies_mqtt_topic_name_key ON public.companies USING btree (mqtt_topic_name);

-- alter table "public"."companies" add constraint "companies_mqtt_topic_name_key" UNIQUE using index "companies_mqtt_topic_name_key";