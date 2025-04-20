CREATE TABLE sales(
	invoice_id VARCHAR(20),
	branch VARCHAR(5),
	city VARCHAR(50),
	customer_type VARCHAR(20),
	 gender VARCHAR(10),
    product_line VARCHAR(50),
    unit_price NUMERIC(10, 2),
    quantity INT,
    tax_5 NUMERIC(10, 2),
    total NUMERIC(10, 2),
    date DATE,
    time TIME,
    payment VARCHAR(20),
    cogs NUMERIC(10, 2),
    gross_margin_percentage NUMERIC(5, 2),
    gross_income NUMERIC(10, 2),
    rating NUMERIC(3, 1)
);
COPY sales FROM 'C:/supermarket_sales.csv'
DELIMITER ',' CSV HEADER;

SELECT* FROM sales LIMIT 10;

SELECT SUM(total) AS total_revenue FROM sales;

SELECT city, SUM (total) AS total_sales
FROM sales
GROUP BY city
ORDER BY total_sales DESC;

SELECT gender, COUNT(*) AS total_customers
FROM sales
GROUP BY gender;


SELECT product_line, ROUND(AVG(rating), 2) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;


SELECT payment, COUNT(*) AS total_transactions
FROM sales
GROUP BY payment
ORDER BY total_transactions DESC;


SELECT date, SUM(total) AS daily_sales
FROM sales
GROUP BY date
ORDER BY date;


SELECT EXTRACT(HOUR FROM time::time) AS hour, COUNT(*) AS sales_count
FROM sales
GROUP BY hour
ORDER BY sales_count DESC;


SELECT city, SUM(total) AS total_sales
FROM sales
GROUP BY city
HAVING SUM(total) > (
    SELECT AVG(total) FROM sales
);


SELECT city, SUM(total) AS total_sales,
       RANK() OVER (ORDER BY SUM(total) DESC) AS sales_rank
FROM sales
GROUP BY city;

SELECT date, SUM(total) AS daily_sales,
	SUM(SUM(total)) OVER (ORDER BY date) AS running_total
FROM sales
GROUP BY date
ORDER BY date;

SELECT product_line, SUM(total) AS total_sales
FROM sales
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1;