alter table "public"."sensor_measurements" drop column "wind_direction";

alter table "public"."sensor_measurements" add column "wind_direction_sensor" real not null;