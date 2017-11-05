CREATE OR REPLACE PACKAGE BODY IRS IS
FUNCTION ALIGN
    (first_string IN varchar2, desired_length IN NUMBER, direction IN varchar2)
    RETURN varchar2
IS
    output varchar2(255);
    characters_to_add NUMBER;
    add_to_left NUMBER;
    add_to_right NUMBER;
    counter NUMBER;
BEGIN
output := first_string;
IF NOT (direction = 'left' OR direction = 'right' OR direction = 'center') THEN
    RETURN output;
ENd IF;
IF LENGTH(first_string) >= desired_length THEN
    RETURN output;
END IF;

IF direction = 'left' THEN
    WHILE LENGTH(output) < desired_length
    LOOP
        output := output || ' ';
    END LOOP;
ELSIF direction = 'right' THEN
    WHILE LENGTH(output) < desired_length
    LOOP
        output := ' ' || output;
    END LOOP;
ELSIF direction = 'center' THEN
    characters_to_add := desired_length - LENGTH(first_string);
    add_to_left := ROUND(characters_to_add / 2);
    add_to_right := characters_to_add - add_to_left;

    counter := 0;
    WHILE counter < add_to_left
    LOOP
        output := ' ' || output;
        counter := counter + 1;
    END LOOP;

    counter := 0;
    WHILE counter < add_to_right
    LOOP
        output := output || ' ';
        counter := counter + 1;
    END LOOP;
END IF;

RETURN output;
END ALIGN;

FUNCTION MOST_WEALTHY_INVESTORS
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
END MOST_WEALTHY_INVESTORS;

PROCEDURE SCALE_INVEST_AMOUNTS
    (entered_investment_id NUMBER, percent NUMBER)
AS
   CURSOR rows IS SELECT id, invest_amount * percent AS scaled_invest_amount FROM investment_data WHERE investment_data.investment_id = entered_investment_id;
BEGIN
    FOR row IN rows
    LOOP
        UPDATE investment_data SET invest_amount = row.scaled_invest_amount WHERE id = row.id;
    END LOOP;
    recalculate_worth;
END SCALE_INVEST_AMOUNTS;

FUNCTION SHOW_INVESTORS
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

PROCEDURE RECALCULATE_WORTH
AS
   CURSOR totals IS SELECT investments.id AS id, SUM(investment_data.invest_amount) AS total FROM investments INNER JOIN investment_data ON investment_data.investment_id = investments.id GROUP BY investments.id;
BEGIN
    FOR row IN totals
    LOOP
        UPDATE investments SET worth = row.total WHERE id = row.id;
    END LOOP;
END RECALCULATE_WORTH;

PROCEDURE DECREASE_INVEST_AMOUNT
    (entered_investment_id NUMBER, difference NUMBER)
AS
    CURSOR rows IS SELECT investment_data.id, invest_amount, investments.min_invest_amount FROM investment_data INNER JOIN investments ON investments.id = investment_data.investment_id WHERE investment_data.investment_id = entered_investment_id;
    negative_difference EXCEPTION;
    too_small_invest_amount EXCEPTION;
    difference_not_round EXCEPTION;
    too_small_difference EXCEPTION;
    new_invest_amount NUMBER;
BEGIN
    IF difference < 0 THEN
        RAISE negative_difference;
    END IF;
    IF difference < 1000 THEN
        RAISE too_small_difference;
    END IF;
    IF NOT MOD(difference, 10) = 0 THEN
        RAISE difference_not_round;
    END IF;

    FOR row IN rows
    LOOP
        new_invest_amount := row.invest_amount - difference;
        IF new_invest_amount < row.min_invest_amount THEN
            RAISE too_small_invest_amount;
        END IF;

        UPDATE investment_data SET invest_amount = new_invest_amount WHERE id = row.id;
    END LOOP;

    recalculate_worth;
EXCEPTION
WHEN negative_difference THEN
raise_application_error(-20001, 'difference must be a positive number');
WHEN difference_not_round THEN
raise_application_error(-20002, 'difference must be a round number');
WHEN too_small_difference THEN
raise_application_error(-20003, 'difference must be greater than 1000');
WHEN too_small_invest_amount THEN
raise_application_error(-20004, 'difference is too big: one of invest amounts is less than minimum invest amount');
END;

END IRS;
/