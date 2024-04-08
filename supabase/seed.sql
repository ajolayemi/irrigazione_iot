-- Seed data for companies table
insert into
    public.companies (
        name,
        email,
        phone_number,
        registered_office_address,
        cf,
        piva,
        image_url,
        updated_at
    )
values
    (
        'Azienda agricola Garrasi Mario',
        'test@example.com',
        '1234567890',
        'Via Roma 1, 12345, Roma',
        '12345678901',
        '12345678901',
        'https://example.com/image.jpg',
        now ()
    ),
    (
        'Azienda agricola San Lio',
        'test@example.com',
        '92828282828',
        'Via vespri 2',
        '12345678901',
        '12345678901',
        '',
        now ()
    ),
    (
        'Azienda agricola F.lli Valenziani',
        'test2@example.com',
        '92828282828',
        'Via San lio, Carlentini',
        '12345678901',
        '12345678901',
        '',
        now ()
    );

-- Seed data for company_users table
insert into
    public.company_users (
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
        updated_at,
        turn_on_command,
        turn_off_command,
        mqtt_msg_name
    )
values
    (
        'Pompa 1',
        1000,
        100,
        1,
        now (),
        now (),
        '1',
        '2',
        'p1'
    ),
    (
        'Pompa 2',
        2000,
        200,
        1,
        now (),
        now (),
        '3',
        '4',
        'p2'
    ),
    (
        'Pompa 3',
        3000,
        300,
        2,
        now (),
        now (),
        '1',
        '2',
        'p3'
    ),
    (
        'Pompa 4',
        4000,
        400,
        2,
        now (),
        now (),
        '3',
        '4',
        'p4'
    ),
    (
        'Pompa 5',
        5000,
        500,
        3,
        now (),
        now (),
        '1',
        '2',
        'p5'
    ),
    (
        'Pompa 6',
        6000,
        600,
        3,
        now (),
        now (),
        '3',
        '4',
        'p6'
    );

-- Seed data for pump_statuses table
insert into
    public.pump_statuses (status, pump_id)
values
    ('1', 1),
    ('2', 1),
    ('3', 2),
    ('4', 2),
    ('5', 3),
    ('6', 3),
    ('7', 4),
    ('8', 4),
    ('9', 5),
    ('10', 5),
    ('11', 6),
    ('12', 6);

-- Seed data for pump_pressures table
insert into
    public.pump_pressures (pressure, pump_id)
values
    (1.2, 1),
    (1.1, 1),
    (1.5, 1),
    (1.3, 2),
    (1.4, 2),
    (1.6, 2),
    (1.7, 3),
    (1.8, 3),
    (1.9, 3),
    (1.2, 4),
    (1.3, 4),
    (1.4, 4),
    (1.5, 5),
    (1.6, 5),
    (1.7, 5),
    (1.8, 6),
    (1.9, 6),
    (1.2, 6);

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
        updated_at,
        mqtt_msg_name
    )
values
    (
        'ME7',
        100,
        20,
        2,
        'pivot',
        'well',
        '1',
        '2',
        'casa me8',
        1,
        2,
        1,
        now (),
        'me7'
    ),
    (
        'ME8',
        300,
        25,
        3,
        'rotolo',
        'lake',
        '3',
        '4',
        '',
        1,
        1,
        1,
        now (),
        'me8'
    ),
    (
        'san lio basso',
        400,
        100,
        2,
        'rotolo',
        'lake',
        '1',
        '2',
        '',
        2,
        1,
        2,
        now (),
        'slb'
    ),
    (
        'san lio alto',
        500,
        200,
        3,
        'pivot',
        'well',
        '3',
        '4',
        '',
        2,
        2,
        2,
        now (),
        'sla'
    ),
    (
        'valenziani',
        600,
        300,
        4,
        'pivot',
        'well',
        '1',
        '2',
        '',
        3,
        1,
        3,
        now (),
        'valen1'
    ),
    (
        'valenziani 2',
        700,
        400,
        5,
        'rotolo',
        'lake',
        '3',
        '4',
        '',
        3,
        2,
        3,
        now (),
        'valen2'
    );

-- Seed data for sector_pumps table
insert into
    public.sector_pumps (sector_id, pump_id)
values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);

-- Seed data for sector_pressures table
insert into
    public.sector_pressures (pressure, sector_id)
