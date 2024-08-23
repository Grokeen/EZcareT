


/*-- --------------------------------------------------------------------------------------------------------------------*/
EXEC :IN_FROM_DATE:='2000-01-01';
EXEC :IN_TO_DATE := '9999-12-31';



SELECT /*+  HIS.PA.AC.PI.PI.SelectPoliceTrauma */
    TO_CHAR(A.REG_DT,'YYYY-MM-DD')                                               AS REG_DT          /* 1.등록일자 */
   ,NVL(A.REG_SEQ,0)                                                             AS REG_SEQ         /* 2.순번 */
   ,NVL(A.PT_NO,'-')                                                             AS PT_NO           /* 3.환자번호 */
   ,NVL(B.PT_NM,'-')                                                             AS PT_NM           /* 4.환자명 */
   ,CASE WHEN B.PT_RRN IS NULL THEN '-'
         ELSE SUBSTR(B.PT_RRN,0,6) || '-' || SUBSTR(B.PT_RRN,7,1) || '******'
    END                                                                          AS PT_RRN          /* 5.주민번호 */
   ,DECODE(A.PACT_TP_CD,'I','입원','O','외래','E','응급',NULL,'-',A.PACT_TP_CD)       AS PACT_TP_CD      /* 6.입원외래 */

   ,NVL(C.DEPT_NM,'-')                                                           AS DEPT_NM         /* 7.진료과 */
   ,NVL(A.RMK_CNTE,'-')                                                          AS RMK_CNTE        /* 8.비고 */

   /* 수정/삭제 필요한 데이터 추가*/
   ,PLS_DECRYPT_B64_ID(B.PT_RRN,800)                                             AS IN_PT_RRN        /* A.주민번호원본 */
   ,A.BSC_ADDR                                                                   AS IN_BSC_ADDR      /* B.기본주소 */
   ,A.TEL_NO                                                                     AS IN_TEL_NO        /* C.보호자명 */
   ,A.MTEL_NO                                                                    AS IN_MTEL_NO       /* D.환자관계구분코드 */
   ,A.PACT_TP_CD                                                                 AS IN_PACT_TP_CD    /* E.원무접수구분코드 */
   ,A.MED_DEPT_CD                                                                AS IN_MED_DEPT_CD   /* F.진료과코드 */
   ,A.MEDR_STF_NO                                                                AS IN_MEDR_STF_NO   /* G.진료의직원번호 */
   ,A.PME_CLS_CD                                                                 AS IN_PME_CLS_CD    /* H.환자급종유형코드 */
   ,A.PSE_CLS_CD                                                                 AS IN_PSE_CLS_CD    /* I.환자보조유형코드 */
   ,TO_CHAR(A.MED_DTM,'YYYYMMDDHH24MI')                                          AS IN_MED_DTM       /* J.진료일시 */
   ,A.FRVS_CMED_YN                                                               AS IN_FRVS_CMED_YN  /* K.초진선택여부 */
   ,A.RMDE_CMED_YN                                                               AS IN_RMDE_CMED_YN  /* L.재진선택여부 */
   ,A.EXM_CMED_YN                                                                AS IN_EXM_CMED_YN   /* M.검사선택여부 */
   ,A.DGNS_CMED_YN                                                               AS IN_DGNS_CMED_YN  /* N.진단선택여부 */

FROM ACPPRPTD A, /* 경찰트라우마진료의뢰서 */
     PCTPCPAM B, /* 환자정보 */
     PDEDBMSM C  /* 부서기본(과정보) */
WHERE  A.PT_NO = B.PT_NO(+)
   AND A.MED_DEPT_CD = C.DEPT_CD(+)
   AND A.CNCL_DT IS NULL
   AND(A.REG_DT BETWEEN NVL(:IN_FROM_DATE,'1958-08-01') AND NVL(:IN_TO_DATE,'2100-01-01'))
ORDER BY A.REG_DT DESC
;

SELECT DGNS_CMED_YN FROM ACPPRPTD;
SELECT * FROM APPOLTRT;
SELECT * FROM APPOLTRT;

/*-- --------------------------------------------------------------------------------------------------------------------*/

