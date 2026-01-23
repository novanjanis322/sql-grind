-- ============================================================
-- E-Commerce Star Schema
-- Week 3, Day 2 - Data Modeling Practice
-- ============================================================

-- ============================================================
-- DIMENSION TABLES
-- ============================================================

-- ------------------------------------------------------------
-- dim_date: Calendar dimension with pre-computed attributes
-- ------------------------------------------------------------
CREATE TABLE dim_date (
    date_key        INT PRIMARY KEY,          -- Smart key: YYYYMMDD
    full_date       DATE NOT NULL,            -- Natural key

    -- Calendar attributes
    day_of_week     VARCHAR(10),              -- 'Monday', 'Tuesday'...
    day_of_month    INT,
    day_of_year     INT,
    week_of_year    INT,
    month_num       INT,
    month_name      VARCHAR(10),
    quarter         INT,
    year            INT,

    -- Business attributes
    is_weekend      BOOLEAN,
    is_holiday      BOOLEAN,
    holiday_name    VARCHAR(50)
);

-- ------------------------------------------------------------
-- dim_product: Product attributes
-- ------------------------------------------------------------
CREATE TABLE dim_product (
    product_key     INT PRIMARY KEY,          -- Surrogate key
    product_id      VARCHAR(20) NOT NULL,     -- Natural key (from source)

    product_name    VARCHAR(100),
    category        VARCHAR(50),
    subcategory     VARCHAR(50),
    brand           VARCHAR(50),
    supplier        VARCHAR(100),
    unit_cost       DECIMAL(10,2),
    is_active       BOOLEAN DEFAULT TRUE
);

-- ------------------------------------------------------------
-- dim_customer: Customer attributes
-- ------------------------------------------------------------
CREATE TABLE dim_customer (
    customer_key    INT PRIMARY KEY,          -- Surrogate key
    customer_id     VARCHAR(20) NOT NULL,     -- Natural key (from source)

    customer_name   VARCHAR(100),
    email           VARCHAR(100),
    segment         VARCHAR(20),              -- 'Consumer', 'Corporate', 'SMB'
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(50),
    region          VARCHAR(20),
    signup_date     DATE,
    is_active       BOOLEAN DEFAULT TRUE
);

-- ------------------------------------------------------------
-- dim_store: Store/location attributes
-- ------------------------------------------------------------
CREATE TABLE dim_store (
    store_key       INT PRIMARY KEY,          -- Surrogate key
    store_id        VARCHAR(20) NOT NULL,     -- Natural key (from source)

    store_name      VARCHAR(100),
    store_type      VARCHAR(20),              -- 'Retail', 'Outlet', 'Warehouse'
    city            VARCHAR(50),
    state           VARCHAR(50),
    country         VARCHAR(50),
    region          VARCHAR(20),
    square_footage  INT,
    open_date       DATE
);

-- ============================================================
-- FACT TABLE
-- ============================================================

