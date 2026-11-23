-- ==========================================
-- SUPPLY CHAIN & INVENTORY PERFORMANCE
-- SQL BUSINESS ANALYSIS
-- ==========================================

-- 1. GENERAL DATA EXPLORATION
SELECT *
FROM supply_chain.inventory_records
LIMIT 10;
SELECT
    COUNT(*) AS total_records
FROM supply_chain.inventory_records;
SELECT
    COUNT(DISTINCT region) AS total_regions
FROM supply_chain.inventory_records;
SELECT
    COUNT(DISTINCT supplier) AS total_suppliers
FROM supply_chain.inventory_records;
SELECT
    COUNT(DISTINCT warehouse) AS total_warehouses
FROM supply_chain.inventory_records;
SELECT
    COUNT(DISTINCT category) AS total_categories
FROM supply_chain.inventory_records;
SELECT
    SUM(units_sold) AS total_units_sold,
    ROUND(AVG(units_sold), 2) AS average_units_sold,
    ROUND(AVG(inventory_level), 2) AS average_inventory_level,
    ROUND(AVG(transportation_cost), 2) AS average_transportation_cost,
    ROUND(AVG(lead_time_days), 2) AS average_lead_time,
    ROUND(AVG(cost_of_goods_sold), 2) AS average_cogs,
    ROUND(AVG(inventory_utilisation_pct), 2) AS average_inventory_utilisation
FROM supply_chain.inventory_records;
-- 2. REGIONAL PERFORMANCE ANALYSIS
SELECT
    region,
    SUM(units_sold) AS total_units_sold,
    COUNT(*) AS total_records
FROM supply_chain.inventory_records
GROUP BY region
ORDER BY total_units_sold DESC;
SELECT
    region,
    ROUND(SUM(transportation_cost), 2) AS total_transportation_cost,
    ROUND(AVG(transportation_cost), 2) AS average_transportation_cost,
    COUNT(*) AS total_records
FROM supply_chain.inventory_records
GROUP BY region
ORDER BY total_transportation_cost DESC;
SELECT
    region,
    category,
    SUM(units_sold) AS total_units_sold
FROM supply_chain.inventory_records
GROUP BY region, category
ORDER BY region, total_units_sold DESC;
SELECT
    region,
    category,
    ROUND(AVG(transportation_cost), 2) AS average_transportation_cost
FROM supply_chain.inventory_records
GROUP BY region, category
ORDER BY region, average_transportation_cost DESC;
-- 3. SUPPLIER PERFORMANCE ANALYSIS
SELECT
    supplier,
    ROUND(AVG(lead_time_days), 2) AS average_lead_time,
    MIN(lead_time_days) AS minimum_lead_time,
    MAX(lead_time_days) AS maximum_lead_time,
    COUNT(*) AS total_records
FROM supply_chain.inventory_records
GROUP BY supplier
ORDER BY average_lead_time DESC;
SELECT
    supplier,
    COUNT(*) FILTER (
        WHERE lead_time_days <= 7
    ) AS within_7_days,
    COUNT(*) FILTER (
        WHERE lead_time_days BETWEEN 8 AND 14
    ) AS between_8_and_14_days,
    COUNT(*) FILTER (
        WHERE lead_time_days BETWEEN 15 AND 21
    ) AS between_15_and_21_days,
    COUNT(*) FILTER (
        WHERE lead_time_days > 21
    ) AS above_21_days
FROM supply_chain.inventory_records
GROUP BY supplier
ORDER BY supplier;
SELECT
    supplier,
    ROUND(AVG(transportation_cost), 2) AS average_transportation_cost,
    ROUND(SUM(transportation_cost), 2) AS total_transportation_cost
FROM supply_chain.inventory_records
GROUP BY supplier
ORDER BY average_transportation_cost DESC;
SELECT
    supplier,
    COUNT(*) AS total_records,
    ROUND(AVG(lead_time_days), 2) AS average_lead_time,
    ROUND(AVG(transportation_cost), 2) AS average_transportation_cost,
    ROUND(AVG(inventory_utilisation_pct), 2) AS average_inventory_utilisation,
    COUNT(*) FILTER (
        WHERE backorder = TRUE
    ) AS backorder_records
FROM supply_chain.inventory_records
GROUP BY supplier
ORDER BY average_lead_time DESC;
-- 4. INVENTORY PERFORMANCE ANALYSIS
SELECT
    warehouse,
    ROUND(AVG(inventory_level), 2) AS average_inventory_level,
    ROUND(MIN(inventory_level), 2) AS minimum_inventory_level,
    ROUND(MAX(inventory_level), 2) AS maximum_inventory_level,
    COUNT(*) AS total_records
FROM supply_chain.inventory_records
GROUP BY warehouse
ORDER BY average_inventory_level DESC;
SELECT
    warehouse,
    ROUND(AVG(inventory_utilisation_pct), 2) AS average_utilisation,
    ROUND(MIN(inventory_utilisation_pct), 2) AS minimum_utilisation,
    ROUND(MAX(inventory_utilisation_pct), 2) AS maximum_utilisation
