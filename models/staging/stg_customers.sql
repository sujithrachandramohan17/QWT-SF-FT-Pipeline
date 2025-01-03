{{config ( materialized = 'table')}}
 select CUSTOMER_ID,
  COMPANY_NAME as companyname, CONTACT_NAME as contactname, 
  CITY, COUNTRY, DIVISION_ID as divisionid, 
 ADDRESS, FAX, PHONE, POSTAL_CODE as  postalcode, STATE_PROVINCE as stateprovince 
 from 
 {{ source('QWT_RAW','customers') }}