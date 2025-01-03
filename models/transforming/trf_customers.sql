{{config ( materialized = 'table', schema ='transforming')}}

 select a.customer_id ,
a.CompanyName ,
a.ContactName ,
a.City ,
a.country ,
b.Divisionname ,
a.Address ,
a.Fax ,
a.Phone ,
a.postalcode ,
IFF(a.stateprovince= '','NA',a.stateprovince) as stateprovince
 from 
 {{ ref('stg_customers') }} a
  left join {{ ref('lkp_divisions') }} b
   where a.divisionid=b.divisionid