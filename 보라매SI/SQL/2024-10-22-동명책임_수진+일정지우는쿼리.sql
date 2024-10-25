
-- Ctrl + Shift + E
select     *
from acpprodm
where pt_no = '97979797'
and med_dt = trunc(sysdate)


-- acpprore
;;;
select     *
from acpprore
where rpy_pact_id IN (select RPY_PACT_ID
											from acpprodm
											where pt_no = '97979797'
											and med_dt = trunc(sysdate)   )

;;

SELECT
   *
FROM ACDPCSCD
WHERE MEDR_STF_NO IN ('01903', '01111')
AND MED_DTM BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + .99999
AND MED_DTM IN (TO_DATE('202410222222', 'YYYYMMDDHH24MI') , TO_DATE('202410222223', 'YYYYMMDDHH24MI') )
