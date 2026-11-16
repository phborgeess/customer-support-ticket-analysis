# Final LinkedIn post (Stages 5 + 6) — draft

**Images:** `images/stage4_overview.png` (main), slide 6 of `reports/executive_summary.pdf` (recommendations)
**Before posting:** replace GITHUB_LINK with the repository URL.

---

A few weeks ago I started a project with one goal: get better at the whole analysis workflow, not just one tool. It's finished, and everything is now on GitHub.

The setup was simple. 8,469 customer support tickets and one question from an imaginary Head of Support: which products cause the most problems, and are we handling tickets in the right order?

Here's how it went, step by step.

In Excel I cleaned the data and learned that not every blank is missing data. In SQL Server I answered the business questions. In Python I tested my own findings, and only one of three survived. In Power BI I put it all into a dashboard. And finally I wrote a short executive summary, because a manager won't read a notebook.

What the data says, in three lines: Samsung Galaxy is the one product with a real defect problem, marking a ticket as Critical doesn't get it resolved any faster, and the satisfaction differences between channels are just noise.

What I'm taking from it: the hardest and most valuable part wasn't any tool. It was deciding what not to say. Leaving out speed because the timestamps were broken, and dropping two "problem products" because the stats didn't back them up.

The repo has everything: the cleaning log, the SQL scripts, the notebook, the Power BI project and the slides.

GITHUB_LINK

Thanks to everyone who commented along the way, the questions made the project better. If you work with data, I'd love to hear what you'd have done differently.

#DataAnalytics #SQL #Python #PowerBI #LearningInPublic