-- ------------------------------------------------------------
-- fact_sales: Grain = one row per product per transaction
-- ------------------------------------------------------------
CREATE TABLE fact_sales (
    sale_key        INT PRIMARY KEY,          -- Surrogate key (optional)

    -- Foreign keys to dimensions
    date_key        INT REFERENCES dim_date(date_key),
    product_key     INT REFERENCES dim_product(product_key),
    customer_key    INT REFERENCES dim_customer(customer_key),
    store_key       INT REFERENCES dim_store(store_key),

    -- Measures (numeric, aggregatable)
    quantity        INT,
    unit_price      DECIMAL(10,2),
    discount_amount DECIMAL(10,2),
    total_amount    DECIMAL(10,2)             -- quantity * unit_price - discount
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

-- dim_date (5 sample dates)
INSERT INTO dim_date VALUES
(20260115, '2026-01-15', 'Thursday',  15, 15, 3, 1, 'January',  1, 2026, FALSE, FALSE, NULL),
(20260116, '2026-01-16', 'Friday',    16, 16, 3, 1, 'January',  1, 2026, FALSE, FALSE, NULL),
(20260117, '2026-01-17', 'Saturday',  17, 17, 3, 1, 'January',  1, 2026, TRUE,  FALSE, NULL),
(20260118, '2026-01-18', 'Sunday',    18, 18, 3, 1, 'January',  1, 2026, TRUE,  FALSE, NULL),
(20260119, '2026-01-19', 'Monday',    19, 19, 4, 1, 'January',  1, 2026, FALSE, FALSE, NULL);

-- dim_product (5 products)
INSERT INTO dim_product VALUES
(1, 'PROD-001', 'Laptop Pro 15',      'Electronics', 'Computers',   'TechBrand',  'Supplier A', 800.00, TRUE),
(2, 'PROD-002', 'Wireless Mouse',     'Electronics', 'Accessories', 'TechBrand',  'Supplier A',  15.00, TRUE),
(3, 'PROD-003', 'Office Chair',       'Furniture',   'Chairs',      'ComfortCo',  'Supplier B', 150.00, TRUE),
(4, 'PROD-004', 'Standing Desk',      'Furniture',   'Desks',       'ComfortCo',  'Supplier B', 400.00, TRUE),
(5, 'PROD-005', 'Notebook Pack (10)', 'Supplies',    'Paper',       'OfficeMate', 'Supplier C',   5.00, TRUE);

-- dim_customer (5 customers)
INSERT INTO dim_customer VALUES
(1, 'CUST-001', 'Alice Johnson',  'alice@email.com',   'Consumer',   'New York',    'NY', 'USA', 'East',  '2024-03-15', TRUE),
(2, 'CUST-002', 'Bob Smith',      'bob@corp.com',      'Corporate',  'Los Angeles', 'CA', 'USA', 'West',  '2023-11-20', TRUE),
(3, 'CUST-003', 'Carol White',    'carol@startup.io',  'SMB',        'Chicago',     'IL', 'USA', 'North', '2025-01-10', TRUE),
(4, 'CUST-004', 'David Lee',      'david@email.com',   'Consumer',   'Houston',     'TX', 'USA', 'South', '2024-07-22', TRUE),
(5, 'CUST-005', 'Emma Brown',     'emma@bigcorp.com',  'Corporate',  'Seattle',     'WA', 'USA', 'West',  '2022-05-08', TRUE);

-- dim_store (3 stores)
INSERT INTO dim_store VALUES
(1, 'STORE-001', 'Downtown Flagship',  'Retail',    'New York',    'NY', 'USA', 'East',  50000, '2015-06-01'),
(2, 'STORE-002', 'West Coast Hub',     'Warehouse', 'Los Angeles', 'CA', 'USA', 'West',  80000, '2018-03-15'),
(3, 'STORE-003', 'Midwest Outlet',     'Outlet',    'Chicago',     'IL', 'USA', 'North', 25000, '2020-11-20');

-- fact_sales (10 transactions)
INSERT INTO fact_sales VALUES
(1,  20260115, 1, 1, 1, 1, 999.99,  50.00,  949.99),   -- Alice buys Laptop at Downtown
(2,  20260115, 2, 1, 1, 2,  29.99,   0.00,   59.98),   -- Alice buys 2 Mice at Downtown
(3,  20260116, 3, 2, 2, 3, 249.99,  25.00,  724.97),   -- Bob buys 3 Chairs at West Coast
(4,  20260116, 4, 2, 2, 1, 599.99,   0.00,  599.99),   -- Bob buys Standing Desk at West Coast
(5,  20260117, 1, 3, 3, 2, 999.99, 100.00, 1899.98),   -- Carol buys 2 Laptops at Midwest (weekend)
(6,  20260117, 5, 4, 1, 5,   9.99,   0.00,   49.95),   -- David buys 5 Notebook Packs at Downtown
(7,  20260118, 2, 5, 2, 3,  29.99,   3.00,   86.97),   -- Emma buys 3 Mice at West Coast (weekend)
(8,  20260119, 4, 1, 1, 2, 599.99,  60.00, 1139.98),   -- Alice buys 2 Desks at Downtown
(9,  20260119, 3, 3, 3, 1, 249.99,   0.00,  249.99),   -- Carol buys Chair at Midwest
(10, 20260119, 1, 5, 2, 1, 999.99,   0.00,  999.99);   -- Emma buys Laptop at West Coast

-- ============================================================
-- EXAMPLE ANALYTICAL QUERIES
-- ============================================================

-- Query 1: Total sales by product category by customer segment
SELECT
    p.category,
    c.segment,
    SUM(f.quantity) AS total_units,
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_customer c ON f.customer_key = c.customer_key
GROUP BY p.category, c.segment
ORDER BY total_revenue DESC;

-- Query 2: Weekend vs Weekday sales by store
SELECT
    s.store_name,
    d.is_weekend,
    COUNT(*) AS num_transactions,
    SUM(f.total_amount) AS total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY s.store_name, d.is_weekend
ORDER BY s.store_name, d.is_weekend;

-- Query 3: Full star join - Sales by all dimensions
SELECT
    d.full_date,
    d.day_of_week,
    p.product_name,
    p.category,
    c.customer_name,
    c.segment,
    s.store_name,
    s.region,
    f.quantity,
    f.total_amount
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_customer c ON f.customer_key = c.customer_key
JOIN dim_store s ON f.store_key = s.store_key
ORDER BY d.full_date, f.sale_key;

-- ============================================================

SELECT
    dp.brand
    ,AVG(fs.discount_amount) AS avg_discount
FROM 
    fact_sales fs
JOIN
    dim_product dp
ON
    fs.product_key = dp.product_key
GROUP BY
    dp.brand
;

SELECT
    dc.customer_name,
    SUM(fs.total_amount) AS total_revenue
FROM
    fact_sales fs
JOIN
    dim_customer dc
ON
    fs.customer_key = dc.customer_key
GROUP BY
    dc.customer_name
ORDER BY
    total_revenue DESC
LIMIT 3;

SELECT
    ds.region,
    dd.quarter,
    SUM(fs.total_amount) AS total_sales
FROM 
    fact_sales fs
JOIN
    dim_store ds
ON
    fs.store_key = ds.store_key
JOIN
    dim_date dd
ON
    fs.date_key = dd.date_key
GROUP BY
    ds.region,
    dd.quarter
ORDER BY
    fs.total_sales DESC;
