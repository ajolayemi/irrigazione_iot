create table
  public.collectors (
    id bigint generated by default as identity,
    name character varying not null,
    connected_filter_name character varying null,
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null,
    company_id bigint null,
    constraint collectors_pkey primary key (id),
    constraint collectors_name_key unique (name),
    constraint public_collectors_company_id_fkey foreign key (company_id) references companies (id) on update restrict on delete cascade
  ) tablespace pg_default;