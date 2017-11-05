CREATE TABLE investment_data
    (
        id NUMBER(6),
        investor_id NUMBER(6) NOT NULL,
        investment_id NUMBER(6) NOT NULL,
        investment_date DATE NOT NULL,
        invest_amount NUMBER(9),
        CONSTRAINT investment_data_pk PRIMARY KEY(id),
        CONSTRAINT fk_investor
            FOREIGN KEY (investor_id)
            REFERENCES investors(id),
        CONSTRAINT fk_investment
            FOREIGN KEY (investment_id)
            REFERENCES investments(id)
    );
