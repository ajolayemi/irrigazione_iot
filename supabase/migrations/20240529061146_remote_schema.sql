drop trigger if exists "board_statuses_gs_hook" on "public"."board_statuses";

CREATE UNIQUE INDEX board_statuses_pkey ON public.board_statuses USING btree (id);

CREATE UNIQUE INDEX collector_pressures_pkey ON public.collector_pressures USING btree (id);

CREATE UNIQUE INDEX pump_flows_pkey ON public.pump_flows USING btree (id);

CREATE UNIQUE INDEX pump_pressures_pkey ON public.pump_pressures USING btree (id);

CREATE UNIQUE INDEX sector_pressures_pkey ON public.sector_pressures USING btree (id);

CREATE UNIQUE INDEX terminal_pressures_pkey ON public.terminal_pressures USING btree (id);

alter table "public"."board_statuses" add constraint "board_statuses_pkey" PRIMARY KEY using index "board_statuses_pkey";

alter table "public"."collector_pressures" add constraint "collector_pressures_pkey" PRIMARY KEY using index "collector_pressures_pkey";

alter table "public"."pump_flows" add constraint "pump_flows_pkey" PRIMARY KEY using index "pump_flows_pkey";

alter table "public"."pump_pressures" add constraint "pump_pressures_pkey" PRIMARY KEY using index "pump_pressures_pkey";

alter table "public"."sector_pressures" add constraint "sector_pressures_pkey" PRIMARY KEY using index "sector_pressures_pkey";

alter table "public"."terminal_pressures" add constraint "terminal_pressures_pkey" PRIMARY KEY using index "terminal_pressures_pkey";

CREATE TRIGGER board_statuses_gs_hook AFTER INSERT ON public.board_statuses FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request (
    'https://insertdataingooglesheet-nqsofkmx5a-uc.a.run.app',
    'POST',
    '{"Content-type":"application/json"}',
    '{}',
    '5000'
);