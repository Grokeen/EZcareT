EXEC :IN_PT_NO := '01626383';
EXEC :IN_PT_NM := '';
EXEC :IN_FROM_DATE := '2023-01-19';
EXEC :IN_TO_DATE := '2024-08-14' ;

SELECT
    EMRM_ARVL_DTM          /* 1.의뢰일시 */
   ,PT_NO                  /* 2.환자번호 */
   ,PT_NM                  /* 3.환자명 */
   ,PT_RRN                 /* 4.주민번호 */
   ,PME_CLS_CD             /* 5.환자유형(입원/외래) */
   ,CORG_NM                /* 6.계약처명_ */
   ,HLS_CTH_PATH_TP_CD     /* 7.내원경로 (코드)*/
   ,HLS_CTH_PATH_TP_NM     /* 7.내원경로 (명)*/
   ,HLS_RFOR_NM            /* 8.의뢰처 */
   ,HLS_RFOR_DEPT_NM       /* 9.부서명 */
   ,HLS_MNG_NO             /* 10.전산관리번호 */
   ,HLS_QF_APLC_DT         /* 11.신청일자_ */
   ,HLS_QF_RPY_DT          /* 12.회신일자 */
   ,INSU_ORGN_CD           /* 13.보장기관 (코드) */
   ,HLS_RJT_RSN_TP_CD      /* 14.불가사유 (코드) */
   ,HLS_RJT_RSN_TP_NM      /* 14.불가사유 (명) */
   ,HLS_TH_MCST_RSLT_NM    /* 15.진료결과 */
   ,PT_CHOT_STS_CD         /* 16.퇴실일자_ */
   ,DS_DTM                 /* 17.퇴원일자 */
   ,ROOM_DIR               /* 18.병동병실 */
   ,HLS_RMK1               /* 19.비고 */
   ,HLS_RMK2               /* 20.비고2 */
   ,HLS_RMK3               /* 21.비고3_ */
   ,CHK_LNKG_YN            /* 22.CHECK LIST */
   ,MTCS_AMT               /* 23.진료비총액(입원/외래) */
   ,INS_SUM_AMT            /* 24.급여금액(입원/외래) */
   ,NINS_SUM_AMT           /* 25.비급여금액_(입원/외래) */
   ,PBDN_HGLM_INS_PT_BRDN_AMT /* 26.환자부담총액단체부담금(입원/외래) */
   ,AGAIN_SSS                /* 27.단체감액(입원/외래) */
   ,UNCL_AMT               /* 28.미수납액(입원/외래) */
   ,RPY_AMT                /* 29.수납금액_(입원/외래) */
   ,PBDN_HGLM_INS_DMD_AMT     /* 30.청구여부(입원/외래)  */
   ,GOO_BN                   /* 31.입원/외래 구분 */
   ,FSR_DTM                /* 32.등록일시 */
   ,FSR_STF_NM             /* 33.등록자 */
   ,COUNT(*)



FROM (
SELECT
   TO_CHAR(A.EMRM_ARVL_DTM,'YYYY-MM-DD HH24:MI')        AS EMRM_ARVL_DTM            /* 1.의뢰일시 */
   ,A.PT_NO                                             AS PT_NO                    /* 2.환자번호 */
   ,B.PT_NM                                             AS PT_NM                    /* 3.환자명 */

   ,SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN, 800),0,6)
   ||'-'||
   SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN, 800),7,1)
   ||'******'                                           AS PT_RRN                   /* 4.주민번호 */

   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.PME_CLS_CD
        ELSE                           --입원
           C.PME_CLS_CD
        END,B.PME_CLS_CD)                               AS PME_CLS_CD               /* 5.환자유형(입원/외래) */


   ,G.CORG_NM                                           AS CORG_NM                  /* 6.계약처명_ */
   ,A.HLS_CTH_PATH_TP_CD                                AS HLS_CTH_PATH_TP_CD       /* 7.내원경로 (코드)*/
   ,XCOM.FT_CCC_CODENAME('22B',A.HLS_CTH_PATH_TP_CD)     AS HLS_CTH_PATH_TP_NM       /* 7.내원경로 (명)*/
   ,A.HLS_RFOR_NM                                       AS HLS_RFOR_NM              /* 8.의뢰처 */
   ,A.HLS_RFOR_DEPT_NM                                  AS HLS_RFOR_DEPT_NM         /* 9.부서명 */
   ,NVL(A.HLS_MNG_NO,'-')                                        AS HLS_MNG_NO               /* 10.전산관리번호 */
   ,TO_CHAR(A.HLS_QF_APLC_DT,'YYYY-MM-DD')              AS HLS_QF_APLC_DT           /* 11.신청일자_ */
   ,TO_CHAR(A.HLS_QF_RPY_DT,'YYYY-MM-DD')               AS HLS_QF_RPY_DT            /* 12.회신일자 */

