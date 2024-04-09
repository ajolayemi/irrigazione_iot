create table if not exists
  public.collector_sectors (
    id bigint generated by default as identity,
    collector_id bigint not null,
    sector_id bigint not null,
    company_id bigint not null,
    created_at timestamp with time zone not null default now(),
    constraint collector_sectors_pkey primary key (id),
    constraint public_collector_sectors_sector_id_fkey foreign key (sector_id) references sectors (id) on update restrict on delete cascade,
    constraint public_collector_sectors_company_id_fkey foreign key (company_id) references companies (id) on update restrict on delete cascade,
    constraint public_collector_sectors_collector_id_fkey foreign key (collector_id) references collectors (id) on update restrict on delete cascade
  ) tablespace pg_default;