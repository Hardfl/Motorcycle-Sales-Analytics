CREATE OR REPLACE VIEW v_sales AS
SELECT
  order_number,
  (date::timestamptz)::date AS order_date,
  DATE_TRUNC('month', date::timestamptz)::date AS month_start,
  warehouse,
  client_type,
  product_line,
  quantity,
  unit_price,
  total AS gross_revenue,
  COALESCE(payment_fee, 0) AS payment_fee,
  (total * COALESCE(payment_fee, 0)) AS fee_amount,
  (total * (1 - COALESCE(payment_fee, 0))) AS net_revenue_after_fees,
  payment
FROM sales_raw;

CREATE OR REPLACE VIEW v_monthly_wholesale AS
SELECT
  month_start,
  warehouse,
  product_line,
  COUNT(*) AS orders,
  SUM(quantity) AS units_sold,
  SUM(gross_revenue) AS gross_revenue,
  SUM(fee_amount) AS fees_paid,
  SUM(net_revenue_after_fees) AS net_revenue
FROM v_sales
WHERE client_type = 'Wholesale'
GROUP BY month_start, warehouse, product_line
ORDER BY month_start, warehouse, product_line;
