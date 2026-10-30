-- 02_overview.sql
-- Business question: What does our support workload look like?

USE TicketSupport;
GO

-- 1. Tickets by status
SELECT
    ticket_status,
    COUNT(*) AS tickets
FROM dbo.tickets
GROUP BY ticket_status
ORDER BY tickets DESC;

-- 2. Tickets by issue category, with % of all tickets
SELECT
    issue_category,
    COUNT(*) AS tickets,
    CAST(100.0 * COUNT(*) / (SELECT COUNT(*) FROM dbo.tickets) AS DECIMAL(5,1)) AS pct_of_total
FROM dbo.tickets
GROUP BY issue_category
ORDER BY tickets DESC;

-- 3. Tickets by channel, with % of all tickets
SELECT
    channel,
    COUNT(*) AS tickets,
    CAST(100.0 * COUNT(*) / (SELECT COUNT(*) FROM dbo.tickets) AS DECIMAL(5,1)) AS pct_of_total
FROM dbo.tickets
GROUP BY channel
ORDER BY tickets DESC;

-- 4. Tickets by priority, with % of all tickets
SELECT
    priority,
    COUNT(*) AS tickets,
    CAST(100.0 * COUNT(*) / (SELECT COUNT(*) FROM dbo.tickets) AS DECIMAL(5,1)) AS pct_of_total
FROM dbo.tickets
GROUP BY priority, priority_order
ORDER BY priority_order DESC;
