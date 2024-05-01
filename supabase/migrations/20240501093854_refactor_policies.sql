drop policy "Company members and generic superusers can read available colle" on "public"."available_sectors";

drop policy "Authenticated user who are member of a company and superusers c" on "public"."board_statuses";

drop policy "Company members and generic superusers can read boards" on "public"."boards";

drop policy "Authenticated user who are member of a company and superusers c" on "public"."collector_pressures";

drop policy "select_companies_policy" on "public"."companies";

drop policy "update_companies_policy" on "public"."companies";

drop policy "Company members and generic superusers can read company users" on "public"."company_users";

drop policy "Privileged company members and generic superusers can create ne" on "public"."company_users";

drop policy "Privileged company members and generic superusers can delete" on "public"."company_users";

drop policy "Privileged company members and generic superusers can update" on "public"."company_users";

drop policy "Authenticated user who are member of a company and superusers c" on "public"."pump_flows";

drop policy "Authenticated user who are member of a company and superusers c" on "public"."pump_pressures";

drop policy "Authenticated users who are member of a company and superusers " on "public"."pump_statuses";

drop policy "Company members and generic superusers can read pumps" on "public"."pumps";

drop policy "Authenticated users who are member of a company and superusers " on "public"."sector_pressures";

drop policy "Authenticated users who are members of a company and superusers" on "public"."sector_statuses";

drop policy "Company members and generic superusers can read sectors" on "public"."sectors";

drop policy "Authenticated users who are member of a company and superusers " on "public"."terminal_pressures";

drop policy "Superusers can create boards" on "public"."boards";

drop policy "Superusers can delete boards" on "public"."boards";

drop policy "Superusers can update boards" on "public"."boards";

drop policy "Superusers can delete existing collector sectors" on "public"."collector_sectors";

drop policy "Superusers can insert new collector sectors" on "public"."collector_sectors";

drop policy "Superusers can update existing collector sectors" on "public"."collector_sectors";

drop policy "Superusers can create collectors" on "public"."collectors";

drop policy "Superusers can delete collectors" on "public"."collectors";

drop policy "Superusers can update collectors" on "public"."collectors";

drop policy "Superusers can delete companies" on "public"."companies";

drop policy "Superusers can create pumps" on "public"."pumps";

drop policy "Superusers can delete pumps" on "public"."pumps";

drop policy "Superusers can update pumps" on "public"."pumps";

drop policy "Superusers can delete existing sector pumps" on "public"."sector_pumps";

drop policy "Superusers can insert new sector pumps" on "public"."sector_pumps";

drop policy "Superusers can update existing sector pumps" on "public"."sector_pumps";

drop policy "Superusers can create sectors" on "public"."sectors";

drop policy "Superusers can delete sectors" on "public"."sectors";

drop policy "Superusers can update sectors" on "public"."sectors";

drop policy "Superusers can delete an existing specie" on "public"."species";

drop policy "Superusers can insert a new specie" on "public"."species";

drop policy "Superusers can update an existing specie" on "public"."species";

drop policy "Superusers can delete in superusers table" on "public"."superusers";

drop policy "Superusers can insert in superusers table" on "public"."superusers";

drop policy "Superusers can read from superusers table" on "public"."superusers";

drop policy "Superusers can update in superusers table" on "public"."superusers";

drop policy "Superusers can delete an existing variety" on "public"."varieties";

drop policy "Superusers can insert a new variety" on "public"."varieties";

drop policy "Superusers can update an existing variety" on "public"."varieties";

create policy "Superusers and company members can select" on "public"."available_sectors" as permissive for
select
    to authenticated using (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = available_sectors.company_id)
            )
        )
    );

create policy "Superusers and company members can select" on "public"."board_statuses" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_board_company_id (board_statuses.board_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers and company members can select" on "public"."boards" as permissive for
select
    to authenticated using (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = boards.company_id)
            )
        )
    );

