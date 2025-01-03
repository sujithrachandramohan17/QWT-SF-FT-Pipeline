{{config ( materialized = 'table', schema ='transforming')}}

 select 
ss.orderid,
ss.lineno,
ss.shipmentdate,
ss.status,
sh.companyname as shipmentcompany_name
 from 
 {{ ref('shipments_snapshot') }} ss
 inner join
   {{ ref('lkp_shippers') }} sh   on    ss.shipperid=sh.shipperid
    where dbt_valid_to is null
