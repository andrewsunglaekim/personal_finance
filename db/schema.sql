DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS transactions;

CREATE TABLE users(
  id               SERIAL PRIMARY KEY,
  username         VARCHAR(25) NOT NULL UNIQUE,
  password_digest  TEXT NOT NULL
);

CREATE TABLE accounts(
  id               SERIAL PRIMARY KEY,
  name             TEXT NOT NULL,
  user_id          INTEGER NOT NULL
);

CREATE TABLE transactions(
  id               SERIAL PRIMARY KEY,
  transaction_type VARCHAR(50) NOT NULL,
  amount           INTEGER NOT NULL,
  account_id       INTEGER NOT NULL
)
