ALTER TABLE public.collector_pressures
RENAME COLUMN event_id TO id;

ALTER TABLE public.pump_pressures
RENAME COLUMN event_id TO id;

ALTER TABLE public.pump_statuses
RENAME COLUMN status_id TO id;

ALTER TABLE public.sector_pressures
RENAME COLUMN event_id TO id;

ALTER TABLE public.sector_statuses
RENAME COLUMN status_id TO id;

ALTER TABLE public.board_statuses
RENAME COLUMN status_id TO id;