-- 06_product_scorecard.sql
-- Business question: How does each product compare on defects, backlog and satisfaction?
-- Creates the view dbo.vw_product_scorecard (one row per product), used by Power BI in Stage 4.

USE TicketSupport;
GO

CREATE OR ALTER VIEW dbo.vw_product_scorecard AS
WITH product_stats AS (
    -- Step 1: count everything once per product
    SELECT
        product,
        COUNT(*)                                                                                AS total_tickets,
        SUM(CASE WHEN issue_category = 'Product defect' THEN 1 ELSE 0 END)                      AS defect_tickets,
        SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END) AS backlog_tickets,
        COUNT(csat)                                                                             AS closed_tickets,
        AVG(csat * 1.0)                                                                         AS avg_csat_raw
    FROM dbo.tickets
    GROUP BY product
)
-- Step 2: turn the counts into rates and rank the products
SELECT
    product,
    total_tickets,
    defect_tickets,
    CAST(100.0 * defect_tickets  / total_tickets AS DECIMAL(5,1)) AS defect_pct,
    CAST(100.0 * backlog_tickets / total_tickets AS DECIMAL(5,1)) AS backlog_pct,
    closed_tickets,
    CAST(avg_csat_raw AS DECIMAL(4,2))                            AS avg_csat,
    RANK() OVER (ORDER BY 1.0 * defect_tickets / total_tickets DESC) AS defect_rank
FROM product_stats;
GO

-- Check: 42 rows, Samsung Galaxy first (49.5%, rank 1)
SELECT *
FROM dbo.vw_product_scorecard
ORDER BY defect_rank, product;

-- Note: RANK (not ROW_NUMBER) so that products with exactly the same defect rate share a rank.
-- The CTE (WITH product_stats AS ...) counts once and reuses the results, instead of
--   repeating the same CASE WHEN expressions as in 03_products.sql.
