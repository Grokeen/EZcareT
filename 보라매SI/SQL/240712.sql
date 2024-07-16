/* ASIS 쿼리 */
Select
csubcd_nm
,cncl_dte
,case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'    /* 승인여부  */
			            when a.cncl_dte is null  then   'Y' end aprv_yn
from  aphipassmt a, cccodest c
where rownum <100;

/* 바코드명?과 취소 날짜가 없을 때 승인 */
SELECT cncl_cd   /*취소사유*/    FROM APHIPASSMT WHERE
cncl_cd in ('07' ,'08','09' ) AND ROWNUM <100
                      

EXEC :IN_FROM_DATE := '2023-03-01';
EXEC :IN_TO_DATE := '2024-07-10' ;

/* 11개  :
신청일자(dmd_no),
환자번호(dmd_acpt_no),

환자명,
주민번호,

승인여부(dmd_pact_tp_cd) ,
환자급종(DMD_TP_CD),

시작일자(첫 진료),
종료일자(마지막 진료),

카드회사,
카드 명의자,
카드번호*/

-- <sql id="HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG">
EXEC :IN_FROM_DATE := '2023-03-01';
EXEC :IN_TO_DATE := '2024-07-10' ;

SELECT /*HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG*/

       TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                AS APLC_DT  /* 신청일자 */
     , A.PT_NO                                        PT_NO       /* 환자번호 */
	   , B.PT_NM                                        PT_NM       /* 환자명 */
     , PLS_DECRYPT_B64_ID(A.APCT_RRN, 800)            AS APCT_RRN /* 주민번호 */

     ,DECODE(CNCL_DT,NULL,'Y','N' )                   SMSS_PSB_YN /* 승인여부 */

     , B.PME_CLS_CD                                   PME_CLS_CD  /* 환자급종 */
     , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')            APY_STR_DT  /* 시작일자 */
     , A.APY_END_DT                                   APY_END_DT  /* 종료일자 */
     , A.CARD_CMP_NM                                  CARD_CMP_NM /* 카드 회사 */
     , A.APCT_NM                                      APCT_NM     /* 카드 명의자 */
	   , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)             AS CARD_NO  /* 카드번호 */

  FROM ACPETHCD A
     , PCTPCPAM B
 WHERE A.PT_NO = B.PT_NO
   AND A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                     AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')
;
-- </sql>

-- ASIS 코드
case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'
     when a.cncl_dte is null  then 'Y' end aprv_yn
/* A.취소 일자가 NULL이 아니고, A.취소 코드가 07 08 09면 -> 'N' + C.공통코드
   A.취소 일자가 NULL이 아니면 -> 'Y' */;


select *
from ACPETHCD

where
 rownum <100;

APLC_CCRC_YN NOT IN('Y')
