-- Add constraint on turn_on_command
ALTER TABLE public.sectors ADD CONSTRAINT sectors_turn_on_command_company_id_key UNIQUE (company_id, turn_on_command);

-- Add constraint on turn_off_command
ALTER TABLE public.sectors ADD CONSTRAINT sectors_turn_off_command_company_id_key UNIQUE (company_id, turn_off_command);