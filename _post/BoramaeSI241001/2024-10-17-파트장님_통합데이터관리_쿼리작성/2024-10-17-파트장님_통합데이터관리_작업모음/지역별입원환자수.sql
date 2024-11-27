EXEC :IN_FYYYYMM := '2024';
EXEC :IN_LOOK := '1';
EXEC :IN_REP_TYP := '1';
exec :IN_LOOK_TYP :='2';




/** *                      1.IN_FYYYYMM     =>시작일자 =   YYYY.년 ,  YYYYMM.년월  , YYYYMMDD.년월일   ,  YYYYMMDD.년월일
    *                      2.IN_TYYYYMM     =>종료일자 =   NULL    ,  NULL        , NULL             ,  YYYYMMDD.년월일
    *
    *                      3.IN_LOOK        =>열람구분 =   1.연보,  2.월보 , 3.일보 , 4.기간
    *                      4.IN_REP_TYP     =>퇴원구분 =   1. 입원환자(실입원)
    *                                                    2. 입원환자(실입원)과별배분
    *                                                    3. 퇴원환자(실퇴원)
    *                                                    4. 퇴원환자(실퇴원)과별배분
    *                                                    5. 재원환자(연입원)
    *                                                    6. 총재원수(연퇴원)
    *                                                    (X)  7 퇴원평균재원일
    *                                                    (X)  8 퇴원평균재원일 = 과별배분
    *                      5.IN_AGE_TYP     =>나이구분 = 1.65세이상 , 2.65세미만 ,3.전체
    *                      6.(X)       IN_LOOK_TYP    =>제외병동 = 1.포함,2.미포함  ER99,OR99,OGOB,NB
**/

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


             SELECT
                   CASE WHEN GROUPING(MED_DEPT) = 0 THEN
                            NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)
                           ELSE
                            '합계'
                       END                                       "진료과"
                  ,SUM(HAPGAE)                               "합계"
                  ,SUM(BOHUM)                                "보험"
                  ,SUM(BOHO1)                                "보호1"
                  ,SUM(BOHO2)                                "보호2"
                  ,SUM(HANGYER)                              "행여"
                  ,SUM(SANJAE)                               "산재"
                  ,SUM(GONGSANG)                             "공상"
                  ,SUM(GENERAL)                              "일반"
                  ,SUM(TRAFFIC)                              "교통"
                  ,SUM(GITA)                                 "기타"
              FROM
                  (





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
                          END                                                        MED_DEPT
                         ,SUM(
                              CASE :IN_REP_TYP
                                   WHEN '1' THEN SHSPCRCP_CNT
                                   WHEN '2' THEN CHSPCRSV_CNT
                                   WHEN '3' THEN SHUNSPCRCP_CNT
                                   WHEN '4' THEN CHUNSPCRSV_CNT
                                   WHEN '5' THEN JESPCRSV_CNT
                                   WHEN '6' THEN JEUNSPCRSV_CNT
                                   ELSE 0
                              END
                             )                                                         HAPGAE
                         ,SUM(
                              CASE WHEN PATTYPE IN ('B1','B2','B6','BB') THEN
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                                   ELSE
                                        0
                              END
                             )                                                         BOHUM
                         ,SUM(
                              CASE WHEN PATTYPE IN ('E1','E2','E6')       THEN
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                                   ELSE
                                        0
                              END
                             )                                                         BOHO1
                         ,0                                                            BOHO2
                         ,SUM(
                              CASE WHEN PATTYPE IN ('E8')                THEN
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                                   ELSE
                                        0
                              END
                             )                                                         HANGYER
                         ,SUM(
                              CASE WHEN PATTYPE IN ('SA','SB','SP')           THEN
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                                   ELSE
                                        0
                              END
                             )                                                         SANJAE
                         ,0                                                            GONGSANG
                         ,SUM(
                              CASE WHEN PATTYPE IN ('AA')                THEN
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                                   ELSE
                                        0
                              END
                             )                                                         GENERAL
                         ,SUM(
                              CASE WHEN PATTYPE IN ('TA')                THEN
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                                   ELSE
                                        0
                              END
                             )                                                        TRAFFIC
                         ,SUM(
                              CASE WHEN PATTYPE IN ( 'B1','B2','B6','BB'
                                                    ,'E1','E2','E6'
                                                    ,'E8'
                                                    ,'SA','SB','SP'
                                                    ,'AA'
                                                    ,'TA'
                                                   )                     THEN
                                        0
                                   ELSE
                                        CASE :IN_REP_TYP
                                             WHEN '1' THEN SHSPCRCP_CNT           --실환자(인원) 입원
                                             WHEN '2' THEN CHSPCRSV_CNT           --실환자(과)   입원
                                             WHEN '3' THEN SHUNSPCRCP_CNT         --실환자(인원) 퇴원
                                             WHEN '4' THEN CHUNSPCRSV_CNT         --실환자(과)   퇴원
                                             WHEN '5' THEN JESPCRSV_CNT           --연환자(인원) 입원
                                             WHEN '6' THEN JEUNSPCRSV_CNT         --연환자(인원) 퇴원
                                             ELSE 0
                                        END
                              END
                             )                                                         GITA
                         ,'1'                                                          GUBUN
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
                                                     CASE WHEN :IN_LOOK IN ('1','2') THEN
                                                               CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                         LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                                    ELSE
                                                                         TRUNC(SYSDATE) -1
                                                               END
                                                         ELSE
                                                               TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                     END       END_DTE
                                                    ,ROW_NUMBER() OVER(PARTITION BY ROWNUM ORDER BY ROWNUM) RANK
                                                FROM DICT
                                               WHERE ROWNUM <= 12

/* 1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                             )
                                        WHERE END_DTE BETWEEN CASE :IN_LOOK
                                                                   WHEN '1' THEN
                                                                        CASE WHEN TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD') < TRUNC(SYSDATE)-1  THEN
                                                                                  TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD')
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '2' THEN
                                                                        CASE WHEN TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD') < TRUNC(SYSDATE)-1  THEN
                                                                                  TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '3' THEN
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                   ELSE
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                              END
                                                          AND
                                                              CASE :IN_LOOK
                                                                   WHEN '1' THEN
                                                                        CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                  LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD'))
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '2' THEN
                                                                        CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                  LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD'))
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '3' THEN
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                   ELSE
                                                                        TO_DATE(:IN_TYYYYMM ,'YYYYMMDD')
                                                              END

/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                      )
                      AND DTL_TYP = 'M01'
                      AND PATSITE = 'I'
                      AND WK_KEY  = '1'

                      /*  */
--                      AND WD_NO
--                                NOT IN
--                                       (CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'ER99'
--                                        END
--                                        ,
--                                        CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'OR99'
--                                        END
--                                        ,
--                                        CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'OGOB'
--                                        END
--                                        ,
--                                        CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'NB'
--                                        END
--                                       )
--                      AND CASE WHEN :IN_AGE_TYP = '3' THEN
--                               '*'
--                               ELSE
--                                   CASE WHEN TO_NUMBER(AGE_TYP) >= 65 THEN
--                                             '1'
--                                        ELSE
--                                             '2'
--                                   END
--                          END  =  CASE WHEN :IN_AGE_TYP = '3' THEN
--                                            '*'
--                                       ELSE
--                                            :IN_AGE_TYP
--                                  END
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
             GROUP BY
                      ROLLUP(MED_DEPT)
             HAVING  SUM(HAPGAE) != 0
             ORDER BY
                      MED_DEPT
/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


;
EXEC :IN_REP_TYP := '7';
