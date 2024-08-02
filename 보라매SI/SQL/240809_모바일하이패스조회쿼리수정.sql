select *
from cccccltc   --공통그룹코드명세
where comn_grp_cd = '996';

select *-- COMN_CD, COMN_CD_NM
from cccccste   --공통그룹코드 상세
where comn_grp_cd = '996';

--asis 그룹코드 조회 - 개발기, 스테이징에선 아래와 같이 DBLink(@....) 붙여야 함. 운영기 조회시엔 빼도 됨.
select *
from asis_hcom.cccodest@dl_prod_mig
where ccd_typ = '996';
















EXEC :IN_FROM_DATE := '2021-07-01';
EXEC :IN_TO_DATE := '2024-08-02' ;
EXEC :IN_SMSS_PSB_YN := 'N';
EXEC :IN_HPCD_CNCL_RSN_CD :='';

    --   SELECT * FROM (
SELECT * FROM ( /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMng */

            SELECT
               --A.HPCD_CNCL_RSN_CD
,                TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
               , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
               , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
               , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */
               --, DECODE(A.CNCL_DT, NULL, 'Y' , 'N')                                                 AS SMSS_PSB_YN         /* 승인여부 */
               , DECODE(A.CNCL_DT, NULL, 'Y' , 'N' ||' ('|| DECODE(C.COMN_CD_NM,NULL,'정보없음',C.COMN_CD_NM) ||')'  )                                                 AS SMSS_PSB_YN         /* 승인여부 */
               , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
               , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
               , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
               , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
               , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
               , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */

              FROM
                HBIL.ACPETHCD A /*테이블 : 하이패스카드등록정보('HBIL.' 나중에 수정)*/
               ,PCTPCPAM B      /*테이블 : 환자정보*/
               ,CCCCCSTE C      /*테이블 : 공통그룹코드 상세*/
             WHERE 1 =1
             AND A.PT_NO = B.PT_NO
             AND A.HPCD_CNCL_RSN_CD = C.COMN_CD(+)
             AND (A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                               AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD'))
             AND C.COMN_GRP_CD(+) = '996'
       ) WHERE SMSS_PSB_YN LIKE '%'|| :IN_SMSS_PSB_YN ||'%'
--        ) WHERE SMSS_PSB_YN = 'N'

;;














SELECT * FROM ACPETHCD WHERE ROWNUM < 10;


  SELECT * FROM
HBIL.ACPETHCD A
  ,CCCCCSTE C WHERE
A.HPCD_CNCL_RSN_CD = C.COMN_CD AND ROWNUM < 10;


SELECT A.APLC_DT, A.HPCD_CNCL_RSN_CD, C.COMN_CD_NM
FROM  ACPETHCD A ,CCCCCSTE C
WHERE A.HPCD_CNCL_RSN_CD IS NOT NULL
AND A.HPCD_CNCL_RSN_CD = C.COMN_CD
AND C.COMN_GRP_CD = '996'