FROM supply_chain.inventory_records
GROUP BY warehouse
ORDER BY average_utilisation DESC;
SELECT
    warehouse,
    CASE
        WHEN inventory_utilisation_pct < 30
            THEN 'Low Utilisation'
        WHEN inventory_utilisation_pct < 60
            THEN 'Moderate Utilisation'
        WHEN inventory_utilisation_pct < 80
            THEN 'High Utilisation'
        ELSE 'Very High Utilisation'
    END AS utilisation_category,
    COUNT(*) AS total_records

FROM supply_chain.inventory_records
GROUP BY
    warehouse,
    utilisation_category
ORDER BY
    warehouse,
    utilisation_category;
SELECT
    CASE
        WHEN inventory_utilisation_pct < 30
            THEN 'Low Utilisation'
        WHEN inventory_utilisation_pct < 60
            THEN 'Moderate Utilisation'
        WHEN inventory_utilisation_pct < 80
            THEN 'High Utilisation'
        ELSE 'Very High Utilisation'
    END AS utilisation_category,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain.inventory_records
GROUP BY utilisation_category
ORDER BY total_records DESC;
SELECT
    category,
    ROUND(AVG(inventory_level), 2) AS average_inventory_level,
    ROUND(AVG(average_inventory), 2) AS average_recorded_average_inventory,
    SUM(units_sold) AS total_units_sold
FROM supply_chain.inventory_records
GROUP BY category
ORDER BY average_inventory_level DESC;
-- 5. BACKORDER ANALYSIS
SELECT
    backorder,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain.inventory_records
GROUP BY backorder
ORDER BY total_records DESC;
SELECT
    category,
    COUNT(*) FILTER (
        WHERE backorder = TRUE
    ) AS total_backorders,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*),
        2
    ) AS backorder_rate
FROM supply_chain.inventory_records
GROUP BY category
ORDER BY backorder_rate DESC;
SELECT
    region,
    COUNT(*) FILTER (
        WHERE backorder = TRUE
    ) AS total_backorders,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*),
        2
    ) AS backorder_rate
FROM supply_chain.inventory_records
GROUP BY region
ORDER BY backorder_rate DESC;
SELECT
    warehouse,
    COUNT(*) FILTER (
        WHERE backorder = TRUE
    ) AS total_backorders,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*),
        2
    ) AS backorder_rate
FROM supply_chain.inventory_records
GROUP BY warehouse
ORDER BY backorder_rate DESC;
SELECT
    region,
    category,
    COUNT(*) FILTER (
        WHERE backorder = TRUE
    ) AS total_backorders,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*),
        2
    ) AS backorder_rate
FROM supply_chain.inventory_records
GROUP BY region, category
ORDER BY backorder_rate DESC;
-- 6. ORDER PERFORMANCE ANALYSIS
SELECT
    order_status,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain.inventory_records
GROUP BY order_status
ORDER BY total_records DESC;
SELECT
    order_accuracy,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain.inventory_records
GROUP BY order_accuracy
ORDER BY order_accuracy DESC;
SELECT
    region,
    COUNT(*) FILTER (
        WHERE order_accuracy = TRUE
    ) AS true_records,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) FILTER (
            WHERE order_accuracy = TRUE
        ) * 100.0 / COUNT(*),
        2
    ) AS true_percentage
FROM supply_chain.inventory_records
GROUP BY region
ORDER BY true_percentage DESC;
SELECT
    region,
    COUNT(*) FILTER (
        WHERE order_status = 'Fulfilled'
    ) AS fulfilled_records,
    COUNT(*) FILTER (
        WHERE order_status = 'Pending'
    ) AS pending_records,
    COUNT(*) FILTER (
        WHERE order_status = 'Canceled'
    ) AS canceled_records
FROM supply_chain.inventory_records
GROUP BY region
ORDER BY region;
SELECT
    category,
    COUNT(*) FILTER (
        WHERE order_status = 'Fulfilled'
    ) AS fulfilled_records,
    COUNT(*) FILTER (
        WHERE order_status = 'Pending'
    ) AS pending_records,
    COUNT(*) FILTER (
        WHERE order_status = 'Canceled'
    ) AS canceled_records
FROM supply_chain.inventory_records
GROUP BY category
ORDER BY category;
-- 7. COST ANALYSIS
SELECT
    ROUND(SUM(transportation_cost), 2)
        AS total_transportation_cost,
    ROUND(AVG(transportation_cost), 2)
        AS average_transportation_cost,
    ROUND(SUM(cost_of_goods_sold), 2)
        AS total_recorded_cogs,
    ROUND(AVG(cost_of_goods_sold), 2)
        AS average_recorded_cogs
FROM supply_chain.inventory_records;
SELECT
    category,
    ROUND(SUM(transportation_cost), 2)
        AS total_transportation_cost,
    ROUND(AVG(transportation_cost), 2)
        AS average_transportation_cost
FROM supply_chain.inventory_records
GROUP BY category
ORDER BY total_transportation_cost DESC;
SELECT
    category,
    ROUND(SUM(cost_of_goods_sold), 2) AS total_cogs,
    ROUND(AVG(cost_of_goods_sold), 2) AS average_cogs
