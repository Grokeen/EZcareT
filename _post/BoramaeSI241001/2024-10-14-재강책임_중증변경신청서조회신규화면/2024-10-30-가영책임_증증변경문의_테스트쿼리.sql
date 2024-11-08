SELECT a.CSUBCD_NM
              FROM  CCCODEST a , MEDNNCDT  b
             WHERE a.CCD_TYP = 'MC14'
               AND a.C_CD = REPLACE(REPLACE(b.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND a.USE_YN = 'Y' AND ROWNUM=1;



 SELECT a.CSUBCD_NM
              FROM  CCCODEST a , MEDNNPDT  b
             WHERE a.CCD_TYP = 'MC14'
               AND a.C_CD = REPLACE(REPLACE(b.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND a.USE_YN = 'Y' AND ROWNUM=1;


------------------------

-- MEDNNCDT 테이블 안에 dz_no가 없는데
SELECT

        NVL((SELECT CCCODEST.CSUBCD_NM
              FROM  CCCODEST
             WHERE CCCODEST.CCD_TYP = 'MC14'
               AND CCCODEST.C_CD = REPLACE(REPLACE(MEDNNCDT.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND CCCODEST.USE_YN = 'Y' AND ROWNUM=1),REPLACE(REPLACE(MEDNNCDT.DZ_NO, CHR(13),''),CHR(10),' ')) APLC_ICD10_CD_CNTE /* 연산추출 - 신청ICD10코드내용 */

  FROM


  (

  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   SELECT /*+ use_hash(MEDRNMAT) use_hash(APREGHVT_NEWT) */  APREGHVT_NEWT.*
              , nvl(APREGHVT_NEWT.REG_NO,APINSSPT.REG_NO) AS INS_REG_NO
              , NVL(CASE WHEN APREGHVT_NEWT.REQ_TYP = '1'
                         THEN 'J3' -- 중증암
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y'      -- 중증치매여부
                         THEN 'SD' -- 중증치매
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y'      -- 난치여부
                         THEN '23' -- 중증난치질환
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N'
                         THEN '21' -- 희귀질환
                         WHEN APREGHVT_NEWT.REQ_TYP = '6'
                         THEN 'TC' -- 결핵
                         WHEN APREGHVT_NEWT.REQ_TYP = '7'
                         THEN '09' -- 중증화상
                         WHEN APREGHVT_NEWT.REQ_TYP = '16'
                         THEN 'LT' -- 잠복결핵
                         WHEN APREGHVT_NEWT.REQ_TYP = '9'
                         THEN 'J3' -- 중증암(+희귀난치 인데 작업어케해야할지 모르겠음, 전산팀에 물어보자)
                         END,'J3') AS SRIL_CDOC_APLC_TP_CD       -- 003. 중증확인증신청구분코드
                    ,DECODE(SUBSTR(NVL(APINSSPT.PATTYPE,'*'),1,1),'B','BB','E','EE', MEDRNMAT.CFSC_KND_CD) CFSC_KND_CD
                    ,MEDRNMAT.DEPT_CD            AS DEPT_CD
                    ,MEDRNMAT.WK_ID              AS ASDR_STF_NO
                    ,MEDRNMAT.PACT_TP_CD         AS PACT_TP_CD
                    ,MEDRNMAT.CRT_DTE            AS CRT_DTE
                    ,ROW_NUMBER() OVER(PARTITION BY  APREGHVT_NEWT.PT_NO, APREGHVT_NEWT.DOC_NOTE_ID,APREGHVT_NEWT.RLS_NO  ORDER BY ABS(APREGHVT_NEWT.REQ_DTE - APINSSPT.APPR_DTE) )   AS PRIORITY_SEQ
                    ,APINSSPT.INS_TO_DTE         AS INS_TO_DTE
        FROM APREGHVT_NEWT APREGHVT_NEWT
           ,(


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
          ;;;; ;;;
           SELECT /*+ INDEX(MEDRNMAT MEDRNMAT_SI06) */   CASE WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('458','459') THEN 'Y'       -- 난치 산정특례
                               WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('456','457','187','213','214') THEN 'N'  -- 희귀 산정특례
                               END                          AS INCURABLE_YN
                        , MEDRNMAT.DOC_NOTE_ID              AS DOC_NOTE_ID
                        , MEDRNMAT.RLS_NO                   AS RLS_NO
                       , DECODE (MEDRNMAT.DOCNOTE_TYP_ID
                                 , '185', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                 , '186', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                 , '187', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                 , '358', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                 , '442', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증치매)
                                 , '456', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                 , '458', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(난치)
                                 , '464', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                 , '465', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                 , '466', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                 , '551', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(잠복결핵)
                                 , '203', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                 , '211', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(중증)
                                 , '212', 'EE'                                                                                                                                                                                      -- 의료급여 산정특례 신청서(중증화상)
                                 , '213', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                 , '214', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 신청서(중증/희귀)
                                 , '359', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                 , '457', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                 , '459', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(난치)
                                 , '467', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(중증)
                                 , '468', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                 , '469', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                              )         AS CFSC_KND_CD
                         , DECODE(DOCNOTE_TYP_ID,'442' ,'Y'
                                               ,'456' ,'N'
                                               ,'458' ,'N')  AS IS_ALZHEIMER
                        , MEDRNMAT.DEPT_CD                  AS DEPT_CD
                        , MEDRNMAT.WK_ID                    AS WK_ID
                        , MEDRNMAT.PT_SECT                  AS PACT_TP_CD
                        , TRUNC(MEDRNMAT.CRT_DTE)           AS CRT_DTE
                        , MEDRNMAT.PT_NO                          AS PT_NO
                     FROM  MEDRNMAT -- 중증치매 기록지
                   ---치매---
                    WHERE MEDRNMAT.DOCNOTE_TYP_ID IN (  '185'
                                                      , '186'
                                                      , '187'
                                                      , '358'
                                                      , '442'
                                                      , '456'
                                                      , '458'
                                                      , '464'
                                                      , '465'
                                                      , '466'
                                                      , '551'
                                                      , '203'
                                                      , '211'
                                                      , '212'
                                                      , '213'
                                                      , '214'
                                                      , '359'
                                                      , '457'
                                                      , '459'
                                                      , '467'
                                                      , '468'
                                                      , '469'
                                                     )
             ;;;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                       ) MEDRNMAT

                    ,(

--ddddddd----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     ;;;
                    SELECT APINSSPT.PT_NO
                           , APINSSPT.SP_QU_TYP
                           , APINSSPT.REG_NO
      , APINSSPT.PATTYPE
                           , MIN(APINSSPT.APPR_DTE)   APPR_DTE
                           , MAX(APINSSPT.TO_DTE)     INS_TO_DTE
                        FROM APINSSPT  APINSSPT
                       WHERE APINSSPT.SP_QU_TYP IN ('G','S','X','H','Q','R','W','U')
                         AND APINSSPT.REG_NO IS NOT NULL
                       GROUP BY APINSSPT.PT_NO
                              , APINSSPT.SP_QU_TYP
                              , APINSSPT.REG_NO
  , APINSSPT.PATTYPE


       ;;;
--ddddddd----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                     )APINSSPT



      WHERE APREGHVT_NEWT.REQ_TYP NOT IN('98','99')
        AND APREGHVT_NEWT.REQ_TYP IS NOT NULL
        AND APREGHVT_NEWT.DOC_NOTE_ID = MEDRNMAT.DOC_NOTE_ID
        AND APREGHVT_NEWT.RLS_NO = MEDRNMAT.RLS_NO
        AND APREGHVT_NEWT.PT_NO = MEDRNMAT.PT_NO
     AND APINSSPT.REG_NO(+)     IS NOT NULL
        AND  APINSSPT.PT_NO(+)=APREGHVT_NEWT.PT_NO
        AND  APINSSPT.REG_NO(+)=APREGHVT_NEWT.REG_NO
        AND CASE WHEN APINSSPT.SP_QU_TYP(+) IN ('G')             AND APREGHVT_NEWT.REQ_TYP IN ('1','9') THEN 'Y'  --중증암
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('S')             AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y' THEN 'Y'  --중증치매
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('X')             AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y' THEN 'Y'  --중증난치
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('H','Q','R','X') AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N' THEN 'Y'  --중증희귀
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('W')             AND APREGHVT_NEWT.REQ_TYP = '6' THEN 'Y'  --결핵
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('U')             AND APREGHVT_NEWT.REQ_TYP = '16' THEN 'Y'  --잠복결핵
                 ELSE 'N'
                 END ='Y') APREGHVT_NEWT
   LEFT OUTER JOIN  APRGIMGT APRGIMGT_SIGN1 on APREGHVT_NEWT.SIGNSTR = APRGIMGT_SIGN1.SIGN_NO
   LEFT OUTER JOIN  ((

 --1qjsds;kadsl;gk;dflgkl;sdfkgl;  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     ;;;
   SELECT MEDNNCDT.*
            , MEDNNPDT.DZ_NM
            , MEDNNPDT.DZ_NO
            , MEDNNPDT.DR_NM
            , MEDNNPDT.LIC_NO
            , MEDNNPDT.INHSP_DTE
         FROM  MEDNNCDT
            ,  MEDNNPDT
        WHERE MEDNNPDT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID(+)
          AND MEDNNPDT.RLS_NO = MEDNNCDT.RLS_NO(+)

      ;;;
 --1qjsds;kadsl;gk;dflgkl;sdfkgl;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

        )) MEDNNCDT on APREGHVT_NEWT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID
   AND APREGHVT_NEWT.RLS_NO = MEDNNCDT.RLS_NO
   LEFT OUTER JOIN  APPATBAT APPATBAT on APREGHVT_NEWT.PT_NO  = APPATBAT.PT_NO
   LEFT OUTER JOIN  APMATCMT APMATCMT on APPATBAT.BUILDING_NO = APMATCMT.BLD_NO
--  LEFT OUTER JOIN MP_CODE mp1 ON COALESCE(mp1.ASIS_CODE,'*NULL VALUE*') = COALESCE(APREGHVT_NEWT.PAT_REL,'*NULL VALUE*')
--         and UPPER(mp1.TOBE_TBL_NM) = 'ACPPRGHD'
--         and UPPER(mp1.TOBE_COL_NM) = 'PT_REL_DTL_TP_CD'
--         and mp1.DB_USER_ID IS NULL
--         and UPPER(mp1.ASIS_TBL_NM) = 'APREGHVT_NEWT'
--         and UPPER(mp1.ASIS_COL_NM) = 'PAT_REL'
 WHERE   PRIORITY_SEQ=1

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
