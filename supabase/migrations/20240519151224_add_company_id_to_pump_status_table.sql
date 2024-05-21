alter table "public"."pump_statuses"
add column "company_id" bigint not null;

alter table "public"."pump_statuses" add constraint "public_pump_statuses_company_id_fkey" FOREIGN KEY (company_id) REFERENCES companies (id) ON UPDATE RESTRICT ON DELETE CASCADE not valid;

alter table "public"."pump_statuses" validate constraint "public_pump_statuses_company_id_fkey";