-- 01_setup.sql
-- Creates the TicketSupport database and loads the clean dataset.

IF DB_ID('TicketSupport') IS NULL
    CREATE DATABASE TicketSupport;
GO

USE TicketSupport;
GO
DROP TABLE IF EXISTS dbo.tickets;

CREATE TABLE dbo.tickets (
    ticket_id          INT            PRIMARY KEY,
    customer_age       INT,
    customer_gender    NVARCHAR(50),
    product            NVARCHAR(100),
    purchase_date      DATE,
    ticket_type        NVARCHAR(50),
    ticket_subject     NVARCHAR(50),
    ticket_status      NVARCHAR(50),
    priority           NVARCHAR(50),
    channel            NVARCHAR(50),
    first_response_at  DATETIME2(0),
    resolved_at        DATETIME2(0),
    csat               TINYINT,
    age_group          NVARCHAR(50),
    priority_order     TINYINT,
    issue_category     NVARCHAR(50)
);

BULK INSERT dbo.tickets
FROM 'C:\Users\Phbor\Documents\Project-TicketSuport\data\clean\tickets_clean.csv'
WITH (
    FORMAT    = 'CSV',
    FIRSTROW  = 2,
    CODEPAGE  = '65001'
);

-- Validation: expected 8469 | 2769 | 5650 | 2020-01-01
SELECT
    COUNT(*)                 AS total_rows,
    COUNT(csat)              AS rated_tickets,
    COUNT(first_response_at) AS responded_tickets,
    MIN(purchase_date)       AS first_purchase
FROM dbo.tickets;
