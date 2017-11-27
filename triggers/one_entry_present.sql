CREATE OR REPLACE TRIGGER ONE_ENTRY_PRESENT
FOR DELETE ON INVESTMENT_DATA
COMPOUND TRIGGER

  TYPE INVESTMENTS_IDS IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
  ids INVESTMENTS_IDS;

  BEFORE EACH ROW IS
  BEGIN
    ids(:OLD.INVESTMENT_ID) := (:OLD.INVESTMENT_ID);
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
    i                     PLS_INTEGER;
    investment_data_count NUMBER;
  BEGIN
    i := ids.FIRST;

    WHILE i IS NOT NULL LOOP
      SELECT COUNT(*)
      INTO investment_data_count
      FROM INVESTMENT_DATA
      WHERE INVESTMENT_ID = ids(i);
      IF investment_data_count < 1
      THEN
        RAISE_APPLICATION_ERROR(-20007, 'Investment (' || ids(i) || ') has no investment data');
      END IF;
      i := ids.NEXT(i);
    END LOOP;
  END AFTER STATEMENT;

END ONE_ENTRY_PRESENT;