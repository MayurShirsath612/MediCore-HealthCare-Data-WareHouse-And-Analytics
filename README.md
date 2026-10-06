# 🏥 Healthcare Data Analytics & BI Pipeline

## 📌 Overview

This project is an end-to-end healthcare data analytics and business intelligence solution built using a custom data warehouse and Power BI.

The project starts with denormalized hospital data from Oracle ERP systems and transforms it into a **Star Schema** for reporting and analytics. The final data model is used to build Power BI dashboards for revenue, clinical KPIs, and insurance claims.

The project also includes **Row-Level Security (RLS)** and PII protection to control access to sensitive patient data.

---

## 🎯 Project Objectives

### Data Engineering

- Transform denormalized hospital data into a Star Schema.
- Load data through **Staging → ODS → Data Warehouse** layers.
- Clean and standardize data before loading it into the warehouse.
- Combine data from hospital, finance, HR, and insurance systems.
- Build a data model optimized for Power BI reporting.

### BI & Reporting

- Build Power BI dashboards for:
  - Revenue by facility, department, and month
  - Clinical KPIs
  - Insurance claims and reimbursements
  - Patient throughput
- Create DAX measures for reporting and analysis.
- Implement **Row-Level Security (RLS)** so users can only access data for their assigned facility.
- Protect patient PII such as names, phone numbers, and email addresses.

---

## 🏗️ Data Warehouse Architecture

The data pipeline is divided into three layers:

| Layer | Purpose | Description |
|---|---|---|
| **Staging** | Ingestion | Stores data from Oracle extracts in its raw form. |
| **ODS** | Cleansing | Cleans, standardizes, and prepares data for the warehouse. |
| **Data Warehouse** | Analytics | Stores the final Star Schema used for reporting. |

```text
Oracle ERP / Healthcare Systems
              ↓
         Staging Layer
              ↓
            ODS
              ↓
      Data Warehouse
        (Star Schema)
              ↓
           Power BI
              ↓
      Reports & Dashboards
```

---

## 🗄️ Data Modeling

The data warehouse uses a **Star Schema** consisting of fact and dimension tables.

### Fact Tables

Fact tables contain measurable business data such as:

- Billing amounts
- Insurance claims
- Claim approvals
- Lab charges
- Medical charges

### Dimension Tables

Dimension tables provide descriptive information such as:

- Patient demographics
- Doctors and staff
- Departments
- Facilities
- Date and time

---

## 🛠️ Tech Stack

- **Source Systems:** Oracle ERP, Oracle HCM, Oracle Health Cloud
- **Data Engineering:** SQL
- **Data Warehouse:** Staging, ODS, and Star Schema
- **Business Intelligence:** Power BI
- **Data Analysis:** DAX
- **Security:** Power BI Row-Level Security (RLS)
- **Deployment:** Power BI Workspaces

---

## 📁 Project Workflow

1. Analyze the source data and business requirements.
2. Design the Staging and ODS layers.
3. Clean and transform the source data.
4. Build the Data Warehouse using a Star Schema.
5. Create relationships between fact and dimension tables.
6. Develop DAX measures.
7. Build Power BI dashboards.
8. Test reports and RLS rules.
9. Deploy the final reports to Power BI.

---

## 📊 Key Metrics

The project covers reporting across:

- **7** hospital facilities
- **1,400** beds
- **850** doctors
- **4.2 lakh+** annual outpatients
- **₹412 Crore** annual revenue

These metrics are used to analyze hospital revenue, patient activity, facility performance, and insurance claims.

---

## 🔐 Data Security

Patient information is treated as sensitive data.

The Power BI solution uses **Row-Level Security (RLS)** to restrict users to their assigned facility. Personally identifiable information (PII) such as patient names, phone numbers, and email addresses is also kept out of reporting where it is not required.

---

## 🚀 Project Outcome

The project provides a centralized data model for hospital reporting and creates a single source of truth for revenue, clinical, and claims-related analysis.

It covers the complete workflow from **data extraction and transformation to data warehousing, Power BI modeling, reporting, security, testing, and deployment**.