-- 다시
   ,A.INSU_ORGN_CD                                      AS INSU_ORGN_CD             /* 13.보장기관 (코드) */
   /* 13.보장기관 (명) */


   ,NVL(A.HLS_RJT_RSN_TP_CD,'-')                                 AS HLS_RJT_RSN_TP_CD        /* 14.불가사유 (코드) */
   ,NVL(XCOM.FT_CCC_CODENAME('22C',A.HLS_RJT_RSN_TP_CD),'-')     AS HLS_RJT_RSN_TP_NM        /* 14.불가사유 (명) */

-- 다시(예가 값이 나와야 GROUP BY가 안되는)
   ,NVL(A.HLS_TH1_MCST_RSLT_NM ||DECODE(TRIM(A.HLS_TH2_MCST_RSLT_NM),NULL,'',', '||A.HLS_TH2_MCST_RSLT_NM),'-')
                                                        AS HLS_TH_MCST_RSLT_NM      /* 15.진료결과 */

   ,TO_CHAR(G.PT_CHOT_STS_CD,'YYYY-MM-DD')                                     AS PT_CHOT_STS_CD           /* 16.퇴실일자_ */
   ,TO_CHAR(G.DS_DTM,'YYYY-MM-DD')                                             AS DS_DTM                   /* 17.퇴원일자 */
   ,G.WD_DEPT_CD ||'-'||G.PRM_NO||'-'||G.BED_NO         AS ROOM_DIR                 /* 18.병동병실 */
   ,NVL(A.HLS_RMK1,'-')                                          AS HLS_RMK1                 /* 19.비고 */
   ,NVL(A.HLS_RMK2,'-')                                          AS HLS_RMK2                 /* 20.비고2 */
   ,NVL(A.HLS_RMK3,'-')                                          AS HLS_RMK3                 /* 21.비고3_ */
   ,A.CHK_LNKG_YN                                       AS CHK_LNKG_YN              /* 22.CHECK LIST */

   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.MTCS_AMT
        ELSE                           --입원
           C.MTCS_AMT
        END,0)                                          AS MTCS_AMT                 /* 23.진료비총액(입원/외래) */
   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.INS_SUM_AMT
        ELSE                           --입원
           C.INS_SUM_AMT
        END,0)                                          AS INS_SUM_AMT              /* 24.급여금액(입원/외래) */
   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.NINS_SUM_AMT
        ELSE                           --입원
           C.NINS_SUM_AMT
        END,0)                                          AS NINS_SUM_AMT             /* 25.비급여금액_(입원/외래) */


-- 다시
    ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.PBDN_AMT
        ELSE                           --입원
           C.PBDN_HGLM_INS_PT_BRDN_AMT
        END,0)                                          AS PBDN_HGLM_INS_PT_BRDN_AMT /* 26.환자부담총액단체부담금(입원/외래) */



-- 다시
   ,0                                                AS AGAIN_SSS                /* 27.단체감액(입원/외래) */



   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.UNCL_AMT
        ELSE                           --입원
           C.UNCL_AMT
        END,0)                                           AS UNCL_AMT                 /* 28.미수납액(입원/외래) */

   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.RPY_AMT
        ELSE                           --입원
           C.RPY_AMT
        END,0)                                           AS RPY_AMT                  /* 29.수납금액_(입원/외래) */

-- 다시(복잡한 계산식)
   ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           D.MTCS_AMT
        ELSE                           --입원
           C.PBDN_HGLM_INS_DMD_AMT
        END,0)                                           AS PBDN_HGLM_INS_DMD_AMT    /* 30.청구여부(입원/외래)  */
    ,NVL(CASE WHEN C.ADS_DT IS NULL THEN--외래
           '응급외래'
        ELSE                            --입원
           '응급입원'
        END,0)                                           AS GOO_BN                   /* 31.입원/외래 구분 */


   ,A.FSR_DTM                                            AS FSR_DTM                  /* 32.등록일시 */
   ,A.FSR_STF_NO                                         AS FSR_STF_NM               /* 33.등록자 */



