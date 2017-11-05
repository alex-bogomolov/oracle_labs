CREATE TABLE investors
    (
        id NUMBER(6),
        first_name VARCHAR(20) NOT NULL,
        last_name VARCHAR(20) NOT NULL,
        email VARCHAR(50) NOT NULL,
        city VARCHAR(20) NOT NULL,
        CONSTRAINT investor_pk PRIMARY KEY(id)
    );

COMMIT;