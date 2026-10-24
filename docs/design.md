# Customer Support Ticket Analysis — Project Design

*Status: approved 2026-10-24*

## 1. Intent

A portfolio and skill-building project for Data Analyst / BI Analyst roles in Ireland.
The author works on it about 2 hours a day, stage by stage. Each stage produces a
LinkedIn post, and the whole project is published as a professional GitHub repository
at the end.

The main goal is learning by doing: the author does the work and Claude acts as a mentor
who explains, reviews and suggests. Starting skill levels: Excel and Power BI
intermediate, SQL and Python basic, so the SQL and Python stages get step-by-step guidance.

## 2. Business case (fictional)

- **Company:** a fictional consumer-electronics retailer selling 42 products
  (cameras, smartphones, smart-home devices, etc.).
- **Stakeholder:** the Head of Customer Support.
- **Core question:** *Which products generate the most problems for support, and what
  kind of problems?*
- **Why it matters:** the Head of Support wants evidence to take to the leadership team
  and to hold the **product team** accountable with data rather than opinion.
- **Supporting questions:**
  - **Backlog:** are tickets for those products stuck in Open / Pending Customer Response?
  - **Satisfaction:** do customers of those products leave less satisfied?
  - **Nature of the issue:** is it a product defect (hardware, battery, software) or a
    service issue (billing, refunds, inquiries)? Only defects justify escalating to the
    product team.
- **Secondary (optional):** customer age group and gender.
- **Acceptable outcome:** "no product stands out" is a valid finding. If that happens,
  the project shows where the problem actually is.

## 3. Deliverables for the stakeholder

1. A **Power BI dashboard** for exploring and monitoring the data.
2. A short **executive summary** (slides or PDF) that tells the story and ends with a
   clear recommendation.

## 4. Dataset

`customer_support_tickets.csv`: 8,469 tickets, 17 columns, a public Kaggle-style dataset.

Known data-quality facts, which are the starting point for Stage 1:

- **Nulls are structural, tied to `Ticket Status`:**
  - Closed (2,769): every field is filled.
  - Pending Customer Response (2,881): no Resolution, Time to Resolution or Satisfaction.
  - Open (2,819): also no First Response Time.

  These nulls must not be dropped or imputed.
- **The time columns are timestamps, not durations.** Every value falls between
  2023-05-31 and 2023-06-02, while purchase dates are in 2020–2021. In 1,365 of the
  2,769 closed tickets, the resolution comes before the first response.
- **The data shows signs of being synthetic:**
  - Category splits are near-uniform (about 25% each for gender, channel, priority and
    type).
  - Every description contains the template text `{product_purchased}`.
  - Expect weak patterns. The project states this openly and treats it as a strength:
    documented decisions and validated findings.
- **Personal data:** customer names and emails look fake, but they are dropped or
  masked in any published output anyway, as good practice.

## 5. Stages

| # | Stage | Tool | Output | LinkedIn post angle |
|---|-------|------|--------|---------------------|
| 1 | Data understanding & cleaning | Excel + Power Query | Cleaned dataset + data-quality log | "Not every null is missing data" |
| 2 | Business questions in SQL | Microsoft SQL Server (T-SQL) | Commented `.sql` queries + results | 2–3 key findings |
| 3 | Is it real or noise? | Python (pandas, Jupyter, guided) | Notebook testing whether product differences are statistically meaningful | "How I checked my findings before presenting them" |
| 4 | Dashboard | Power BI | `.pbix` + screenshots | Dashboard walkthrough |
| 5 | Executive summary | Slides / PDF | Recommendation for leadership | Conclusions |
| 6 | Publish | GitHub | Professional repo + README telling the full story | Final post with link |

Tools follow the questions. If a stage turns out not to need its tool, it changes.
The rough estimate is 2–4 sessions each for Stages 1, 2 and 4, and 1–2 sessions each
for Stages 3, 5 and 6.

## 6. Constraints

- All published material is in **English**: repo, README, code, comments and posts.
- Free tools only (Excel, Power BI Desktop and Microsoft SQL Server are already installed).
- Each stage must end with something that can be shown.
- Every cleaning and analysis decision is written down, since that log feeds the
  README and the posts.

## 7. Non-goals and anti-goals

- **Non-goals:**
  - Using every tool just to tick a box.
  - Machine-learning models.
  - Text mining of the templated descriptions.
- **Anti-goals:** the project fails, even if it technically works, if it:
  - presents random differences as real insights;
  - hides the data-quality problems;
  - consists of charts without a recommendation;
  - is work Claude did that the author cannot explain in an interview.

## 8. Left to decide during the work

- How to treat the time columns in Stage 1: derive durations, flag them as unreliable,
  or exclude them from the speed analysis. The author decides this with guidance; it
  is a learning moment.
- Final GitHub folder structure. Claude proposes it in Stage 6. A working draft:
  `data/raw`, `data/clean`, `excel/`, `sql/`, `notebooks/`, `powerbi/`, `reports/`,
  `images/`, `docs/`.
- Visual style of the dashboard and slides.

### Calls made by Claude (please check)

- Product defect vs. service issue is the main analytical split.
- Personal data (names, emails) is dropped or masked in published outputs.
- This document lives in `docs/design.md` and later feeds the README.
