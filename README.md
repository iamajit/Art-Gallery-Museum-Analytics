# 🎨 Art Gallery & Museum Analytics — SQL Portfolio Project

## 📌 Project Title

**Art Gallery & Museum Analytics using SQL Server**

---

## 🧾 Project Description

This project demonstrates advanced SQL skills by analyzing an **Art Gallery and Museum dataset**. The goal is to extract meaningful business insights related to artists, artworks, pricing strategies, museum operations, and customer interests.

The project is designed to simulate real-world business scenarios and showcase expertise in **data cleaning, transformation, and analytical querying using T-SQL**.

---

## 🎯 Objectives

* Analyze artist performance and trends
* Evaluate museum operations and distribution
* Identify pricing patterns and discount strategies
* Discover popular art styles and subjects
* Generate business insights using advanced SQL techniques

---

## 🛠️ Tools & Technologies

* **SQL Server**
* **T-SQL (Transact-SQL)**
* SQL Server Management Studio (SSMS)

---

## 🗂️ Database Schema

The project consists of the following tables:

| Table Name     | Description                                                |
| -------------- | ---------------------------------------------------------- |
| `artist`       | Stores artist details such as name, nationality, and style |
| `work`         | Contains artwork details linked to artists and museums     |
| `museum`       | Stores museum information including location and contact   |
| `museum_hours` | Tracks opening and closing hours of museums                |
| `canvas_size`  | Defines artwork canvas dimensions                          |
| `product_size` | Contains pricing details for artworks                      |
| `image_link`   | Stores image URLs for artworks                             |
| `subject`      | Categorizes artworks by subject                            |

---

## 🧹 Data Cleaning & Preparation

Key preprocessing steps performed:

* Removed duplicate artist records using CTE and ROW_NUMBER
* Corrected inconsistent pricing (sale price > regular price)
* Handled missing or invalid museum references
* Validated NULL values across critical columns

---

## 📊 Exploratory Data Analysis (EDA)

Basic analysis performed:

* Total number of artists, artworks, and museums
* Distribution of artists by nationality
* Most popular art styles
* Subject frequency analysis

---

## 🚀 Advanced SQL Techniques Used

### ✔ Common Table Expressions (CTE)

Used for data cleaning and ranking operations.

### ✔ Window Functions

* RANK() for top artist identification
* SUM() OVER() for running totals

### ✔ Joins

* INNER JOIN for relational analysis
* LEFT JOIN for missing data detection

### ✔ Aggregations

* COUNT(), SUM(), AVG() for KPI calculations

### ✔ CASE Statements

Used for categorizing price ranges and business logic implementation

---

## 📚 Skills Demonstrated

* Writing optimized and structured SQL queries
* Performing real-world data analysis using SQL
* Applying business logic through SQL transformations
* Using advanced SQL features (CTE, Window Functions)
* Designing scalable and reusable query structures

---

## 💼 Use Case

This project is suitable for:

* SQL Developer Portfolio
* Data Analyst Portfolio
* Freelance project demonstration
* Interview preparation (real-world SQL scenarios)

---

## 📬 Contact

Available for freelance SQL and data analytics projects.

---
👨‍💻 Author

Ajit Kumar Giri

SQL Developer | Data Analyst

---

## ⭐ If You Like This Project

Give it a ⭐ on GitHub and feel free to fork or contribute!

