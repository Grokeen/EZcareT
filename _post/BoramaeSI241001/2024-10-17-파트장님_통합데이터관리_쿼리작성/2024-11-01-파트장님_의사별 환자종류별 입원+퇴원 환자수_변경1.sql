EXEC :in_fyyyymm  := '2024';
EXEC :in_look := '1';
EXEC :in_age_typ := '3';
EXEC :in_rep_typ := '1';
EXEC :in_look_typ := '1';



/* 6번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

            SELECT
                   CASE WHEN GROUPING(MED_DEPT)||GROUPING(MEDDR_ID) = '11' THEN
                            '합계'
                           ELSE
                            ( XBIL.FC_GET_DEPT_NM(MED_DEPT))
                       END                                      AS  "진료과"



                  ,CASE WHEN GROUPING(MED_DEPT)||GROUPING(MEDDR_ID) = '00' THEN
                                                                                 NVL((XCOM.FT_CNL_SELSTFINFO('4',MEDDR_ID,NULL)) , MEDDR_ID)
                        WHEN GROUPING(MED_DEPT)||GROUPING(MEDDR_ID) = '11' THEN
                            '전체'
                           ELSE
                            '소계'
                       END                                      AS  "진료의"
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


/* 5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                   --------------------------------------------------------------------------------------
                   -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 추가함..
                   --------------------------------------------------------------------------------------
                   SELECT
                          A.MED_DEPT                                      MED_DEPT
                         ,A.MEDDR_ID                                      MEDDR_ID
                         ,A.GUBUN                                         GUBUN
                         ,SUM(A.HAPGAE  )                                 HAPGAE
                         ,SUM(A.BOHUM   )                                 BOHUM
                         ,SUM(A.BOHO1   )                                 BOHO1
                         ,SUM(A.BOHO2   )                                 BOHO2
                         ,SUM(A.HANGYER )                                 HANGYER
                         ,SUM(A.SANJAE  )                                 SANJAE
                         ,SUM(A.GONGSANG)                                 GONGSANG
                         ,SUM(A.GENERAL )                                 GENERAL
                         ,SUM(A.TRAFFIC )                                 TRAFFIC
                         ,SUM(A.GITA    )                                 GITA
                     FROM (


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
                                  END                                                          MED_DEPT
                                 ,MEDDR_ID
                                 ,SUM(
                                      CASE :IN_REP_TYP
                                           WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                           WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                           WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                           WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                           WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                           WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                           WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
                                           ELSE 0
                                      END
                                     )                                                         HAPGAE
                                 ,SUM(
                                      CASE WHEN PATTYPE IN ('B1','B2','B6','BB') THEN
                                                CASE :IN_REP_TYP
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
                                                     ELSE 0
                                                END
                                           ELSE
                                                0
                                      END
                                     )                                                         BOHUM
                                 ,SUM(
                                      CASE WHEN PATTYPE IN ('E1','E2','E6')                THEN
                                                CASE :IN_REP_TYP
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
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
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
                                                     ELSE 0
                                                END
                                           ELSE
                                                0
                                      END
                                     )                                                         HANGYER
                                 ,SUM(
                                      CASE WHEN PATTYPE IN ('SA','SB','SP')      THEN
                                                CASE :IN_REP_TYP
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
                                                     ELSE 0
                                                END
                                           ELSE
                                                0
                                      END
                                     )                                                         SANJAE
                                 ,0                                                           GONGSANG
                                 ,SUM(
                                      CASE WHEN PATTYPE IN ('AA')                THEN
                                                CASE :IN_REP_TYP
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
                                                     ELSE 0
                                                END
                                           ELSE
                                                0
                                      END
                                     )                                                         GENERAL
                                 ,SUM(
                                      CASE WHEN PATTYPE IN ('TA')                THEN
                                                CASE :IN_REP_TYP
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
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
                                                     WHEN '1' THEN DAY_CNT4           --입원실환자수    :등록최초과
                                                     WHEN '2' THEN JESPCRSV_CNT       --재원연환자수    :전과반영
                                                     WHEN '3' THEN CHSPCRSV_CNT       --재원실환자수    :전과반영
                                                     WHEN '4' THEN SHUNSPCRCP_CNT     --퇴원실환자수    :최종과
                                                     WHEN '5' THEN CHUNSPCRSV_CNT     --퇴원실환자수    :전과반영
                                                     WHEN '6' THEN JEUNSPCRSV_CNT     --퇴원연환자수    :최종과
                                                     WHEN '7' THEN SHUNSPCRSV_CNT     --퇴원연환자수    :전과반영
                                                     ELSE 0
                                                END
                                      END
                                     )                                                         GITA
                                 ,'1' GUBUN
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
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD'))
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
                                                                                TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                      END
                                                                  AND CASE :IN_LOOK
                                                                           WHEN '1' THEN
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD'))
                                                                                     ELSE
                                                                                          TRUNC(SYSDATE)-1
                                                                                END
                                                                           WHEN '2' THEN
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD'))
                                                                                     ELSE
                                                                                          TRUNC(SYSDATE)-1
                                                                                END
                                                                           WHEN '3' THEN
                                                                                TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                           ELSE
                                                                                TO_DATE(:IN_TYYYYMM ,'YYYYMMDD')
                                                                      END




/* 2번 긑----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                              )



                              AND DTL_TYP = 'M01'
                              AND PATSITE = 'I'
                              AND WK_KEY  = '1'
                              AND WD_NO
                                        NOT IN
                                               (CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'ER99'
                                                END
                                                ,
                                                CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'OR99'
                                                END
                                                ,
                                                CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'OGOB'
                                                END
                                                ,
                                                CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'NB'
                                                END
                                               )
                              AND CASE WHEN :IN_AGE_TYP = '3' THEN
                                       '*'
                                       ELSE
                                           CASE WHEN TO_NUMBER(AGE_TYP) >= 65 THEN
                                                     '1'
                                                ELSE
                                                     '2'
                                           END
                                  END  =  CASE WHEN :IN_AGE_TYP = '3' THEN
                                                    '*'
                                               ELSE
                                                    :IN_AGE_TYP
                                          END
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
                                 ,MEDDR_ID



/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          )        A


                    GROUP BY
                          A.MED_DEPT
                         ,A.MEDDR_ID
                         ,A.GUBUN



/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                  )
             GROUP BY
                      ROLLUP(MED_DEPT,MEDDR_ID)
             HAVING  SUM(HAPGAE) != 0
             ORDER BY
                     MED_DEPT


                           ;;
/* 5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

EXEC :in_fyyyymm  := '2024';
EXEC :in_look := '1';
EXEC :in_age_typ := '3';
EXEC :in_rep_typ := '1';
EXEC :in_look_typ := '2';
