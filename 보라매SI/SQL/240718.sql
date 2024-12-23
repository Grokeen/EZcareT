﻿/* ASIS 쿼리 ############################################################################################################################# */
EXEC :in_gubun := 'X';
SELECT * FROM (
Select
   a.pt_no
   ,b.pt_nm
   ,c.CSUBCD_NM                                                                                                    AS CSUBCD_NM /* 원인 이름 */
   ,a.CNCL_DTE                                                                                                    AS CNCL_DTE  /* 취소날짜  */
   ,case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'
         when a.cncl_dte is null  then   'Y' end                                                                  AS APRV_YN   /* 승인여부  */
   ,a.cncl_cd                                                                                                     AS CNCL_CD   /* 취소코드  */
   ,c.ccd_typ
from  APHIPASSMT a,
      APPATBAT b,
      CCCODEST c
WHERE nvl(a.cncl_cd,'XX') = decode(:in_gubun ,'A' ,nvl(a.cncl_cd,'XX')    --전체 조회
                                             ,'N' ,'09'                   --원무과 취소 조회
		                                         ,'X' ,'07'                   --미승인 조회
		                                         ,'XX')                       --전체 조회
    and a.pt_no = b.pt_no
    and c.ccd_typ (+)= '996'
    and c.c_cd (+)= a.cncl_cd
) WHERE CSUBCD_NM IS NOT NULL


;

-- 전체 조회
SELECT * FROM CCCODEST WHERE ccd_typ (+)= '996';
SELECT * FROM APHIPASSMT a, CCCODEST c WHERE c.c_cd (+)= a.cncl_cd;
SELECT * FROM APHIPASSMT WHERE ROWNUM < 10;



;
Select
CSUBCD_NM
,CNCL_DTE
,case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'
			            when a.cncl_dte is null  then   'Y' end                                                      AS APRV_YN /* 승인여부  */
,a.cncl_cd                                                                                                     AS CNCL_CD
from  aphipassmt a,
      cccodest c WHERE ROWNUM < 10
;

하이패스카드수납상세
case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'
     when a.cncl_dte is null  then 'Y' end aprv_yn
/* A.취소 일자가 NULL이 아니고, A.취소 코드가 07 08 09면 -> 'N' + C.공통코드
   A.취소 일자가 NULL이 아니면 -> 'Y' */;


;

/* TOBE 쿼리 ############################################################################################################################# */
-- <sql id="HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG">
EXEC :IN_FROM_DATE := '2000-03-01';
EXEC :IN_TO_DATE := '2024-07-10' ;
EXEC :IN_SMSS_PSB_YN := 'N';


SELECT * FROM ( /**HIS.PA.AC.PE.PS.HIPASSMOBILEAPPROVALMNG*/
   SELECT
      'check' || ROWNUM                                                                                                 AS CHECK_BOX           /* 체크박스 */
      , TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
      , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
      , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
      , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */

      , DECODE(CNCL_DT,NULL,'Y','N' )                                                                                   AS SMSS_PSB_YN         /* 승인여부 */
      -- and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||  ' ('|| c.csubcd_nm  ||')'
      , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
      , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
      , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
      , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
      , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
      , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */

     FROM ACPETHCD A /*하이패스카드등록정보*/
        , PCTPCPAM B /*환자정보*/
    WHERE A.PT_NO = B.PT_NO
      AND (A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                         AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')))
WHERE SMSS_PSB_YN IN(SUBSTR(:IN_SMSS_PSB_YN,1,1))


;
-- </sql>



select HSP_TP_CD , *
from ACPETHCD
GROUP BY HSP_TP_CD;


SELECT * FROM AIMIREMC
 ;



/* ------------------------------------------------------------------------------------------------------------------------------------

승인 . 취소 버튼 클릭 시
-------------------------------------------------------------------------------------------------------------------------------------- */
UPDATE /** */
       ACPETHCD A /*환자검사처방기본*/
   SET A.RPY_STS_CD = 'N'
     , LSH_STF_NO  = :HIS_STF_NO
     , LSH_DTM     = SYSDATE
     , LSH_PRGM_NM = :HIS_PRGM_NM
     , LSH_IP_ADDR = :HIS_IP_ADDR
 WHERE A.ORD_ID     = :ORD_ID
   AND A.RPY_STS_CD = 'R' -- 환불한 검사만 다시 체크






