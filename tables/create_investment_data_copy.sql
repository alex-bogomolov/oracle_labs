CREATE TABLE investment_data_copy
    (
        id NUMBER(6),
        investor_id NUMBER(6) NOT NULL,
        investment_id NUMBER(6) NOT NULL,
        investment_date DATE NOT NULL,
        invest_amount NUMBER(9),
        CONSTRAINT investment_data_copy_pk PRIMARY KEY(id)
    );
