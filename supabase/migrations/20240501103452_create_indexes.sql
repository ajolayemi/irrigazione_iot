CREATE INDEX board_statuses_board_id_idx ON public.board_statuses USING btree (board_id);

CREATE INDEX boards_collector_id_idx ON public.boards USING btree (collector_id);

CREATE INDEX boards_company_id_idx ON public.boards USING btree (company_id);

CREATE INDEX boards_id_idx ON public.boards USING btree (id);

CREATE INDEX collector_pressures_collector_id_idx ON public.collector_pressures USING btree (collector_id);

CREATE INDEX collector_sectors_collector_id_idx ON public.collector_sectors USING btree (collector_id);

CREATE INDEX collectors_company_id_idx ON public.collectors USING btree (company_id);

CREATE INDEX pump_flows_pump_id_idx ON public.pump_flows USING btree (pump_id);

CREATE INDEX pump_pressures_pump_id_idx ON public.pump_pressures USING btree (pump_id);

CREATE INDEX pump_statuses_pump_id_idx ON public.pump_statuses USING btree (pump_id);

CREATE INDEX pumps_company_id_idx ON public.pumps USING btree (company_id);

CREATE INDEX sector_pressures_sector_id_idx ON public.sector_pressures USING btree (sector_id);

CREATE INDEX sector_pumps_pump_id_idx ON public.sector_pumps USING btree (pump_id);

CREATE INDEX sector_statuses_sector_id_idx ON public.sector_statuses USING btree (sector_id);

CREATE INDEX sectors_company_id_idx ON public.sectors USING btree (company_id);

CREATE INDEX sectors_company_id_idx1 ON public.sectors USING btree (company_id);

CREATE INDEX sectors_specie_id_idx ON public.sectors USING btree (specie_id);

CREATE INDEX sectors_variety_id_idx ON public.sectors USING btree (variety_id);

CREATE INDEX terminal_pressures_collector_id_idx ON public.terminal_pressures USING btree (collector_id);