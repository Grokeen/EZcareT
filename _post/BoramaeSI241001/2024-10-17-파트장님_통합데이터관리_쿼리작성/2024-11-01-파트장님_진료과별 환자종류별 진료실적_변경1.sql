EXEC :IN_FYYYYMM := '202408';
EXEC :IN_TYYYYMM := '202408';
EXEC :IN_LOOK := '';

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

        SELECT
               NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) ,'총합') AS MED_DEPT


              ,SUM(TOT_CNT)                       "환자수"
              ,SUM(SIN_CNT)                       "신환  "
              ,SUM(CHO_CNT)                       "초진  "
              ,SUM(JAE_CNT)                       "재진  "
              ,CASE WHEN SUM(TOT_CNT) = 0 OR SUM(OP_DAY_CNT) = 0 THEN          -- SUM(
                         0
                    ELSE
                         ROUND(SUM(TOT_CNT)    /    SUM(OP_DAY_CNT)    )      --SUM(
               END                                "일평균"
              ,SUM(PT_RIP_CNT)                    "입원실환자수(최종과)"
              ,SUM(TRIP_CNT)                      "재원연환자수(전과반영)"
              ,CASE WHEN SUM(TRIP_CNT) = 0 OR SUM(IP_DAY_CNT) = 0 THEN      -- SUM(
                         0
                    ELSE
                         ROUND(SUM(TRIP_CNT)  /    SUM(IP_DAY_CNT))    --SUM(
               END                                "일평균(입)"
              ,SUM(PT_TIP_CNT )                   "퇴원실환자수(최종과)"
              ,SUM(TTIP_CNT)                      "퇴원연환자수(최종과)"
              ,CASE WHEN SUM(TTIP_CNT) = 0 OR SUM(IP_DAY_CNT) = 0 THEN              --SUM(
                         0
                    ELSE
                         ROUND(SUM(TTIP_CNT)    /   SUM(IP_DAY_CNT))   --SUM(
               END                                "일평균(퇴)"
              ,CASE WHEN SUM(TOE_DTE) = 0 OR SUM(TIP_CNT) = 0 THEN
                         0
                    ELSE
                         ROUND(SUM(TOE_DTE)/SUM(TIP_CNT),1)
               END                                "평균재원일(전과반영)"
              ,CASE WHEN SUM(TTIP_CNT) = 0 OR SUM(PT_TIP_CNT) = 0 THEN
                         0
                    ELSE
                         ROUND(SUM(TTIP_CNT)/SUM(PT_TIP_CNT),1)
               END                                "평균재원일"
          FROM
              (


/* ㄴ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

               SELECT
                      -----------------------------------------------------------
                      -- 2010.10.01 센터관련 적용
                      -----------------------------------------------------------
                      CASE WHEN MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                           WHEN MED_DEPT = 'BCGS'            THEN 'GS'
                           WHEN MED_DEPT = 'BCOL'            THEN 'OL'
                           WHEN MED_DEPT = 'BCPS'            THEN 'PS'
                           WHEN MED_DEPT = 'BCDR'            THEN 'DR'

                           WHEN MED_DEPT = 'CVGS'            THEN 'GS'
                           WHEN MED_DEPT = 'CVIMC'           THEN 'IMC'
                           WHEN MED_DEPT = 'CVTS'            THEN 'TS'
                           WHEN MED_DEPT = 'DEIME'           THEN 'IME'
                           WHEN MED_DEPT = 'OGO2'            THEN 'OG'

                           WHEN MED_DEPT = 'RCIMR'           THEN 'IMR'
                           WHEN MED_DEPT = 'RCNP'            THEN 'NP'
                           WHEN MED_DEPT = 'RCTS'            THEN 'TS'

                           WHEN MED_DEPT = 'THDR'            THEN 'DR'
                           WHEN MED_DEPT = 'THGS'            THEN 'GS'
                           WHEN MED_DEPT = 'THIME'           THEN 'IME'
                           WHEN MED_DEPT = 'THNM'            THEN 'NM'
                           WHEN MED_DEPT = 'THOL'            THEN 'OL'
                           WHEN MED_DEPT = 'ONP'            THEN 'NP'

                           ELSE MED_DEPT
                       END                                                         MED_DEPT
                     ,SUM(RSV_CNT+TODAY_CNT)                                       TOT_CNT
                     ,SUM(SHRSV_CNT+SHUNSPCRSV_CNT)                                SIN_CNT
                     ,SUM(CHSPCRSV_CNT+CHUNSPCRSV_CNT)                             CHO_CNT
                     ,SUM(JESPCRSV_CNT+JEUNSPCRSV_CNT)                             JAE_CNT
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            PT_RIP_CNT    --입원실환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            TRIP_CNT      --재원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            PT_TIP_CNT    --퇴원실환자수(최종과)
                     ,0                                                            TTIP_CNT      --퇴원연환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            TIP_CNT       --퇴원실환자수(전과반영)
                     ,0                                                            TOE_DTE       --퇴원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,'1' GUBUN
                 FROM APSTATMT2
                     ,(










/* ㄱ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                        SELECT TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')  STAR_DTE
                              ,CASE WHEN LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                       LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD'))
                                  ELSE
                                       TRUNC(SYSDATE)-1
                               END END_DTE
                          FROM DUAL



/* ㄱ번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      )
                WHERE MED_DTE BETWEEN STAR_DTE  AND  END_DTE
                  AND DTL_TYP = '06'
                  AND PATSITE IN ('O','E')
                GROUP BY
                      -----------------------------------------------------------
                      -- 2010.10.01 센터관련 적용
                      -----------------------------------------------------------
                      CASE WHEN MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                           WHEN MED_DEPT = 'BCGS'            THEN 'GS'
                           WHEN MED_DEPT = 'BCOL'            THEN 'OL'
                           WHEN MED_DEPT = 'BCPS'            THEN 'PS'
                           WHEN MED_DEPT = 'BCDR'            THEN 'DR'

                           WHEN MED_DEPT = 'CVGS'            THEN 'GS'
                           WHEN MED_DEPT = 'CVIMC'           THEN 'IMC'
                           WHEN MED_DEPT = 'CVTS'            THEN 'TS'
                           WHEN MED_DEPT = 'DEIME'           THEN 'IME'
                           WHEN MED_DEPT = 'OGO2'            THEN 'OG'

                           WHEN MED_DEPT = 'RCIMR'           THEN 'IMR'
                           WHEN MED_DEPT = 'RCNP'            THEN 'NP'
                           WHEN MED_DEPT = 'RCTS'            THEN 'TS'

                           WHEN MED_DEPT = 'THDR'            THEN 'DR'
                           WHEN MED_DEPT = 'THGS'            THEN 'GS'
                           WHEN MED_DEPT = 'THIME'           THEN 'IME'
                           WHEN MED_DEPT = 'THNM'            THEN 'NM'
                           WHEN MED_DEPT = 'THOL'            THEN 'OL'
                           WHEN MED_DEPT = 'ONP'            THEN 'NP'

                           ELSE MED_DEPT
                       END





/* ㄴ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


               UNION ALL

/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

               SELECT
                      -----------------------------------------------------------
                      -- 2010.10.01 센터관련 적용
                      -----------------------------------------------------------
                      CASE WHEN MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                           WHEN MED_DEPT = 'BCGS'            THEN 'GS'
                           WHEN MED_DEPT = 'BCOL'            THEN 'OL'
                           WHEN MED_DEPT = 'BCPS'            THEN 'PS'
                           WHEN MED_DEPT = 'BCDR'            THEN 'DR'

                           WHEN MED_DEPT = 'CVGS'            THEN 'GS'
                           WHEN MED_DEPT = 'CVIMC'           THEN 'IMC'
                           WHEN MED_DEPT = 'CVTS'            THEN 'TS'
                           WHEN MED_DEPT = 'DEIME'           THEN 'IME'
                           WHEN MED_DEPT = 'OGO2'            THEN 'OG'

                           WHEN MED_DEPT = 'RCIMR'           THEN 'IMR'
                           WHEN MED_DEPT = 'RCNP'            THEN 'NP'
                           WHEN MED_DEPT = 'RCTS'            THEN 'TS'

                           WHEN MED_DEPT = 'THDR'            THEN 'DR'
                           WHEN MED_DEPT = 'THGS'            THEN 'GS'
                           WHEN MED_DEPT = 'THIME'           THEN 'IME'
                           WHEN MED_DEPT = 'THNM'            THEN 'NM'
                           WHEN MED_DEPT = 'THOL'            THEN 'OL'
                           WHEN MED_DEPT = 'ONP'            THEN 'NP'

                           ELSE MED_DEPT
                       END                                                         MED_DEPT
                     ,0                                                            TOT_CNT
                     ,0                                                            SIN_CNT
                     ,0                                                            CHO_CNT
                     ,0                                                            JAE_CNT
                     -----------------------------------------------------------------------------------------------------
                     ,SUM(DAY_CNT4)                                                PT_RIP_CNT    --입원실환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,SUM(JESPCRSV_CNT)                                            TRIP_CNT      --재원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,SUM(SHUNSPCRCP_CNT)                                          PT_TIP_CNT    --퇴원실환자수(최종과)
                     ,SUM(JEUNSPCRSV_CNT)                                          TTIP_CNT      --퇴원연환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,SUM(CHUNSPCRSV_CNT)                                          TIP_CNT       --퇴원실환자수(전과반영)
                     ,SUM(SHUNSPCRSV_CNT)                                          TOE_DTE       --퇴원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,'1'                                                          GUBUN
                 FROM APSTATMT2
                WHERE MED_DTE IN
                                 (



/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                  SELECT END_DTE
                                    FROM
                                        (





/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                         SELECT
                                                DISTINCT
                                                CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                          LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                     ELSE
                                                          TRUNC(SYSDATE) -1
                                                END     END_DTE
                                               ,ROW_NUMBER() OVER(PARTITION BY ROWNUM ORDER BY ROWNUM) RANK
                                               ,CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                          LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD'))
                                                     ELSE
                                                          TRUNC(SYSDATE)-1
                                                END                                FROM_DTE
                                              ,CASE WHEN LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                         LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD'))
                                                    ELSE
                                                         TRUNC(SYSDATE)-1
                                               END                                 TO_DTE
                                           FROM DICT
                                          WHERE ROWNUM <= 12



/* 1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                        )
                                   WHERE END_DTE BETWEEN  FROM_DTE AND TO_DTE


/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                 )
                   AND DTL_TYP = 'M01'
                   AND PATSITE = 'I'
                   AND WK_KEY  = '1'
                   AND WD_NO
                           NOT IN
                                  (CASE :IN_LOOK WHEN '1' THEN '*'
                                                 ELSE 'ER99'
                                   END
                                   ,
                                   CASE :IN_LOOK WHEN '1' THEN '*'
                                                 ELSE 'OR99'
                                   END
                                   ,
                                   CASE :IN_LOOK WHEN '1' THEN '*'
                                                 ELSE 'OGOB'
                                   END
                                   ,
                                   CASE :IN_LOOK WHEN '1' THEN '*'
                                                 ELSE 'NB'
                                   END
                                  )
                GROUP BY
                      -----------------------------------------------------------
                      -- 2010.10.01 센터관련 적용
                      -----------------------------------------------------------
                      CASE WHEN MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                           WHEN MED_DEPT = 'BCGS'            THEN 'GS'
                           WHEN MED_DEPT = 'BCOL'            THEN 'OL'
                           WHEN MED_DEPT = 'BCPS'            THEN 'PS'
                           WHEN MED_DEPT = 'BCDR'            THEN 'DR'

                           WHEN MED_DEPT = 'CVGS'            THEN 'GS'
                           WHEN MED_DEPT = 'CVIMC'           THEN 'IMC'
                           WHEN MED_DEPT = 'CVTS'            THEN 'TS'
                           WHEN MED_DEPT = 'DEIME'           THEN 'IME'
                           WHEN MED_DEPT = 'OGO2'            THEN 'OG'

                           WHEN MED_DEPT = 'RCIMR'           THEN 'IMR'
                           WHEN MED_DEPT = 'RCNP'            THEN 'NP'
                           WHEN MED_DEPT = 'RCTS'            THEN 'TS'

                           WHEN MED_DEPT = 'THDR'            THEN 'DR'
                           WHEN MED_DEPT = 'THGS'            THEN 'GS'
                           WHEN MED_DEPT = 'THIME'           THEN 'IME'
                           WHEN MED_DEPT = 'THNM'            THEN 'NM'
                           WHEN MED_DEPT = 'THOL'            THEN 'OL'
                           WHEN MED_DEPT = 'ONP'            THEN 'NP'

                           ELSE MED_DEPT
                       END



/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                   )
                    ,
                  (




/* B번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                SELECT XSUP.FT_CNT_OPDAY (STAR_DTE,END_DTE,'1') IP_DAY_CNT
                      ,XSUP.FT_CNT_OPDAY (STAR_DTE,END_DTE,'3') OP_DAY_CNT
                 FROM
                     (



/* A번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      SELECT TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')  STAR_DTE
                            ,CASE WHEN LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                       LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD'))
                                  ELSE
                                       TRUNC(SYSDATE)-1
                             END      END_DTE
                        FROM DUAL



/* A번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                      )


/* B번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

               )
        GROUP BY
                 ROLLUP(MED_DEPT)



/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



