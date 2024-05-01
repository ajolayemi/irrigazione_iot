ALTER TABLE public.pump_statuses
add column status_boolean boolean not null default false;

ALTER TABLE public.sector_statuses
add column status_boolean boolean not null default false;