DROP TABLE IF EXISTS sales_raw;

CREATE TABLE sales_raw (
  order_number  text,
  date          text,
  warehouse     text,
  client_type   text,
  product_line  text,
  quantity      int,
  unit_price    numeric(12,2),
  total         numeric(12,2),
  payment       text,
  payment_fee   numeric(6,4)
);
