CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    offer_type VARCHAR(50),
    amount DECIMAL(10,2),
    created_at TIMESTAMP,
    company VARCHAR(100),
    product_name VARCHAR(200)
);

CREATE TABLE subventions (
    subvention_id VARCHAR(10) PRIMARY KEY,
    transaction_id INTEGER REFERENCES transactions(transaction_id),
    amount DECIMAL(10,2)
);

INSERT INTO transactions (transaction_id, user_id, offer_type, amount, created_at, company, product_name) VALUES
(1002, 43435, 'Fridge', 8.31, '2020-01-02 10:15:00', 'Bouygues', 'Tagliatelles'),
(1003, 43435, 'Fridge', 1.00, '2020-01-02 11:15:00', 'Bouygues', 'Coca-Cola'),
(1004, 43435, 'On-demand', 5.43, '2020-01-03 12:14:00', 'Bouygues', 'Penne légumes'),
(1005, 12411, 'Fridge', 4.13, '2020-01-03 09:14:00', 'Molitor', 'Chili Con Carne');

INSERT INTO subventions (subvention_id, transaction_id, amount) VALUES
('s123', 1002, 2.0),
('s124', 1002, 1.2),
('s125', 1004, 3.3),
('s126', 1005, 2.1);
