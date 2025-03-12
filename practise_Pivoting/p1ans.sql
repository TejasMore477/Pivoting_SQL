CREATE TABLE sales (
    employee TEXT,
    month TEXT,
    sales_amount INTEGER
);

INSERT INTO sales (employee, month, sales_amount) VALUES
('Alice', 'Jan', 5000),
('Alice', 'Feb', 7000),
('Bob', 'Jan', 6000),
('Bob', 'Mar', 8000),
('Charlie', 'Feb', 6500);

SELECT * FROM sales;


---- sub query
SELECT employee, month ,sales_amount,
ROW_NUMBER() OVER(PARTITION BY month ORDER BY sales_amount) AS rn
FROM sales;


---- PIVOTING QUERY
SELECT DISTINCT subquery.employee,
	MAX(CASE WHEN month = 'Jan' THEN sales_amount END) AS jan_sal,
	MAX(CASE WHEN month = 'Feb' THEN sales_amount END) AS feb_sal,
	MAX(CASE WHEN month = 'Mar' THEN sales_amount END) AS mar_sal
FROM (
		SELECT employee, month ,sales_amount,
		ROW_NUMBER() OVER(PARTITION BY month ORDER BY sales_amount) AS rn
		FROM sales
) AS subquery
GROUP BY subquery.employee
ORDER BY subquery.employee;
