ALTER TABLE public.pumps
DROP CONSTRAINT pumps_turn_on_command_key;

ALTER TABLE public.pumps
DROP CONSTRAINT pumps_turn_off_command_key;

ALTER TABLE public.pumps ADD CONSTRAINT pumps_turn_on_command_company_id_key UNIQUE (turn_on_command, company_id);

ALTER TABLE public.pumps ADD CONSTRAINT pumps_turn_off_command_company_id_key UNIQUE (turn_off_command, company_id);