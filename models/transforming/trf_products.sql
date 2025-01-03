{{config ( materialized = 'table', schema ='transforming')}}

 select 
 a.PRODUCTID, a.PRODUCTNAME, a.SUPPLIERID, a.CATEGORYID, 
 a.QUANTITYPERUNIT, a.UNITCOST, UNITPRICE, UNITSINSTOCK, 
 a.UNITSONORDER,
(a.unitprice-a.unitcost) as profit,
case when a.UNITSINSTOCK > a.UNITSONORDER
     THEN 'YES'
      else 'NO'
 end as availability
 ,b.categoryname 
 ,c.CompanyName as suppliercompnayname
 ,c.ContactName as suppliercontactname
 ,c.city as suppliercity
 ,c.country as suppliercountry
 
 from 
 {{ ref('stg_products') }} a
  left join
   {{ ref('lkp_categories') }} b    on    a.categoryid=b.categoryid
     left join
   {{ ref('trf_suppliers') }} c    on    a.supplierid=c.supplierid


  