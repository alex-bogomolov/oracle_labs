CREATE TABLE investments
(
  id                      NUMBER(6),
  name                    VARCHAR(30) NOT NULL,
  worth                   NUMBER(9)   NOT NULL,
  address                 VARCHAR(50) NOT NULL,
  city                    VARCHAR(30) NOT NULL,
  country                 VARCHAR(30) NOT NULL,
  min_invest_amount       NUMBER(9)   NOT NULL,
  max_invest_amount       NUMBER(9)   NOT NULL,
  max_total_invest_amount NUMBER(9)   NOT NULL,
  marked                  NUMBER(1)   NOT NULL,
  CONSTRAINT investment_pk PRIMARY KEY (id)
);
