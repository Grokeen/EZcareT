



SELECT /*+ HIS.PA.AC.PI.PI.SelectOneStopSEL */
    TO_CHAR(A.REG_DT,'YYYY-MM-DD')                                           AS REG_DT         /* 1.등록일자 */
   ,NVL(A.REG_SEQ,0)                                                         AS REG_SEQ        /* 2.순번 */
   ,NVL(A.PT_NO,'-')                                                         AS PT_NO          /* 3.환자번호 */
   ,NVL(B.PT_NM,'-')                                                         AS PT_NM          /* 4.환자명 */
   ,CASE WHEN PLS_DECRYPT_B64_ID(B.PT_RRN,800) IS NULL THEN '-'
         ELSE SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN,800),0,6) || '-'
         || SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN,800),7,1) || '******'
    END                                                                       AS PT_RRN         /* 5.주민번호 */
   ,DECODE(A.PACT_TP_CD,'I','입원','O','외래','E','응급',NULL,'-',A.PACT_TP_CD)    AS PACT_TP_CD     /* 6.입원외래 */
   ,CASE WHEN A.EMRG_KIT_USE_YN IS NOT NULL THEN
         (CASE WHEN A.EMRG_KIT_USE_YN = 'Y' THEN '사용'
         	     WHEN A.EMRG_KIT_USE_YN = 'N' THEN '미사용'
          END)
          ELSE '-'
    END                                                                       AS EMRG_KIT_USE_YN /* 7.응급키트 */
   ,DECODE(A.RFFM_TP_CD,1,'원스탑(성)',2,'원스탑(가정)',NULL,'-',A.RFFM_TP_CD)        AS ADS_NOTM/* 8.적용구분 */
   ,NVL(C.DEPT_NM,'-')                                                        AS DEPT_NM         /* 9.진료과 */
   ,NVL(A.RMK_CNTE,'-')                                                       AS RMK_CNTE        /* 10.비교 */

FROM ACPPROSD A, /* ONESTOP진료의뢰서정보 */
     PCTPCPAM B, /* 환자정보 */
     PDEDBMSM C  /* 부서기본(과정보) */
WHERE  A.PT_NO = B.PT_NO(+)
   AND A.MED_DEPT_CD = C.DEPT_CD(+)
   AND A.CNCL_DT IS NOT NULL
   AND(A.REG_DT BETWEEN NVL(:IN_FROM_DATE,'1958-08-01') AND NVL(:IN_TO_DATE,'2100-01-01'))
ORDER BY A.REG_DT DESC

         ;
 A, PCTPCPAM B, PDEDBMSM C;

SELECT * FROM ACPPROSD WHERE ROWNUM < 100;
SELECT * FROM CCCCCLTC WHERE ROWNUM < 10; AND COMN_GRP_CD =;
