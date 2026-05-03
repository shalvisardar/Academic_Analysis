SELECT
pd.result_type,	
COUNT(pd.id_student)
FROM
	prediction_data pd
GROUP BY
	pd.result_type