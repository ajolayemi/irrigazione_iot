alter table "public"."collector_pressures" drop constraint "collector_pressures_pkey";

alter table "public"."terminal_pressures" drop constraint "terminal_pressures_pkey";

alter table "public"."board_statuses" drop constraint "board_statuses_pkey";

alter table "public"."pump_flows" drop constraint "pump_flows_pkey";

alter table "public"."pump_pressures" drop constraint "pump_pressures_pkey";

alter table "public"."sector_pressures" drop constraint "sector_pressures_pkey";

drop index if exists "public"."board_statuses_created_at_idx";

drop index if exists "public"."collector_pressures_created_at_idx";

drop index if exists "public"."collector_pressures_pkey";

drop index if exists "public"."pump_flows_created_at_idx";

drop index if exists "public"."pump_pressures_created_at_idx";

drop index if exists "public"."sector_pressures_created_at_idx";

drop index if exists "public"."terminal_pressures_created_at_idx";

drop index if exists "public"."terminal_pressures_pkey";

drop index if exists "public"."board_statuses_pkey";

drop index if exists "public"."pump_flows_pkey";

drop index if exists "public"."pump_pressures_pkey";

drop index if exists "public"."sector_pressures_pkey";

CREATE UNIQUE INDEX collector_pressure_pkey ON public.collector_pressures USING btree (id);

CREATE UNIQUE INDEX sector_pumps_pump_id_key ON public.sector_pumps USING btree (pump_id);

CREATE UNIQUE INDEX terminal_pressure_pkey ON public.terminal_pressures USING btree (id);

CREATE UNIQUE INDEX board_statuses_pkey ON public.board_statuses USING btree (id);

CREATE UNIQUE INDEX pump_flows_pkey ON public.pump_flows USING btree (id);

CREATE UNIQUE INDEX pump_pressures_pkey ON public.pump_pressures USING btree (id);

CREATE UNIQUE INDEX sector_pressures_pkey ON public.sector_pressures USING btree (id);

alter table "public"."collector_pressures" add constraint "collector_pressure_pkey" PRIMARY KEY using index "collector_pressure_pkey";

alter table "public"."terminal_pressures" add constraint "terminal_pressure_pkey" PRIMARY KEY using index "terminal_pressure_pkey";

alter table "public"."board_statuses" add constraint "board_statuses_pkey" PRIMARY KEY using index "board_statuses_pkey";

alter table "public"."pump_flows" add constraint "pump_flows_pkey" PRIMARY KEY using index "pump_flows_pkey";

alter table "public"."pump_pressures" add constraint "pump_pressures_pkey" PRIMARY KEY using index "pump_pressures_pkey";

alter table "public"."sector_pressures" add constraint "sector_pressures_pkey" PRIMARY KEY using index "sector_pressures_pkey";

alter table "public"."sector_pumps" add constraint "sector_pumps_pump_id_key" UNIQUE using index "sector_pumps_pump_id_key";

set check_function_bodies = off;

DROP FUNCTION IF EXISTS public.notify_webhook;

CREATE TRIGGER board_statuses_gs_hook AFTER INSERT ON public.board_statuses FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER collector_pressures_gs_hook AFTER INSERT ON public.collector_pressures FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER pump_flows_gs_hook AFTER INSERT ON public.pump_flows FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER pump_pressures_gs_hook AFTER INSERT ON public.pump_pressures FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER pump_statuses_gs_hook AFTER INSERT ON public.pump_statuses FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER sector_pressures_gs_hook AFTER INSERT ON public.sector_pressures FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER sector_statuses_gs_hook AFTER INSERT ON public.sector_statuses FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER terminal_pressures_gs_hook AFTER INSERT ON public.terminal_pressures FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER weather_station_battery_gs_hook AFTER INSERT ON public.weather_station_battery_data FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');

CREATE TRIGGER weather_station_measurements_gs_hook AFTER INSERT ON public.weather_station_measurements FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app', 'POST', '{"Content-type":"application/json"}', '{}', '1000');