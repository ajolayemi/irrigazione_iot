-- Seed data for companies table
insert into
    public.companies (
        name,
        email,
        phone_number,
        registered_office_address,
        cf,
        piva,
        image_url
    )
values
    (
        'Azienda agricola Garrasi Mario',
        'test@example.com',
        '1234567890',
        'Via Roma 1, 12345, Roma',
        '12345678901',
        '12345678901',
        'https://example.com/image.jpg'
    ),
    (
        'Azienda agricola San Lio',
        'test@example.com',
        '92828282828',
        'Via vespri 2',
        '12345678901',
        '12345678901',
        ''
    ),
    (
        'Azienda agricola F.lli Valenziani',
        'test2@example.com',
        '92828282828',
        'Via San lio, Carlentini',
        '12345678901',
        '12345678901',
        ''
    );

-- Seed data for companies_user table
insert into
    public.companies_user (
        email,
        full_name,
        role,
        created_at,
        updated_at,
        company_id
    )
values
    (
        'test1@email.com',
        'Kehinde Jolayemi',
        'admin',
        now (),
        now (),
        1
    ),
    (
        'test1@email.com',
        'Kehinde Jolayemi',
        'user',
        now (),
        now (),
        2
    ),
    (
        'test2@email.com',
        'Salvo Clemenza',
        'superuser',
        now (),
        now (),
        2
    ),
    (
        'test2@email.com',
        'Salvo Clemenza',
        'user',
        now (),
        now (),
        3
    )