FROM supply_chain.inventory_records
GROUP BY category
ORDER BY total_cogs DESC;
SELECT
    region,
    ROUND(SUM(transportation_cost), 2)
        AS total_transportation_cost,
    ROUND(SUM(cost_of_goods_sold), 2)
        AS total_cogs,
    ROUND(AVG(transportation_cost), 2)
        AS average_transportation_cost,
    ROUND(AVG(cost_of_goods_sold), 2)
        AS average_cogs
FROM supply_chain.inventory_records
GROUP BY region
ORDER BY total_transportation_cost DESC;
SELECT
    EXTRACT(YEAR FROM date) AS year,
    ROUND(SUM(transportation_cost), 2)
        AS total_transportation_cost,
    ROUND(AVG(transportation_cost), 2)
        AS average_transportation_cost
FROM supply_chain.inventory_records
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY year;
SELECT
    EXTRACT(YEAR FROM date) AS year,
    ROUND(SUM(cost_of_goods_sold), 2) AS total_cogs
FROM supply_chain.inventory_records
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY year;
-- 8. TIME-BASED ANALYSIS
SELECT
    EXTRACT(YEAR FROM date) AS year,
    COUNT(*) AS total_records,
    SUM(units_sold) AS total_units_sold,
    ROUND(AVG(transportation_cost), 2)
        AS average_transportation_cost,
    ROUND(AVG(inventory_utilisation_pct), 2)
        AS average_inventory_utilisation
FROM supply_chain.inventory_records
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY year;
SELECT
    DATE_TRUNC('month', date)::DATE AS month,
    SUM(units_sold) AS total_units_sold
FROM supply_chain.inventory_records
GROUP BY DATE_TRUNC('month', date)
ORDER BY month;
SELECT
    DATE_TRUNC('month', date)::DATE AS month,
    ROUND(SUM(transportation_cost), 2)
        AS total_transportation_cost
FROM supply_chain.inventory_records
GROUP BY DATE_TRUNC('month', date)
ORDER BY month;
SELECT
    DATE_TRUNC('month', date)::DATE AS month,
    COUNT(*) FILTER (
        WHERE backorder = TRUE
    ) AS total_backorders,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*),
        2
    ) AS backorder_rate
FROM supply_chain.inventory_records
GROUP BY DATE_TRUNC('month', date)
ORDER BY month;
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM date) AS year,
        SUM(units_sold) AS total_units_sold
    FROM supply_chain.inventory_records
    GROUP BY EXTRACT(YEAR FROM date)
),
sales_comparison AS (
    SELECT
        year,
        total_units_sold,
        LAG(total_units_sold) OVER (
            ORDER BY year
        ) AS previous_year_units_sold
    FROM yearly_sales
)
SELECT
    year,
    total_units_sold,
    previous_year_units_sold,
    total_units_sold - previous_year_units_sold
        AS change_in_units_sold,
    ROUND(
        (
            total_units_sold - previous_year_units_sold
        ) * 100.0 / NULLIF(previous_year_units_sold, 0),
        2
    ) AS percentage_change
FROM sales_comparison
ORDER BY year;
-- 9. ADVANCED SQL ANALYSIS
WITH regional_costs AS (
    SELECT
        region,
        AVG(transportation_cost) AS average_cost
    FROM supply_chain.inventory_records
    GROUP BY region
),
overall_cost AS (
    SELECT
        AVG(transportation_cost) AS overall_average
    FROM supply_chain.inventory_records
)
SELECT
    r.region,
    ROUND(r.average_cost, 2) AS regional_average_cost,
    ROUND(o.overall_average, 2) AS overall_average_cost
FROM regional_costs r
CROSS JOIN overall_cost o
WHERE r.average_cost > o.overall_average
ORDER BY r.average_cost DESC;
WITH category_backorders AS (
    SELECT
        category,
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*) AS backorder_rate
    FROM supply_chain.inventory_records
    GROUP BY category
),
overall_backorder AS (
    SELECT
        COUNT(*) FILTER (
            WHERE backorder = TRUE
        ) * 100.0 / COUNT(*) AS overall_rate
    FROM supply_chain.inventory_records
)
SELECT
    c.category,
    ROUND(c.backorder_rate, 2) AS category_backorder_rate,
    ROUND(o.overall_rate, 2) AS overall_backorder_rate
FROM category_backorders c
CROSS JOIN overall_backorder o
WHERE c.backorder_rate > o.overall_rate
ORDER BY c.backorder_rate DESC;
SELECT
    warehouse,
    ROUND(AVG(inventory_utilisation_pct), 2)
        AS average_utilisation,
    RANK() OVER (
        ORDER BY AVG(inventory_utilisation_pct) DESC
    ) AS warehouse_rank
FROM supply_chain.inventory_records
GROUP BY warehouse;
SELECT
    supplier,
    ROUND(AVG(lead_time_days), 2) AS average_lead_time,
    DENSE_RANK() OVER (
        ORDER BY AVG(lead_time_days) DESC
    ) AS supplier_rank
FROM supply_chain.inventory_records
GROUP BY supplier;