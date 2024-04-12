ALTER TABLE public.pump_pressures
ADD COLUMN filter_in_pressure DECIMAL(10, 2) NOT NULL DEFAULT 0;

ALTER TABLE public.pump_pressures
ADD COLUMN filter_out_pressure DECIMAL(10, 2) NOT NULL DEFAULT 0;

ALTER TABLE public.pump_pressures
ADD COLUMN pressure_difference DECIMAL(10, 2) NOT NULL GENERATED ALWAYS AS (filter_in_pressure - filter_out_pressure) STORED;