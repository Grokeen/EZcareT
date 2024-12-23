﻿```SQL
;
/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT * FROM CNLRRUSD WHERE SID ='1000014';
SELECT * FROM ACPPRETM WHERE PT_NO = '01626383';
SELECT * FROM ACPPEOPD WHERE MTCS_AMT != 10000 AND ROWNUM <10;


SELECT B.COMN_CD, B.COMN_CD_NM
      --  A.HLS_MTRT_TP_CD                -- 진료결과코드
      -- ,A.HLS_RJT_RSN_TP_CD             -- 불가사유코드
      -- ,A.HLS_RJT_RSN_CNTE              -- 불가사유명
FROM ACPPIHLD A, CCCCCSTE B
WHERE
 A.HLS_MTRT_TP_CD = B.COMN_CD
--AND PT_NO = '01626383'
AND B.COMN_CD_NM = '진료중';

/* ------------------------------------------------------------------------------------------------------------------------- */

SELECT HLS_CTH_PATH_TP_CD,
COUNT(*),
XCOM.FT_CCC_CODENAME('22B',HLS_CTH_PATH_TP_CD) AS HLS_CTH_PATH_TP_NM       /* 8.내원경로 (명)*/
FROM ACPPIHLD GROUP BY HLS_CTH_PATH_TP_CD;


SELECT * FROM CCCCCSTE WHERE ROWNUM < 10 AND COMN_CD_NM = '진료중';
SELECT * FROM PCTPCPAM WHERE ROWNUM < 10;
SELECT * FROM CCCCCSTE WHERE ROWNUM < 50 AND COMN_GRP_CD; AND COMN_CD ='3200000';
/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT * FROM PCTPCPAM B WHERE PT_NO = '01626383';
SELECT * FROM ACPPIHLD WHERE PT_NO = '01626383';

/*ASIS*/SELECT CR_ORGN_NM FROM APREQVAT;
/* ------------------------------------------------------------------------------------------------------------------------- */

EXEC :IN_PT_NM := '';
EXEC :IN_FROM_DATE := NULL;
EXEC :IN_TO_DATE := NULL ;

EXEC :IN_PT_NO := '01626383';
SELECT
    EMRM_ARVL_DTM              /* 1.의뢰일시 */
   ,PT_NO                      /* 2.환자번호 */
   ,PT_NM                      /* 3.환자명 */
   ,PT_RRN                     /* 4.주민번호 */
   ,PME_CLS_CD                 /* 5.환자유형(입원/외래) */
   ,PSE_CLS_CD                 /* 6.보조유형(입원/외래) */
   ,HLS_CTH_PATH_TP_CD         /* 7.내원경로 (코드)*/
   ,HLS_CTH_PATH_TP_NM         /* 8.내원경로 (명)*/
   ,HLS_RFOR_NM                /* 9.의뢰처 */
   ,HLS_RFOR_DEPT_NM           /* 10.부서명 */
   ,HLS_MNG_NO                 /* 11.전산관리번호 */
   ,HLS_QF_APLC_DT             /* 12.신청일자_ */
   ,HLS_QF_RPY_DT              /* 13.회신일자 */
   ,INSU_ORGN_CD               /* 14.보장기관 (코드) */
   ,INSU_ORGN_NM               /* 15.보장기관 (명) */
   ,HLS_RJT_RSN_TP_CD          /* 16.불가사유 (코드) */
   ,HLS_RJT_RSN_TP_NM          /* 17.불가사유 (명) */
   ,HLS_MTRT_TP_CD             /* 18.진료결과 (코드) */
   ,COMN_CD_NM                 /* 19.진료결과 (명) */
   ,CHOT_DTM                   /* 20.퇴실일자_ */
   ,ROOM_DIR                   /* 21.병동병실 */
   ,HLS_RMK1                   /* 22.비고 */
   ,FSR_DTM                    /* 23.등록일시 */
   ,FSR_STF_NO                 /* 24.등록자 (ID) */
   ,DS_DTM                     /* 25.퇴원일자 */
   ,CHK_LNKG_YN                /* 26.CHECK LIST */
   ,MTCS_AMT                   /* 27.진료비총액(입원/외래) */
   ,INS_SUM_AMT                /* 28.급여금액(입원/외래) */
   ,NINS_SUM_AMT               /* 29.비급여금액_(입원/외래) */
   ,PBDN_AMT                   /* 30.환자부담총액단체부담금(입원/외래) */
   ,UNCL_AMT                   /* 31.단체부담금(미수금액)(입원/외래) */
   ,RDTN_AMT                   /* 32.단체금액(감면금액)(입원/외래) */
   ,UNCL_INAM_AMT              /* 33.미수납액(개인미수금액)(입원/외래) */
   ,RPY_AMT                    /* 34.수납금액_(입원/외래) */
   ,GOO_BN                     /* 35.입원/외래 구분 */
   ,PBDN_HGLM_INS_DMD_AMT      /* 36.청구여부(입원/외래)  */
   ,CORG_NM                    /* 37.계약처명_ */
   ,HLS_RMK2                   /* 38.비고2 */
   ,HLS_RMK3                   /* 39.비고3_ */
   ,FSR_STF_NM                 /* 40.등록자 (명) */
   ,COUNT(*)
FROM (
   SELECT
       TO_CHAR(A.EMRM_ARVL_DTM,'YYYY-MM-DD HH24:MI')                AS EMRM_ARVL_DTM            /* 1.의뢰일시 */
      ,A.PT_NO                                                      AS PT_NO                    /* 2.환자번호 */
      ,B.PT_NM                                                      AS PT_NM                    /* 3.환자명 */
      ,SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN, 800),0,6)
      ||'-'||
      SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN, 800),7,1)
      ||'******'                                                    AS PT_RRN                   /* 4.주민번호 */
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.PME_CLS_CD--외래
                ELSE C.PME_CLS_CD                      --입원
           END,B.PME_CLS_CD)                                        AS PME_CLS_CD               /* 5.환자유형(입원/외래) */
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.PSE_CLS_CD--외래
                ELSE C.PSE_CLS_CD                      --입원
           END,B.PSE_CLS_CD)                                        AS PSE_CLS_CD               /* 6.보조유형(입원/외래) */
      ,A.HLS_CTH_PATH_TP_CD                                         AS HLS_CTH_PATH_TP_CD       /* 7.내원경로 (코드)*/
      ,XCOM.FT_CCC_CODENAME('22B',A.HLS_CTH_PATH_TP_CD)             AS HLS_CTH_PATH_TP_NM       /* 8.내원경로 (명)*/
      ,A.HLS_RFOR_NM                                                AS HLS_RFOR_NM              /* 9.의뢰처 */
      ,A.HLS_RFOR_DEPT_NM                                           AS HLS_RFOR_DEPT_NM         /* 10.부서명 */
      ,NVL(A.HLS_MNG_NO,'-')                                        AS HLS_MNG_NO               /* 11.전산관리번호 */
      ,NVL(TO_CHAR(A.HLS_QF_APLC_DT,'YYYY-MM-DD'),'-')              AS HLS_QF_APLC_DT           /* 12.신청일자_ */
      ,NVL(TO_CHAR(A.HLS_QF_RPY_DT,'YYYY-MM-DD'),'-')               AS HLS_QF_RPY_DT            /* 13.회신일자 */
      ,A.INSU_ORGN_CD                                               AS INSU_ORGN_CD             /* 14.보장기관 (코드) */
      ,(SELECT POB_NM FROM ACPPRCOD WHERE POB_NO = A.INSU_ORGN_CD)  AS INSU_ORGN_NM             /* 15.보장기관 (명) */
      ,NVL(A.HLS_RJT_RSN_TP_CD,'-')                                 AS HLS_RJT_RSN_TP_CD        /* 16.불가사유 (코드) */
      ,NVL(XCOM.FT_CCC_CODENAME('22B',A.HLS_RJT_RSN_TP_CD),'-')     AS HLS_RJT_RSN_TP_NM        /* 17.불가사유 (명) */
      ,NVL(A.HLS_MTRT_TP_CD,'-')                                    AS HLS_MTRT_TP_CD           /* 18.진료결과 (코드) */

-- 보류(환자번호 : 01006057 박중선 -> 진료결과명 일반전화 값 x, 진료비총액+급여금액+비급여금액+환자부담금+수납금액 미출력)
-- 확인필요(환자번호 : 01626383 강미순 -> 진료중이란 값 X)
      ,CASE WHEN A.HLS_MTRT_TP_CD IS NULL THEN '진료중'
            ELSE NVL((SELECT H.COMN_CD_NM
                  FROM CCCCCSTE H  /* 테이블명 : 공통그룹코드상세 */
                  WHERE H.COMN_GRP_CD  = '22D'/* ASIS(987) */
                    AND K.MTRT_TP_CD = H.COMN_CD(+)),'-')
       END                                                          AS COMN_CD_NM               /* 19.진료결과 (명) */


-- 보류(환자번호 : 00668517 신현오 -> 퇴실일자 값 x, 구분에 입원인데 외래로 출력, 체크리스트 값 x)
      ,CASE WHEN K.CHOT_DTM IS NULL THEN '-'
            ELSE TO_CHAR(K.CHOT_DTM,'YYYY-MM-DD')
       END                                                          AS CHOT_DTM                 /* 20.퇴실일자_ */
      ,CASE WHEN K.ADS_DT IS NULL THEN '-'                --외래
           ELSE                                           --입원
               CASE WHEN G.WD_DEPT_CD IS NULL AND G.PRM_NO IS NULL AND G.BED_NO IS NULL THEN '-'
                    ELSE G.WD_DEPT_CD ||'-'||G.PRM_NO||'-'||G.BED_NO
               END
       END                                                          AS ROOM_DIR                 /* 21.병동병실 */
      ,NVL(A.HLS_RMK1,'-')                                          AS HLS_RMK1                 /* 22.비고 */
      ,TO_CHAR(A.FSR_DTM,'YYYY-MM-DD HH24:MI')                      AS FSR_DTM                  /* 23.등록일시 */
      ,A.FSR_STF_NO                                                 AS FSR_STF_NO               /* 24.등록자 (ID) */
      ,CASE WHEN G.DS_DTM IS NULL THEN '-'
            ELSE TO_CHAR(G.DS_DTM,'YYYY-MM-DD')
       END                                                          AS DS_DTM                   /* 25.퇴원일자 */


-- 보류(환자번호 : 00668517 신현오 -> 퇴실일자 값 x, 구분에 입원인데 외래로 출력, 체크리스트 값 x)
      ,NVL(A.CHK_LNKG_YN,'-')                                       AS CHK_LNKG_YN              /* 26.CHECK LIST */

-- 다시(환자번호 : 01626383 강미순 -> 값 4개 출력)
-- 다시(환자번호 : 01626612 이동호 -> ASIS에서 0000출력? 이거 맞나?)
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.MTCS_AMT     --외래
                ELSE C.MTCS_AMT                           --입원
           END,0)                                                   AS MTCS_AMT                 /* 27.진료비총액(입원/외래) */
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.INS_SUM_AMT  --외래
                ELSE C.INS_SUM_AMT                        --입원
           END,0)                                                   AS INS_SUM_AMT              /* 28.급여금액(입원/외래) */
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.NINS_SUM_AMT --외래
                ELSE C.NINS_SUM_AMT                       --입원
           END,0)                                                   AS NINS_SUM_AMT             /* 29.비급여금액_(입원/외래) */
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.PBDN_AMT     --외래
                 ELSE C.PBDN_AMT                          --입원
            END,0)                                                  AS PBDN_AMT                 /* 30.환자부담총액단체부담금(입원/외래) */


-- 다시(환자번호 : 01521816 박프란세스 -> 계약처명 미출력, 단체부담금 미출력, 두 가지 외 정상출력)
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.UNCL_AMT     --외래
                 ELSE C.UNCL_AMT                          --입원
            END,0)                                                  AS UNCL_AMT                 /* 31.단체부담금(미수금액)(입원/외래) */


      ,NVL((SELECT RDTN_AMT
             FROM ACPPEDCD  /* 테이블명 : 외래감면정보 */
            WHERE PT_NO=A.PT_NO),0)                                 AS RDTN_AMT                  /* 32.단체금액(감면금액)(입원/외래) -> 감면금액 관련 컬럼을 못 찾았다. */

-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 다시(환자번호 : 01376708 김근철)
-- 다시(환자번호 : 01522964 황성기)
-- 다시(환자번호 : 01075595 정원규)
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.UNCL_INAM_AMT--외래
                ELSE C.UNCL_INAM_AMT                      --입원
           END,0)                                                   AS UNCL_INAM_AMT            /* 33.미수납액(개인미수금액)(입원/외래) */



-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 다시(환자번호 : 01001701 박보현)
      ,NVL(CASE WHEN K.ADS_DT IS NULL THEN D.RPY_AMT      --외래
                ELSE C.RPY_AMT                            --입원
           END,0)                                                   AS RPY_AMT                  /* 34.수납금액_(입원/외래) */



-- 보류(환자번호 : 00668517 신현오 -> 퇴실일자 값 x, 구분에 입원인데 외래로 출력, 체크리스트 값 x)
       ,NVL(CASE WHEN K.ADS_DT IS NULL THEN '응급외래'     --외래
                 ELSE '응급입원'                           --입원
            END,0)                                                  AS GOO_BN                   /* 35.입원/외래 구분 */
       ,NVL(CASE WHEN K.ADS_DT IS NULL THEN               --외래
                     NVL((SELECT 'Y'
                          FROM ACPPEOPH I /* 테이블명 : 외래수납이력 */
                          WHERE I.PT_NO = D.PT_NO
                            AND I.MED_DT = D.MED_DT
                            AND I.MED_DEPT_CD = D.MED_DEPT_CD
                            AND I.RPY_CLS_SEQ = D.RPY_CLS_SEQ
                            AND I.MEDR_STF_NO = D.MEDR_STF_NO
                            AND I.CNCL_DTM IS NULL
                            AND I.RPY_DT  IS NOT NULL
                            AND ROWNUM = 1)
                          ,'N')
                 ELSE                                     --입원
                     NVL((SELECT 'Y'
                          FROM ACPPEIPS J /* 테이블명 : 입원수납이력정보 */
                          WHERE J.PT_NO = C.PT_NO
                            AND J.ADS_DT = C.ADS_DT
                            AND J.RPY_CLS_SEQ = C.RPY_CLS_SEQ
                            AND J.CNCL_DT IS NULL
                            AND J.RPY_DT  IS NOT NULL
                            AND ROWNUM = 1)
                          ,'N')
           END,0)                                                   AS PBDN_HGLM_INS_DMD_AMT   /* 36.청구여부(입원/외래)  */

-- 다시(환자번호 : 01626612 이동호 -> 계약처명 '미수(응급용)' 미출력)
-- 다시(환자번호 : 01521816 박프란세스 -> 계약처명 미출력, 단체부담금 미출력, 두 가지 외 정상출력)
      ,NVL(G.CORG_NM,'-')                                           AS CORG_NM                 /* 37.계약처명_ */
      ,NVL(A.HLS_RMK2,'-')                                          AS HLS_RMK2                /* 38.비고2 */
      ,NVL(A.HLS_RMK3,'-')                                          AS HLS_RMK3                /* 39.비고3_ */
      ,XCOM.FT_CNL_SELSTFINFO('4',A.FSR_STF_NO,NULL)                AS FSR_STF_NM              /* 40.등록자 (명) */



   FROM  ACPPIHLD A      /* 테이블명 : 행려자격신청정보 */
        ,PCTPCPAM B      /* 테이블명 : 환자정보 */
        ,ACPPEIPD C      /* 테이블명 : 입원수납정보 */
        ,ACPPEOPD D      /* 테이블명 : 외래수납정보 */
        ,(SELECT
              E.CORG_CD                                             AS CORG_CD        /* 계약기관코드 */
             ,F.PT_NO                                               AS PT_NO          /* 2.환자번호 */
             ,F.PT_CHOT_STS_CD                                      AS PT_CHOT_STS_CD /* 20.퇴실일자_ */
             ,TO_CHAR(F.DS_DTM,'YYYY-MM-DD')                        AS DS_DTM         /* 25.퇴원일자 */
             ,E.CORG_NM                                             AS CORG_NM        /* 37.계약처명_ */
             ,F.ADS_DT                                              AS ADS_DT         /* 입원일자 */
             ,F.WD_DEPT_CD                                          AS WD_DEPT_CD     /* 병동번호 */
             ,F.PRM_NO                                              AS PRM_NO         /* 병실번호 */
             ,F.BED_NO                                              AS BED_NO         /* 병상번호 */
          FROM ACPPRCUM E /* 테이블명 : 계약처마스터 */
              ,ACPPRAAM F /* 테이블명 : 입원접수기본 */
          WHERE  F.ICD10_CD = E.CORG_CD) G

        ,ACPPRETM K       /* 테이블명 : 응급접수기본 */

   WHERE  A.PT_NO                  = NVL(:IN_PT_NO, A.PT_NO)
      AND A.PT_NO                  = B.PT_NO
      AND A.PT_NO                  = C.PT_NO(+)
      AND A.PT_NO                  = D.PT_NO(+)
      AND A.PT_NO                  = G.PT_NO(+)
      --AND K.CORG_CD                = G.CORG_CD(+)
      --AND A.PT_NO                  = K.PT_NO
      AND A.PACT_ID                = K.PACT_ID(+)


      --AND C.RPY_CLS_SEQ(+)         = '0'
      --AND D.RPY_CLS_SEQ(+)         = '0'
      AND C.CNCL_DT(+)             IS NULL
      AND D.CNCL_DTM(+)            IS NULL


      --AND NVL(K.MTRT_TP_CD,H.COMN_CD)             = H.COMN_CD
      --AND A.HLS_MTRT_TP_CD         = H.COMN_CD
      --AND A.HLS_CTH_PATH_TP_CD     = H.COMN_GRP_CD(+)
      --AND NOT EXISTS (SELECT 'Y'
      --                FROM APEMGRCT
      --                WHERE PT_NO = A.PT_NO
      --                  AND ARV_DTM = A.ARV_DTM)

      AND K.ARVL_AFT_FST_MED_DTM(+)   = D.MED_DT  -- 진료일시
      AND K.ADS_DT(+)                 = C.ADS_DT  -- 입원날짜
      AND (A.EMRM_ARVL_DTM     BETWEEN NVL(:IN_FROM_DATE,'1955-06-18')
                                   AND NVL(:IN_TO_DATE,'2100-01-01'))
)GROUP BY
    EMRM_ARVL_DTM              /* 1.의뢰일시 */
   ,PT_NO                      /* 2.환자번호 */
   ,PT_NM                      /* 3.환자명 */
   ,PT_RRN                     /* 4.주민번호 */
   ,PME_CLS_CD                 /* 5.환자유형(입원/외래) */
   ,PSE_CLS_CD                 /* 6.보조유형(입원/외래) */
   ,HLS_CTH_PATH_TP_CD         /* 7.내원경로 (코드)*/
   ,HLS_CTH_PATH_TP_NM         /* 8.내원경로 (명)*/
   ,HLS_RFOR_NM                /* 9.의뢰처 */
   ,HLS_RFOR_DEPT_NM           /* 10.부서명 */
   ,HLS_MNG_NO                 /* 11.전산관리번호 */
   ,HLS_QF_APLC_DT             /* 12.신청일자_ */
   ,HLS_QF_RPY_DT              /* 13.회신일자 */
   ,INSU_ORGN_CD               /* 14.보장기관 (코드) */
   ,INSU_ORGN_NM               /* 15.보장기관 (명) */
   ,HLS_RJT_RSN_TP_CD          /* 16.불가사유 (코드) */
   ,HLS_RJT_RSN_TP_NM          /* 17.불가사유 (명) */
   ,HLS_MTRT_TP_CD             /* 18.진료결과 (코드) */
   ,COMN_CD_NM                 /* 19.진료결과 (명) */

   ,CHOT_DTM                   /* 20.퇴실일자_ */
   ,ROOM_DIR                   /* 21.병동병실 */
   ,HLS_RMK1                   /* 22.비고 */
   ,FSR_DTM                    /* 23.등록일시 */
   ,FSR_STF_NO                 /* 24.등록자 (ID) */
   ,DS_DTM                     /* 25.퇴원일자 */
   ,CHK_LNKG_YN                /* 26.CHECK LIST */
   ,MTCS_AMT                   /* 27.진료비총액(입원/외래) */
   ,INS_SUM_AMT                /* 28.급여금액(입원/외래) */
   ,NINS_SUM_AMT               /* 29.비급여금액_(입원/외래) */

   ,PBDN_AMT                   /* 30.환자부담총액단체부담금(입원/외래) */
   ,UNCL_AMT                   /* 31.단체부담금(미수금액)(입원/외래) */
   ,RDTN_AMT                   /* 32.단체금액(감면금액)(입원/외래) */
   ,UNCL_INAM_AMT              /* 33.미수납액(개인미수금액)(입원/외래) */
   ,RPY_AMT                    /* 34.수납금액_(입원/외래) */
   ,GOO_BN                     /* 35.입원/외래 구분 */
   ,PBDN_HGLM_INS_DMD_AMT      /* 36.청구여부(입원/외래)  */
   ,CORG_NM                    /* 37.계약처명_ */
   ,HLS_RMK2                   /* 38.비고2 */
   ,HLS_RMK3                   /* 39.비고3_ */
   ,FSR_STF_NM                 /* 40.등록자 (명) */

ORDER BY EMRM_ARVL_DTM DESC,
         PT_NM         ASC,
         MTCS_AMT      DESC
;
/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT SYSDATE FROM DUAL;





























/* ------------------------------------------------------------------------------------------------------------------------- */
-- 입원 날짜가 있는데????
SELECT ADS_DT FROM ACPPEIPD WHERE PT_NO = '01626383';


/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT * FROM CCCCCSTE WHERE COMN_GRP_CD = '271' AND ROWNUM <50 ;
SELECT * FROM CCCCCLTC WHERE COMN_GRP_CD = '3150000' AND ROWNUM <50 ;
SELECT * FROM CCCCCSTE WHERE COMN_CD = '3150000' AND ROWNUM <50 ;
SELECT * FROM CCCCCLTC A, ACPPIHLD B WHERE B.INSU_ORGN_CD = A.COMN_GRP_CD  AND ROWNUM <50 ;
SELECT * FROM CCCCCSTE WHERE ROWNUM <50;
SELECT * FROM ACPPRCUM A, ACPPIHLD B WHERE B.INSU_ORGN_CD = A.CORG_CD  AND ROWNUM <50 ;
SELECT * FROM ACPPRCUM WHERE ROWNUM < 40;CORG_CD = '3150000';
SELECT DS_DTM, DS_EXPT_DT,PT_CHOT_STS_CD FROM ACPPRAAM WHERE ROWNUM <50;


SELECT *
  FROM ALL_COL_COMMENTS
 WHERE TABLE_NAME = 'APCUSTMT'
;
/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT
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
       WHERE  F.ICD10_CD(+) = E.CORG_CD
;
/* ------------------------------------------------------------------------------------------------------------------------- */

SELECT SUBSTR(PLS_DECRYPT_B64_ID(B.RLT_PT_RRN, 800),0,6)
   ||''||
   SUBSTR(PLS_DECRYPT_B64_ID(B.RLT_PT_RRN, 800),6,1)
   ||'******'  FROM PCTPCPAM B WHERE PT_NO = '01626383';

SELECT SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN, 800),0,6)
   ||'-'||
   SUBSTR(PLS_DECRYPT_B64_ID(B.PT_RRN, 800),7,1)
   ||'******'  FROM PCTPCPAM B WHERE PT_NO = '01626383';

/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT * FROM CCCCCLTC WHERE COMN_GRP_CD_NM LIKE '%행려%';
   SELECT * FROM CCCCCLTC WHERE COMN_GRP_CD ='22D';
   SELECT * FROM CCCCCLTC WHERE NEXTG_FMR_COMN_GRP_CD = '987';
   SELECT * FROM CCCCCSTE WHERE ROWNUM < 100;
   SELECT * FROM CCCCCSTE WHERE COMN_GRP_CD = '22B';
   SELECT * FROM CCCCCSTE WHERE COMN_GRP_CD = '22C';
   SELECT * FROM CCCCCSTE WHERE COMN_GRP_CD = '22D';
/* ------------------------------------------------------------------------------------------------------------------------- */
SELECT * FROM ACPPRETM K,(SELECT
           E.CORG_CD                                             AS CORG_CD        /* 계약기관코드 */
          ,F.PT_NO                                               AS PT_NO          /* 2.환자번호 */
          ,F.PT_CHOT_STS_CD                                      AS PT_CHOT_STS_CD /* 20.퇴실일자_ */
          ,TO_CHAR(F.DS_DTM,'YYYY-MM-DD')                        AS DS_DTM         /* 25.퇴원일자 */
          ,E.CORG_NM                                             AS CORG_NM        /* 37.계약처명_ */
          ,F.ADS_DT                                              AS ADS_DT         /* 입원일자 */
          ,F.WD_DEPT_CD                                          AS WD_DEPT_CD     /* 병동번호 */
          ,F.PRM_NO                                              AS PRM_NO         /* 병실번호 */
          ,F.BED_NO                                              AS BED_NO         /* 병상번호 */
       FROM ACPPRCUM E /* 테이블명 : 계약처마스터 */
           ,ACPPRAAM F /* 테이블명 : 입원접수기본 */
       WHERE  F.ICD10_CD = E.CORG_CD) A
WHERE K.CORG_CD = A.CORG_CD(+)

       ;
```
