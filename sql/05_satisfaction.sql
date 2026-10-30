-- 05_satisfaction.sql
-- Business question: What drives low customer satisfaction?
-- CSAT (1-5) only exists for Closed tickets (2,769), so every query here
-- works on rated tickets only; AVG ignores NULLs automatically.

USE TicketSupport;
GO

-- 1. Overall CSAT: the integer trap
-- csat is an integer column, so AVG(csat) returns an integer (2) instead of 2.99.
SELECT
    AVG(csat)                                 AS avg_csat_wrong,
    CAST(AVG(csat * 1.0) AS DECIMAL(4,2))     AS avg_csat,
    COUNT(csat)                               AS rated_tickets
FROM dbo.tickets;

-- 2. CSAT by issue category
SELECT
    issue_category,
    CAST(AVG(csat * 1.0) AS DECIMAL(4,2)) AS avg_csat,
    COUNT(csat)                           AS n
FROM dbo.tickets
WHERE csat IS NOT NULL
GROUP BY issue_category
ORDER BY avg_csat;

-- 3. CSAT by channel
SELECT
    channel,
    CAST(AVG(csat * 1.0) AS DECIMAL(4,2)) AS avg_csat,
    COUNT(csat)                           AS n
FROM dbo.tickets
WHERE csat IS NOT NULL
GROUP BY channel
ORDER BY avg_csat;

-- 4. CSAT by priority
SELECT
    priority,
    CAST(AVG(csat * 1.0) AS DECIMAL(4,2)) AS avg_csat,
    COUNT(csat)                           AS n
FROM dbo.tickets
WHERE csat IS NOT NULL
GROUP BY priority, priority_order
ORDER BY priority_order DESC;

-- 5. CSAT by product, lowest first (always read avg_csat together with n)
SELECT
    product,
    CAST(AVG(csat * 1.0) AS DECIMAL(4,2)) AS avg_csat,
    COUNT(csat)                           AS n
FROM dbo.tickets
WHERE csat IS NOT NULL
GROUP BY product
ORDER BY avg_csat, product;

-- 6. Rating distribution: how many 1s, 2s, ... 5s?
SELECT
    csat,
    COUNT(*)                                                       AS tickets,
    CAST(100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS DECIMAL(5,1)) AS pct
FROM dbo.tickets
WHERE csat IS NOT NULL
GROUP BY csat
ORDER BY csat;

-- Finding: average satisfaction is 2.99 out of 5 (n = 2,769 closed tickets).
-- Ratings are spread almost evenly from 1 to 5 (about 20% each), which is unusual for
--   real customers and another sign of synthetic data.
-- Issue category (2.98-3.01), channel (2.95-3.08, Chat highest) and priority (2.96-3.05)
--   barely move the score.
-- By product the range is wider: Fitbit Versa Smartwatch 2.54 (n = 63) vs Google Pixel /
--   Dyson Vacuum Cleaner 3.22, but each product has only 47-83 ratings, so no product
--   should be called "the worst" before Stage 3 tests these differences.