SELECT /*+ HIS.PA.AC.PI.PI.SelectOneStopSEL */
    TO_CHAR(A.REG_DT,'YYYY-MM-DD')                                              AS REG_DT         /* 1.등록일자 */
   ,NVL(A.REG_SEQ,0)                                                            AS REG_SEQ        /* 2.순번 */
   ,NVL(A.PT_NO,'-')                                                            AS PT_NO          /* 3.환자번호 */
   ,NVL(B.PT_NM,'-')                                                            AS PT_NM          /* 4.환자명 */
   ,CASE WHEN B.PT_RRN IS NULL THEN '-'
         ELSE SUBSTR(B.PT_RRN,0,6) || '-' || SUBSTR(B.PT_RRN,7,1) || '******'
    END                                                                          AS PT_RRN         /* 5.주민번호 */
   ,DECODE(A.PACT_TP_CD,'I','입원','O','외래','E','응급',NULL,'-',A.PACT_TP_CD)       AS PACT_TP_CD     /* 6.입원외래 */
   ,CASE WHEN A.EMRG_KIT_USE_YN IS NOT NULL THEN
         (CASE WHEN A.EMRG_KIT_USE_YN = 'Y' THEN '사용'
         	     WHEN A.EMRG_KIT_USE_YN = 'N' THEN '미사용'
          END)
          ELSE '-'
    END                                                                          AS EMRG_KIT_USE_YN /* 7.응급키트 */
   ,DECODE(A.RFFM_TP_CD,1,'원스탑(성)',2,'원스탑(가정)',NULL,'-',A.RFFM_TP_CD)           AS ADS_NOTM        /* 8.적용구분 */
   ,NVL(C.DEPT_NM,'-')                                                           AS DEPT_NM         /* 9.진료과 */
   ,NVL(A.RMK_CNTE,'-')                                                          AS RMK_CNTE        /* 10.비교 */

   /* 수정/삭제 필요한 데이터 추가*/
   ,PLS_DECRYPT_B64_ID(B.PT_RRN,800)                                             AS IN_PT_RRN          /* A.주민번호원본 */
   ,A.BSC_ADDR                                                                   AS IN_BSC_ADDR        /* B.기본주소 */
   ,A.TEL_NO                                                                     AS IN_TEL_NO          /* C.보호자명 */
   ,A.MTEL_NO                                                                    AS IN_MTEL_NO         /* D.환자관계구분코드 */
   ,A.PACT_TP_CD                                                                 AS IN_PACT_TP_CD      /* E.원무접수구분코드 */
   ,A.MED_DEPT_CD                                                                AS IN_MED_DEPT_CD     /* F.진료과코드 */
   ,A.MEDR_STF_NO                                                                AS IN_MEDR_STF_NO     /* G.진료의직원번호 */
   ,A.PME_CLS_CD                                                                 AS IN_PME_CLS_CD      /* H.환자급종유형코드 */
   ,A.PSE_CLS_CD                                                                 AS IN_PSE_CLS_CD      /* I.환자보조유형코드 */
   ,TO_CHAR(A.MED_DTM,'YYYYMMDDHH24MI')                                          AS IN_MED_DTM         /* J.진료일시 */
   ,A.FRVS_CMED_YN                                                               AS IN_FRVS_CMED_YN    /* K.초진선택여부 */
   ,A.RMDE_CMED_YN                                                               AS IN_RMDE_CMED_YN    /* L.재진선택여부 */
   ,A.EXM_CMED_YN                                                                AS IN_EXM_CMED_YN     /* M.검사선택여부 */
   ,A.DGNS_CMED_YN                                                               AS IN_DGNS_CMED_YN    /* N.진단선택여부 */
   ,A.RFFM_TP_CD                                                                 AS IN_RFFM_TP_CD      /* O.검사선택여부 */
   ,A.EMRG_KIT_USE_YN                                                            AS IN_EMRG_KIT_USE_YN /* P.진단선택여부 */

FROM ACPPROSD A, /* ONESTOP진료의뢰서정보 */
     PCTPCPAM B, /* 환자정보 */
     PDEDBMSM C  /* 부서기본(과정보) */
WHERE  A.PT_NO = B.PT_NO(+)
   AND A.MED_DEPT_CD = C.DEPT_CD(+)
   AND A.CNCL_DT IS NULL
   AND(A.REG_DT BETWEEN NVL(:IN_FROM_DATE,'1958-08-01') AND NVL(:IN_TO_DATE,'2100-01-01'))
ORDER BY A.REG_DT DESC;
