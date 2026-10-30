-- 03_products.sql
-- Business question: Which products cause the most problems for support,
-- and what kind of problems?

USE TicketSupport;
GO

-- 1. Tickets per product (all issue types)
SELECT
    product,
    COUNT(*) AS total_tickets
FROM dbo.tickets
GROUP BY product
ORDER BY total_tickets DESC;

-- 2. Share of each product's tickets that are product defects
SELECT
    product,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN issue_category = 'Product defect' THEN 1 ELSE 0 END) AS defect_tickets,
    CAST(100.0 * SUM(CASE WHEN issue_category = 'Product defect' THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS defect_pct
FROM dbo.tickets
GROUP BY product
ORDER BY defect_pct DESC;

-- 3. Products whose defect share is more than 5 points above the overall rate (37.4%)
SELECT
    product,
    COUNT(*) AS total_tickets,
    CAST(100.0 * SUM(CASE WHEN issue_category = 'Product defect' THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS defect_pct,
    CAST(100.0 * SUM(CASE WHEN issue_category = 'Product defect' THEN 1 ELSE 0 END) / COUNT(*)
         - 100.0 * (SELECT COUNT(*) FROM dbo.tickets WHERE issue_category = 'Product defect')
                 / (SELECT COUNT(*) FROM dbo.tickets)
         AS DECIMAL(5,1)) AS points_above_avg
FROM dbo.tickets
GROUP BY product
HAVING 100.0 * SUM(CASE WHEN issue_category = 'Product defect' THEN 1 ELSE 0 END) / COUNT(*)
     - 100.0 * (SELECT COUNT(*) FROM dbo.tickets WHERE issue_category = 'Product defect')
             / (SELECT COUNT(*) FROM dbo.tickets) > 5
ORDER BY points_above_avg DESC;


-- Finding: two products stand out on defect share (overall: 37.4%):
--   Samsung Galaxy 49.5% (+12.0 pts, n = 194) and Sony 4K HDR TV 42.9% (+5.4 pts, n = 210).
--   Google Nest is borderline (+4.98 pts, just under the 5-point cut-off).
--   Points above average are calculated from exact values, not the rounded percentages.
-- Meaning: for these products, more of their tickets are product defects rather than
--   service issues, so the conversation is with the product team, not the support team.
-- Why share, not volume: Canon EOS has the most tickets (240) but may simply sell more;
--   without sales data, ticket volume is not a fair comparison.
-- Caveat: samples are small and the data is synthetic; Stage 3 tests whether these
--   differences are statistically significant or just chance.
