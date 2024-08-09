EXEC :IN_FROM_DATE := '2023-07-21';
EXEC :IN_TO_DATE := '2024-08-02' ;
EXEC :IN_HPCD_CNCL_RSN_CD := 'A';


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
   AND NVL(A.HPCD_CNCL_RSN_CD, 'XX') LIKE DECODE(:IN_HPCD_CNCL_RSN_CD,  'N', '09',                                                  -- 취소
                                                                        'U', '07',                                                  -- 미승인
                                                                        'Y', 'XX',                                                  -- 승인
                                                                        'A', '%')                                                  -- 전체



   ORDER BY APLC_DT DESC, PT_NM ASC

) WHERE SMSS_PSB_YN IS NOT NULL

--AND SMSS_PSB_YN LIKE '%N%'


;
;;


  SELECT * FROM HBIL.ACPETHCD WHERE ROWNUM < 100
;;

;;

-- 변경
EXEC :IN_LSH_STF_NO := 'C8ADM';
EXEC :IN_CNCL_DT := '2024-08-09' ;
EXEC :IN_HPCD_CNCL_RSN_CD := '09';


---- 조회
EXEC :IN_PT_NO := '00116267';
EXEC :IN_APY_STR_DT := '2023-01-17' ;
EXEC :IN_TKN_NO := '5317648383391318=57220011326181554180';


UPDATE ACPETHCD /*+ HIS.PA.AC.PE.PS.HipassMobileApprovalMngUpdate */
   SET   LSH_STF_NO = :IN_LSH_STF_NO                                               /* 최종변경하는직원번호 */
       , HPCD_CNCL_RSN_CD = NVL(:IN_HPCD_CNCL_RSN_CD,NULL)                         /* 취소코드 */
       , CNCL_DT = DECODE(:IN_CNCL_DT,NULL,NULL,TO_DATE(:IN_CNCL_DT,'YYYY-MM-DD')) /* 취소날짜 */
   WHERE  PT_NO = :IN_PT_NO                                                        /* 환자번호 */
     AND APY_STR_DT = TO_DATE(:IN_APY_STR_DT,'YYYY-MM-DD')                         /* 시작일자 */
     AND TKN_NO = :IN_TKN_NO                                                       /* 하이패스토큰번호 */

;;
--commit;
SELECT PT_NO,APY_STR_DT,TKN_NO,LSH_STF_NO,HPCD_CNCL_RSN_CD,CNCL_DT FROM ACPETHCD where rownum <10 AND PT_NO=:IN_PT_NO AND APY_STR_DT= :IN_APY_STR_DT AND TKN_NO = :IN_TKN_NO;
SELECT * FROM ACPETHCD where rownum <10 order by APY_STR_DT desc ;
SELECT :IN_APY_STR_DT FROM DUAL;
