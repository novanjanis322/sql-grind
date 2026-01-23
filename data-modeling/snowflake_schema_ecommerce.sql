CREATE TABLE dim_category(
    category_key   INT PRIMARY KEY,
    category VARCHAR(100),
    subcategory VARCHAR(50)
);

CREATE TABLE dim_brand(
    brand_key  INT PRIMARY KEY,
    brand VARCHAR(50),
    supplier VARCHAR(100)
);

CREATE TABLE dim_product (
    product_key     INT PRIMARY KEY,          
    product_id      VARCHAR(20) NOT NULL,    
    product_name    VARCHAR(100),
    category_key    INT REFERENCES dim_category(category_key),
    brand_key       INT REFERENCES dim_brand(brand_key),
    unit_cost       DECIMAL(10,2),
    is_active       BOOLEAN DEFAULT TRUE
);

