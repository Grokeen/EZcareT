EXEC :IN_FROM_DATE := '2023-07-01';
EXEC :IN_TO_DATE := '2024-08-02' ;
EXEC :IN_SMSS_PSB_YN := 'Y';

SELECT * FROM (
 SELECT * FROM ( /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMng */
            SELECT
                 TO_CHAR(A.APLC_DT,'YYYY-MM-DD')                                                                                 AS APLC_DT             /* 신청일자 */
               , A.PT_NO                                                                                                         AS PT_NO               /* 환자번호 */
               , B.PT_NM                                                                                                         AS PT_NM               /* 환자명 */
               , SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),1,6)||'-'||SUBSTR(PLS_DECRYPT_B64_ID(A.APCT_RRN, 800),7,1)||'******' AS APCT_RRN            /* 주민번호 */
               , DECODE(CNCL_DT,NULL,'Y','N' )                                                                                   AS SMSS_PSB_YN         /* 승인여부 */
               , B.PME_CLS_CD                                                                                                    AS PME_CLS_CD          /* 환자급종 */
               , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                                                                             AS APY_STR_DT          /* 시작일자 */
               , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                                                                             AS APY_END_DT          /* 종료일자 */
               , TRIM(A.CARD_CMP_NM)                                                                                             AS CARD_CMP_NM         /* 카드 회사 */
               , A.APCT_NM                                                                                                       AS APCT_NM             /* 카드 명의자 */
               , PLS_DECRYPT_B64_ID(A.CARD_NO, 100)                                                                              AS CARD_NO             /* 카드번호 */

              FROM
                HBIL.ACPETHCD A /*하이패스카드등록정보('HBIL.' 나중에 수정)*/
               ,PCTPCPAM      B /*환자정보*/
             WHERE 1 =1
             AND A.PT_NO = B.PT_NO
             AND A.APLC_DT BETWEEN TO_DATE(:IN_FROM_DATE,'YYYY-MM-DD')
                               AND TO_DATE(:IN_TO_DATE,'YYYY-MM-DD')
         ) WHERE :IN_SMSS_PSB_YN IS NULL
              OR SMSS_PSB_YN LIKE '%'|| :IN_SMSS_PSB_YN || '%'
) WHERE   SMSS_PSB_YN = 'N'
