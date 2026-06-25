# 🏦 Oracle Banking Database + Power BI Analytics
**End-to-End Data Analytics Portfolio Project**

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Oracle](https://img.shields.io/badge/Database-Oracle%20XE%2021c-red.svg)
![Power BI](https://img.shields.io/badge/BI%20Tool-Power%20BI%20Desktop-blue.svg)
![SQL](https://img.shields.io/badge/SQL-Advanced-green.svg)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen.svg)

---

## 🎯 Key Highlights

| Aspect | Details |
|--------|---------|
| **Project Scope** | Complete end-to-end analytics pipeline: Database Design → Data Population → SQL Analytics → BI Dashboard |
| **Data Volume** | 7 tables, 2000+ transactions, 150 loans, 200+ customers, 6+ months of transaction history |
| **SQL Skills** | DDL/DML, Window Functions (RANK, LAG, LEAD, ROW_NUMBER), CTEs, Aggregations, Date Functions, Stored Procedures, Triggers |
| **Power BI Skills** | Star Schema Design, DAX Measures, Multi-page Interactive Dashboards, Slicers, Conditional Formatting, KPI Cards |
| **Database Objects** | 5 Reusable Views, 3 Stored Procedures, 2 Triggers, PL/SQL Functions, CHECK Constraints, UNIQUE Constraints |
| **Key Outcomes** | 5-Page Executive Dashboard with 20+ KPI metrics, 20+ analytical SQL queries, Real-world normalized schema |

---

## 📊 Project Overview

This project demonstrates **real-world SQL and analytics skills** by building a complete banking analytics solution from scratch:

- **Backend:** Oracle Database XE 21c with normalized relational schema (7 tables, star-schema design)
- **Data Layer:** Reusable database views, stored procedures, triggers, and PL/SQL functions
- **Frontend:** Microsoft Power BI Desktop with interactive 3-page executive dashboard
- **Use Cases:** Customer segmentation, loan portfolio analysis, transaction trends, branch performance

The banking domain was chosen because it covers **all essential SQL concepts** that appear in enterprise analytics roles: one-to-many relationships, complex aggregations, window functions, date-based analysis, and status-based filtering.

---

## 🖼️ Visual Assets

### Dashboard Preview
> **Note:** Replace these with your actual screenshots
- **Page 1 - Executive Summary:** KPI cards, branch performance, monthly trends, top customers
- **Page 2 - Branch Anlysis:** KPI card, branch perfornamce,total loans,etc
- **Page 3 - Loan Portfolio:** Loan disbursement, default rates, repayment trends, branch vs loan type matrix
- **Page 4 - Transaction Analysis:** Waterfall charts, day-of-week patterns, account balance analysis
- **Page 5 - Customer insights** Total customer, Customers insights, Total balance, etc.

### Database Architecture
> **Database ERD Diagram** - Shows all 7 tables, relationships, and constraints

---

## 🛠️ Tools & Technologies

| Layer | Tool | Version |
|-------|------|---------|
| **Database** | Oracle Database XE | 21c |
| **Database Client** | Oracle SQL Developer | Latest |
| **BI Platform** | Microsoft Power BI Desktop | Latest |
| **ODBC Driver** | Oracle ODBC Driver | 32/64-bit |
| **Query Language** | PL/SQL, Oracle SQL | ANSI-SQL compliant |

---

## 📁 Project Structure

```
banking-sql-powerbi/
│
├── README.md                          # This file
├── LICENSE                            # MIT License
├                          
│
├── setup/
│   └── 01_create_user.sql            # Creates banking_user with permissions
│
├── phase1_schema/                     # Database Design
│   ├── 01_index _sequence_and_table_creation                 # Performance indexes
│   └── ERD.png                # Entity Relationship Diagram
│
├── phase2_data/                       # Data Population (2000+ records)
│   ├── 01_insert_branches.sql         # 10 branches
│   ├── 02_insert_employees.sql        # 50 employees
│   ├── 03_insert_customers.sql        # 200 customers
│   ├── 04_insert_accounts.sql         # 350 accounts
│   ├── 05_insert_transactions.sql     # 2000+ transactions
│   ├── 06_insert_loans.sql            # 150 loans
│   └── 07_insert_loan_payments.sql    # 600+ loan payments
│
├── phase3_queries/                    # 20+ Analytical SQL Queries
│   ├── 01_basic_queries.sql           # SELECT, WHERE, ORDER BY
│   ├── 02_joins_aggregations.sql      # JOINs, GROUP BY, aggregations
│   ├── 03_window_functions.sql        # RANK, LAG, LEAD, SUM OVER, NTILE
│   └── 04_kpi_queries.sql             # KPI calculations for dashboard
│
├── phase4_objects/                    # Reusable Database Objects
│   ├── 01_views.sql                   # 5 reporting views
│   ├── 02_stored_procedures.sql       # 3 business logic procedures
│   ├── 03-audit_triggers_and_final_verification   # 2 audit & automation triggers
|   └── 04_plsql_function
│
├── phase5_powerbi/
│   ├── connection_guide.docx            # ODBC setup & Power BI connection steps
│   
│
├── phase6_dashboard/
│   ├── banking_dashboard.pbix         # Complete Power BI dashboard file
│   └── dashboard_screenshots/         # Page 1, 2, 3 PNG exports
│

```

---

## 🚀 Quick Start (5 Minutes)

### Prerequisites
- ✅ **Oracle Database XE 21c** (installed & running)
- ✅ **Oracle SQL Developer** (or SQL*Plus)
- ✅ **Power BI Desktop** (free download)
- ✅ **Oracle ODBC Driver** (matching your system: 32-bit or 64-bit)

### Setup Steps

1. **Connect to Oracle as SYS (SYSDBA)**
   ```sql
   sqlplus / as sysdba
   @setup/01_create_user.sql
   ```

2. **Create Database Schema** (Connect as `banking_user`)
   ```sql
   @phase1_schema/01_sequences.sql
   @phase1_schema/02_tables.sql
   @phase1_schema/03_indexes.sql
   ```

3. **Load Sample Data** (2000+ records across 7 tables)
   ```sql
   @phase2_data/01_insert_branches.sql
   @phase2_data/02_insert_employees.sql
   @phase2_data/03_insert_customers.sql
   @phase2_data/04_insert_accounts.sql
   @phase2_data/05_insert_transactions.sql
   @phase2_data/06_insert_loans.sql
   @phase2_data/07_insert_loan_payments.sql
   ```

4. **Explore SQL Queries** (Review analytical queries)
   ```sql
   @phase3_queries/01_basic_queries.sql
   @phase3_queries/02_joins_aggregations.sql
   @phase3_queries/03_window_functions.sql
   ```

5. **Create Database Objects** (Views, Procedures, Triggers)
   ```sql
   @phase4_objects/01_views.sql
   @phase4_objects/02_stored_procedures.sql
   @phase4_objects/03_triggers.sql
   ```

6. **Connect Power BI to Oracle**
   - See detailed guide: `phase5_powerbi/connection_guide.docx`

7. **View Dashboard**
   - Open `phase6_dashboard/banking_dashboard.pbix` in Power BI Desktop

### ✅ Verify Setup
```sql
-- Run this to confirm all data loaded correctly
SELECT 'BRANCHES'     AS tbl, COUNT(*) AS rows FROM branches     UNION ALL
SELECT 'EMPLOYEES'    AS tbl, COUNT(*) AS rows FROM employees    UNION ALL
SELECT 'CUSTOMERS'    AS tbl, COUNT(*) AS rows FROM customers    UNION ALL
SELECT 'ACCOUNTS'     AS tbl, COUNT(*) AS rows FROM accounts     UNION ALL
SELECT 'TRANSACTIONS' AS tbl, COUNT(*) AS rows FROM transactions UNION ALL
SELECT 'LOANS'        AS tbl, COUNT(*) AS rows FROM loans        UNION ALL
SELECT 'LOAN_PAYMENTS'AS tbl, COUNT(*) AS rows FROM loan_payments;

-- Expected output:
-- BRANCHES      |     10
-- EMPLOYEES     |     50
-- CUSTOMERS     |    200
-- ACCOUNTS      |    350
-- TRANSACTIONS  |   2000+
-- LOANS         |    150
-- LOAN_PAYMENTS |    600+
```

---

## 📚 Detailed Project Phases

### Phase 1: Database Schema Design
**What:** Normalized relational schema with 7 tables following star-schema principles
- **Entity Tables:** BRANCHES, EMPLOYEES, CUSTOMERS (reference data)
- **Transactional Tables:** ACCOUNTS, TRANSACTIONS, LOANS, LOAN_PAYMENTS (events)
- **Key Features:** Primary keys (sequences), foreign keys, CHECK constraints, UNIQUE constraints
- **Design Decision:** Branch-centric dimensional model enables geographic filtering in Power BI

**SQL Skills:** DDL (CREATE TABLE, ALTER TABLE), constraints, sequences, indexes

---

### Phase 2: Sample Data Loading
**What:** Realistic banking data across 6 months (Jan 2022 - Dec 2024)
- 10 branches across major Indian cities
- 200 customers with varied demographics
- 350 accounts (Savings, Current, Fixed Deposit, Salary)
- 2000+ transactions with realistic patterns
- 150 loans (Home, Personal, Auto, Education, Business) with 15% default rate
- 600+ loan payments with monthly installments

**Data Quality:** No orphan records, referential integrity, realistic distributions

**SQL Skills:** DML (INSERT), bulk data loading, data validation

---

### Phase 3: SQL Analytics (20+ Queries)

#### Basic Level
- Total customers per branch
- Account balance summary by type
- Monthly transaction volume & value
- Loan portfolio breakdown

#### Intermediate Level (JOINs & Aggregations)
- Customer 360 view (all accounts, transactions, loans)
- Branch performance (deposits, withdrawals, net position)
- Top 10 customers by balance
- Loan repayment rates

#### Advanced Level (Window Functions)
- **RANK()** — Top customers by deposit value per branch
- **ROW_NUMBER()** — Latest transaction per account
- **LAG() / LEAD()** — Month-over-month growth rates
- **SUM() OVER()** — Running balance totals
- **NTILE(4)** — Customer segmentation by quartiles

#### Example: Month-over-Month Growth
```sql
SELECT
  TO_CHAR(transaction_date, 'YYYY-MM')  AS txn_month,
  SUM(amount)                            AS total_amount,
  LAG(SUM(amount)) OVER (ORDER BY TO_CHAR(transaction_date, 'YYYY-MM')) AS prev_month,
  ROUND(
    (SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY TO_CHAR(transaction_date,'YYYY-MM')))
    / LAG(SUM(amount)) OVER (ORDER BY TO_CHAR(transaction_date,'YYYY-MM')) * 100, 2
  ) AS growth_pct
FROM transactions
WHERE transaction_type = 'DEPOSIT'
GROUP BY TO_CHAR(transaction_date, 'YYYY-MM')
ORDER BY txn_month;
```

**SQL Skills:** JOINs, GROUP BY, HAVING, window functions, aggregations, date functions, CTEs

---

### Phase 4: Database Objects (Reusable Logic)

#### Views (Data Layer for Power BI)
- `vw_branch_summary` — KPIs per branch
- `vw_customer_360` — Unified customer profile
- `vw_monthly_transactions` — Pre-aggregated time series
- `vw_loan_portfolio` — Loan status & repayment progress
- `vw_account_balances` — Current balances with customer names

#### Stored Procedures (Business Logic)
- `sp_process_loan_payment()` — Validates & records payments, updates status
- `sp_open_account()` — Creates account with opening transaction
- `sp_monthly_interest()` — Calculates & credits interest to savings accounts

#### Triggers (Automation & Audit)
- `trg_audit_transactions` — Logs every transaction to audit table
- `trg_update_loan_status` — Auto-closes loan when fully repaid
- `trg_account_balance_update`— Auto Balance Update

#### PL/SQL Functions (auto functions)
- `fn_get_account_balance`—  Gets account balance when called
- `fn_calculate_emi`— Standard reducing-balance EMI formula
- `fn_customer_risk_rating`—  It return customers Risk level by finding their loan history

**SQL Skills:** Views, stored procedures, PL/SQL, triggers, exception handling, CURSOR loops

---

### Phase 5: Oracle to Power BI Connection

**Steps:**
1. Download & install Oracle ODBC Driver (32-bit or 64-bit)
2. Configure DSN in Windows ODBC Data Source Administrator
3. In Power BI: Get Data > Oracle Database > localhost:1521/XE
4. Import the 5 reporting views (not raw tables)
5. Configure relationships in Model view to create star schema

**Why Views?** Encapsulate business logic, insulate Power BI from schema changes, improve security

See detailed guide: `phase5_powerbi/connection_guide.docx`

---

### Phase 6: Power BI Dashboard (3 Pages)

#### Page 1: Executive Summary
- **KPI Cards:** Total Deposits, Total Withdrawals, Net Balance, Active Customers
- **Bar Chart:** Branch-wise deposits
- **Line Chart:** Monthly transaction trend (Jan 2022 - Dec 2024)
- **Donut Chart:** Account type distribution
- **Table:** Top 10 customers by balance

#### Page 2: Loan Portfolio Analysis
- **KPI Cards:** Total Loans Issued, Outstanding, Default Rate %, Avg Interest Rate
- **Bar Chart:** Loan disbursement by type
- **Stacked Bar:** Loan status (Active/Closed/Defaulted) by branch
- **Line Chart:** Monthly repayment trend
- **Matrix:** Branch vs Loan Type

#### Page 3: Transaction Analysis
- **KPI Cards:** Total Transactions, Avg Value, Fees Collected
- **Waterfall Chart:** Deposits vs Withdrawals vs Net
- **Line Chart:** Day-of-week transaction patterns
- **Scatter Plot:** Account balance vs transaction frequency
- **Slicer:** Transaction type filter

#### Key DAX Measures
```dax
Total Deposits = CALCULATE(SUM(Transactions[amount]), 
  Transactions[transaction_type] = "DEPOSIT")

Loan Default Rate % = DIVIDE(
  CALCULATE(COUNTROWS(Loans), Loans[status] = "DEFAULTED"),
  COUNTROWS(Loans), 0) * 100

MoM Growth % = VAR current = [Total Deposits]
  VAR prev = CALCULATE([Total Deposits], 
    DATEADD('Calendar'[Date], -1, MONTH))
  RETURN DIVIDE(current - prev, prev, 0) * 100
```

**Power BI Skills:** Star schema, DAX measures, multi-page dashboards, slicers, conditional formatting, KPI cards, interactive visuals

---

## 🎓 Skills Demonstrated

### SQL & Database Design
- ✅ Relational database design (normalization, star schema)
- ✅ DDL: CREATE TABLE, sequences, constraints
- ✅ DML: INSERT, UPDATE, DELETE with business rules
- ✅ DQL: SELECT, JOINs (INNER, LEFT, RIGHT), subqueries, CTEs
- ✅ Aggregations: GROUP BY, HAVING, ROLLUP, CUBE
- ✅ Window Functions: RANK, DENSE_RANK, ROW_NUMBER, LAG, LEAD, SUM OVER, NTILE
- ✅ Date Functions: TO_CHAR, ADD_MONTHS, MONTHS_BETWEEN, TRUNC, SYSDATE
- ✅ Performance: Indexes, query optimization

### PL/SQL & Oracle-Specific
- ✅ Stored procedures with IN/OUT parameters
- ✅ Error handling (EXCEPTION blocks)
- ✅ PL/SQL functions with return values
- ✅ Triggers for audit logging & automation
- ✅ CURSOR-based loops for batch processing
- ✅ Sequences for primary key generation

### Power BI & DAX
- ✅ Data model design: star schema, relationships
- ✅ DAX functions: CALCULATE, FILTER, DIVIDE, time intelligence
- ✅ Visualizations: KPI cards, bar/line/donut/waterfall charts, matrix, scatter
- ✅ UX: slicers, drill-through, conditional formatting, bookmarks
- ✅ Performance: Report optimization, filter context

### Enterprise Analytics
- ✅ KPI definition & calculation
- ✅ Executive dashboard design
- ✅ Customer segmentation
- ✅ Loan portfolio analytics
- ✅ Time-series analysis
- ✅ Trend analysis & forecasting
- ✅ Data quality & validation

---

## 📊 Sample Query Results

### Query: Top 10 Customers by Total Balance
```
Customer_Name        | Total_Balance  | Account_Count | Primary_Branch
---------------------------------------------------------------------------
Rajesh Kumar        | 5,234,500      | 4             | Chennai
Priya Sharma        | 4,892,300      | 3             | Mumbai
Amit Patel          | 4,521,100      | 5             | Bangalore
...
```

### Query: Loan Default Rate by Branch
```
Branch_Name    | Total_Loans | Active | Closed | Defaulted | Default_Rate
---------------------------------------------------------------------------
Chennai        | 25          | 18     | 5      | 2         | 8.0%
Mumbai         | 32          | 27     | 3      | 2         | 6.25%
Bangalore      | 28          | 23     | 4      | 1         | 3.57%
...
```

### Query: Monthly Transaction Trend
```
TXN_MONTH | Total_Amount | Prev_Month_Amount | Growth_pct
----------------------------------------------------------
2022-01   | 1,245,300    | NULL              | NULL
2022-02   | 1,389,500    | 1,245,300         | 11.56%
2022-03   | 1,521,400    | 1,389,500         | 9.49%
...
```

---

## 🔧 Troubleshooting

### Oracle Connection Issues
- **Error:** "ORA-12514: TNS:listener does not currently know of service requested"
  - **Solution:** Ensure Oracle XE is running. Check `tnsnames.ora` for XE entry.

- **Error:** "ORA-01017: invalid username/password; logon denied"
  - **Solution:** Verify banking_user credentials in `setup/01_create_user.sql`

### Power BI Connection Issues
- **Error:** "The Oracle ODBC driver is not installed"
  - **Solution:** Download from Oracle Technology Network (OTN) matching your system architecture (32/64-bit)

- **Error:** "The connection string is invalid"
  - **Solution:** Ensure DSN is configured in ODBC Administrator matching Power BI's bitness

### Data Loading Issues
- **Error:** "Constraint violation on INSERT"
  - **Solution:** Check `phase2_data/` scripts for FK reference integrity. Run in correct sequence.

---

## 📝 What I Learned

This project taught me:
- **Database Design:** How to normalize schemas, design for analytics (star schema), balance OLTP vs OLAP needs
- **SQL Mastery:** Complex window functions, performance tuning, query optimization, subqueries
- **PL/SQL:** Stored procedures for business logic encapsulation, triggers for audit trails
- **Analytics Mindset:** How to think like a data analyst, define KPIs, build metrics hierarchies
- **BI Best Practices:** Data model relationships, DAX measure design, dashboard UX principles
- **End-to-End:** Appreciation for the full data pipeline from schema to dashboard

---

## 🎯 Future Enhancements

- [ ] Add data validation rules (CHECK constraints beyond current ones)
- [ ] Implement data warehouse architecture (fact/dimension tables separated)
- [ ] Add real-time streaming data (Oracle GoldenGate or Kafka)
- [ ] Build advanced ML models (customer churn prediction, credit scoring)
- [ ] Create REST API for dashboard data consumption
- [ ] Add CI/CD pipeline for automated testing
- [ ] Implement row-level security (RLS) in Power BI

---

## 📖 Resources Used

- [Oracle SQL Documentation](https://docs.oracle.com/en/database/oracle/oracle-database/)
- [Microsoft Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)
- [DAX Function Reference](https://dax.guide/)
- [Window Functions in SQL](https://oracle-base.com/articles/misc/window-functions)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

**In Plain English:** You're free to use, modify, and share this project for personal or commercial purposes. Just give credit where it's due! ✨

---

## 👤 Author

**DHILIP KUMARAN S**  
Data Analyst | SQL Developer | BI Enthusiast

- LinkedIn: (https://www.linkedin.com/in/dhilip-kumaran-246023212/)
- Email: dilipkumaran23@gmail.com

---

## 🤝 Contributing

This is a portfolio project, but feedback is always welcome!
- Found a bug? Open an issue
- Have suggestions? Feel free to reach out
- Want to fork and extend? Go ahead! (Please give attribution)

---

## ⭐ Show Your Support

If you found this project useful or learned something from it, please consider:
- ⭐ **Starring** this repository
- 🔗 **Sharing** with others interested in SQL/BI
- 💬 **Providing feedback** via issues or email

---

**Built with ❤️ using Oracle XE 21c + Power BI Desktop**

*Last Updated: June 2026*
