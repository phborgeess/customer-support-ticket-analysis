# Stage 2 — LinkedIn post (published)

**Images:** `images/stage2_backlog_priority.png`, `images/stage2_product_scorecard.png`

---

Marking a ticket as "Critical" didn't make it move any faster.

Stage 2 of my customer support project: after cleaning 8,469 tickets in Excel, I moved to SQL Server to answer the Head of Support's questions.

First, I built a script that loads the clean CSV, validates every row, and can be re-run without duplicating anything.

Then the questions:

🔹 Which products cause the most trouble? Canon EOS had the most tickets (240), but that doesn't make it the worst. It may simply sell more, and I have no sales data. So I compared the share of each product's tickets that were defects instead. Samsung Galaxy stood out at 49.5%, 12 points above the 37.4% average.

🔹 Where are tickets getting stuck? Two in three tickets are still unresolved. The surprise: Critical tickets (65.9% backlog) are stuck almost as often as Low ones (68.8%). Priority isn't changing how work gets done.

🔹 What drives satisfaction? My first query said the average was 2. The real answer was 2.99. SQL divides integers as integers, so AVG(csat * 1.0) fixed it. Small detail, big difference.

One honest caveat: each product has only about 200 tickets, so some of these gaps could be chance. That's Stage 3: testing them statistically in Python.

(Bonus: SSMS broke mid-project and I had to reinstall it. Also part of the job. 😅)

#SQL #SQLServer #DataAnalytics #DataAnalysis #LearningInPublic

---

**Note:** markdown bold did not render on LinkedIn, and engagement was much lower than the Stage 1 post. Future posts use plain text, no emoji bullets, and a more personal, conversational tone.
