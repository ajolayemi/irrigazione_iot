drop policy if exists "Superusers and company members can select" on "public"."companies";

create policy "Superusers and company members can select" on "public"."companies" as permissive for
select
  to anon,
  authenticated,
  service_role using (
    (
      (
        (
          id IN (
            SELECT
              *
            FROM
              get_companies_ids_for_user (get_user_email_v2 ())
          )
        )
        AND check_if_user_is_privileged (get_user_email_v2 (), id)
      )
      OR check_if_user_is_superuser (get_user_email_v2 ())
    )
  );