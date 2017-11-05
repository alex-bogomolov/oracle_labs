CREATE OR REPLACE VIEW investments_in_current_year AS
    SELECT investors.first_name, investors.last_name, investments.name, investment_data.invest_amount,
           investment_data.investment_date
    FROM investment_data
    INNER JOIN investments ON investments.id = investment_data.investment_id
    INNER JOIN investors ON investors.id = investment_data.investor_id
    WHERE EXTRACT(YEAR FROM investment_data.investment_date) = EXTRACT(YEAR FROM SYSDATE)
    ORDER BY investment_data.investment_date;
COMMIT;