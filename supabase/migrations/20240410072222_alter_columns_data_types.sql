-- drop pressure_difference column to avoid error when changing data types of filter_in_pressure and filter_out_pressure columns
ALTER TABLE public.collector_pressures
DROP COLUMN pressure_difference;

-- change data types of columns in collector_pressures table
ALTER TABLE public.collector_pressures
ALTER COLUMN filter_in_pressure
SET
    DATA TYPE DECIMAL(10, 2);

ALTER TABLE public.collector_pressures
ALTER COLUMN filter_out_pressure
SET
    DATA TYPE DECIMAL(10, 2);

-- readd pressure_difference column
ALTER TABLE public.collector_pressures
ADD COLUMN pressure_difference DECIMAL(10, 2) NOT NULL GENERATED ALWAYS AS (filter_in_pressure - filter_out_pressure) STORED;

-- change data types of columns in pump_flows table
ALTER TABLE public.pump_flows
ALTER COLUMN flow
SET
    DATA TYPE DECIMAL(10, 2);

-- change data types of columns in sector_pressures table
ALTER TABLE public.sector_pressures
ALTER COLUMN pressure
SET
    DATA TYPE DECIMAL(10, 2);

-- change data types of column in terminal_pressures table
ALTER TABLE public.terminal_pressures
ALTER COLUMN pressure
SET
    DATA TYPE DECIMAL(10, 2);