DROP VIEW IF EXISTS Trial_Balance;
CREATE VIEW IF NOT EXISTS Trial_Balance as
-- CREATE TB
-- select all sales
select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Invoice_Trans
group by line_coa_id

-- select all purchases
union all

select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Bill_Trans
group by line_coa_id

-- select all received money
union all

select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Received_Money_Trans
group by line_coa_id

-- select all spent money
union all

select
    line_coa_id as acct_code,
    line_coa_name as acct_name,
    (case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as debit_bal,
    (case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as credit_bal
from Spent_Money_Trans
group by line_coa_id

-- select all AP
union all

select
    ap_account as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Bill_Trans
where status = "0"

-- select all AR
union all

select
    ar_account as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Invoice_Trans
where status = "0"


-- select all bill_payments
union all

select
    bank_account as acct_code,
    bank_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Bill_Trans
where status = "1"

-- select all invoice_payments
union all

select
    bank_account as acct_code,
    bank_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Invoice_Trans
where status = "1"


-- select all received_money
union all

select
    coa_id as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Received_Money_Trans

-- select all spent_money
union all

select
    coa_id as acct_code,
    coa_name as acct_name,
    -(case when sum(line_amount) < 0 then sum(line_amount) else 0 end) as debit_bal,
    -(case when sum(line_amount) > 0 then sum(line_amount) else 0 end) as credit_bal
from Spent_Money_Trans


order by acct_code