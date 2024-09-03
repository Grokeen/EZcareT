


SELECT
   to_char(ADS_DT,'hh')
FROM ACPPRAAM
where to_char(ADS_DT,'mi') != '00' ;
;;;
SELECT
  to_char(APY_STR_DT,'yyyy-mm-dd hh:mi')
FroM ACPPRTSD
where to_char(APY_STR_DT,'mi') != '00'
;


SELECT AMIS_ACPT_YN FROM ACPPINID WHERE AMIS_ACPT_YN IS NOT NULL;

/* HIS.PA.AC.PI.PI.SelectPsychiatryAdmissionMng */


EXEC :IN_FROMDATE :='20230801' ;
EXEC :IN_TODATE :='20240830' ;
EXEC :DT_CONDITION :='A';            -- A입원 D퇴원
EXEC :AMIS_CONDITION := 'Y';




SELECT  /* HIS.PA.AC.PI.PI.SelectPsychiatryAdmissionMng */
               NVL(B.RDOC_ACPT_CMPL_YN, 'N')                                              AS RDOC_ACPT_CMPL_YN          -- 01.서류접수 완료여부
             , A.PT_NO                                                                    AS PT_NO           -- 02.등록번호
             , XBIL.FT_ACP_GET_PATNM(A.PT_NO)                                             AS PT_NM           -- 03.환자이름
             , SUBSTR(NVL(F.COMN_CD_NM, E.COMN_CD_NM), 1, 4)                              AS PSYC_ADS_TP_NM   -- 04.입원유형명칭
             , TO_CHAR(A.ADS_DT , 'YYYY-MM-DD')                                           AS ADS_DT         -- 05.입원일자
             , xbil.FT_GET_OVERDATE(TO_CHAR(A.APY_STR_DT,'YYYYMMDD'), '3')                AS DAYAFT_3        -- 06.3일후 (정신과 시작일로부터)
             , TO_CHAR(A.APY_STR_DT + 7  * 2 - 1, 'YYYY-MM-DD')                           AS DAYAFT_2WK      -- 07.2주후 (정신과 시작일로부터)
             , TO_CHAR(A.APY_STR_DT + 30 * 1 - 1, 'YYYY-MM-DD')                           AS DAYAFT_1M       -- 08.1개월후 (정신과 시작일로부터)
             , TO_CHAR(A.APY_STR_DT + 30 * 2 - 1, 'YYYY-MM-DD')                           AS DAYAFT_2M       -- 09.2개월후 (정신과 시작일로부터)
             , TO_CHAR(A.APY_STR_DT + 30 * 3 - 1, 'YYYY-MM-DD')                           AS DAYAFT_3M       -- 10.3개월후 (정신과 시작일로부터)
             , TO_CHAR(A.DS_DTM, 'YYYY-MM-DD')                                            AS DS_DTM        -- 11.퇴원일자
             , NVL(B.AMIS_ACPT_YN, 'N')                                              AS AMIS_ACPT_YN         -- 12.AMIS 신청여부
              , NVL((SELECT X.WRT_STF_NO
                      FROM MRDDRECM X
                     WHERE X.PT_NO          = A.PT_NO
                       AND X.REC_DTM        BETWEEN A.ADS_DT  AND NVL(A.DS_EXPT_DT, TRUNC(SYSDATE))
                       AND X.MDRC_DC_TP_CD          = 'C'
                       AND X.MDRC_WRT_STS_CD            IN ('11', '12')
                       AND X.OLD_MDFM_CLS_CD = 536  -- ASIS - DOCNOTE_TYP_ID, 진단 결과서(정신건강의학과)
                       AND X.LST_YN          = 'Y'
                       AND ROWNUM = 1
                     UNION ALL
                    SELECT XCOM.FT_CNL_SELSTFINFO('4',X.WRT_STF_NO,NULL)
                      FROM MRDDRECM X
                     WHERE X.PT_NO          = A.PT_NO
                       AND X.REC_DTM        BETWEEN A.ADS_DT  AND NVL(A.DS_EXPT_DT, TRUNC(SYSDATE))
                       AND X.MDRC_DC_TP_CD          = 'C'
                       AND X.MDRC_WRT_STS_CD            IN ('11', '12')
                       AND X.MDFM_ID = '2002344'     --진단 결과서(정신건강의학과)
                       AND X.LST_YN          = 'Y'
                       AND ROWNUM = 1
                   ), A.MEDR_STF_NO)                                                             AS MEDR_STF_NO        -- 13.진료의사코드
             , NVL((SELECT XCOM.FT_CNL_SELSTFINFO('4',X.WRT_STF_NO,NULL)
                      FROM MRDDRECM X
                     WHERE X.PT_NO          = A.PT_NO
                       AND X.REC_DTM        BETWEEN A.ADS_DT  AND NVL(A.DS_EXPT_DT, TRUNC(SYSDATE))
                       AND X.MDRC_DC_TP_CD          = 'C'
                       AND X.MDRC_WRT_STS_CD            IN ('11', '12')
                       AND X.OLD_MDFM_CLS_CD = 536  -- ASIS - DOCNOTE_TYP_ID, 진단 결과서(정신건강의학과)
                       AND X.LST_YN          = 'Y'
                       AND ROWNUM = 1
                     UNION ALL
                    SELECT XCOM.FT_CNL_SELSTFINFO('4',X.WRT_STF_NO,NULL)
                      FROM MRDDRECM X
                     WHERE X.PT_NO          = A.PT_NO
                       AND X.REC_DTM        BETWEEN A.ADS_DT  AND NVL(A.DS_EXPT_DT, TRUNC(SYSDATE))
                       AND X.MDRC_DC_TP_CD          = 'C'
                       AND X.MDRC_WRT_STS_CD            IN ('11', '12')
                       AND X.MDFM_ID = '2002344'     --진단 결과서(정신건강의학과)
                       AND X.LST_YN          = 'Y'
                       AND ROWNUM = 1
                   ), XCOM.FT_CNL_SELSTFINFO('4',A.MEDR_STF_NO,NULL))                         AS MEDR_STF_NM        -- 13.진료의사명
             , A.WD_DEPT_CD || '-' || A.PRM_NO                                                AS WD_PRM_NO         -- 14.병동병실
             , A.PRM_GRD_CD                                                                   AS PRM_GRD_CD        -- 병실등급코드
             , XCOM.FT_CCC_CODENAME('358',A.PRM_GRD_CD)                                       AS PRM_GRD_NM        -- 병실등급명
             , A.PRM_TP_CD                                                                    AS PRM_TP_CD         -- 병실구분코드
             , XCOM.FT_CCC_CODENAME('359',A.PRM_TP_CD)                                        AS PRM_TP_NM        -- 병실구분명
             -----------------------------------------------------------
             -- 서류접수관리
             -----------------------------------------------------------
             , TO_CHAR(B.RDOC_TH1_ACPT_DT, 'YYYY-MM-DD')                                     AS RDOC_TH1_ACPT_DT     -- 15.1차 서류수령일자
             , TO_CHAR(B.RDOC_TH2_ACPT_DT, 'YYYY-MM-DD')                                     AS RDOC_TH2_ACPT_DT     -- 16.2차 서류수령일자
             , NVL(B.PSYC_ADS_CSFM_YN  , 'N')                                                 AS PSYC_ADS_CSFM_YN      -- 17.입원신청서
             , NVL(B.PT_DOC_ACPT_YN  , 'N')                                                 AS PT_DOC_ACPT_YN      -- 18.환자서류
             , NVL(B.PROR_TH1_DOC_ACPT_YN , 'N')                                                 AS PROR_TH1_DOC_ACPT_YN     -- 19.보호자1서류
             , NVL(B.PROR_TH2_DOC_ACPT_YN , 'N')                                                 AS PROR_TH2_DOC_ACPT_YN     -- 20.보호자2서류
             , NVL(B.PSYC_SPCT_DGNS_RSLT_YN, 'N')                                                 AS PSYC_SPCT_DGNS_RSLT_YN    -- 21.진단결과서
             , B.PT_TRNF_TP_CD                                                               AS PT_TRNF_TP_CD        -- 23.이송방법 (1:경찰관, 2:구급대원, 3:가족, 4:응급환자이송단, 9:기타)
             , B.PT_TRNF_ETC_CNTE                                                               AS PT_TRNF_ETC_CNTE        -- 24.기타 이송방법 (이송방법이 9일때 작성)
             , B.RMK_CNTE                                                                    AS RMK_CNTE             -- 25.특이사항
