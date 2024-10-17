

exec :IN_PT_NO := '';
EXEC :IN_REG_DT := '202409';
                   

<sql id="HIS.PA.AC.PI.SelectSeriousIllnessModificationApplicationFormCancelAsk">
<!--
    Clss :  [text|package|sp|plsql] (쿼리유형)
    Desc : 중증변경신청서조회
    Author : 이지케어텍 김용록
    Create date : 2024-10-16
    Update date : 2024-10-16 
    AS IS : 
-->
;;;
-- UI를 만들기 위한 테스트 쿼리입니다.

SELECT /*+ HIS.PA.AC.PI.SelectSeriousIllnessModificationApplicationFormCancelAsk */
     A.PT_NO    		  						            AS PT_NO 					/* 환자번호 */
   , A.APCT_NM 										        AS PT_NM 					/* 성명 */
   , A.SRIL_CFMT_NO  							            AS CFSC_NO 				    /* 산정특례번호 */
   , ''														AS APLC_TP 				    /* 신청구분 */
   , A.CFSC_CD 										        AS CHG_FMR_SKNS 	        /* 변경전상병 */
   , A.CFSC_CD 										        AS CHG_AFT_SKNS 	        /* 변경후상병 */
   , A.ASDR_NM										        AS ASDR_NM 				    /* 담당의사 */
   , TO_CHAR(A.APLC_DT,'YYYY-MM-DD') 						AS REG_DT					/* 신청일 */
   , CASE WHEN ADS_DT IS NULL THEN (SELECT PME_CLS_CD
                                      FROM ACPPRORE B
                                     WHERE A.PT_NO = B.PT_NO
                                       AND ROWNUM =1)
          WHEN ADS_DT IS NOT NULL THEN (SELECT PME_CLS_CD
                                          FROM ACPPRIRE B
                                         WHERE A.PT_NO = B.PT_NO
                                       AND ROWNUM =1)
     END 	    										    AS INS_CLS 				     /* 보험유형 */



   , CASE WHEN ADS_DT IS NULL THEN '외래'
          WHEN ADS_DT IS NOT NULL THEN '입원'
     END 													AS CTH_TP 				     /* 내원구분 */


   , A.RMK_CNTE 										    AS RMK 					     /* 비고 */
   , NVL2(A.RMK_CNTE,'Y','N') 			                    AS RMK_EN 			         /* 비고유무 */
   
   ,CASE WHEN A.SRIL_CFMT_NO IS NULL THEN 'N'
         WHEN A.SRIL_CFMT_NO IS NOT NULL THEN 'Y'
    END 													AS CMPL_EN 		           	 /* 완료유무 */
    
FROM ACPPRGHD A  /* 중증산정특례신청서정보 테이블*/
WHERE A.PT_NO = NVL(:IN_PT_NO,A.PT_NO)
  AND TO_CHAR(A.APLC_DT,'YYYYMM') = NVL(:IN_REG_DT,TO_CHAR(A.APLC_DT,'YYYYMM'))
ORDER BY A.APLC_DT

;;;
</sql>




;;;;
00732798
;;;


-- 2324104461를 찾아야 하는데
exec :PT_NO := '01632633';

SELECT /* HIS.PA.CORE.SelPAPtInsuranceBasics */
       A.PME_CLS_CD || ' - ' || A.PSE_CLS_CD AS PMSE_CLS_CD
     , A.CORG_CD                             AS CTRC_ORG_CD
     , B.POB_NO
     , B.HLTH_INSC_NO
     ,  (SELECT COMN_CD_NM
         FROM CCCCCSTE
        WHERE COMN_GRP_CD =  '203'
          AND COMN_CD = B.PT_REL_TP_CD ) AS PT_REL_TP_CD
     , B.ISPS_NM
     , TO_CHAR(B.INS_APY_DT,'yyyy-mm-dd') || ' ~ ' || TO_CHAR(B.INS_END_DT,'yyyy-mm-dd') AS INS_APY_END_DT
     , TO_CHAR(B.QF_ACQS_DT,'yyyy-mm-dd') AS QF_ACQS_DT
-----------------------추가2012.05.25------------------------
     , A.PME_CLS_CD
     , XCOM.FT_CCC_CODENAME('356', A.PME_CLS_CD) AS PME_CLS_NM
     , A.PSE_CLS_CD
     , XCOM.FT_CCC_CODENAME('357', A.PSE_CLS_CD) AS PSE_CLS_NM
     , C.POB_NM
     , B.PT_REL_TP_CD AS PT_REL_TP_CODE
     , TO_CHAR(B.INS_APY_DT,'yyyy-mm-dd') INS_APY_DT
     , TO_CHAR(B.INS_END_DT,'yyyy-mm-dd') INS_END_DT
  FROM PCTPCPAM A
     , ACPPRPID B
     , ACPPRCOD C
 WHERE A.PT_NO      = :PT_NO
   AND A.PT_NO      = B.PT_NO(+)
   AND A.PME_CLS_CD = B.PME_CLS_CD(+)
   AND B.POB_NO     = C.POB_NO(+)
   AND B.INS_APY_DT(+) <= TRUNC(SYSDATE)
   AND NVL(B.INS_END_DT(+), TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
  -- AND C.HSP_TP_CD(+)  = HIS_HSP_TP_CD
ORDER BY B.INS_APY_DT DESC


;;;

select * from ACPPRGHD
--where rownum < 10;
where PT_NO      = :PT_NO;

rcorg_no = '2324104461' ;



SELECT *
  FROM FXQUERYSTORE
 WHERE UPPER(QUERYTEXT) LIKE '%DISREGPRSON2%'
;


SELECT *
  FROM ALL_SOURCE
 WHERE UPPER(TEXT) LIKE '%DISREGPRSON2%'
   AND OWNER IN ('HSMS','ISMS','XBIL')
;
DISREGPRSON2
