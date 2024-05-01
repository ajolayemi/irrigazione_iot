-- drop primary key index on board statuses
ALTER TABLE board_statuses
DROP CONSTRAINT board_statuses_pkey;

-- create a new one
ALTER TABLE board_statuses ADD PRIMARY KEY (id, created_at);

-- create hypertable for board_statuses
select
    create_hypertable (
        'board_statuses',
        'created_at',
        migrate_data => true
    );

-- drop collector pressures existing pkey index
ALTER TABLE collector_pressures
DROP constraint IF EXISTS collector_pressure_pkey;

-- create a new pkey index for collector_pressures
alter table collector_pressures add primary key (id, created_at);

-- create hypertable for collector pressures
select
    create_hypertable (
        'collector_pressures',
        'created_at',
        migrate_data => true
    );

-- drop pump_flows existing pkey index
ALTER TABLE pump_flows
DROP constraint IF EXISTS pump_flows_pkey;

-- create a new pkey index for pump_flows
alter table pump_flows add primary key (id, created_at);

-- create hypertable for pump_flows
select
    create_hypertable ('pump_flows', 'created_at', migrate_data => true);

-- drop pump pressures existing pkey index
ALTER TABLE pump_pressures
DROP constraint IF EXISTS pump_pressures_pkey;

-- create a new pkey index for pump_pressures
alter table pump_pressures add primary key (id, created_at);

-- create hypertable for pump_pressures
select
    create_hypertable (
        'pump_pressures',
        'created_at',
        migrate_data => true
    );

-- drop sector pressures existing pkey index
ALTER TABLE sector_pressures
DROP constraint IF EXISTS sector_pressures_pkey;

-- create a new pkey index for pump_pressures
alter table sector_pressures add primary key (id, created_at);

-- create hypertable for sector_pressures
select
    create_hypertable (
        'sector_pressures',
        'created_at',
        migrate_data => true
    );

-- drop terminal pressures existing pkey index
ALTER TABLE terminal_pressures
DROP constraint IF EXISTS terminal_pressure_pkey;

-- create a new pkey index for terminal_pressures
alter table terminal_pressures add primary key (id, created_at);

-- create hypertable for terminal_pressures
select
    create_hypertable (
        'terminal_pressures',
        'created_at',
        migrate_data => true
    );