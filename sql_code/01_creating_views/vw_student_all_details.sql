CREATE VIEW student_all_details AS
WITH demographic_details AS(
	SELECT
		sr.code_module,
		sr.code_presentation,
		sr.id_student,
		sd.gender,
		sd.region,
		sd.highest_education,
		sd.imd_band,
		sd.age_band,
		sd.disability
	FROM
		student_registration sr
	LEFT JOIN
		student_details sd
		ON
		sr.id_student = sd.id_student
)

SELECT
	CONCAT(dd.code_module, '-' , dd.code_presentation, '-' , dd.id_student) AS virtual_pik,
	dd.*,
	sv.site_count,
	sa.num_of_prev_attempts,
	sa.studied_credits,
	sa.final_result
FROM
	demographic_details dd
LEFT JOIN
	student_vle sv 
	ON
	(dd.code_module = sv.code_module) AND
	(dd.code_presentation = sv.code_presentation) AND
	(dd.id_student = sv.id_student)
LEFT JOIN
	student_academics sa
	ON
	(dd.code_module = sa.code_module) AND
	(dd.code_presentation = sa.code_presentation) AND
	(dd.id_student = sa.id_student)