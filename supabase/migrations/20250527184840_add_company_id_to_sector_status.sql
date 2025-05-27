-- Step 1: Add the new column
ALTER TABLE sector_statuses ADD COLUMN company_id int;

-- Step 2: Add foreign key constraint (after filling data)
-- But hold off this until values are populated

-- Update company_id in sector_statuses from sectors table
UPDATE sector_statuses
SET company_id = sectors.company_id
FROM sectors
WHERE sector_statuses.sector_id = sectors.id;

-- Now add foreign key constraint
ALTER TABLE sector_statuses
ADD CONSTRAINT fk_company
FOREIGN KEY (company_id) REFERENCES companies(id);