create policy "Superusers and company members can select" on "public"."collector_pressures" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_collector_company_id (collector_pressures.collector_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Privileged users, superusers can update" on "public"."companies" as permissive for
update to authenticated,
service_role using (
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

create policy "Superusers and company members can select" on "public"."companies" as permissive for
select
    to authenticated,
    service_role using (
        (
            (
                id IN (
                    SELECT
                        get_companies_ids_for_user.get_companies_ids_for_user
                    FROM
                        get_companies_ids_for_user (get_user_email_v2 ()) get_companies_ids_for_user (get_companies_ids_for_user)
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy " Superusers and company members can select" on "public"."company_users" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = company_users.company_id)
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Privileged users, superusers can delete" on "public"."company_users" as permissive for delete to authenticated using (
    (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = company_users.company_id)
                )
            )
            AND check_if_user_is_privileged (get_user_email_v2 (), company_id)
        )
        OR check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Privileged users, superusers can insert" on "public"."company_users" as permissive for insert to authenticated
with
    check (
        (
            (
                (
                    EXISTS (
                        SELECT
                            1
                        FROM
                            companies
                        WHERE
                            (companies.id = company_users.company_id)
                    )
                )
                AND check_if_user_is_privileged (get_user_email_v2 (), company_id)
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Privileged users, superusers can update" on "public"."company_users" as permissive for
update to authenticated using (
    (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = company_users.company_id)
                )
            )
            AND check_if_user_is_privileged (get_user_email_v2 (), company_id)
        )
        OR check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy " Superusers and company members can select" on "public"."pump_flows" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_pump_company_id (pump_flows.pump_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy " Superusers and company members can select" on "public"."pump_pressures" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_pump_company_id (pump_pressures.pump_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy " Superusers and company members can select" on "public"."pump_statuses" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_pump_company_id (pump_statuses.pump_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers and company members can select" on "public"."pumps" as permissive for
select
    to authenticated using (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = pumps.company_id)
            )
        )
    );

create policy "Superusers and company members can select" on "public"."sector_pressures" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_sector_company_id (sector_pressures.sector_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers and company members can select" on "public"."sector_statuses" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_sector_company_id (sector_statuses.sector_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers and company members can select" on "public"."sectors" as permissive for
select
    to authenticated using (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = sectors.company_id)
            )
        )
    );

create policy "Superusers and company members can select" on "public"."terminal_pressures" as permissive for
select
    to authenticated using (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (
                            companies.id = get_collector_company_id (terminal_pressures.collector_id)
                        )
                )
            )
            OR check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers can create boards" on "public"."boards" as permissive for insert to authenticated
with
    check (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = boards.company_id)
                )
            )
            AND check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers can delete boards" on "public"."boards" as permissive for delete to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = boards.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can update boards" on "public"."boards" as permissive for
update to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = boards.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can delete existing collector sectors" on "public"."collector_sectors" as permissive for delete to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can insert new collector sectors" on "public"."collector_sectors" as permissive for insert to authenticated
with
    check (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can update existing collector sectors" on "public"."collector_sectors" as permissive for
update to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can create collectors" on "public"."collectors" as permissive for insert to authenticated
with
    check (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = collectors.company_id)
                )
            )
            AND check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers can delete collectors" on "public"."collectors" as permissive for delete to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = collectors.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can update collectors" on "public"."collectors" as permissive for
update to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = collectors.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can delete companies" on "public"."companies" as permissive for delete to service_role using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can create pumps" on "public"."pumps" as permissive for insert to authenticated
with
    check (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = pumps.company_id)
                )
            )
            AND check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers can delete pumps" on "public"."pumps" as permissive for delete to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = pumps.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can update pumps" on "public"."pumps" as permissive for
update to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = pumps.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can delete existing sector pumps" on "public"."sector_pumps" as permissive for delete to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can insert new sector pumps" on "public"."sector_pumps" as permissive for insert to authenticated
with
    check (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can update existing sector pumps" on "public"."sector_pumps" as permissive for
update to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can create sectors" on "public"."sectors" as permissive for insert to authenticated
with
    check (
        (
            (
                EXISTS (
                    SELECT
                        1
                    FROM
                        companies
                    WHERE
                        (companies.id = sectors.company_id)
                )
            )
            AND check_if_user_is_superuser (get_user_email_v2 ())
        )
    );

create policy "Superusers can delete sectors" on "public"."sectors" as permissive for delete to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = sectors.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can update sectors" on "public"."sectors" as permissive for
update to authenticated using (
    (
        (
            EXISTS (
                SELECT
                    1
                FROM
                    companies
                WHERE
                    (companies.id = sectors.company_id)
            )
        )
        AND check_if_user_is_superuser (get_user_email_v2 ())
    )
);

create policy "Superusers can delete an existing specie" on "public"."species" as permissive for delete to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can insert a new specie" on "public"."species" as permissive for insert to authenticated
with
    check (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can update an existing specie" on "public"."species" as permissive for
update to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can delete in superusers table" on "public"."superusers" as permissive for delete to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can insert in superusers table" on "public"."superusers" as permissive for insert to authenticated
with
    check (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can read from superusers table" on "public"."superusers" as permissive for
select
    to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can update in superusers table" on "public"."superusers" as permissive for
update to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can delete an existing variety" on "public"."varieties" as permissive for delete to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can insert a new variety" on "public"."varieties" as permissive for insert to authenticated
with
    check (check_if_user_is_superuser (get_user_email_v2 ()));

create policy "Superusers can update an existing variety" on "public"."varieties" as permissive for
update to authenticated using (check_if_user_is_superuser (get_user_email_v2 ()));