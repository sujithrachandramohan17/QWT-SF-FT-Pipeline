{{config ( materialized = 'table', schema ='transforming')}}

 select a.ORDERID, a.ORDERDATE, a.CUSTOMERID, a.EMPLOYEEID, a.SHIPPERID, a.FREIGHT,
 b.LINENO, b.QUANTITY, b.UNITPRICE, b.DISCOUNT,
c.PRODUCTID, c.PRODUCTNAME, c.SUPPLIERID, c.CATEGORYID, c.QUANTITYPERUNIT, 
c.UNITCOST, c.UNITSINSTOCK, c.UNITSONORDER,
((b.unitprice*b.quantity)*(1-b.discount)) as linesalesamount,
(c.unitcost*b.quantity ) as costofsoldgoods,
(((b.unitprice*b.quantity)*(1-b.discount)) - (c.unitcost*b.quantity)) as margin

 from 
 {{ ref('stg_orders') }} a
  inner join {{ ref('stg_orderdetails') }} b
 on a.orderid=b.orderid
   inner join {{ ref('stg_products') }} c
   on b.productid=c.productid