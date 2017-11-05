CREATE OR REPLACE PROCEDURE recalculate_worth
AS
   CURSOR totals IS SELECT investments.id AS id, SUM(investment_data.invest_amount) AS total FROM investments INNER JOIN investment_data ON investment_data.investment_id = investments.id GROUP BY investments.id;
BEGIN
    FOR row IN totals
    LOOP
        UPDATE investments SET worth = row.total WHERE id = row.id;
    END LOOP;
END;
/
COMMIT;
