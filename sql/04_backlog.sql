-- 04_backlog.sql
-- Business question: Where are tickets getting stuck?
-- Backlog = tickets not yet closed (Open or Pending Customer Response).

USE TicketSupport;
GO

-- 1. Overall backlog
SELECT
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END) AS backlog_tickets,
    CAST(100.0 * SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS backlog_pct
FROM dbo.tickets;

-- 2. Backlog by priority: are critical tickets being handled first?
SELECT
    priority,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END) AS backlog_tickets,
    CAST(100.0 * SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS backlog_pct
FROM dbo.tickets
GROUP BY priority, priority_order
ORDER BY priority_order DESC;

-- 3. Backlog by channel: is any channel getting stuck more than the others?
SELECT
    channel,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END) AS backlog_tickets,
    CAST(100.0 * SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS backlog_pct
FROM dbo.tickets
GROUP BY channel
ORDER BY backlog_pct DESC;

-- 4. Backlog by issue category: do some types of problem get stuck more?
SELECT
    issue_category,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END) AS backlog_tickets,
    CAST(100.0 * SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS backlog_pct
FROM dbo.tickets
GROUP BY issue_category
ORDER BY backlog_pct DESC;

-- 5. Backlog by product: which products have the most unresolved tickets?
SELECT
    product,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END) AS backlog_tickets,
    CAST(100.0 * SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS backlog_pct
FROM dbo.tickets
GROUP BY product
ORDER BY backlog_pct DESC;

-- 6. Does complexity explain the priority result? Critical vs Low within each issue category
--    (issue_category is used as a rough proxy for complexity; there is no complexity field)
SELECT
    issue_category,
    priority,
    COUNT(*) AS total_tickets,
    CAST(100.0 * SUM(CASE WHEN ticket_status IN ('Open', 'Pending Customer Response') THEN 1 ELSE 0 END)
         / COUNT(*) AS DECIMAL(5,1)) AS backlog_pct
FROM dbo.tickets
WHERE priority IN ('Critical', 'Low')
GROUP BY issue_category, priority, priority_order
ORDER BY issue_category, priority_order DESC;

-- Finding: two in three tickets are still unresolved (67.3% backlog, 5,700 of 8,469).
-- Priority barely changes this: Critical 65.9% vs Low 68.8%, only ~3 points apart,
--   so marking a ticket as Critical does not seem to move it faster.
-- Channel (66.4%-67.8%) and issue category (66.6%-68.7%) make almost no difference:
--   the backlog is a general problem, not one channel or problem type.
-- Within each issue category the Critical vs Low gap stays small (1.6 to 5.2 points),
--   so problem type (a proxy for complexity) does not explain the priority result.
-- By product the spread is wider: Nintendo Switch Pro Controller 75.9% vs Microsoft Office 60.0%.
--   High backlog and high defect share are different problems (the Switch Pro Controller is not
--   among the high-defect products), so they may need different actions.
-- Caveat: about 200 tickets per product and synthetic data; Stage 3 tests whether
--   these differences are real or just chance.
