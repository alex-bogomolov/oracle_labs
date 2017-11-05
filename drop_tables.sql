DROP TABLE investment_data PURGE;
DROP TABLE investors PURGE;
DROP TABLE investments PURGE;
DROP VIEW investors_by_city;
DROP VIEW investment_summary;
DROP VIEW investments_in_current_year;
DROP FUNCTION align;
DROP PROCEDURE recalculate_worth;
DROP SYNONYM holders;

COMMIT;