{{ config(materialized = 'incremental',unique_key =['orderid', 'lineno']) }}
 
select a.order_id as orderid,
 a.line_no as lineno,
product_id as productid,
quantity,
unit_price as unitprice,
discount,
b.order_date from 
  {{ source('QWT_RAW','order_details') }} a
  inner join {{ source('QWT_RAW','orders') }} b
   on a.order_id = b.order_id


{% if is_incremental() %}

where b.order_date > (select max(orderdate) from {{this}} )

{% endif %}

