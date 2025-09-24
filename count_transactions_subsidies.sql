SELECT COUNT(DISTINCT t.transaction_id) AS transactions_with_subsidy
FROM transactions t
INNER JOIN subventions s ON t.transaction_id = s.transaction_id;
