alter table "public"."boards"
drop constraint "boards_mqtt_msg_name_key";

alter table "public"."collector_pressures"
drop constraint "collector_pressures_pkey";

alter table "public"."terminal_pressures"
drop constraint "terminal_pressures_pkey";

drop index if exists "public"."boards_mqtt_msg_name_key";

drop index if exists "public"."collector_pressures_pkey";

drop index if exists "public"."terminal_pressures_pkey";

alter table "public"."boards"
drop column "mqtt_msg_name";

CREATE UNIQUE INDEX collector_pressure_pkey ON public.collector_pressures USING btree (id);

CREATE UNIQUE INDEX sector_pumps_pump_id_key ON public.sector_pumps USING btree (pump_id);

CREATE UNIQUE INDEX terminal_pressure_pkey ON public.terminal_pressures USING btree (id);

alter table "public"."collector_pressures" add constraint "collector_pressure_pkey" PRIMARY KEY using index "collector_pressure_pkey";

alter table "public"."terminal_pressures" add constraint "terminal_pressure_pkey" PRIMARY KEY using index "terminal_pressure_pkey";

alter table "public"."sector_pumps" add constraint "sector_pumps_pump_id_key" UNIQUE using index "sector_pumps_pump_id_key";