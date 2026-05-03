CREATE VIEW student_full_acad AS 
WITH student_scores AS(
SELECT
	sa.id_student,
	a.code_module,
	a.code_presentation,
	AVG(sa.score) AS average_score
FROM
	student_assessments sa 
LEFT JOIN
	assessments a 
	ON
	sa.id_assessment = a.id_assessment 
GROUP BY
	sa.id_student,
	a.code_module,
	a.code_presentation
)

SELECT
	ss.id_student,
	ss.code_module,
	ss.code_presentation,
	sv.site_count,
	sa.num_of_prev_attempts,
	sa.studied_credits,
	ss.average_score,
	sa.final_result
FROM
	student_scores ss
LEFT JOIN
	student_academics sa 
	ON
	(ss.id_student = sa.id_student) AND 
	(ss.code_presentation = sa.code_presentation) AND
	(ss.code_module = sa.code_module)
LEFT JOIN
	student_vle sv
	ON
	(ss.id_student = sv.id_student) AND 
	(ss.code_presentation = sv.code_presentation) AND
	(ss.code_module = sv.code_module)