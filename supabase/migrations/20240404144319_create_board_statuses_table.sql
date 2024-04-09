create table if not exists
  public.board_statuses (
    status_id bigint generated by default as identity,
    battery_level double precision not null,
    "when" timestamp with time zone not null,
    board_id bigint not null,
    constraint board_statuses_pkey primary key (status_id),
    constraint public_board_statuses_board_id_fkey foreign key (board_id) references boards (id) on update restrict on delete cascade
  ) tablespace pg_default;