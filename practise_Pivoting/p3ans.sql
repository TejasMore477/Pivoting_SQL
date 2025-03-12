CREATE TABLE exam_scores (
    student TEXT,
    subject TEXT,
    score INT
);

INSERT INTO exam_scores (student, subject, score) VALUES
('Alice', 'Math', 85),
('Alice', 'Science', 90),
('Bob', 'Math', 78),
('Bob', 'History', 88),
('Charlie', 'Science', 92);

SELECT * FROM exam_scores;

-- subquery
SELECT student, subject,score,
	ROW_NUMBER() OVER( PARTITION BY subject ORDER BY score) AS rn
FROM exam_scores;

-- pivoting query
SELECT subquery.student,
	MAX(CASE WHEN subject = 'History' THEN score END) AS History,
	MAX(CASE WHEN subject = 'Math' THEN score END) AS Math,
	MAX(CASE WHEN subject = 'Science' THEN score END) AS Science
FROM (
	SELECT student, subject,score,
		ROW_NUMBER() OVER( PARTITION BY subject ORDER BY score) AS rn
	FROM exam_scores
) AS subquery
GROUP BY subquery.student
ORDER BY subquery.student;
	