CREATE VIEW student_score_details AS
SELECT
	CONCAT(a.code_module, '-' , a.code_presentation, '-' , sa.id_student) AS virtual_pik,
	a.code_module,
	a.code_presentation,
	sa.id_student,
	sa.id_assessment,
	a.assessment_type,
	sa.score
FROM
	student_assessments sa
LEFT JOIN
	assessments a
	ON
	sa.id_assessment = a.id_assessment