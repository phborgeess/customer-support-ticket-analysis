# Data Quality Log

Every issue found in the raw data and the decision taken, in order.

| # | Column | Issue found | Decision | Reason |
|---|--------|-------------|----------|--------|
| 1 | Ticket Description | 6,150 descriptions contain line breaks inside quoted fields; opening the CSV directly in Excel can split rows | Load the file only through Power Query (UTF-8, comma delimiter) | Keeps the row count at 8,469 and the text intact |
| 2 | All typed columns | Windows regional settings can misread `3.0` or `2021-03-22` | Set data types with *Change Type → Using Locale → English (United States)* | Values are stored in US format; checked CSAT = 1–5, purchase dates 2020-01-01 to 2021-12-30, age 18–70 |
| 3 | Resolution | 5,700 blanks were imported as empty strings (`""`), not nulls, so they were counted as filled | *Replace Values* `""` → `null` in Power Query | Text columns import blanks as empty text; date and number columns convert blanks to null automatically. Without this, null counts are wrong |
| 4 | Resolution, Time to Resolution, Customer Satisfaction Rating, First Response Time | ~5,700 blank values. Profiling by `Ticket Status`: Closed (2,769) has every field filled; Pending Customer Response (2,881) has no resolution, resolution time or rating; Open (2,819) also has no first response | Keep as nulls — no deletion, no imputation | Blanks belong to tickets that are not finished yet, so they are expected, not errors. Deleting would remove two-thirds of the tickets; filling would invent resolutions and ratings that never happened |
| 5 | Whole dataset | Signs of synthetic data: categories split ~25% each (gender, channel, priority, type); all 8,469 descriptions contain the template text `{product_purchased}`; 139 emails appear on more than one ticket | Treat findings with caution; validate differences before presenting them (Stage 3) | Synthetic data tends to show weak patterns; stating this openly avoids presenting random noise as insight |
