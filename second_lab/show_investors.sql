CREATE OR REPLACE FUNCTION show_investors
    (entered_investment_id NUMBER)
RETURN VARCHAR2
    
IS
    output VARCHAR2(80);
    CURSOR investor_rows IS SELECT investors.first_name, investors.last_name FROM investors INNER JOIN investment_data ON investment_data.investor_id = investors.id AND investment_data.investment_id = entered_investment_id;
    counter NUMBER;
BEGIN
    output := '';
    counter := 0;

    FOR row in investor_rows
    LOOP
        IF counter = 0 THEN
            output := output || row.first_name || ' ' || row.last_name;
            counter := counter + 1;
        ELSE
            output := output || ', ' || row.first_name || ' ' || row.last_name;
        END IF;
    END LOOP;

    RETURN output;
END;
/
