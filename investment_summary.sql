CREATE OR REPLACE VIEW investment_summary AS
    SELECT investments.id, investments.name, SUM(investment_data.invest_amount) "invest_amount"
    FROM investment_data 
    INNER JOIN investments ON investments.id = investment_data.investment_id
    INNER JOIN investors ON investors.id = investment_data.investor_id
    GROUP BY investments.id, investments.name
    ORDER BY "invest_amount" DESC;
    
