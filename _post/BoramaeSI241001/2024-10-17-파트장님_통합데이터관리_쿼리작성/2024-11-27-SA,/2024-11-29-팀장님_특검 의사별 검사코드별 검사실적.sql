
/*
     화면명   : 특검 의사별 검사코드별 검사실적

     TEST    : exec :IN_FROM_DT := '202410';
               exec :IN_TO_DATE := '202410';
               exec :IN_CHECK := 'A';      -- A:전체/S:선택

     CAREATE :
     UPDATE  : 2024-11-29 김용록 : 합계 추가
*/

select * from (
SELECT

    case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then (SELECT STF_NM FROM CNLRRUSD WHERE STF_NO = K.REPT_DR)
         when '111' then '합계'
     end            "판독의"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then  K.ORD_CD
     end             "검사코드"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then K.ORD_NM
     end             "검사명"
  ,case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then  SUM(K.QTY)  / 2
         when '111' then SUM(K.QTY)  / 2
     end             "건수"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then  DECODE(SUM(K.PRC), '', 0, ROUND(SUM(K.PRC)/(SUM(K.QTY)/2),0))
         when '111' then DECODE(SUM(K.PRC), '', 0, ROUND(SUM(K.PRC)/(SUM(K.QTY)/2),0))
     end
             "단가"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then  DECODE(SUM(K.PRC), '', 0, SUM(K.PRC) )
         when '111' then DECODE(SUM(K.PRC), '', 0, SUM(K.PRC) )
     end                              "합계"

FROM (

   -- 1
   SELECT
    A.ORD_CD
    , C.ORD_NM
    , '1'        QTY
    , D.BRFG_STF_NO                     REPT_DR
    , (SELECT  /*+ INDEX(E ACPPEOCE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEOCE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND D.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM', 'MOEEXAMT')
       AND E.RPY_PACT_ID = D.RPY_PACT_ID
       AND E.ORD_CD = D.ORD_CD
       AND E.PT_NO = D.PT_NO
          )             PRC
   FROM MSERMAAD A
   , CCOOCCSC B
   , CCOOCBAC C
   , MOOOREXM D
   WHERE A.PHTG_DTM BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1','CP','PA')
    AND D.EXM_PRGR_STS_CD IN ('E','D','N')
    AND D.ODDSC_TP_CD = 'C'
    AND B.ORD_SLIP_CTG_CD = C.ORD_SLIP_CTG_CD
    AND A.ORD_CD = C.ORD_CD
    AND A.ORD_ID = D.ORD_ID
    AND A.PT_NO = D.PT_NO
    AND A.ORD_DT = D.ORD_DT
    AND A.ORD_SEQ = D.ORD_SEQ
    AND D.PACT_TP_CD LIKE '' || '%'
    AND EXISTS (SELECT 'Y' FROM MOOOREXM W
       WHERE W.ORD_ID = A.ORD_ID
        AND W.PT_NO = A.PT_NO
  --      AND W.ORD_DT = A.ORD_DT
  --      AND W.ORD_SEQ = A.ORD_SEQ
        AND W.ODDSC_TP_CD = 'C')
    AND NVL(D.EXM_CHDR_STF_NO, D.ANDR_STF_NO) =
              ( SELECT STF_NO FROM CNLRRUSD
                  WHERE STF_NO = NVL(D.EXM_CHDR_STF_NO, D.ANDR_STF_NO)
                   AND USE_GRP_CD = 'DO'
                   AND USE_GRP_DTL_CD = '02'
                            AND SUBSTR(STF_NO,1,1) <> 'X'
              )
          AND 'S' = :IN_CHECK
   -- 2
   UNION ALL
   SELECT
    A.ORD_CD
    , C.ORD_NM
    , '1'        QTY
    , D.BRFG_STF_NO                    REPT_DR
    , (SELECT  /*+ INDEX(E ACPPEICE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEICE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND D.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM')
       AND E.RPY_PACT_ID = D.RPY_PACT_ID
       AND E.ORD_CD = D.ORD_CD
       AND E.PT_NO = D.PT_NO
          )             PRC
   FROM MSERMAAD A
   , CCOOCCSC B
   , CCOOCBAC C
   , MOOOREXM D
   WHERE A.PHTG_DTM BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1','CP','PA')
    AND D.EXM_PRGR_STS_CD IN ('E','D','N')
    AND D.ODDSC_TP_CD = 'C'
    AND B.ORD_SLIP_CTG_CD = C.ORD_SLIP_CTG_CD
    AND A.ORD_CD = C.ORD_CD
    AND A.ORD_ID = D.ORD_ID
    AND A.PT_NO = D.PT_NO
    AND A.ORD_DT = D.ORD_DT
    AND A.ORD_SEQ = D.ORD_SEQ
    AND D.PACT_TP_CD LIKE '' || '%'
    AND EXISTS (SELECT 'Y' FROM MOOOREXM W
       WHERE W.ORD_ID = A.ORD_ID
        AND W.PT_NO = A.PT_NO
  --     W.PT_NO = A.PT_NO
  --      AND W.ORD_DT = A.ORD_DT
  --      AND W.ORD_SEQ = A.ORD_SEQ
        AND W.ODDSC_TP_CD = 'C')
    AND NVL(D.EXM_CHDR_STF_NO, D.ANDR_STF_NO) =
              ( SELECT STF_NO FROM CNLRRUSD
                  WHERE STF_NO = NVL(D.EXM_CHDR_STF_NO, D.ANDR_STF_NO)
                   AND USE_GRP_CD = 'DO'
                   AND USE_GRP_DTL_CD = '02'
                            AND SUBSTR(STF_NO,1,1) <> 'X'
              )
          AND 'S' = :IN_CHECK

   -- 3
   UNION ALL
   SELECT
    A.ORD_CD
    , B.ORD_NM
    , '1'        QTY
    , NVL(A.RTM_FMT_STF_NO, A.FSR_STF_NO)  REPT_DR
    , (SELECT /*+ INDEX(E ACPPEOCE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEOCE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND A.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM', 'MOOORFED')
       AND E.RPY_PACT_ID = A.RPY_PACT_ID
   --    AND E.ORD_CD = A.ORD_CD
       AND E.MIF_CD = A.MIF_CD
       AND E.PT_NO = A.PT_NO
          )             PRC
   FROM MOOORFED A
   , CCOOCBAC B
   WHERE A.ORD_CTG_CD = 'TRM'
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1')
    AND A.ORD_CD = B.ORD_CD
    AND A.PACT_TP_CD LIKE '' || '%'
    AND A.ORD_CD IN ('L9429','L9430','H10110','L9403EA','L9405EB','L9406EC','L9407ED')
    AND A.ORD_DT BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_DT >= TO_DATE('20100101','YYYYMMDD')
    AND A.ODDSC_TP_CD = 'C'
    AND NVL(A.CHDR_STF_NO, A.ANDR_STF_NO) =
              ( SELECT STF_NO FROM CNLRRUSD
                  WHERE STF_NO = NVL(A.CHDR_STF_NO, A.ANDR_STF_NO)
                   AND USE_GRP_CD = 'DO'
                   AND USE_GRP_DTL_CD = '02'
                            AND SUBSTR(STF_NO,1,1) <> 'X'
              )
          AND 'S' = :IN_CHECK

   -- 4
   UNION ALL
   SELECT
    A.ORD_CD
    , B.ORD_NM
    , '1'        QTY
    , NVL(A.RTM_FMT_STF_NO, A.FSR_STF_NO)  REPT_DR
    , (SELECT  /*+ INDEX(E ACPPEICE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEICE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND A.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM', 'MOOORFED')
       AND E.RPY_PACT_ID = A.RPY_PACT_ID
--       AND E.ORD_CD = A.ORD_CD
       AND E.MIF_CD = A.MIF_CD
       AND E.PT_NO = A.PT_NO
          )             PRC
   FROM MOOORFED A
   , CCOOCBAC B
   WHERE A.ORD_CTG_CD = 'TRM'
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1')
    AND A.ORD_CD = B.ORD_CD
    AND A.PACT_TP_CD LIKE '' || '%'
    AND A.ORD_CD IN ('L9429','L9430','H10110','L9403EA','L9405EB','L9406EC','L9407ED')
    AND A.ORD_DT BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_DT >= TO_DATE('20100101','YYYYMMDD')
    AND A.ODDSC_TP_CD = 'C'
    AND NVL(A.CHDR_STF_NO, A.ANDR_STF_NO) =
              ( SELECT STF_NO FROM CNLRRUSD
                  WHERE STF_NO = NVL(A.CHDR_STF_NO, A.ANDR_STF_NO)
                   AND USE_GRP_CD = 'DO'
                   AND USE_GRP_DTL_CD = '02'
                            AND SUBSTR(STF_NO,1,1) <> 'X'
              )
          AND 'S' = :IN_CHECK

   ) K
GROUP BY rollup(K.REPT_DR
              , K.ORD_CD
              , K.ORD_NM)



UNION ALL




SELECT
  case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then nvl((SELECT STF_NM FROM CNLRRUSD WHERE STF_NO = K.REPT_DR), K.REPT_DR)
         when '111' then '합계'
     end            "판독의"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then K.ORD_CD
     end             "검사코드"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then K.ORD_NM

     end             "검사명"

  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then SUM(K.QTY)
         when '111' then SUM(K.QTY)
     end                                                                                    "건수"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then DECODE(SUM(K.PRC), '', 0, ROUND(SUM(K.PRC)/(SUM(K.QTY)/2),0))
         when '111' then DECODE(SUM(K.PRC), '', 0, ROUND(SUM(K.PRC)/(SUM(K.QTY)/2),0))
     end            "단가"
  , case grouping(K.REPT_DR) || grouping(K.ORD_CD) || grouping(K.ORD_NM)
         when '000' then DECODE(SUM(K.PRC), '', 0, SUM(K.PRC) )
         when '111' then DECODE(SUM(K.PRC), '', 0, SUM(K.PRC) )
     end                                                "합계"
FROM (

   -- 1
   SELECT
    A.ORD_CD
    , C.ORD_NM
    , '1'        QTY
    , D.BRFG_STF_NO                     REPT_DR
    , (SELECT  --/*+ INDEX(E ACPPEOCE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEOCE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND D.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM', 'MOEEXAMT')
       AND E.RPY_PACT_ID = D.RPY_PACT_ID
       AND E.ORD_CD = D.ORD_CD
       AND E.PT_NO = D.PT_NO
          )             PRC
   FROM MSERMAAD A
   , CCOOCCSC B
   , CCOOCBAC C
   , MOOOREXM D
   WHERE A.PHTG_DTM BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1','DS','CP','PA')
    AND D.EXM_PRGR_STS_CD IN ('E','D','N')
    AND D.ODDSC_TP_CD = 'C'
    AND B.ORD_SLIP_CTG_CD = C.ORD_SLIP_CTG_CD
    AND A.ORD_CD = C.ORD_CD
    AND A.ORD_ID = D.ORD_ID
    AND A.PT_NO = D.PT_NO
    AND A.ORD_DT = D.ORD_DT
    AND A.ORD_SEQ = D.ORD_SEQ
    AND D.PACT_TP_CD LIKE '' || '%'
    AND EXISTS (SELECT 'Y' FROM MOOOREXM W
       WHERE W.ORD_ID = A.ORD_ID
        AND W.PT_NO = A.PT_NO
        AND W.ORD_DT = A.ORD_DT
        AND W.ORD_SEQ = A.ORD_SEQ
        AND W.ODDSC_TP_CD = 'C')
          AND 'A' = :IN_CHECK
   -- 2
   UNION ALL
   SELECT
    A.ORD_CD
    , C.ORD_NM
    , '1'        QTY
    , D.BRFG_STF_NO                    REPT_DR
    , (SELECT  --/*+ INDEX(E ACPPEICE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEICE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND D.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM')
       AND E.RPY_PACT_ID = D.RPY_PACT_ID
       AND E.ORD_CD = D.ORD_CD
       AND E.PT_NO = D.PT_NO
          )             PRC
   FROM MSERMAAD A
   , CCOOCCSC B
   , CCOOCBAC C
   , MOOOREXM D
   WHERE A.PHTG_DTM BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1','DS','CP','PA')
    AND D.EXM_PRGR_STS_CD IN ('E','D','N')
    AND D.ODDSC_TP_CD = 'C'
    AND B.ORD_SLIP_CTG_CD = C.ORD_SLIP_CTG_CD
    AND A.ORD_CD = C.ORD_CD
    AND A.ORD_ID = D.ORD_ID
    AND A.PT_NO = D.PT_NO
    AND A.ORD_DT = D.ORD_DT
    AND A.ORD_SEQ = D.ORD_SEQ
    AND D.PACT_TP_CD LIKE '' || '%'
    AND EXISTS (SELECT 'Y' FROM MOOOREXM W
       WHERE W.ORD_ID = A.ORD_ID
        AND W.PT_NO = A.PT_NO
        AND W.ORD_DT = A.ORD_DT
        AND W.ORD_SEQ = A.ORD_SEQ
        AND W.ODDSC_TP_CD = 'C')
          AND 'A' = :IN_CHECK

   -- 3
   UNION ALL
   SELECT
    A.ORD_CD
    , B.ORD_NM
    , '1'        QTY
    , NVL(A.RTM_FMT_STF_NO, A.FSR_STF_NO)  REPT_DR
    , (SELECT   /*+ INDEX(E ACPPEOCE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEOCE E
   --    , AIMIRPMC F
      WHERE 1=1 --E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND A.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM', 'MOOORFED')
       AND E.RPY_PACT_ID = A.RPY_PACT_ID
   --    AND E.ORD_CD = A.ORD_CD
       AND E.MIF_CD = A.MIF_CD
       AND E.PT_NO = A.PT_NO
          )             PRC
   FROM MOOORFED A
   , CCOOCBAC B
   WHERE A.ORD_CTG_CD = 'TRM'
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1','DS')
    AND A.ORD_CD = B.ORD_CD
    AND A.PACT_TP_CD LIKE '' || '%'
    AND A.ORD_CD IN ('L9429','L9430','H10110','L9403EA','L9405EB','L9406EC','L9407ED')
    AND A.ORD_DT BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_DT >= TO_DATE('20100101','YYYYMMDD')
    AND A.ODDSC_TP_CD = 'C'
          AND 'A' = :IN_CHECK

   -- 4
   UNION ALL
   SELECT
    A.ORD_CD
    , B.ORD_NM
    , '1'        QTY
    , NVL(A.RTM_FMT_STF_NO, A.FSR_STF_NO)  REPT_DR
    , (SELECT  /*+ INDEX(E ACPPEICE_PK) */
       SUM(E.HSP_ADN_ICLS_AMT) + SUM(E.CMED_AMT)
      FROM ACPPEICE E
   --    , AIMIRPMC F
      WHERE 1=1--E.MIF_CD = F.MIF_CD
   --     AND F.APY_END_DT IS NULL
   --  AND A.ORD_DT BETWEEN F.APY_STR_DT AND F.APY_END_DT
       AND E.ORD_INPT_TBL_NM IN ('MOOOREXM', 'MOOORFED')
       AND E.RPY_PACT_ID = A.RPY_PACT_ID
   --    AND E.ORD_CD = A.ORD_CD
       AND E.MIF_CD = A.MIF_CD
       AND E.PT_NO = A.PT_NO
          )             PRC
   FROM MOOORFED A
   , CCOOCBAC B
   WHERE A.ORD_CTG_CD = 'TRM'
    AND A.ORD_CTG_CD NOT IN ('BR1','BN1','DS')
    AND A.ORD_CD = B.ORD_CD
    AND A.PACT_TP_CD LIKE '' || '%'
    AND A.ORD_CD IN ('L9429','L9430','H10110','L9403EA','L9405EB','L9406EC','L9407ED')
    AND A.ORD_DT BETWEEN TO_DATE(:IN_FROM_DT || '01', 'YYYYMMDD')
         AND LAST_DAY(TO_DATE(:IN_TO_DATE, 'YYYYMM')) + 0.99999
    AND A.ORD_DT >= TO_DATE('20100101','YYYYMMDD')
    AND A.ODDSC_TP_CD = 'C'
          AND 'A' = :IN_CHECK

   ) K
GROUP BY rollup(  K.REPT_DR
                , K.ORD_CD
                , K.ORD_NM)

ORDER BY 1,2

)  where 1=1
     and "합계" is not null
order by case when "판독의" = '합계'
               then 1
               else 0
           end
          ,1,2



