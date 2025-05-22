alter table "public"."sector_statuses" add column "company_id" bigint not null;

alter table "public"."sector_statuses" add constraint "sector_statuses_company_id_fkey" FOREIGN KEY (company_id) REFERENCES companies(id) ON UPDATE RESTRICT ON DELETE CASCADE not valid;

alter table "public"."sector_statuses" validate constraint "sector_statuses_company_id_fkey";