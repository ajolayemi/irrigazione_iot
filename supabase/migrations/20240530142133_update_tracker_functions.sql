-- Update the function that keeps track of pump statuses in a separate table
CREATE
OR REPLACE FUNCTION public.track_pump_statuses () RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  -- Will hold already saved record for the pump whose status is being updated
  existing_pump_record pumps_switched_on%ROWTYPE;
BEGIN
  -- Get already saved record for the current pump
  SELECT * INTO existing_pump_record FROM pumps_switched_on WHERE pump_id = NEW.pump_id;

  -- If a record was found, meaning that a previous record was already saved in the helper table
  IF existing_pump_record is not null THEN
    UPDATE pumps_switched_on SET status_boolean = NEW.status_boolean WHERE id = existing_pump_record.id;
  ELSE
    -- When no record was found, meaning this is the first time here
    -- Insert new record
    INSERT INTO pumps_switched_on(status_boolean, pump_id, company_id) 
    VALUES (NEW.status_boolean, NEW.pump_id, NEW.company_id);
  END IF;

  RETURN NEW;
END;
$$;