
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

select * from APREGHVT_NEWT
         where pt_no = '00776940'



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
          and MEDNNCDT.doc_note_id = '53055704'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


                    SELECT APINSSPT.PT_NO
                           , APINSSPT.SP_QU_TYP
                           , APINSSPT.REG_NO
                           , APINSSPT.PATTYPE
                           , MIN(APINSSPT.APPR_DTE)   APPR_DTE
                           , MAX(APINSSPT.TO_DTE)     INS_TO_DTE
                        FROM APINSSPT  APINSSPT
                       WHERE APINSSPT.SP_QU_TYP IN ('G','S','X','H','Q','R','W','U')
                         AND APINSSPT.REG_NO IS NOT NULL


                         and  APINSSPT.pt_no = '00776940'
                       GROUP BY APINSSPT.PT_NO
                              , APINSSPT.SP_QU_TYP
                              , APINSSPT.REG_NO
                              , APINSSPT.PATTYPE



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




-- 싯할 치매에 있을리가 있나ㅏ
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
                         and   doc_note_id = '53055704'




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







select * from (
select
   NVL(
           (SELECT CCCODEST.CSUBCD_NM
              FROM CCCODEST
             WHERE CCCODEST.CCD_TYP = 'MC14'
               AND CCCODEST.C_CD   = REPLACE(REPLACE(a.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND CCCODEST.USE_YN = 'Y' AND ROWNUM=1)

           ,

            REPLACE(REPLACE(a.DZ_NO, CHR(13),''),CHR(10),' ')


       )              as ss


       , a.doc_note_id
 from  (
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



        )   a,

        (
         select * from APREGHVT_NEWT
         where pt_no = '00776940'
          )  b

where a.doc_note_id =  b.doc_note_id


)
where ss is not null
--and doc_note_id = '0122172199'





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
select NVL(
           (SELECT CCCODEST.CSUBCD_NM
              FROM CCCODEST
             WHERE CCCODEST.CCD_TYP = 'MC14'
               AND CCCODEST.C_CD   = REPLACE(REPLACE(a.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND CCCODEST.USE_YN = 'Y' AND ROWNUM=1)

           ,

            REPLACE(REPLACE(a.DZ_NO, CHR(13),''),CHR(10),' ')
       )                                                             as ssss
from  (
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

          )  a
     , (


            ) b
where a.doc_note_id(+) = b.doc_note_id
  and b.PT_NO = '00776940'

;;;


select * from CCCODEST where rownum < 10;
