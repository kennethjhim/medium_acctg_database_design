DROP TABLE IF EXISTS `COA`;

CREATE TABLE IF NOT EXISTS `COA` (
    id INTEGER PRIMARY KEY,
    name TEXT
);


DROP TABLE IF EXISTS `Customers`;

CREATE TABLE IF NOT EXISTS `Customers` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    contact_person TEXT,
    email TEXT,
    phone TEXT,
    fax TEXT,
    address TEXT
);

DROP TABLE IF EXISTS `Invoice_Payments`;

CREATE TABLE IF NOT EXISTS `Invoice_Payments` (
    id INTEGER PRIMARY KEY,
    tran_date DATE NOT NULL,
    description TEXT,
    reference TEXT,
    total DECIMAL(20,2) NOT NULL,
    coa_id INTEGER NOT NULL, -- automatically Bank
    FOREIGN KEY(`coa_id`) REFERENCES `COA`(`id`)
);

DROP TABLE IF EXISTS `Invoices`;

CREATE TABLE IF NOT EXISTS `Invoices` (
    id INTEGER PRIMARY KEY,
    tran_date DATE NOT NULL,
    due_date DATE,
    description TEXT,
    reference TEXT,
    total DECIMAL(10,2) NOT NULL,
    status BOOLEAN,
    customer_id INTEGER,
    invoice_payment_id INTEGER,
    coa_id INTEGER NOT NULL, -- automatically AR
    FOREIGN KEY(`customer_id`) REFERENCES `Customers`(`id`),
    FOREIGN KEY(`invoice_payment_id`) REFERENCES `Invoice_Payments`(`id`),
    FOREIGN KEY(`coa_id`) REFERENCES `COA`(`id`)
);


DROP TABLE IF EXISTS `Received_Moneys`;

CREATE TABLE IF NOT EXISTS `Received_Moneys` (
    id INTEGER PRIMARY KEY,
    tran_date DATE NOT NULL,
    description TEXT,
    reference TEXT,
    total DECIMAL(20,2) NOT NULL,
    customer_id INTEGER,
    coa_id INTEGER NOT NULL, -- automatically Bank
    FOREIGN KEY(`customer_id`) REFERENCES `Customers`(`id`),
    FOREIGN KEY(`coa_id`) REFERENCES `COA`(`id`)
);



DROP TABLE IF EXISTS `Invoice_Lines`;

CREATE TABLE IF NOT EXISTS `Invoice_Lines` (
    id INTEGER PRIMARY KEY,
    line_amount DECIMAL(20,2) NOT NULL,
    invoice_id INTEGER,
    line_coa_id INTEGER NOT NULL,
    FOREIGN KEY(`invoice_id`) REFERENCES `Invoices`(`id`),
    FOREIGN KEY(`line_coa_id`) REFERENCES `COA`(`id`)
);


DROP TABLE IF EXISTS `Received_Money_Lines`;

CREATE TABLE IF NOT EXISTS `Received_Money_Lines` (
    id INTEGER PRIMARY KEY,
    line_amount DECIMAL(20,2) NOT NULL,
    received_money_id INTEGER,
    line_coa_id INTEGER NOT NULL,
    FOREIGN KEY(`received_money_id`) REFERENCES `Received_Moneys`(`id`),
    FOREIGN KEY(`line_coa_id`) REFERENCES `COA`(`id`)
);

-- *********************************************************************

DROP TABLE IF EXISTS `Suppliers`;

CREATE TABLE IF NOT EXISTS `Suppliers` (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    contact_person TEXT,
    email TEXT,
    phone TEXT,
    fax TEXT,
    address TEXT
);

DROP TABLE IF EXISTS `Bill_Payments`;

CREATE TABLE IF NOT EXISTS `Bill_Payments` (
    id INTEGER PRIMARY KEY,
    tran_date DATE NOT NULL,
    description TEXT,
    reference TEXT,
    total DECIMAL(20,2) NOT NULL,
    coa_id INTEGER NOT NULL, -- automatically Bank
    FOREIGN KEY(`coa_id`) REFERENCES `COA`(`id`)
);


DROP TABLE IF EXISTS `Bills`;

CREATE TABLE IF NOT EXISTS `Bills` (
    id INTEGER PRIMARY KEY,
    tran_date DATE NOT NULL,
    due_date DATE,
    description TEXT,
    reference TEXT,
    total DECIMAL(10,2) NOT NULL,
    status BOOLEAN,
    supplier_id INTEGER,
    bill_payment_id INTEGER,
    coa_id INTEGER NOT NULL, -- automatically AP
    FOREIGN KEY(`supplier_id`) REFERENCES `Suppliers`(`id`),
    FOREIGN KEY(`bill_payment_id`) REFERENCES `Bill_Payments`(`id`),
    FOREIGN KEY(`coa_id`) REFERENCES `COA`(`id`)
);


DROP TABLE IF EXISTS `Spent_Moneys`;

CREATE TABLE IF NOT EXISTS `Spent_Moneys` (
    id INTEGER PRIMARY KEY,
    tran_date DATE NOT NULL,
    description TEXT,
    reference TEXT,
    total DECIMAL(20,2) NOT NULL,
    supplier_id INTEGER,
    coa_id INTEGER NOT NULL, -- automatically Bank
    FOREIGN KEY(`supplier_id`) REFERENCES `Suppliers`(`id`),
    FOREIGN KEY(`coa_id`) REFERENCES `COA`(`id`)
);


DROP TABLE IF EXISTS `Bill_Lines`;

CREATE TABLE IF NOT EXISTS `Bill_Lines` (
    id INTEGER PRIMARY KEY,
    line_amount DECIMAL(20,2) NOT NULL,
    bill_id INTEGER,
    line_coa_id INTEGER NOT NULL,
    FOREIGN KEY(`bill_id`) REFERENCES `Bills`(`id`),
    FOREIGN KEY(`line_coa_id`) REFERENCES `COA`(`id`)
);


DROP TABLE IF EXISTS `Spent_Money_Lines`;

CREATE TABLE IF NOT EXISTS `Spent_Money_Lines` (
    id INTEGER PRIMARY KEY,
    line_amount DECIMAL(20,2) NOT NULL,
    spent_money_id INTEGER,
    line_coa_id INTEGER NOT NULL,
    FOREIGN KEY(`spent_money_id`) REFERENCES `Spent_Moneys`(`id`),
    FOREIGN KEY(`line_coa_id`) REFERENCES `COA`(`id`)
);