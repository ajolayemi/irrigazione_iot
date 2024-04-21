-- rename pump_pressures table column pressure_timestamp to created_at
ALTER TABLE public.pump_pressures
RENAME COLUMN pressure_timestamp TO created_at;

-- set default value for created_at column in pump_pressures table
ALTER TABLE public.pump_pressures
ALTER COLUMN created_at
SET DEFAULT now ();

-- rename pump_statuses table column status_timestamp to created_at
ALTER TABLE public.pump_statuses
RENAME COLUMN status_timestamp TO created_at;

-- set default value for created_at column in pump_statuses table
ALTER TABLE public.pump_statuses
ALTER COLUMN created_at
SET DEFAULT now ();

-- rename sector_pressures table column pressure_timestamp to created_at
ALTER TABLE public.sector_pressures
RENAME COLUMN pressure_timestamp TO created_at;

-- set default value for created_at column in sector_pressures table
ALTER TABLE public.sector_pressures
ALTER COLUMN created_at
SET DEFAULT now ();

-- rename sector_statuses table column status_timestamp to created_at
ALTER TABLE public.sector_statuses
RENAME COLUMN status_timestamp TO created_at;

-- set default value for created_at column in sector_statuses table
ALTER TABLE public.sector_statuses
ALTER COLUMN created_at
SET DEFAULT now ();

-- rename collector_pressures table column pressure_timestamp to created_at
ALTER TABLE public.collector_pressures
RENAME COLUMN pressure_timestamp TO created_at;

-- set default value for created_at column in collector_pressures table
ALTER TABLE public.collector_pressures
ALTER COLUMN created_at
SET DEFAULT now ();

-- rename board_pressures table column pressure_timestamp to created_at
ALTER TABLE public.board_statuses
RENAME COLUMN status_timestamp TO created_at;

-- set default value for created_at column in board_statuses table
ALTER TABLE public.board_statuses
ALTER COLUMN created_at
SET DEFAULT now ();