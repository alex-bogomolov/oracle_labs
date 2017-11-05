CREATE OR REPLACE FUNCTION most_wealthy_investors
RETURN VARCHAR2
IS
    output VARCHAR2(255);
    current_amount NUMBER;
    CURSOR investor_rows IS select investors.id, investors.first_name, investors.last_name, SUM(investment_data.invest_amount) AS total_investments FROM investors INNER JOIN investment_data ON investment_data.investor_id = investors.id GROUP BY investors.id, investors.first_name, investors.last_name ORDER BY total_investments DESC, last_name, first_name;
BEGIN
    output := '';
    current_amount := -1;
    FOR row in investor_rows
    LOOP
        IF current_amount = -1 THEN
            current_amount := row.total_investments;
            output := output || row.first_name || ' ' || row.last_name;
            CONTINUE;
        END IF;

        IF current_amount = row.total_investments THEN
            output := output || ', ' || row.first_name || ' ' || row.last_name;
        ELSE
            EXIT;
        END IF;

    END LOOP;
    RETURN output;
END;
/
