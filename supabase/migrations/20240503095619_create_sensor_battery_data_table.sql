-- create table
create table
  public.sensor_battery_data (
    id bigint generated by default as identity,
    battery_level numeric not null,
    sensor_id bigint not null,
    created_at timestamp with time zone not null default now(),
    constraint sensor_battery_data_pkey primary key (id),
    constraint public_sensor_battery_data_sensor_id_fkey foreign key (sensor_id) references sensors (id) on update restrict on delete cascade
  ) tablespace pg_default;


  -- drop existing select policy if it already exists
drop policy if exists "Superusers and company members can select" on public.sensor_battery_data;

-- create policy
create policy "Superusers and company members can select" on public.sensor_battery_data for
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
              companies.id = get_sensor_company_id (sensor_battery_data.sensor_id)
            )
        )
      )
      OR check_if_user_is_superuser (get_user_email_v2 ())
    )
  );
