INSERT INTO investments VALUES (1, 'Investment1', 150000, 'Address1', 'Kharkiv', 'Ukraine', 5000, 50000, 100000, 1);
INSERT INTO investments VALUES (2, 'Investment2', 300000, 'Address2', 'Kyiv', 'Ukraine', 15000, 50000, 125000, 0);
INSERT INTO investments VALUES (3, 'Investment3', 50000, 'Address3', 'Lviv', 'Ukraine', 30000, 50000, 75000, 0);

INSERT INTO investors VALUES (1, 'Alex', 'Bogomolov', 'alexbogomolov.kharkiv@gmail.com', 'Kharkiv');
INSERT INTO investors VALUES (2, 'Name1', 'LastName1', 'email1@gmail.com', 'Kyiv');
INSERT INTO investors VALUES (3, 'Name2', 'LastName2', 'email2@gmail.com', 'Kyiv');
INSERT INTO investors VALUES (4, 'Name3', 'LastName3', 'email3@gmail.com', 'Lvyv');

INSERT INTO investment_data VALUES(1, 1, 1,  DATE '2016-01-01', 50000);
INSERT INTO investment_data VALUES(2, 2, 1,  DATE '2016-02-01', 15000);
INSERT INTO investment_data VALUES(3, 3, 1,  DATE '2017-03-01', 25000);

INSERT INTO investment_data VALUES(4, 1, 2,  DATE '2017-04-01', 50000);
INSERT INTO investment_data VALUES(5, 2, 2,  DATE '2017-05-01', 75000);

INSERT INTO investment_data VALUES(6, 1, 3,  DATE '2017-06-01', 95000);

INSERT INTO investment_data VALUES(7, 4, 3, DATE '2017-07-01', 25000);

COMMIT;