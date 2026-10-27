# Stage 1 — LinkedIn post

**Images:** `images/stage1_column_quality.png` (optional: nulls-by-status pivot table)

---

**Not every blank is missing data.**

I'm building a personal analytics project with 8,469 customer support tickets from a fictional electronics company (public Kaggle dataset), and it's been challenging me a lot.

First, I had to choose a direction. You could ask this data a thousand questions, so I imagined a Head of Customer Support asking me one: *"Which products are causing the most problems — and is it the product's fault or our service?"*

Then I opened the data in Power Query and found 5,700 blank values. The easy move would have been to delete them.

Instead, I asked why they were blank. Every blank belonged to a ticket that wasn't finished yet: Open tickets had no response, resolution or rating, and only Closed tickets had every field filled. They weren't errors. They were telling me the status of the work.

The second surprise: in 1,365 closed tickets, the "resolution" happened before the first response. That's impossible, so I made a call: I won't analyse response speed at all. Sometimes the right answer is choosing not to answer a question your data can't support.

Every decision is documented in a data quality log.

Next step: SQL Server, to answer the business questions. 🔍

Have you ever found that the "problem" in your data was actually the story?

#DataAnalytics #DataCleaning #PowerQuery #Excel #LearningInPublic
