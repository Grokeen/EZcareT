

select
PLS_DECRYPT_B64_ID(acnt_no, 800) , acnt_no
from ACPPEOPD
--not(acnt_no is null)
--acnt_no is not null
-- acnt_no != null
union

select
PLS_DECRYPT_B64_ID(acnt_no, 800) , acnt_no
from ACPPEIPD

union

select
PLS_DECRYPT_B64_ID(acnt_no, 800) , acnt_no
from ACPPEDPD

union
            ;
select
substr(A.ACNT_NO
from dual
;

select * from
ACPPEOPD
where pt_no = '01863828'
and rownum < 100;

select
-- SUBSTR(A.ACNT_NO,0,1)
-- 1xWC8ucRxVxV8russ1OOhA==
--,PLS_DECRYPT_B64_ID(A.ANCT_NO,100)
*
from
ACPPEIPD A
WHERE ROWNUM<100
-- AND  pt_no = '01863828'
ORDER BY APY_STR_DT;
where pt_no = '01863828';
and rpy_pact_id = 'MI0186382820221220';


SELECT
    PLS_DECRYPT_B64_ID(PT_RRN,800)
   ,A.*
FROM PCTPCPAM A WHERE ROWNUM < 10;

ACPPEDPD

ACPPEHRE
