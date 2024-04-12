ALTER TABLE public.sectors 
ALTER COLUMN irrigation_system_type TYPE irrigation_system USING irrigation_system_type::irrigation_system;

ALTER TABLE public.sectors
ALTER COLUMN irrigation_source TYPE irrigation_source USING irrigation_source::irrigation_source;