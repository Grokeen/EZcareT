EXEC :IN_LOOK := '1';
EXEC :IN_FYYYYMM := '2024';
EXEC :IN_TYYYYMM := '';
EXEC :IN_LOOK_TYP := '1';
EXEC :IN_REP_TYP := '3';



  /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income022_new
        *    최초 작성일     : 2010.12.06
        *    최초 작성자     :
        *    Description     : 병동별 환자종류별 연간입퇴원환자
        *    Input Parameter :
    *                      1.in_fyyyymm     =>시작일자 :  yyyy :년,  yyyymm :년월, yyyymmdd:년월일 ,  yyyymmdd:년월일
    *                      2.in_tyyyymm     =>종료일자 :  NULL    ,  NULL        , NULL            ,  yyyymmdd:년월일
    *                      3.in_look        =>열람구분 : '1' 연보,  '2' 월보    , '3' 일보       , else 기간
    *                      4.in_rep_typ     =>퇴원구분 : '1' 입원실환자수    :등록최초과
    *                                                    '2' 재원연환자수    :전과반영
    *                                                    '3' 재원실환자수    :전과반영
    *                                                    '4' 퇴원실환자수    :최종과
    *                                                    '5' 퇴원실환자수    :전과반영
    *                                                    '6' 퇴원연환자수    :최종과
    *                                                    '7' 퇴원연환자수    :전과반영
    *                                                    '8' 퇴원평균재원일수:최종과  (퇴원연환자/퇴원실환자)
    *                                                    '9' 퇴원평균재원일수:전과반영(퇴원연환자/퇴원실환자)
    *                      5.in_age_typ     =>나이구분 : '1' 65세이상 , '2' 65세미만 ,'3' 전체
    *                      6.in_look_typ    =>제외병동 : '1' 포함 ,'2' 미포함   ;ER99,OR99,OGOB,NB
        *    페이지ID        :
        ***********************************************************************************/


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

            SELECT
                   CASE WHEN GROUPING(MED_DEPT) = 0 THEN
                            (

                                ( XBIL.FC_GET_DEPT_NM(MED_DEPT))
/* A번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--                            SELECT
--                                   DEPT_NM || CASE WHEN MED_DEPT LIKE '%+%' AND
--                                                        SUBSTR(MED_DEPT,INSTR(MED_DEPT,'+',1,1)+1,2) = '01' THEN '-가족분만실'
--                                                   WHEN MED_DEPT LIKE '%+%' AND
--                                                        SUBSTR(MED_DEPT,INSTR(MED_DEPT,'+',1,1)+1,2) = '02' THEN '-뇌졸중집중치료실'
--                                                                                                            ELSE NULL
--                                              END
--                               FROM CCDEPART A
--                              WHERE DEPT_CD =
--                                             CASE WHEN (MED_DEPT LIKE '%+%') THEN SUBSTR(MED_DEPT,1,INSTR(MED_DEPT,'+',1,1)-1)
--                                                                             ELSE MED_DEPT
--                                              END


/* A번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )
                           ELSE
                            '합계'
                       END                                       "병동"
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
                          WD_NO                                                        MED_DEPT
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
                              CASE WHEN PATTYPE IN ('E1','E2','E6')      THEN
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
                         ,0                                                            GONGSANG
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

                                              SELECT DISTINCT
                                                     CASE
                                                        WHEN :IN_LOOK = '1' THEN
                                                               CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                         LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                                    ELSE
                                                                         TRUNC(SYSDATE) -1
                                                               END

                                                        WHEN :IN_LOOK = '2' THEN
                                                               CASE WHEN LAST_DAY(TO_DATE(CASE WHEN LPAD(ROWNUM,2,'0') < SUBSTR(:IN_FYYYYMM ,5,2)
                                                                                               THEN SUBSTR(:IN_TYYYYMM ,1,4)
                                                                                               ELSE SUBSTR(:IN_FYYYYMM ,1,4)
                                                                                          END||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1
                                                                    THEN LAST_DAY(TO_DATE(CASE WHEN LPAD(ROWNUM,2,'0') < SUBSTR(:IN_FYYYYMM ,5,2)
                                                                                               THEN SUBSTR(:IN_TYYYYMM ,1,4)
                                                                                               ELSE SUBSTR(:IN_FYYYYMM , 1,4)
                                                                                          END||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
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



/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                      )
                      AND DTL_TYP = 'M01'--'XXX'--'M01'
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
                             WD_NO
                                                                                                                                                               

/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



                )
             group by
                      rollup(med_dept)
             having  sum(hapgae) != 0
             order by
                      med_dept


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/











;
EXEC :IN_LOOK := '1';
EXEC :IN_FYYYYMM := '2024';
EXEC :IN_TYYYYMM := '';
EXEC :IN_LOOK_TYP := '1';
EXEC :IN_REP_TYP := '7';
