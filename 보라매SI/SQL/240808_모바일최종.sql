EXEC :IN_FROM_DATE := '2023-07-21';
EXEC :IN_TO_DATE := '2024-08-02' ;
EXEC :IN_SMSS_PSB_YN := '';


SELECT * FROM ( /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMng */
   SELECT

       TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
     , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
     , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
     , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */


     , CASE WHEN A.CNCL_DT IS NOT NULL AND A.HPCD_CNCL_RSN_CD IN ('07' ,'08','09' ) THEN 'N' ||' ('|| C.COMN_CD_NM  ||')'
              WHEN A.CNCL_DT IS NULL  THEN   'Y' END                                                                   AS SMSS_PSB_YN         /* 승인여부 */
     , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
     , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
     , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
     , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
     , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
     , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */
     , A.TKN_NO                                                                                                        AS TKN_NO              /* 하이패스토큰번호 */
    FROM
      HBIL.ACPETHCD A /*테이블 : 하이패스카드등록정보('HBIL.' 나중에 수정)*/
     ,PCTPCPAM B      /*테이블 : 환자정보*/
     ,CCCCCSTE C      /*테이블 : 공통그룹코드 상세*/
   WHERE 1 =1
   AND A.PT_NO = B.PT_NO
   AND C.COMN_CD (+)= A.HPCD_CNCL_RSN_CD
   AND (A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                      AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD'))
   AND C.COMN_GRP_CD (+)= '996'
   AND NVL(A.HPCD_CNCL_RSN_CD,'XX') = decode(:IN_HPCD_CNCL_RSN_CD ,'A' ,nvl(A.HPCD_CNCL_RSN_CD,'XX')   --전체 조회
                                                                  ,'N' ,'09'                           --원무과 취소  조회
                                                                  ,'U' ,'07'                           --미승인 조회
                                                                  ,'XX')                               --원무과 승인 조회
   ORDER BY APLC_DT DESC, PT_NM ASC

) WHERE SMSS_PSB_YN IS NOT NULL

;
;;


-- 변경
EXEC :IN_LSH_STF_NO := '97516';
EXEC :IN_CNCL_DT := '2024-08-02' ;
EXEC :IN_HPCD_CNCL_RSN_CD := '09';


-- 조회
EXEC :IN_PT_NO := '01231173';
EXEC :IN_APY_STR_DT := '2015-07-27' ;
EXEC :IN_TKN_NO := '3870728567289984';


UPDATE ACPETHCD
   SET   LSH_STF_NO = :IN_LSH_STF_NO                       /* 최종변경하는직원번호 */
       , HPCD_CNCL_RSN_CD = :IN_HPCD_CNCL_RSN_CD           /* 취소코드 */
       , CNCL_DT = TO_DATE(:IN_CNCL_DT,'YYYY-MM-DD')       /* 취소날짜 */
   WHERE  PT_NO = :IN_PT_NO                                /* 환자번호 */
        , APY_STR_DT = TO_DATE(:IN_APY_STR_DT,'YYYY-MM-DD')/* 시작일자 */
        , TKN_NO = :IN_TKN_NO                              /* 하이패스토큰번호 */

;;
SELECT * FROM ACPETHCD where rownum <10;
