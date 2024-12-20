


 select
       A.CHOT_DTM
--     , a.MED_RSV_DTE
     , a.*
      --,count(*) as cnt
 from ACPPRETM a
where 1=1
 and CHOT_DTM >= '2024-12-12';
 and pt_no = '01741540'


;

HIS.PA.AC.PC.OP.EMERGENCYMEDCOSTRECEIVEPAYMENTMNG_01
;

 select
      a.*
      --,count(*) as cnt
 from ACPPEDPD a
where 1=1
 and pt_no = '01741540'



;
SELECT PT_RRN
      ,SUBSTR(PT_RRN,0,6) || '-' || SUBSTR(PT_RRN,7,1) ||'******'
FROM PCTPCPAM
WHERE PT_NO = '01741540'
