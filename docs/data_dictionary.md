# Data Dictionary — `data/clean/tickets_clean.csv`

8,469 rows, one per support ticket. UTF-8, comma-separated. Empty cells are nulls.
Produced by the Power Query query `tickets_clean` in `excel/ticket_analysis.xlsx`; every step is explained in [data_quality_log.md](data_quality_log.md).

| Column | Type | Description | Example | Nulls |
|---|---|---|---|---|
| `ticket_id` | integer | Unique ticket identifier | 1 | 0 |
| `customer_age` | integer | Customer age in years (18–70) | 32 | 0 |
| `customer_gender` | text | Male / Female / Other | Other | 0 |
| `product` | text | Product the ticket is about (42 products) | GoPro Hero | 0 |
| `purchase_date` | date (yyyy-mm-dd) | Date the product was purchased (2020-01-01 to 2021-12-30) | 2021-03-22 | 0 |
| `ticket_type` | text | Type chosen when the ticket was opened (5 types) | Technical issue | 0 |
| `ticket_subject` | text | Specific subject of the problem (16 subjects) | Product setup | 0 |
| `issue_category` | text | Derived from `ticket_subject`: Product defect / Usage & setup / Service & billing (mapping in `data/reference/subject_mapping.csv`) | Usage & setup | 0 |
| `ticket_status` | text | Open / Pending Customer Response / Closed | Pending Customer Response | 0 |
| `priority` | text | Low / Medium / High / Critical | Critical | 0 |
| `priority_order` | integer | Sort key for priority: Low=1, Medium=2, High=3, Critical=4 | 4 | 0 |
| `channel` | text | Email / Phone / Chat / Social media | Social media | 0 |
| `first_response_at` | datetime (yyyy-mm-dd hh:mm:ss) | Timestamp of the first support response. **Not used for analysis** (see log #11) | 2023-06-01 12:15:36 | 2,819 (Open tickets) |
| `resolved_at` | datetime (yyyy-mm-dd hh:mm:ss) | Timestamp of resolution. **Not used for analysis** (see log #11) | 2023-06-01 18:05:38 | 5,700 (Open + Pending) |
| `csat` | integer 1–5 | Customer satisfaction rating, only given after a ticket is closed | 4 | 5,700 (Open + Pending) |
| `age_group` | text | Age band: 18-24, 25-34, 35-44, 45-54, 55-64, 65+ | 25-34 | 0 |
