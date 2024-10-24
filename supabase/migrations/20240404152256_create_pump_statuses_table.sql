create table if not exists
  public.pump_statuses (
    status_id bigint generated by default as identity,
    status character varying not null,
    pump_id bigint not null,
    status_timestamp timestamp with time zone not null,
    constraint pump_statuses_pkey primary key (status_id),
    constraint public_pump_statuses_pump_id_fkey foreign key (pump_id) references pumps (id) on update restrict on delete cascade
  ) tablespace pg_default;