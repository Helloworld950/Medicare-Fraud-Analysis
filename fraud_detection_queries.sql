-- Query to identify Providers with high inpatient claim volumes and high average billing
SELECT 
    Inpatient.Provider, 
    COUNT(Inpatient.ClaimID) AS Total_Claims,
    SUM(Inpatient.InscClaimAmtReimbursed) AS Total_Reimbursed,
    AVG(Inpatient.InscClaimAmtReimbursed) AS Average_Claim_Amount
FROM Train_Inpatientdata AS Inpatient
JOIN Train_Beneficiarydata AS Beneficiary
    ON Inpatient.BeneID = Beneficiary.BeneID
WHERE Beneficiary.State = 10 -- Filtering for a specific state code before grouping
GROUP BY Inpatient.Provider
HAVING COUNT(Inpatient.ClaimID) > 20 -- Only looking at providers with significant volume
ORDER BY Average_Claim_Amount DESC;