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
    );

-- Seed data for pumps table
insert into
    public.pumps (
        name,
        capacity_in_volume,
        consume_rate_in_kw,
        company_id,
        created_at,
        updated_at
    )
values
    ('Pompa 1', 1000, 100, 1, now (), now ()),
    ('Pompa 2', 2000, 200, 1, now (), now ()),
    ('Pompa 3', 3000, 300, 2, now (), now ()),
    ('Pompa 4', 4000, 400, 2, now (), now ()),
    ('Pompa 5', 5000, 500, 3, now (), now ()),
    ('Pompa 6', 6000, 600, 3, now (), now ());

-- Seed data for species table
insert into
    public.species (name)
values
    ('arancia'),
    ('mela'),
    ('pera'),
    ('pesca'),
    ('ciliegia'),
    ('albicocca'),
    ('prugna'),
    ('fico'),
    ('uva'),
    ('melograno'),
    ('kiwi'),
    ('limone'),
    ('mandarino'),
    ('pompelmo'),
    ('limetta'),
    ('clementina'),
    ('mango'),
    ('ananas'),
    ('banana'),
    ('papaya'),
    ('cocco');

-- Seed data for varieties table
insert into
    public.varieties (name)
values
    ('Tarocco'),
    ('Moro'),
    ('Sanguinello'),
    ('Valencia'),
    ('Navel'),
    ('Washington'),
    ('Mela Rossa'),
    ('Mela Verde'),
    ('Mela Gialla'),
    ('Mela Fuji'),
    ('Mela Pink Lady'),
    ('Mela Granny Smith'),
    ('Mela Golden'),
    ('Mela Red Delicious'),
    ('Mela Royal Gala'),
    ('Mela Renetta'),
    ('Mela Annurca'),
    ('Mela Stark Delicious')