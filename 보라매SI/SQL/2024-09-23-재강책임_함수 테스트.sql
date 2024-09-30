EXEC :IN_PACT_ID := '0000005972';

SELECT
   :IN_PACT_ID AS PACT_ID
   ,MOMNMDRD_YN
   ,AIMIAIDDD_YN
FROM
(


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
AND    A.ERLY_DS_DLY_TP_CD  = 2

AND    A.WRT_SEQ = (SELECT
                       MAX(WRT_SEQ)
                    FROM MOMNMDRD A
                    WHERE A.PACT_ID = :IN_PACT_ID
                      AND A.ERLY_DS_DLY_TP_CD  = 2  /* 조기퇴원구분코드 : 2 = 퇴원지연 */
                      AND ROWNUM = 1)
AND ROWNUM = 1)) a,



(select
case when count(*) > 0  then 'Y'
   else 'N'
   end   as AIMIAIDDD_YN
   from(
SELECT /*우선심사사유 : HIS.PA.AI.IP.MG.SelectAimiaidd*/
       TO_CHAR(A.FSR_DTM, 'YYYY-MM-DD HH24:MI')FSR_DTM ,
       A.FSR_STF_NO||'('||B1.STF_NM||')' || TO_CHAR(A.FSR_DTM, 'YYYY-MM-DD HH24:MI') FSR_STF_NO,
       TO_CHAR(A.LSH_DTM, 'YYYY-MM-DD HH24:MI') LSH_DTM,
       A.LSH_STF_NO ||'('||B2.STF_NM||')' || TO_CHAR(A.LSH_DTM, 'YYYY-MM-DD HH24:MI') LSH_STF_NO,
       A.OP_FEE_CFMT_YN ,
       A.ANST_FEE_CFMT_YN ,
       A.OP_MTRL_CFMT_YN ,
       A.SRIL_RRNS_RLV_YN ,
       A.PME_CFMT_YN ,
       A.SPCM_NN_ACPT_YN ,
       A.WD_REQ_PSD_YN ,
       A.ACMD_AMD_YN ,
       A.ETC_YN ,
       A.ETC_DTL_CNTE ,
       A.TDS_YN ,
       A.DGNS_NM_YN ,
       A.UTWV_YN
FROM   AIMIAIDD A ,
       CNLRRUSD B1 ,
       CNLRRUSD B2
WHERE  A.PACT_ID = :IN_PACT_ID
AND    A.FSR_STF_NO = B1.STF_NO
AND    A.LSH_STF_NO = B2.STF_NO )) b;


