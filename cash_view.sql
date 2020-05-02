DROP VIEW IF EXISTS Cash_Trans;

CREATE VIEW IF NOT EXISTS Cash_Trans AS
select
    tran_date,
    coa_id,
    'Business Bank Account' as `coa_name`,
    total,
    Cash_Lines.id  as `line_id`,
    line_coa_id,
    -- COALESCE(sales_account_id, line_account_id) as `line_account_id`,
    COA.name as `line_coa_name`,
    COA.type as `line_coa_type`,
    -- Items.inventory_account_id as `inventory_account_id`,
    qty,
    unit_price,
    -- ABS(line_amount) as `line_amount`
    line_amount
from Cash_Lines
left join Cash on Cash_Lines.cash_id = Cash.id
left join COA on Cash_Lines.line_coa_id = COA.id;

select * from Cash_Trans;