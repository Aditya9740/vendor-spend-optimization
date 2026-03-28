-- ============================================
-- VENDOR SPEND OPTIMIZATION — SQL QUERIES
-- PostgreSQL 16 | vendor_db
-- Author: Aditya Mahajan
-- ============================================

-- QUERY 1: Total Spend Overview
SELECT 
    COUNT(*)                                AS total_transactions,
    ROUND(SUM(spend_amount)::numeric, 2)    AS total_spend,
    ROUND(AVG(spend_amount)::numeric, 2)    AS avg_transaction,
    ROUND(MAX(spend_amount)::numeric, 2)    AS largest_payment,
    ROUND(MIN(spend_amount)::numeric, 2)    AS smallest_payment
FROM vendor_spend;

-- QUERY 2: Top 10 Vendors by Spend
SELECT 
    vendor_id,
    vendor_name,
    COUNT(*)                                        AS total_transactions,
    ROUND(SUM(spend_amount)::numeric, 2)            AS total_spend,
    ROUND(AVG(spend_amount)::numeric, 2)            AS avg_spend,
    ROUND(SUM(spend_amount)::numeric * 100.0 / 
        (SELECT SUM(spend_amount)::numeric 
         FROM vendor_spend), 2)                     AS spend_percentage
FROM vendor_spend
GROUP BY vendor_id, vendor_name
ORDER BY total_spend DESC
LIMIT 10;

-- QUERY 3: Category Spend Breakdown
SELECT 
    category,
    COUNT(*)                                AS total_transactions,
    ROUND(SUM(spend_amount)::numeric, 2)    AS total_spend,
    ROUND(AVG(spend_amount)::numeric, 2)    AS avg_spend,
    ROUND(SUM(spend_amount)::numeric * 100.0 /
        (SELECT SUM(spend_amount)::numeric 
         FROM vendor_spend), 2)             AS spend_percentage
FROM vendor_spend
GROUP BY category
ORDER BY total_spend DESC;

-- QUERY 4: Monthly Spend Trend
SELECT 
    month,
    month_name,
    COUNT(*)                                AS total_transactions,
    ROUND(SUM(spend_amount)::numeric, 2)    AS monthly_spend,
    ROUND(AVG(spend_amount)::numeric, 2)    AS avg_transaction
FROM vendor_spend
GROUP BY month, month_name
ORDER BY month;

-- QUERY 5: Department Spend Breakdown
SELECT 
    department,
    COUNT(*)                                AS total_transactions,
    ROUND(SUM(spend_amount)::numeric, 2)    AS total_spend,
    ROUND(AVG(spend_amount)::numeric, 2)    AS avg_spend,
    ROUND(SUM(spend_amount)::numeric * 100.0 /
        (SELECT SUM(spend_amount)::numeric 
         FROM vendor_spend), 2)             AS spend_percentage
FROM vendor_spend
GROUP BY department
ORDER BY total_spend DESC;

-- QUERY 6: Vendor-Department Concentration
SELECT 
    department,
    vendor_name,
    COUNT(*)                                AS transactions,
    ROUND(SUM(spend_amount)::numeric, 2)    AS total_spend,
    ROUND(AVG(spend_amount)::numeric, 2)    AS avg_spend
FROM vendor_spend
GROUP BY department, vendor_name
ORDER BY total_spend DESC
LIMIT 15;
