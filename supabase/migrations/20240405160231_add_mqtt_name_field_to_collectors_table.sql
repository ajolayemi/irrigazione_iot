ALTER TABLE public.collectors
ADD COLUMN mqtt_msg_name VARCHAR NOT NULL UNIQUE;