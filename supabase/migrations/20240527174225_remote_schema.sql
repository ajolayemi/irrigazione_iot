alter table "public"."sector_pumps" drop constraint "sector_pumps_pump_id_key";

alter table "public"."collector_pressures" drop constraint "collector_pressure_pkey";

alter table "public"."terminal_pressures" drop constraint "terminal_pressure_pkey";

alter table "public"."board_statuses" drop constraint "board_statuses_pkey";

alter table "public"."pump_flows" drop constraint "pump_flows_pkey";

alter table "public"."pump_pressures" drop constraint "pump_pressures_pkey";

alter table "public"."sector_pressures" drop constraint "sector_pressures_pkey";

drop index if exists "public"."collector_pressure_pkey";

drop index if exists "public"."sector_pumps_pump_id_key";

drop index if exists "public"."terminal_pressure_pkey";

drop index if exists "public"."board_statuses_pkey";

drop index if exists "public"."pump_flows_pkey";

drop index if exists "public"."pump_pressures_pkey";

drop index if exists "public"."sector_pressures_pkey";

CREATE INDEX board_statuses_created_at_idx ON public.board_statuses USING btree (created_at DESC);

CREATE INDEX collector_pressures_created_at_idx ON public.collector_pressures USING btree (created_at DESC);

CREATE UNIQUE INDEX collector_pressures_pkey ON public.collector_pressures USING btree (id, created_at);

CREATE INDEX pump_flows_created_at_idx ON public.pump_flows USING btree (created_at DESC);

CREATE INDEX pump_pressures_created_at_idx ON public.pump_pressures USING btree (created_at DESC);

CREATE INDEX sector_pressures_created_at_idx ON public.sector_pressures USING btree (created_at DESC);

CREATE INDEX terminal_pressures_created_at_idx ON public.terminal_pressures USING btree (created_at DESC);

CREATE UNIQUE INDEX terminal_pressures_pkey ON public.terminal_pressures USING btree (id, created_at);

CREATE UNIQUE INDEX board_statuses_pkey ON public.board_statuses USING btree (id, created_at);

CREATE UNIQUE INDEX pump_flows_pkey ON public.pump_flows USING btree (id, created_at);

CREATE UNIQUE INDEX pump_pressures_pkey ON public.pump_pressures USING btree (id, created_at);

CREATE UNIQUE INDEX sector_pressures_pkey ON public.sector_pressures USING btree (id, created_at);

alter table "public"."collector_pressures" add constraint "collector_pressures_pkey" PRIMARY KEY using index "collector_pressures_pkey";

alter table "public"."terminal_pressures" add constraint "terminal_pressures_pkey" PRIMARY KEY using index "terminal_pressures_pkey";

alter table "public"."board_statuses" add constraint "board_statuses_pkey" PRIMARY KEY using index "board_statuses_pkey";

alter table "public"."pump_flows" add constraint "pump_flows_pkey" PRIMARY KEY using index "pump_flows_pkey";

alter table "public"."pump_pressures" add constraint "pump_pressures_pkey" PRIMARY KEY using index "pump_pressures_pkey";

alter table "public"."sector_pressures" add constraint "sector_pressures_pkey" PRIMARY KEY using index "sector_pressures_pkey";


