CREATE TABLE work_shifts (
    employee TEXT,
    day TEXT,
    shift TEXT
);

INSERT INTO work_shifts (employee, day, shift) VALUES
('Alice', 'Monday', 'Morning'),
('Alice', 'Tuesday', 'Evening'),
('Bob', 'Monday', 'Night'),
('Bob', 'Wednesday', 'Morning'),
('Charlie', 'Tuesday', 'Night');

SELECT * FROM work_shifts;

--subquery
SELECT employee,day,shift,
	ROW_NUMBER() OVER( PARTITION BY day ORDER BY shift) AS rn
FROM work_shifts;

--query for pivioting

SELECT subquery.employee,
	MAX(CASE WHEN day = 'Monday' THEN shift END) AS mon_sft,
	MAX(CASE WHEN day = 'Tuesday' THEN shift END) AS tue_sft,
	MAX(CASE WHEN day = 'Wednesday' THEN shift END) AS wed_sft
FROM (
	SELECT employee,day,shift,
		ROW_NUMBER() OVER( PARTITION BY day ORDER BY shift) AS rn
	FROM work_shifts
) AS subquery
GROUP BY subquery.employee;