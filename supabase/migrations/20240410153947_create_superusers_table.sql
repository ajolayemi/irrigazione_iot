create table
  public.superusers (
    id bigint generated by default as identity,
    email text not null,
    created_at timestamp with time zone not null default now(),
    constraint superusers_pkey primary key (id),
    constraint superusers_email_key unique (email)
  ) tablespace pg_default;