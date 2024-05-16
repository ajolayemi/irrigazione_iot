drop policy "Everyone can insert a new company" on "public"."companies";

drop policy "Superusers and company members can select" on "public"."companies";

create policy "Everyone can insert a new company" on "public"."companies" as permissive for insert to public
with
    check (true);

create policy "Superusers and company members can select" on "public"."companies" as permissive for
select
    to authenticated,
    service_role,
    anon using (
        (
            (
                (
                    id IN (
                        SELECT
                            get_companies_ids_for_user.get_companies_ids_for_user
                        FROM
                            get_companies_ids_for_user (get_user_email_v2 ()) get_companies_ids_for_user (get_companies_ids_for_user)
                    )
                )
                AND check_if_user_is_privileged (get_user_email_v2 (), id)
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );