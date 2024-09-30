
우선심사사유
:IN_PACT_ID


;

FUNCTION FT_ACP_TDY_SLOT_YN ( IN_MED_DTM      IN     ACDPCSCD.MED_DTM%TYPE      -- 01. 진료일시
                            , IN_MEDR_STF_NO  IN     ACDPCSCD.MEDR_STF_NO%TYPE  -- 02. 진료의직원번호 
                            , IN_MED_DEPT_CD  IN     ACDPCSCD.MED_DEPT_CD%TYPE
                            )                               
                            
RETURN VARCHAR2 IS
/***********************************************************************************                                                                                                            
 *    서비스이름  : FT_ACP_TDY_SLOT_YN
 *    최초 작성일 : 2024-05-21
 *    최초 작성자 : 김재강
 *    DESCRIPTION : 진료일의 오전오후 가장 마지막 슬롯 여부
 *                  오전 : ~ 1259                                    
 *                  오후 : 1300 ~ 
 ***********************************************************************************/         
 TDY_SLOT_YN VARCHAR2(1);        -- 마지막 슬롯 여부
 ------------------------
BEGIN    
    
   
    
    BEGIN 
        select 
        
    EXCEPTION
    WHEN  OTHERS THEN 
      TDY_SLOT_YN := 'N';
    END;
    
    RETURN TDY_SLOT_YN;
    
END FT_ACP_TDY_SLOT_YN;        

SELECT /*HIS.PA.AI.IP.MG.SelectMomnmdrd*/
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
and     A.ERLY_DS_DLY_TP_CD  = :IN_ERLY_DS_DLY_TP_CD

<IsNotEmpty Property="IN_MAX_GUBUN"> 
<![CDATA[
AND :IN_MAX_GUBUN = :IN_MAX_GUBUN
AND    A.WRT_SEQ = (SELECT MAX(WRT_SEQ) 
FROM MOMNMDRD A 
WHERE A.PACT_ID = :IN_PACT_ID 
AND A.ERLY_DS_DLY_TP_CD  = :IN_ERLY_DS_DLY_TP_CD
AND ROWNUM = 1
)
]]>
</IsNotEmpty>

<IsNotEmpty Property="IN_MIN_GUBUN"> 
<![CDATA[
AND :IN_MIN_GUBUN = :IN_MIN_GUBUN
AND    A.WRT_SEQ = (SELECT MIN(WRT_SEQ) 
		FROM MOMNMDRD A 
		WHERE A.PACT_ID = :IN_PACT_ID 
		AND A.ERLY_DS_DLY_TP_CD  = :IN_ERLY_DS_DLY_TP_CD
		AND ROWNUM = 1
		)
]]>
</IsNotEmpty>

AND    ROWNUM = 1



select /*우선심사사유 : HIS.PA.AI.IP.MG.SelectAimiaidd*/ 
       to_char(A.FSR_DTM, 'yyyy-mm-dd hh24:mi')FSR_DTM ,
       A.FSR_STF_NO||'('||B1.STF_NM||')' || to_char(A.FSR_DTM, 'yyyy-mm-dd hh24:mi') FSR_STF_NO,
       to_char(A.LSH_DTM, 'yyyy-mm-dd hh24:mi') LSH_DTM,
       A.LSH_STF_NO ||'('||B2.STF_NM||')' || to_char(A.LSH_DTM, 'yyyy-mm-dd hh24:mi') LSH_STF_NO,
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
from   AIMIAIDD a ,
       CNLRRUSD b1 ,
       CNLRRUSD b2
where  A.PACT_ID = :IN_PACT_ID
and    A.FSR_STF_NO = B1.STF_NO
and    A.LSH_STF_NO = B2.STF_NO