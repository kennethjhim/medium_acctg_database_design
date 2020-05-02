DROP VIEW IF EXISTS Invoice_Trans;

CREATE VIEW IF NOT EXISTS Invoice_Trans AS

with recursive

itrans as (SELECT
    'INV'||i.id as `tran_id`,
    i.tran_date,
    i.coa_id as ar_account,
    -- ABS(total) as `total`,
    'Accounts Receivable' as `coa_name`,
    i.total,
    il.id  as `line_id`,
    il.line_coa_id,
    il.line_amount,
    ip.id,
    ip.coa_id as bank_account,
    'Business Bank Account' as `bank_name`,
    i.status
from Invoices as i
left join Invoice_Lines as il on i.id = il.invoice_id
left join COA as c on i.coa_id = c.id
left join Invoice_Payments as ip on i.invoice_payment_id = ip.id
)

select
itrans.*,
c.name as `line_coa_name`
from itrans
left join COA as c on itrans.line_coa_id = c.id;

SELECT * from Invoice_Trans;

****************************************************************************

DROP VIEW IF EXISTS Bill_Trans;

CREATE VIEW IF NOT EXISTS Bill_Trans AS

with recursive

btrans as (SELECT
    'BILL'||b.id as `tran_id`,
    b.tran_date,
    b.coa_id as ap_account,
    -- ABS(total) as `total`,
    'Accounts Payable' as `coa_name`,
    b.total,
    bl.id  as `line_id`,
    bl.line_coa_id,
    bl.line_amount,
    bp.id,
    bp.coa_id as bank_account,
    'Business Bank Account' as `bank_name`,
    b.status
from Bills as b
left join Bill_Lines as bl on b.id = bl.bill_id
left join COA as c on b.coa_id = c.id
left join Bill_Payments as bp on b.bill_payment_id = bp.id
)

select
btrans.*,
c.name as `line_coa_name`
from btrans
left join COA as c on btrans.line_coa_id = c.id;

SELECT * from Bill_Trans;


****************************************************************************

DROP VIEW IF EXISTS Received_Money_Trans;

CREATE VIEW IF NOT EXISTS Received_Money_Trans AS
SELECT
    'RM'||rm.id as `tran_id`,
    tran_date,
    coa_id,
    'Business Bank Account' as `coa_name`,
    total,
    rml.id  as `line_id`,
    rml.line_coa_id,
    c.name as `line_coa_name`,
    rml.line_amount
from Received_Moneys as rm
left join Received_Money_Lines as rml on rm.id = rml.received_money_id
left join COA  as c on c.id = rml.line_coa_id;

SELECT * from Received_Money_Trans;

****************************************************************************

DROP VIEW IF EXISTS Spent_Money_Trans;

CREATE VIEW IF NOT EXISTS Spent_Money_Trans AS
SELECT
    'SM'||sm.id as `tran_id`,
    tran_date,
    coa_id,
    'Business Bank Account' as `coa_name`,
    total,
    sml.id  as `line_id`,
    sml.line_coa_id,
    c.name as `line_coa_name`,
    sml.line_amount
from Spent_Moneys as sm
left join Spent_Money_Lines as sml on sm.id = sml.spent_money_id
left join COA  as c on c.id = sml.line_coa_id;

SELECT * from Spent_Money_Trans;