--------------------------------------------------             , B.NP_TYP_CHG                                                             AS NP_TYP_CHG      -- 26.변경전 입원유형 / ASIS에도 다 NULL값인 컬럼이라 필요없을 듯
             , NVL(B.PSYC_ADS_TP_CD, E.DTRL6_NM)                                          AS PSYC_ADS_TP_CD      -- 27.입원유형
             , DECODE(B.PT_NO, NULL, 'N', 'Y')                                          AS REG_YN          -- 28.정신과입원관리 등록 여부
             , CASE WHEN A.ADS_DT = A.APY_STR_DT THEN NULL ELSE A.APY_STR_DT END           AS APY_STR_DT
             , (SELECT CASE WHEN UNCL_RSN_CD IS NOT NULL THEN CORG_CD || '   ' || CORG_NM
                                                         ELSE ''
                            END
                  FROM ACPPRCUM
                 WHERE CORG_CD = A.CORG_CD
                   AND APY_END_DT = TO_DATE('99991231','YYYYMMDD')
               )                                                                   AS CORG_CD          -- 계약처코드
             , (SELECT CASE WHEN RDTN_RSN_CD IS NOT NULL THEN CORG_CD || '   ' || CORG_NM
                                                         ELSE ''
                            END
                  FROM ACPPRCUM
                 WHERE CORG_CD = A.CORG_CD
                   AND APY_END_DT = TO_DATE('99991231','YYYYMMDD')
               )                                                                   AS CORG_CD2          -- 감면코드
             , A.PME_CLS_CD                                                        AS PME_CLS_CD        -- 유형
             , XCOM.FT_CCC_CODENAME('356',A.PME_CLS_CD)                            AS PME_CLS_NM        -- 유형명
             , A.PSE_CLS_CD                                                        AS PSE_CLS_CD        -- 보조유형
             , XCOM.FT_CCC_CODENAME('357',A.PSE_CLS_CD)                            AS PSE_CLS_NM        -- 보조유형명




          from (
































                 SELECT X.PT_NO                         AS PT_NO
                     , X.ADS_DT                        AS ADS_DT
                     , X.DS_EXPT_DT                    AS DS_EXPT_DT
                     , X.DS_DTM                        AS DS_DTM
                     , NVL(X.NCDR_STF_NO, X.CHDR_STF_NO)  AS MEDR_STF_NO
                     , X.WD_DEPT_CD                    AS WD_DEPT_CD
                     , X.PRM_NO                        AS PRM_NO
                     , X.PRM_GRD_CD                    AS PRM_GRD_CD
                     , X.PRM_TP_CD                     AS PRM_TP_CD
                     , X.CORG_CD                       AS CORG_CD
                     , Z.ADS_RSV_TP_CD                 AS ADS_RSV_TP_CD
                     , X.ADS_DT                        AS APY_STR_DT
                     , X.PME_CLS_CD                    AS PME_CLS_CD
                     , X.PSE_CLS_CD                    AS PSE_CLS_CD
                  FROM

                  -- 김용록 : 입원과 퇴원이 조회 날짜에 들어가면 UNINO ALL
                  (SELECT *
                          FROM ACPPRAAM X
                         WHERE :DT_CONDITION = 'A' AND X.ADS_DT BETWEEN :IN_FROMDATE AND :IN_TODATE
                        UNION ALL
                        SELECT *
                          FROM ACPPRAAM X
                         WHERE :DT_CONDITION = 'D' AND X.DS_EXPT_DT BETWEEN :IN_FROMDATE AND :IN_TODATE) X
                     , ACPPRARD Z
                 WHERE 1=1
                 -- 김용록 : IF 문
                       --<IsNotEmpty Property="IN_PT_NO">
                        --  <IsNotNull Property="IN_PT_NO" >
                              --AND X.PT_NO           =       :IN_PT_NO
                           --</IsNotNull>
                      -- </IsNotEmpty>
                   AND X.APCN_DTM   IS NULL
                   AND Z.PT_NO      = X.PT_NO
                   AND Z.ADS_DT    = X.ADS_DT
                   AND Z.CNCL_DTM    IS NULL
                --##########################################################################
                -- NP로 전과시 무조건 입원지시가 발행되는데, 타과로 입원 후 NP로 전과한 경우,
                -- NP 입원지시가 입원(apiprsvt.ADS_DT가 null)으로 연동되지 않으므로
                -- 입원지시의 입원예정일자와 NP로 전과한 시작일자로 JOIN하여 리스트에 보여줌...2023.01.17 김태훈
                --##########################################################################
                 UNION




                SELECT X.PT_NO                         AS PT_NO
                     , X.ADS_DT                        AS ADS_DT   --입원일자는, 입원내역 조회 조건이므로 유지
                     , X.DS_EXPT_DT                    AS DS_EXPT_DT
                     , X.DS_DTM                        AS DS_DTM
                     , NVL(Y.NCDR_STF_NO, Y.CHDR_STF_NO)  AS MEDR_STF_NO
                     , Y.WD_DEPT_CD                    AS WD_DEPT_CD
                     , Y.PRM_NO                        AS PRM_NO
                     , X.PRM_GRD_CD                    AS PRM_GRD_CD
                     , X.PRM_TP_CD                     AS PRM_TP_CD
                     , X.CORG_CD                       AS CORG_CD
                     , Z.ADS_RSV_TP_CD                 AS ADS_RSV_TP_CD
                     ---------------------------------------------------------------------------------------------------------------------
                     , Y.APY_STR_DT                    AS APY_STR_DT  --정신과 시작일
                     , X.PME_CLS_CD                    AS PME_CLS_CD
                     , X.PSE_CLS_CD                    AS PSE_CLS_CD
                  FROM (SELECT *
                          FROM ACPPRAAM X
                         WHERE :DT_CONDITION = 'A' AND DS_EXPT_DT BETWEEN :IN_FROMDATE AND :IN_TODATE
                        UNION ALL
                        SELECT *
                          FROM ACPPRAAM X
                         WHERE :DT_CONDITION = 'D'                                                                                                                                                       -- AND Y.DS_EXPT_DT BETWEEN :IN_FROMDATE AND :IN_TODATE
                                                  ) X
                     , (SELECT *
                          FROM ACPPRTSD Y
                         WHERE :DT_CONDITION = 'D' AND APY_STR_DT BETWEEN :IN_FROMDATE AND :IN_TODATE
                        UNION ALL
                        SELECT *
                          FROM ACPPRTSD Y
                         WHERE :DT_CONDITION = 'A') Y
                     , ACPPRARD Z
                 WHERE 1=1
                       --<IsNotEmpty Property="IN_PT_NO">
                       --   <IsNotNull Property="IN_PT_NO" >
                         --     AND X.PT_NO           =       :IN_PT_NO
                         --  </IsNotNull>
                      -- </IsNotEmpty>
                   AND X.APCN_DTM   IS NULL
                   AND Y.PT_NO      = X.PT_NO
                   AND Y.ADS_DT    = X.ADS_DT
                   AND Y.MED_DEPT_CD   = 'NP'
                   AND Z.PT_NO      = Y.PT_NO
                   AND Z.ADS_EXPT_DT = Y.APY_STR_DT
                   AND Z.ADS_DT    IS NULL
                   AND Z.CNCL_DTM    IS NULL
               ) A
             , ACPPINID B -- apnpadmt b  --정신과입원 관리
             , CCCCCSTE E -- 공통코드
             , (SELECT DISTINCT
                       SUBSTR(COMN_CD_NM, 1, 4)     COMN_CD_NM
                     , DTRL6_NM                     DTRL6_NM
                  FROM CCCCCSTE A
                 WHERE COMN_GRP_CD    = '240'
                   AND DTRL2_NM = 'NP'
                   AND USE_YN     = 'Y'
               ) F
         WHERE 1=1
           ------------------------------------------------
           -- 조회조건2 : 자의.동의입원 제외 여부
           ------------------------------------------------
           AND CASE WHEN :SELF_CONDITION  IS NULL                                                         THEN 'TRUE'
                    WHEN :SELF_CONDITION  = 'Y'   AND NVL(B.PSYC_ADS_TP_CD,E.DTRL6_NM) NOT IN ('1','9') THEN 'TRUE'        ------------------------------
                    WHEN :SELF_CONDITION  = 'N'                                                           THEN 'TRUE'
               END  = 'TRUE'
           ------------------------------------------------
           -- 조회조건3 : AMIS 신청여부 선택
           ------------------------------------------------
           AND CASE WHEN :AMIS_CONDITION = 'Y'   AND NVL(B.AMIS_ACPT_YN,'N') = 'Y'                        THEN 'TRUE'  --신청
                    WHEN :AMIS_CONDITION = 'N'   AND NVL(B.AMIS_ACPT_YN,'N') = 'N'                        THEN 'TRUE'  --미신청
                    WHEN :AMIS_CONDITION = 'A'                                                            THEN 'TRUE'  --전체
               END  = 'TRUE'
           ------------------------------------------------
           AND B.PT_NO     (+)  = A.PT_NO
           AND B.ADS_DT   (+)  = A.ADS_DT
           AND B.APCN_DTM  (+)  IS NULL
           AND E.COMN_GRP_CD        = '240'
           AND E.DTRL2_NM           = 'NP'
           AND E.COMN_CD            = A.ADS_RSV_TP_CD  --입원지시
           AND E.USE_YN             = 'Y'
           AND F.DTRL6_NM (+) = B.PSYC_ADS_TP_CD  --정신과입원 관리
         ORDER BY
               A.ADS_DT;
-------------------------------------------------------------------------------------------------------------------------------
