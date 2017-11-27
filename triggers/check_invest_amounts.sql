CREATE OR REPLACE TRIGGER CHECK_INVEST_AMOUNTS
FOR UPDATE OR INSERT ON INVESTMENT_DATA
COMPOUND TRIGGER
  TYPE INVESTMENTS_IDS IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  ids INVESTMENTS_IDS;

  BEFORE EACH ROW IS
    min_invest_amount NUMBER(6);
    max_invest_amount NUMBER(6);
  BEGIN
    SELECT MIN_INVEST_AMOUNT
    INTO min_invest_amount
    FROM INVESTMENTS
    WHERE ID = :NEW.INVESTMENT_ID;

    SELECT MAX_INVEST_AMOUNT
    INTO max_invest_amount
    FROM INVESTMENTS
    WHERE ID = :NEW.INVESTMENT_ID;

    IF :NEW.INVEST_AMOUNT < min_invest_amount THEN
      :NEW.INVEST_AMOUNT := min_invest_amount;
    END IF;

    IF :NEW.INVEST_AMOUNT > max_invest_amount THEN
      :NEW.INVEST_AMOUNT := max_invest_amount;
    END IF;

    ids(:NEW.INVESTMENT_ID) := :NEW.INVESTMENT_ID;
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
    i PLS_INTEGER;
    total_invest_amount NUMBER;
    max_total_inv_amount NUMBER;
    inv_id NUMBER;
  BEGIN
    i := ids.FIRST;

    WHILE i IS NOT NULL LOOP
      inv_id := ids(i);

      SELECT SUM(INVEST_AMOUNT) INTO total_invest_amount FROM INVESTMENT_DATA WHERE INVESTMENT_ID = inv_id;

      SELECT MAX_TOTAL_INVEST_AMOUNT INTO max_total_inv_amount FROM INVESTMENTS WHERE ID = inv_id;

      IF total_invest_amount > max_total_inv_amount THEN
        RAISE_APPLICATION_ERROR(-20008, 'Total invest amount for investment (' || inv_id || ') is ' || total_invest_amount || ' and it can not be bigger than ' || max_total_inv_amount);
      END IF;

      i := ids.NEXT(i);
    END LOOP;
  END AFTER STATEMENT;
END CHECK_INVEST_AMOUNTS;
