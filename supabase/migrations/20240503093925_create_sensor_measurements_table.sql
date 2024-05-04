create table
  public.sensor_measurements (
    id bigint generated by default as identity,
    air_temperature real not null,
    air_humidity real not null,
    light_intensity real not null,
    uv_index real not null,
    wind_speed real not null,
    wind_direction real not null,
    rain_gauge real not null,
    barometric_pressure real not null,
    created_at timestamp with time zone not null default now(),
    sensor_id bigint not null,
    constraint sensor_measurements_pkey primary key (id),
    constraint public_sensor_measurements_sensor_id_fkey foreign key (sensor_id) references sensors (id) on update restrict on delete cascade
  ) tablespace pg_default;

-- enable rls
alter table "public"."sensor_measurements" enable row level security;

  -- create function to get_sensor_company_id
create
or replace function get_sensor_company_id (sensor_id_input bigint) returns bigint as $$
declare
  result bigint;
begin
  select company_id into result from sensors where id = sensor_id_input;
  return result;
end;
$$ language plpgsql stable security definer;

-- drop existing select policy if it already exists
drop policy if exists "Superusers and company members can select" on public.sensor_measurements;

-- create policy
create policy "Superusers and company members can select" on public.sensor_measurements for
select
  to authenticated using (
    (
      (
        EXISTS (
          SELECT
            1
          FROM
            companies
          WHERE
            (
              companies.id = get_sensor_company_id (sensor_measurements.sensor_id)
            )
        )
      )
      OR check_if_user_is_superuser (get_user_email_v2 ())
    )
  );