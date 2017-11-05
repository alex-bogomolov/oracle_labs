CREATE OR REPLACE PROCEDURE recalculate_worth AS
   amount NUMBER;
   BEGIN
    FOR investment IN ( SELECT id FROM investments )
    LOOP
        amount := 0;
        FOR investment_data_row IN (SELECT invest_amount FROM investment_data WHERE investment_id = investment.id)
        LOOP
            amount := amount + investment_data_row.invest_amount;
        END LOOP;
        UPDATE investments SET worth = amount WHERE id = investment.id;
    END LOOP; 
   END;
/
COMMIT;