FROM  ACPPIHLD A      /* 테이블명 : 행려자격신청정보 */
     ,PCTPCPAM B      /* 테이블명 : 환자정보 */
     ,ACPPEIPD C      /* 테이블명 : 입원수납정보 */
     ,ACPPEOPD D      /* 테이블명 : 외래수납정보 */
     ,(SELECT
           F.PT_NO                                             AS PT_NO          /* 2.환자번호 */
          ,E.CORG_NM                                           AS CORG_NM        /* 6.계약처명_ */
          ,F.PT_CHOT_STS_CD                                    AS PT_CHOT_STS_CD /* 16.퇴실일자_ */
          ,TO_DATE(F.DS_DTM,'YYYY-MM-DD')                      AS DS_DTM         /* 17.퇴원일자 */
          ,F.ADS_DT                                            AS ADS_DT         /* 입원일자 */
          ,F.WD_DEPT_CD                                        AS WD_DEPT_CD     /* 병동번호 */
          ,F.PRM_NO                                            AS PRM_NO         /* 병실번호 */
          ,F.BED_NO                                            AS BED_NO         /* 병상번호 */
       FROM ACPPRCUM E /* 테이블명 : 계약처마스터 */
           ,ACPPRAAM F /* 테이블명 : 입원접수기본 */
       WHERE  F.ICD10_CD(+) = E.CORG_CD) G
     ,CCCCCSTE H       /* 테이블명 : 공통그룹코드상세 */


WHERE  A.PT_NO    = NVL(:IN_PT_NO, A.PT_NO)
   AND (A.EMRM_ARVL_DTM BETWEEN NVL(:IN_FROM_DATE,'1955-06-18')
      AND NVL(:IN_TO_DATE,'3000-01-01'))

   AND A.PT_NO = B.PT_NO
   AND A.PT_NO = C.PT_NO
   AND A.PT_NO = D.PT_NO
   AND H.COMN_GRP_CD = '22D'



ORDER BY EMRM_ARVL_DTM DESC,
         PT_NM ASC



) WHERE -- EMRM_ARVL_DTM  IS NOT NULL
        ROWNUM<100



GROUP BY
    EMRM_ARVL_DTM          /* 1.의뢰일시 */
   ,PT_NO                  /* 2.환자번호 */
   ,PT_NM                  /* 3.환자명 */
   ,PT_RRN                 /* 4.주민번호 */
   ,PME_CLS_CD             /* 5.환자유형(입원/외래) */
   ,CORG_NM                /* 6.계약처명_ */
   ,HLS_CTH_PATH_TP_CD     /* 7.내원경로 (코드)*/
   ,HLS_CTH_PATH_TP_NM     /* 7.내원경로 (명)*/
   ,HLS_RFOR_NM            /* 8.의뢰처 */
   ,HLS_RFOR_DEPT_NM       /* 9.부서명 */
   ,HLS_MNG_NO             /* 10.전산관리번호 */
   ,HLS_QF_APLC_DT         /* 11.신청일자_ */
   ,HLS_QF_RPY_DT          /* 12.회신일자 */
   ,INSU_ORGN_CD           /* 13.보장기관 (코드) */
   ,HLS_RJT_RSN_TP_CD      /* 14.불가사유 (코드) */
   ,HLS_RJT_RSN_TP_NM      /* 14.불가사유 (명) */
   ,HLS_TH_MCST_RSLT_NM    /* 15.진료결과 */
   ,PT_CHOT_STS_CD         /* 16.퇴실일자_ */
   ,DS_DTM                 /* 17.퇴원일자 */
   ,ROOM_DIR               /* 18.병동병실 */
   ,HLS_RMK1               /* 19.비고 */
   ,HLS_RMK2               /* 20.비고2 */
   ,HLS_RMK3               /* 21.비고3_ */
   ,CHK_LNKG_YN            /* 22.CHECK LIST */
   ,MTCS_AMT               /* 23.진료비총액(입원/외래) */
   ,INS_SUM_AMT            /* 24.급여금액(입원/외래) */
   ,NINS_SUM_AMT           /* 25.비급여금액_(입원/외래) */
   ,PBDN_HGLM_INS_PT_BRDN_AMT /* 26.환자부담총액단체부담금(입원/외래) */
   ,AGAIN_SSS                /* 27.단체감액(입원/외래) */



   ,UNCL_AMT               /* 28.미수납액(입원/외래) */
   ,RPY_AMT                /* 29.수납금액_(입원/외래) */
   ,PBDN_HGLM_INS_DMD_AMT     /* 30.청구여부(입원/외래)  */
   ,GOO_BN                   /* 31.입원/외래 구분 */
   ,FSR_DTM                /* 32.등록일시 */
   ,FSR_STF_NM             /* 33.등록자 */
