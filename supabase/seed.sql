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
    ('Mela Stark Delicious');

-- Seed data for sectors table
insert into
    public.sectors (
        name,
        area,
        num_of_plants,
        water_consumption_per_hour,
        irrigation_system_type,
        irrigation_source,
        turn_on_command,
        turn_off_command,
        notes,
        specie_id,
        variety_id,
        company_id,
        updated_at
    )
values
    (
        'ME7',
        100,
        20,
        2,
        'pivot',
        'pozzo',
        '1',
        '2',
        'casa me8',
        1,
        2,
        1,
        now ()
    ),
    (
        'ME8',
        300,
        25,
        3,
        'rotolo',
        'lago',
        '3',
        '4',
        '',
        1,
        1,
        1,
        now ()
    ),
    (
        'san lio basso',
        400,
        100,
        2,
        'rotolo',
        'lago',
        '5',
        '6',
        '',
        2,
        1,
        2,
        now ()
    ),
    (
        'san lio alto',
        500,
        200,
        3,
        'pivot',
        'pozzo',
        '7',
        '8',
        '',
        2,
        2,
        2,
        now ()
    ),
    (
        'valenziani',
        600,
        300,
        4,
        'pivot',
        'pozzo',
        '9',
        '10',
        '',
        3,
        1,
        3,
        now ()
    ),
    (
        'valenziani 2',
        700,
        400,
        5,
        'rotolo',
        'lago',
        '11',
        '12',
        '',
        3,
        2,
        3,
        now ()
    );

-- Seed data for collector table
insert into
    public.collectors (
        name,
        connected_filter_name,
        updated_at,
        company_id
    )
values
    ('S1 (cisterne)', 'filtro s1', now (), 1),
    ('S2 (pozzo)', 'filtro s2', now (), 1),
    ('S3 (lago)', 'filtro s3', now (), 2),
    ('S4 (cisterne)', 'filtro s4', now (), 2),
    ('S5 (pozzo)', 'filtro s5', now (), 3),
    ('S6 (lago)', 'filtro s6', now (), 3);

-- Seed data for collector_sectors table
insert into
    public.collector_sectors (collector_id, sector_id, company_id)
values
    (1, 1, 1),
    (2, 2, 1),
    (3, 3, 2),
    (4, 4, 2),
    (5, 5, 3),
    (6, 6, 3);

-- Seed data for boards table
insert into
    public.boards (
        name,
        model,
        serial_number,
        collector_id,
        company_id,
        updated_at
    )
values
    (
        'arduino mkr 3',
        'mkr 3',
        '1234567890',
        1,
        1,
        now ()
    ),
    (
        'arduino mkr 4',
        'mkr 4',
        '1234567891',
        2,
        1,
        now ()
    ),
    (
        'arduino mkr 5',
        'mkr 5',
        '1234567892',
        3,
        2,
        now ()
    ),
    (
        'arduino mkr 6',
        'mkr 6',
        '1234567893',
        4,
        2,
        now ()
    ),
    (
        'arduino mkr 7',
        'mkr 7',
        '1234567894',
        5,
        3,
        now ()
    ),
    (
        'arduino mkr 8',
        'mkr 8',
        '1234567895',
        6,
        3,
        now ()
    );

-- Seed data for board_statuses table
insert into
    public.board_statuses (battery_level, status_timestamp, board_id)
values
    (0.2, now (), 1),
    (0.3, now (), 2),
    (0.4, now (), 3),
    (0.5, now (), 4),
    (0.6, now (), 5),
    (0.7, now (), 6);

-- Seed data for collector_pressures table
insert into
    public.collector_pressures (
        filter_in_pressure,
        filter_out_pressure,
        pressure_timestamp,
        collector_id
    ) 
    values
    (1.2, 1.1, now (), 1),
    (1.3, 1.2, now (), 2),
    (1.4, 1.3, now (), 3),
    (1.5, 1.4, now (), 4),
    (1.6, 1.5, now (), 5),
    (1.7, 1.6, now (), 6);