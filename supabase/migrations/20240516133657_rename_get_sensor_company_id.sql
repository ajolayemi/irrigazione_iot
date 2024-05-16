drop policy "Superusers and company members can select" on "public"."weather_station_battery_data";

drop policy "Superusers and company members can select" on "public"."weather_station_measurements";

drop function if exists "public"."get_sensor_company_id"(sensor_id_input bigint);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.get_weather_station_company_id(sensor_id_input bigint)
 RETURNS bigint
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$declare
  result bigint;
begin
  select company_id into result from weather_stations where id = sensor_id_input;
  return result;
end;$function$
;

create policy "Superusers and company members can select"
on "public"."weather_station_battery_data"
as permissive
for select
to authenticated
using (((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = get_weather_station_company_id(weather_station_battery_data.weather_station_id)))) OR check_if_user_is_superuser(get_user_email_v2())));


create policy "Superusers and company members can select"
on "public"."weather_station_measurements"
as permissive
for select
to authenticated
using (((EXISTS ( SELECT 1
   FROM companies
  WHERE (companies.id = get_weather_station_company_id(weather_station_measurements.weather_station_id)))) OR check_if_user_is_superuser(get_user_email_v2())));