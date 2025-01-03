{{config ( materialized = 'view', schema ='reporting')}}

select cust.companyname,
cust.contactname,
min(od.orderdate) as first_order_date,
max(od.orderdate) as recent_order_date,
count(prod.PRODUCTID) as total_products,
sum(od.quantity) as total_quantity,
sum(od.linesalesamount) as totallinesalesamt,
avg(od.margin) as avg_margin 
from 
    {{ ref('dim_products') }} prod
   
 inner join
   {{ ref('fct_orders') }} od
   on prod.productid = od.productid
       inner join
    {{ ref('dim_customers') }} cust
    on cust.customer_id=od.customerid
    group by companyname,contactname
    having first_order_date is not null
    order by totallinesalesamt desc