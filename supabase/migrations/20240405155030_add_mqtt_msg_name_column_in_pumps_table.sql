ALTER TABLE public.pumps
ADD COLUMN mqtt_msg_name VARCHAR NOT NULL UNIQUE;