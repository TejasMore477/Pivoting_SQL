SELECT * FROM temperature_records;


SELECT EXTRACT(MONTH FROM record_date) AS month,
MAX(CASE WHEN data_type = 'max' THEN data_value END) as max_month_temp,
MIN(CASE WHEN data_type = 'min' THEN data_value END) as min_month_temp,
ROUND(AVG(CASE WHEN data_type = 'avg' THEN data_value END),0) as avg_month_temp
FROM temperature_records
GROUP BY  month
ORDER BY  month ASC