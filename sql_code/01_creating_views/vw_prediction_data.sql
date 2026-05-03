CREATE VIEW prediction_data AS
WITH at_risk_values AS(
	SELECT
		arp.code_module,
		arp.code_presentation,
		arp.id_student,
		arp."CMA",
		arp."TMA",
		arp."Exam",
		arp.final_result,
		CASE 
			WHEN arp.final_result = 'Pass' THEN 0
			WHEN arp.final_result = 'Distinction' THEN 0
			ELSE 1
		END AS at_risk,
		arp.predicted_risk,
		CASE 
			WHEN arp.predicted_risk = 0 THEN 'Safe'
			ELSE 'At-risk'
		END AS predicted_result
	FROM
		at_risk_predictions arp
	ORDER BY
		arp.code_module,
		arp.code_presentation
)

SELECT
	CONCAT(arv.code_module, '-' , arv.code_presentation, '-' , arv.id_student) AS virtual_pik,
	arv.*,
	CASE
		WHEN arv.at_risk = 1 AND arv.predicted_risk = 1 THEN 'True Positive'
		WHEN arv.at_risk = 1 AND arv.predicted_risk = 0 THEN 'False Positive'
		WHEN arv.at_risk = 0 AND arv.predicted_risk = 1 THEN 'False Negative'
		ELSE 'True Negative'
	END AS result_type
FROM
	at_risk_values arv