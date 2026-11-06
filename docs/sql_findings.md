# Stage 2 — SQL Findings

**Tool:** SQL Server 2025 (T-SQL), database `TicketSupport`, table `dbo.tickets` (8,469 rows loaded from `data/clean/tickets_clean.csv`).
**Stakeholder question:** *Which products are causing the most problems for support, and is it the product's fault or our service?*

> **Read with care:** the dataset is synthetic (see the [data quality log](data_quality_log.md), #5) and most groups contain only about 200 tickets. The differences below are **descriptive**; Stage 3 tests whether they are statistically significant.

## 1. Workload — `sql/02_overview.sql`

| Status | Tickets |
|---|---|
| Pending Customer Response | 2,881 |
| Open | 2,819 |
| Closed | 2,769 |

- **Product defects are the largest group: 3,171 tickets (37.4%)**, ahead of Service & billing (31.4%) and Usage & setup (31.2%).
- Channel and priority are split almost exactly 25% each. Real support volumes are rarely this even, which is another sign of synthetic data.

## 2. Products — `sql/03_products.sql`

Ticket **volume** is not a fair comparison: Canon EOS has the most tickets (240), but it may simply sell more, and there is no sales data. Instead, the analysis compares the **share of each product's tickets that are product defects**.

| Product | Tickets | Defect share | vs. average (37.4%) |
|---|---|---|---|
| Samsung Galaxy | 194 | **49.5%** | +12.0 pts |
| Sony 4K HDR TV | 210 | **42.9%** | +5.4 pts |
| Google Nest *(borderline)* | 198 | 42.4% | +4.98 pts |
| … | | | |
| HP Pavilion (lowest) | 200 | 31.0% | −6.4 pts |

**So what:** if the Samsung Galaxy and Sony 4K HDR TV gaps are confirmed, the conversation is with the **product team**, not the support team.

## 3. Backlog — `sql/04_backlog.sql`

- **Two in three tickets are unresolved: 67.3% backlog** (5,700 of 8,469).
- **Priority barely matters:** Critical 65.9% vs. Low 68.8%. Marking a ticket as Critical does not seem to move it faster. *This is the most actionable finding for the Head of Support.*
- **Complexity check:** there is no complexity field, so issue category serves as a rough proxy. Within each category, the Critical vs. Low gap stays small (Product defect 65.4% vs. 67.4%, Service & billing 67.3% vs. 72.5%, Usage & setup 65.1% vs. 66.7%), so problem type does not explain the priority result. Resource allocation cannot be tested, because there is no agent or team data.
- Channel (66.4–67.8%) and issue category (66.6–68.7%) make almost no difference, so the backlog is a general problem.
- By product the spread is wider: Nintendo Switch Pro Controller 75.9% vs. Microsoft Office 60.0%. A high backlog is a different problem from a high defect share; the Switch Pro Controller's defect share is a below-average 36.5%.

## 4. Satisfaction — `sql/05_satisfaction.sql`

- **Average CSAT: 2.99 / 5** (n = 2,769 closed tickets). Ratings are spread almost evenly from 1 to 5 (about 20% each).
- Issue category (2.98–3.01), channel (2.95–3.08; Chat is highest) and priority (2.96–3.05) barely move the score.
- By product: Fitbit Versa Smartwatch 2.54 (n = 63) is the lowest, and Google Pixel / Dyson Vacuum Cleaner 3.22 are the highest. With only 47–83 ratings per product, no product is called "the worst" yet.
- *SQL lesson:* `AVG(csat)` on an integer column returns **2**, not 2.99. Multiplying by `1.0` first fixes it.

## 5. Product scorecard — `sql/06_product_scorecard.sql`

The view `dbo.vw_product_scorecard` combines everything in one row per product (42 rows), using a CTE and `RANK()`:

`product · total_tickets · defect_tickets · defect_pct · backlog_pct · closed_tickets · avg_csat · defect_rank`

It is the input for the Power BI dashboard (Stage 4).

## What goes to Stage 3

**Answered in [stats_findings.md](stats_findings.md):** Samsung Galaxy is real (adjusted p = 0.019); there is no evidence that priority changes the backlog (p = 0.10); there is no evidence that satisfaction differs by product or channel.


1. Is Samsung Galaxy's 49.5% defect share significantly above the rest, or just chance?
2. Is the Critical vs. Low backlog gap (65.9% vs. 68.8%) real?
3. Do product CSAT differences survive a significance test, given 47–83 ratings per product?
