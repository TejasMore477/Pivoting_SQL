-- What Does "Pivot the Table" Mean?
-- In SQL, pivoting a table means transforming rows into columns to make data easier to read and analyze.

CREATE DATABASE pivot_table;

CREATE TABLE OCCUPATIONS (
    Name VARCHAR(50),
    Occupation VARCHAR(50)
);

INSERT INTO OCCUPATIONS (Name, Occupation) VALUES 
('Alice', 'Doctor'),
('Bob', 'Actor'),
('Charlie', 'Professor'),
('David', 'Singer'),
('Eve', 'Doctor'),
('Frank', 'Actor'),
('Grace', 'Singer'),
('Helen', 'Professor');

SELECT * FROM OCCUPATIONS;
----------SUB QUERY
SELECT Name, Occupation, 
	ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
FROM OCCUPATIONS

---------PIVOTING QUERY
SELECT 
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM (
    SELECT Name, Occupation, 
           ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) AS subquery
GROUP BY rn;



