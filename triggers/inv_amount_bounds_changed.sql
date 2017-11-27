CREATE OR REPLACE TRIGGER inv_amount_bounds_changed
FOR UPDATE ON INVESTMENTS
COMPOUND TRIGGER
  TYPE INVESTMENTS_IDS IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  ids INVESTMENTS_IDS;

  BEFORE EACH ROW IS
    min_invest_amount NUMBER(6);
    max_invest_amount NUMBER(6);
  BEGIN
    IF UPDATING('MIN_INVEST_AMOUNT') OR UPDATING('MAX_INVEST_AMOUNT') THEN
      ids(:OLD.ID) := :OLD.ID;
    END IF;
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
    i PLS_INTEGER;
    inv_id NUMBER;
    CURSOR inv_data IS SELECT * FROM INVESTMENT_DATA WHERE INVESTMENT_ID = inv_id;
    max_inv_amount NUMBER;
    min_inv_amount NUMBER;
  BEGIN
    i := ids.FIRST;

    WHILE i IS NOT NULL LOOP
      inv_id := ids(i);

      SELECT MAX_INVEST_AMOUNT INTO max_inv_amount FROM INVESTMENTS WHERE ID = inv_id;
      SELECT MIN_INVEST_AMOUNT INTO min_inv_amount FROM INVESTMENTS WHERE ID = inv_id;

      FOR r IN inv_data LOOP
        IF r.INVEST_AMOUNT > max_inv_amount THEN
          UPDATE INVESTMENT_DATA SET INVEST_AMOUNT = max_inv_amount WHERE ID = r.ID;
        END IF;

        IF r.INVEST_AMOUNT < min_inv_amount THEN
          UPDATE INVESTMENT_DATA SET INVEST_AMOUNT = min_inv_amount WHERE ID = r.ID;
        END IF;

      END LOOP;

      i := ids.NEXT(i);
    END LOOP;
  END AFTER STATEMENT;
END inv_amount_bounds_changed;