values
    (1.2, 1),
    (1.1, 1),
    (0.9, 1),
    (1.3, 2),
    (1.4, 2),
    (1.6, 2),
    (1.7, 3),
    (1.8, 3),
    (1.9, 3),
    (1.2, 4),
    (1.3, 4),
    (1.4, 4),
    (1.5, 5),
    (1.6, 5),
    (1.7, 5),
    (1.8, 6),
    (1.9, 6),
    (1.2, 6);

-- Seed data for sector_statuses table
insert into
    public.sector_statuses (status, sector_id)
values
    ('1', 1),
    ('2', 1),
    ('3', 2),
    ('4', 2),
    ('5', 3),
    ('6', 3),
    ('7', 4),
    ('8', 4),
    ('9', 5),
    ('10', 5),
    ('11', 6),
    ('12', 6);

-- Seed data for collector table
insert into
    public.collectors (
        name,
        connected_filter_name,
        updated_at,
        company_id,
        mqtt_msg_name
    )
values
    ('S1 (cisterne)', 'filtro s1', now (), 1, 's1'),
    ('S2 (pozzo)', 'filtro s2', now (), 1, 's2'),
    ('S3 (lago)', 'filtro s3', now (), 2, 's3'),
    ('S4 (cisterne)', 'filtro s4', now (), 2, 's4'),
    ('S5 (pozzo)', 'filtro s5', now (), 3, 's5'),
    ('S6 (lago)', 'filtro s6', now (), 3, 's6');

-- Seed data for collector_sectors table
insert into
    public.collector_sectors (collector_id, sector_id)
values
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);

-- Seed data for boards table
insert into
    public.boards (
        name,
        model,
        serial_number,
        collector_id,
        company_id,
        updated_at,
        mqtt_msg_name
    )
values
    (
        'arduino mkr 3',
        'mkr 3',
        '1234567890',
        1,
        1,
        now (),
        'mkr 3'
    ),
    (
        'arduino mkr 4',
        'mkr 4',
        '1234567891',
        2,
        1,
        now (),
        'mkr 4'
    ),
    (
        'arduino mkr 5',
        'mkr 5',
        '1234567892',
        3,
        2,
        now (),
        'mkr 5'
    ),
    (
        'arduino mkr 6',
        'mkr 6',
        '1234567893',
        4,
        2,
        now (),
        'mkr 6'
    ),
    (
        'arduino mkr 7',
        'mkr 7',
        '1234567894',
        5,
        3,
        now (),
        'mkr 7'
    ),
    (
        'arduino mkr 8',
        'mkr 8',
        '1234567895',
        6,
        3,
        now (),
        'mkr 8'
    );

-- Seed data for board_statuses table
insert into
    public.board_statuses (battery_level, board_id)
values
    (0.2, 1),
    (0.1, 1),
    (0.3, 2),
    (0.4, 2),
    (0.5, 3),
    (0.6, 3),
    (0.7, 4),
    (0.8, 4),
    (0.9, 5),
    (0.2, 5),
    (0.3, 6),
    (0.4, 6),
    (0.3, 2),
    (0.4, 3),
    (0.5, 4),
    (0.6, 5),
    (0.7, 6);

-- Seed data for collector_pressures table
insert into
    public.collector_pressures (
        filter_in_pressure,
        filter_out_pressure,
        collector_id
    )
values
    (1.2, 1.1, 1),
    (1.0, 1.0, 1),
    (1.3, 1.2, 1),
    (1.3, 1.2, 2),
    (1.4, 1.3, 2),
    (1.6, 1.5, 2),
    (1.7, 1.6, 3),
    (1.8, 1.7, 3),
    (1.9, 1.8, 3),
    (1.2, 1.1, 4),
    (1.3, 1.2, 4),
    (1.4, 1.3, 3),
    (1.5, 1.4, 4),
    (1.6, 1.5, 5),
    (1.7, 1.6, 6);

-- Seed data for pump_flows table
insert into
    public.pump_flows (flow, pump_id)
values
    (100, 1),
    (200, 1),
    (300, 2),
    (400, 2),
    (500, 3),
    (600, 3),
    (700, 4),
    (800, 4),
    (900, 5),
    (1000, 5),
    (1100, 6),
    (1200, 6);

-- Seed data for terminal_pressures table
insert into
    public.terminal_pressures (pressure, collector_id)
values
    (1.2, 1),
    (1.1, 1),
    (1.3, 2),
    (1.4, 2),
    (1.6, 2),
    (1.7, 3),
    (1.8, 3),
    (1.9, 3),
    (1.2, 4),
    (1.3, 4),
    (1.4, 4),
    (1.5, 5),
    (1.6, 5),
    (1.7, 5),
    (1.8, 6),
    (1.9, 6),
    (1.2, 6);