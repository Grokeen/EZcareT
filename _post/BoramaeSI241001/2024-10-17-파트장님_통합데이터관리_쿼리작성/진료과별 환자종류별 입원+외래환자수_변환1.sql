
EXEC :IN_FROMYYMM  := '202410';
EXEC :IN_TOYYMM := '202410';
EXEC :IN_PATSITE := '1';
EXEC :IN_SUJINFLAG := '1';

 /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income009
        *    최초 작성일     : 2009.10.22
        *    최초 작성자     :
        *    Description     : 진료과별환자종류별환자수
        *    Input Parameter :
        *    페이지ID        : D:\WEB\MIS\PTS\PTS\INC\ReadClcDtGa2.aspx
        *
--     1.&in_fromyymm  => yyyymm :년월
--     2.&in_toyymm    => yyyymm :년월
--     3.&in_sujinflag => '1' : 수진, '2':미수진  else 전체
--     4.&in_patsite  => 1:입원 , 2:외래 3:전체
        ***********************************************************************************/


/* 6번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

   SELECT *

        FROM (
/* 5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

        SELECT
               CASE WHEN GROUP_ING = '0' THEN
                         NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)
                    ELSE --(CASE :IN_SUJINFLAG
--                                  WHEN '1' THEN '입원 합계'
--                                  WHEN '2' THEN '외래 합계'
--                                  ELSE
                                       '합계'
--                          END)
               END              AS "진료과"
              ,TOT_CNT           AS "합계"
              -------------------------------------------------------------------
              -- 2010.11.29 이강준 보험(차상위포함) ==> 보험,차상위 분리
              -------------------------------------------------------------------
              --기존
              --,INS_CNT
              -------------------------------------------------------------------
              ,INS_CNT              AS "보험"
              ,CHA_CNT              AS "차상위"
              -------------------------------------------------------------------
              ,BOHO_CNT             AS "보호"
              ,GEN_CNT              AS "일반"
              ,SAN_CNT              AS "산재/공상"
              ,CAR_CNT              AS "교통"
              ,HANG_CNT             AS "행려"
              ,ETC_CNT              AS "기타"
              ,CASE WHEN TOT_CNT = 0 OR DAY_CNT = 0 THEN
                         0
                    ELSE
                         ROUND(TOT_CNT / DAY_CNT , 0)
               END                  AS "일평균 환자수"
              ,CASE WHEN TOT_CNT = 0 OR TOTAL_CNT = 0 THEN
                         0
                    ELSE
                         ROUND(TOT_CNT / TOTAL_CNT *100,1)
               END                  AS "구성비(%)"
              ,SPC_Y_CNT            AS "선택계"
              ,SPC_N_CNT            AS "비선택계"
          FROM
              (




/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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
                      END                                                     MED_DEPT
                     ,SUM(SINCNT +  CHOCNT + JAECNT)                          TOT_CNT
                     ------------------------------------------------------------
                     -- 2010.11.29 이강준 보험(차상위포함) ==> 보험,차상위 분리
                     ------------------------------------------------------------
                     --기존LOGIC
                     --,SUM(
                     --     CASE WHEN PATTYPE IN ('B1','B2','B6','BB') THEN
                     --               SINCNT + CHOCNT + JAECNT
                     --          ELSE
                     --               0
                     --     END
                     --    )                                                    INS_CNT
                     ------------------------------------------------------------
                     ,SUM(
                          CASE WHEN PATTYPE IN ('BB') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    INS_CNT
                     ,SUM(
                          CASE WHEN PATTYPE IN ('B1','B2','B6') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    CHA_CNT
                     ------------------------------------------------------------
                     ,SUM(
                          CASE WHEN PATTYPE IN ('E1','E2','E6') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    BOHO_CNT
                     ,SUM(
                          CASE WHEN PATTYPE IN ('AA') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    GEN_CNT
                     ,SUM(
                          CASE WHEN PATTYPE IN ('SA','SB','SP') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    SAN_CNT
                     ,SUM(
                          CASE WHEN PATTYPE IN ('TA') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    CAR_CNT
                     ,SUM(
                          CASE WHEN PATTYPE IN ('E8') THEN
                                    SINCNT + CHOCNT + JAECNT
                               ELSE
                                    0
                          END
                         )                                                    HANG_CNT
                     ,SUM(
                          CASE WHEN PATTYPE IN ( 'B1','B2','B6','BB'
                                                ,'E1','E2','E6'
                                                ,'AA'
                                                ,'SA','SB','SP'
                                                ,'TA'
                                                ,'E8'
                                               ) THEN
                                    0
                               ELSE
                                    SINCNT + CHOCNT + JAECNT
                          END
                         )                                                    ETC_CNT
                     ,SUM(SPC_Y_CNT) SPC_Y_CNT
                     ,SUM(SPC_N_CNT) SPC_N_CNT
                     ,GROUPING(
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
                              )    GROUP_ING
                 FROM
                     (





/* 3-1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          SELECT
                             MED_DEPT
                            ,PATTYPE
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN SHSPCMED_CNT+SHUNSPCMED_CNT
                                  WHEN '2' THEN (SHRSV_CNT+SHUNSPCRSV_CNT) - (SHSPCMED_CNT+SHUNSPCMED_CNT)
                                  ELSE          SHRSV_CNT+SHUNSPCRSV_CNT
                             END   SINCNT
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN MEDCHSPC_CNT+CHUNSPCMED_CNT
                                  WHEN '2' THEN (CHSPCRSV_CNT+CHUNSPCRSV_CNT) - (MEDCHSPC_CNT+CHUNSPCMED_CNT)
                                  ELSE          CHSPCRSV_CNT+CHUNSPCRSV_CNT
                             END   CHOCNT
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN JESPCMED_CNT+JEUNSPCMED_CNT
                                  WHEN '2' THEN (JESPCRSV_CNT+JEUNSPCRSV_CNT) -(JESPCMED_CNT+JEUNSPCMED_CNT)
                                  ELSE          JESPCRSV_CNT+JEUNSPCRSV_CNT
                             END   JAECNT
                            ,RSV_CNT+TODAY_CNT TCNT
                            -------------------------------------------------------------------------------
                            -- 2010.12.03 이강준 지정,비지정 부분에는 수진,미수진이 적용이 안되어 있음..적용처리
                            -------------------------------------------------------------------------------
                            --기존LOGIC
                            --,CHSPCRSV_CNT+JESPCRSV_CNT+SHRSV_CNT               SPC_Y_CNT
                            --,CHUNSPCRSV_CNT+JEUNSPCRSV_CNT+SHUNSPCRSV_CNT      SPC_N_CNT
                            -------------------------------------------------------------------------------
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN MEDCHSPC_CNT+JESPCMED_CNT+SHSPCMED_CNT
                                  WHEN '2' THEN (CHSPCRSV_CNT+JESPCRSV_CNT+SHRSV_CNT) - (MEDCHSPC_CNT+JESPCMED_CNT+SHSPCMED_CNT)
                                  ELSE          CHSPCRSV_CNT+JESPCRSV_CNT+SHRSV_CNT
                             END                                               SPC_Y_CNT

                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN CHUNSPCMED_CNT+JEUNSPCMED_CNT+SHUNSPCMED_CNT
                                  WHEN '2' THEN (CHUNSPCRSV_CNT+JEUNSPCRSV_CNT+SHUNSPCRSV_CNT) - (CHUNSPCMED_CNT+JEUNSPCMED_CNT+SHUNSPCMED_CNT)
                                  ELSE          CHUNSPCRSV_CNT+JEUNSPCRSV_CNT+SHUNSPCRSV_CNT
                             END                                               SPC_N_CNT
                        FROM APSTATMT2
                            ,
                            (



/* 3-1-1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                             SELECT
                                    TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD') STAR_DTE
                                   ,CASE WHEN LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE) -1 THEN
                                              LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD'))
                                         ELSE
                                              TRUNC(SYSDATE) -1
                                    END     END_DTE
                               FROM DUAL


/* 3-1-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )
                       WHERE MED_DTE BETWEEN STAR_DTE AND END_DTE
                         AND DTL_TYP = '06'
                         AND PATSITE IN ('O','E')
                         AND CASE WHEN :IN_PATSITE = '1' THEN '1'
                                  WHEN :IN_PATSITE = '2' THEN '2'
                                  ELSE '3'
                             END
                                 =
                                   CASE WHEN :IN_PATSITE = '1' THEN 'X'
                                        WHEN :IN_PATSITE = '2' THEN '2'
                                        ELSE '3'
                                   END


/* 3-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



                          UNION ALL


/* 3-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                           SELECT
                             MED_DEPT
                            ,PATTYPE
                            ,0                   SINCNT
                            ,0                   CHOCNT
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN JESPCRSV_CNT
                                  WHEN '2' THEN JESPCRSV_CNT - JESPCRSV_CNT
                                  ELSE          JESPCRSV_CNT
                             END                 JAECNT
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN JESPCRSV_CNT
                                  WHEN '2' THEN JESPCRSV_CNT - JESPCRSV_CNT
                                  ELSE          JESPCRSV_CNT
                             END                 T_CNT
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN JESPCRCP_CNT
                                  WHEN '2' THEN JESPCRCP_CNT - JESPCRCP_CNT
                                  ELSE          JESPCRCP_CNT
                             END                 SPC_Y_CNT
                            ,CASE :IN_SUJINFLAG
                                  WHEN '1' THEN JEUNSPCRCP_CNT
                                  WHEN '2' THEN JEUNSPCRCP_CNT - JEUNSPCRCP_CNT
                                  ELSE          JEUNSPCRCP_CNT
                             END                SPC_N_CNT
--                            ,JESPCRSV_CNT        JAECNT
--                            ,JESPCRSV_CNT        T_CNT
--                            ,JESPCRCP_CNT        SPC_Y_CNT
--                            ,JEUNSPCRCP_CNT      SPC_N_CNT
                        FROM APSTATMT2
                       WHERE MED_DTE IN
                                        (


/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                         SELECT  END_DTE
                                           FROM
                                               (



/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                SELECT
                                                       DISTINCT
                                                       CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FROMYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                 LAST_DAY(TO_DATE(SUBSTR(:IN_FROMYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                            ELSE
                                                                 TRUNC(SYSDATE) -1
                                                       END     END_DTE
                                                      ,ROW_NUMBER() OVER(PARTITION BY ROWNUM ORDER BY ROWNUM) RANK
                                                      ,CASE WHEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                 LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD'))
                                                            ELSE
                                                                 TRUNC(SYSDATE)-1
                                                       END                                FROM_DTE
                                                     ,CASE WHEN LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD'))
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
--                         AND WD_NO NOT IN ('ER99','OR99','OGOB','NB')
                         AND (CHUNSPCRSV_CNT != 0 OR JESPCRCP_CNT != 0  OR JEUNSPCRCP_CNT != 0)
                         AND CASE WHEN :IN_PATSITE = '1' THEN '1'
                                  WHEN :IN_PATSITE = '2' THEN '2'
                                  ELSE '3'
                             END
                                 =
                                   CASE WHEN :IN_PATSITE = '1' THEN '1'
                                        WHEN :IN_PATSITE = '2' THEN 'X'
                                        ELSE '3'
                                   END

/* 3-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                               )
               GROUP BY
                        ROLLUP(
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
                              )


/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                           )

                           ,
                           (




/* A번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      SELECT
                             NVL(SUM(RSV_CNT+TODAY_CNT),0) TOTAL_CNT
                        FROM APSTATMT2
                            ,
                            (


/* B-1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                             SELECT
                                    TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD') STAR_DTE
                                   ,CASE WHEN LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE) -1 THEN
                                              LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD'))
                                         ELSE
                                              TRUNC(SYSDATE) -1
                                    END     END_DTE
                               FROM DUAL


/* B-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )
                       WHERE MED_DTE BETWEEN STAR_DTE AND END_DTE
                         AND DTL_TYP = '06'
                         AND PATSITE IN ('O','E')
                         AND CASE WHEN :IN_PATSITE = '1' THEN '1'
                                  WHEN :IN_PATSITE = '2' THEN '2'
                                  ELSE '3'
                             END
                                 =
                                   CASE WHEN :IN_PATSITE = '1' THEN 'X'
                                        WHEN :IN_PATSITE = '2' THEN '2'
                                        ELSE '3'
                                   END


/* A번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      UNION ALL


/* A-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      SELECT
                             SUM(JESPCRSV_CNT) TOTAL_CNT
                        FROM APSTATMT2
                       WHERE MED_DTE IN
                                        (


/* C번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                         SELECT  END_DTE
                                           FROM
                                               (



/* D번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                SELECT
                                                       DISTINCT
                                                       CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FROMYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                 LAST_DAY(TO_DATE(SUBSTR(:IN_FROMYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                            ELSE
                                                                 TRUNC(SYSDATE) -1
                                                       END     END_DTE
                                                      ,ROW_NUMBER() OVER(PARTITION BY ROWNUM ORDER BY ROWNUM) RANK
                                                      ,CASE WHEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                 LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD'))
                                                            ELSE
                                                                 TRUNC(SYSDATE)-1
                                                       END                                FROM_DTE
                                                     ,CASE WHEN LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD'))
                                                           ELSE
                                                                TRUNC(SYSDATE)-1
                                                      END                                 TO_DTE
                                                  FROM DICT
                                                 WHERE ROWNUM < 12



/* D번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                               )
                                          WHERE END_DTE BETWEEN  FROM_DTE AND TO_DTE



/* C번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                        )
                         AND DTL_TYP = 'M01'
                         AND PATSITE = 'I'
                         AND WK_KEY  = '1'
--                         AND WD_NO NOT IN ('ER99','OR99','OGOB','NB')
                         AND (CHUNSPCRSV_CNT != 0 OR JESPCRCP_CNT != 0  OR JEUNSPCRCP_CNT != 0)
                         AND CASE WHEN :IN_PATSITE = '1' THEN '1'
                                  WHEN :IN_PATSITE = '2' THEN '2'
                                  ELSE '3'
                             END
                                 =
                                   CASE WHEN :IN_PATSITE = '1' THEN '1'
                                        WHEN :IN_PATSITE = '2' THEN 'X'
                                        ELSE '3'
                                   END


/* B-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                     )



/* A-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


               ,
                (

/* ㄱ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                  SELECT
                      STAR_DTE
                     ,END_DTE
                     ,CASE WHEN :IN_PATSITE = '1'  THEN
                                XSUP.FT_CNT_OPDAY(STAR_DTE,END_DTE,'1')
                           WHEN :IN_PATSITE = '2'  THEN
                                XSUP.FT_CNT_OPDAY(STAR_DTE,END_DTE,'3')
                           ELSE
                                (XSUP.FT_CNT_OPDAY(STAR_DTE,END_DTE,'1')+XSUP.FT_CNT_OPDAY(STAR_DTE,END_DTE,'3')) / 2
                      END    DAY_CNT
                 FROM
                     (


/* ㄴ번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      SELECT
                             TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD') STAR_DTE
                            ,CASE WHEN LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE) -1 THEN
                                       LAST_DAY(TO_DATE(:IN_TOYYMM ||'01','YYYYMMDD'))
                                  ELSE
                                       TRUNC(SYSDATE) -1
                             END     END_DTE
                        FROM DUAL


/* ㄴ번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                     )


/* ㄱ번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

              ) B
         ORDER BY
                  TO_NUMBER(GROUP_ING)
                 ,MED_DEPT


/* 5번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

    )
    WHERE "구성비(%)" IS NOT NULL


/* 6번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

       ;;;



EXEC :IN_FROMYYMM  := '202408';
EXEC :IN_TOYYMM := '202408';
EXEC :IN_PATSITE := '3';
EXEC :IN_SUJINFLAG := '3';

 /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income009
        *    최초 작성일     : 2009.10.22
        *    최초 작성자     :
        *    Description     : 진료과별환자종류별환자수
        *    Input Parameter :
        *    페이지ID        : D:\WEB\MIS\PTS\PTS\INC\ReadClcDtGa2.aspx
        *
--     1.&in_fromyymm  => yyyymm :년월
--     2.&in_toyymm    => yyyymm :년월
--     3.&in_sujinflag => '1' : 수진, '2':미수진  else 전체
--     4.&in_patsite  => 1:입원 , 2:외래 3:전체
        ***********************************************************************************/




