select
   *
from MOMNMDRD
where ERLY_DS_DLY_TP_CD  = 2
and rownum < 10;


;;

select
   *
from MOMNMDRD
where ETC_DTL_CNTE is not null
and ERLY_DS_DLY_TP_CD  = 1
and rownum <10;


 SELECT /* 우선심사사유 HIS.PA.AI.IP.MG.SelectMomnmdrd */
       A.ETC_DTL_CNTE ,
       A.LSH_STF_NO||'('||B1.STF_NM||')' || TO_CHAR(A.LSH_DTM, 'YYYY-MM-DD HH24:MI') LSH_STF_NO ,
       TO_CHAR(A.LSH_DTM, 'YYYY-MM-DD HH24:MI') LSH_DTM
FROM   MOMNMDRD A ,
       CNLRRUSD B1
WHERE  A.PACT_ID = :IN_PACT_ID
AND    A.LSH_STF_NO = B1.STF_NO(+)
AND    A.ERLY_DS_DLY_TP_CD  = 1

AND    A.WRT_SEQ = (SELECT
                       MAX(WRT_SEQ)
                    FROM MOMNMDRD A
                    WHERE A.PACT_ID = :IN_PACT_ID
                      AND A.ERLY_DS_DLY_TP_CD  = 1  /* 조기퇴원구분코드 : 1 = 조기퇴원 */
                      AND ROWNUM = 1)
AND ROWNUM = 1


;

EXEC :IN_PACT_ID := '0000005972';


select
case when count(*) > 0  then 'Y'
   else 'N'
   end   as MOMNMDRD_YN
   from(
SELECT /* 퇴원지연사유 HIS.PA.AI.IP.MG.SelectMomnmdrd */
   A.DG_RTN_YN ,
       A.NR_ORD_ICMP_YN ,
       A.EXM_AFT_DS_YN ,
       A.OP_AFT_DS_YN ,
       A.IRSN_CMPL_YN,
       A.ETC_YN ,
       A.ETC_DTL_CNTE ,
       A.IRSN_CMPL_YN ,
       A.LSH_STF_NO||'('||B1.STF_NM||')' || TO_CHAR(A.LSH_DTM, 'YYYY-MM-DD HH24:MI') LSH_STF_NO ,
       TO_CHAR(A.LSH_DTM, 'YYYY-MM-DD HH24:MI') LSH_DTM,
        A.PROR_PT_REQ_YN
FROM   MOMNMDRD A ,
       CNLRRUSD B1
WHERE  A.PACT_ID = :IN_PACT_ID
AND    A.LSH_STF_NO = B1.STF_NO(+)
AND    A.ERLY_DS_DLY_TP_CD  = 1

AND    A.WRT_SEQ = (SELECT
                       MAX(WRT_SEQ)
                    FROM MOMNMDRD A
                    WHERE A.PACT_ID = :IN_PACT_ID
                      AND A.ERLY_DS_DLY_TP_CD  = 1  /* 조기퇴원구분코드 : 1 = 조기퇴원 */
                      AND ROWNUM = 1)
AND ROWNUM = 1)) a




;;;





SELECT
   FT_ACP_DELAY_REASON_YN('1','MI0011327320100514')
FROM DUAL;



;;


SELECT * FROM MOMNMDRD WHERE ERLY_DS_DLY_TP_CD  = 2
AND PACT_ID = 'MI0011327320100514'
;

SELECT  'Y'

              FROM  MOMNMDRD
             WHERE  PACT_ID =  'MI0011327320100514'
               AND  ERLY_DS_DLY_TP_CD  = 2
               AND  WRT_SEQ = (SELECT MAX(WRT_SEQ)
                                   FROM MOMNMDRD
                                  WHERE PACT_ID =  'MI0011327320100514'
                                    AND ERLY_DS_DLY_TP_CD  = 2  /* 조기퇴원구분코드 : 2 = 퇴원지연 */
                                    AND ROWNUM = 1)
               AND (  DG_RTN_YN = 'Y'
                   OR NR_ORD_ICMP_YN = 'Y'
                   OR EXM_AFT_DS_YN = 'Y'
                   OR OP_AFT_DS_YN = 'Y'
                   OR IRSN_CMPL_YN= 'Y'
                   OR ETC_YN = 'Y' )
               --AND FSR_DTM BETWEEN TRUNC(SYSDATE)
               --                AND TRUNC(SYSDATE)+0.99999 --추가된부분(일자조건).
               AND ROWNUM = 1
;
