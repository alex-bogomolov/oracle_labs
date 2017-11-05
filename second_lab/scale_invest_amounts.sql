CREATE OR REPLACE PROCEDURE scale_invest_amounts
    (entered_investment_id NUMBER, percent NUMBER)
AS
   CURSOR rows IS SELECT id, invest_amount * percent AS scaled_invest_amount FROM investment_data WHERE investment_data.investment_id = entered_investment_id;
BEGIN
    FOR row IN rows
    LOOP
        UPDATE investment_data SET invest_amount = row.scaled_invest_amount WHERE id = row.id;
    END LOOP;
    recalculate_worth;
END;
/

