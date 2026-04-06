# Amazon E-Commerce Sales Analysis

**Tools:** SQL · Power BI · Excel  
**Dataset:** 112,991 orders | 2015–2020  
**Domain:** E-Commerce · Business Intelligence · Sales Analytics

---

## 📌 Project Overview

This project analyzes **112,991 Amazon orders** spanning 5 years (2015–2020) to uncover revenue opportunities, identify underperforming categories, and expose logistics inefficiencies. Every finding is tied to a direct business recommendation.

---

## 🎯 Business Problems Solved

| # | Business Question | Finding |
|---|---|---|
| 1 | Which year drove the most growth? | 2020 was the **only growth year** — $24.0M revenue, +43% surge |
| 2 | Which product category is underperforming? | Health & Beauty at $11.9M vs $38.5M benchmark — **$26.6M gap** |
| 3 | Is international shipping causing customer loss? | **4× delay** — 15 days international vs 3.5 days domestic across 39,000 customers |

---

## 🔍 Key Findings

### 1. Revenue Analysis
- Analyzed revenue trends across 2015–2020
- **2020 flagged as the only growth year** ($24.0M, +43%)
- Built a data-backed framework to identify and replicate the triggers behind the 2020 surge
- All other years showed flat or declining revenue — signalling structural issues in product or marketing strategy

### 2. Category Gap Analysis
- Benchmarked all product categories against top performer
- **Health & Beauty** identified as the weakest category at $11.9M
- Quantified the **$26.6M revenue gap** against the $38.5M category benchmark
- Recommended targeted promotional intervention to close the gap

### 3. Shipping & Logistics Analysis
- Compared domestic vs international shipping times
- Discovered a **4× international shipping delay** — 15 days vs 3.5 days domestic
- Quantified the **retention risk across 39,000 international customers**
- Delivered a logistics optimization recommendation with projected impact on customer retention

---

## 🛠️ Tools & Techniques

| Tool | Usage |
|---|---|
| **SQL** | Data extraction, filtering, aggregation, joins |
| **Power BI** | Interactive dashboard, revenue trend visualization, category comparison |
| **Excel** | Data cleaning, pivot tables, preliminary analysis |

---

## 📁 Project Structure

```
Amazon-E-Commerce-Analysis/
│
├── data/
│   └── amazon_orders.csv          # Raw dataset (112,991 orders)
│
├── sql/
│   └── amazon_analysis.sql        # All SQL queries used
│
├── dashboard/
│   └── amazon_dashboard.pbix      # Power BI dashboard file
│
└── README.md
```
---

## 💡 Business Recommendations

1. **Replicate 2020 growth triggers** — investigate what drove the +43% surge (COVID demand, promotions, new categories) and build a repeatable playbook
2. **Invest in Health & Beauty** — targeted promotions and better product curation could close the $26.6M gap
3. **Overhaul international logistics** — partner with faster carriers or set up regional warehouses to bring 15-day delivery under 7 days

---

## 🚀 How to Run This Project

1. Clone the repo:
   ```bash
   git clone https://github.com/Sakethsiju/Amazon-E-Commerce-Analysis.git
   ```
2. Open `amazon_analysis.sql` in any SQL editor (MySQL Workbench, pgAdmin, DBeaver)
3. Load `amazon_orders.csv` as your data source
4. Run queries section by section
5. Open `amazon_dashboard.pbix` in Power BI Desktop to view the dashboard

