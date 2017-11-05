CREATE TABLE investments
    (
        id NUMBER(6),
        name VARCHAR(30) NOT NULL,
        worth NUMBER(9) NOT NULL,
        address VARCHAR(50) NOT NULL,
        city VARCHAR(30) NOT NULL,
        country VARCHAR(30) NOT NULL,
        CONSTRAINT investment_pk PRIMARY KEY(id)
    );

COMMIT;