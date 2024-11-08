
EXEC :IN_SELYN := '3';
EXEC :IN_YYYY := '2023';
EXEC :IN_LOOK := '1';


/*#### 3번 진료과별/의사별 환자현황 시작 ##################----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*3-6번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

           select
              case when group_ing = '00' then --rank = 1 and
                        med_dept_nm
                   when group_ing = '11' then
                        '합계'
                   else  null
              end        as "부서명"
             ,meddr_id as "의사명"
             ,ROUND(AAA.CNTALL / (TO_NUMBER(TO_CHAR(SYSDATE, 'DDD')-1) ) )                                        AS "총합"
             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT01 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT01 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END                                                                                                 AS "1월"



             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT02 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT02 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END                                                                                                 AS "2월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT03 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT03 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "3월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT04 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT04 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "4월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT05 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT05 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "5월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT06 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT06 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "6월"
             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT07 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT07 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "7월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT08 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT08 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "8월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT09 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT09 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END   AS "9월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT10 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT10 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "10월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT11 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT11 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END    AS "11월"

             ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1
                        THEN ROUND(AAA.CNT12 / SUBSTR(LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')),-2,2), 1)
                        ELSE ROUND(AAA.CNT12 / SUBSTR(TRUNC(SYSDATE)-1,-2,2) , 1)
              END  AS "12월"
         from
             (


/*----3_5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                  select
                     NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)  med_dept_nm
                    ,meddr_id
                    ,cntall
                    ,cnt01
                    ,cnt02
                    ,cnt03
                    ,cnt04
                    ,cnt05
                    ,cnt06
                    ,cnt07
                    ,cnt08
                    ,cnt09
                    ,cnt10
                    ,cnt11
                    ,cnt12
                    ,group_ing
                    ,row_number() over (partition by   NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)
                                            order by   meddr_id
                                       ) rank
                from
                    (


/*----3_4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                          --------------------------------------------------------------------------------------
                     -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 추가함..
                     --------------------------------------------------------------------------------------
                     SELECT
                            MED_DEPT                                                               MED_DEPT
                           ,NVL((XCOM.FT_CNL_SELSTFINFO('4',MEDDR_ID,NULL)) , MEDDR_ID)            MEDDR_ID
                           ,CNTALL                                                                 CNTALL
                           ,CNT01                                                                  CNT01
                           ,CNT02                                                                  CNT02
                           ,CNT03                                                                  CNT03
                           ,CNT04                                                                  CNT04
                           ,CNT05                                                                  CNT05
                           ,CNT06                                                                  CNT06
                           ,CNT07                                                                  CNT07
                           ,CNT08                                                                  CNT08
                           ,CNT09                                                                  CNT09
                           ,CNT10                                                                  CNT10
                           ,CNT11                                                                  CNT11
                           ,CNT12                                                                  CNT12
                           ,GROUP_ING                                                              GROUP_ING
                           , XBIL.FC_GET_DEPT_NM(MEDDR_ID)            as sss
                       FROM (

/*----3_3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                              SELECT
                                    A.MED_DEPT                                                   MED_DEPT
                                   ,NVL(B.LSH_STF_NO,A.MEDDR_ID)                                 MEDDR_ID
                                   ,SUM(A.CNTALL)                                                CNTALL
                                   ,SUM(A.CNT01 )                                                CNT01
                                   ,SUM(A.CNT02 )                                                CNT02
                                   ,SUM(A.CNT03 )                                                CNT03
                                   ,SUM(A.CNT04 )                                                CNT04
                                   ,SUM(A.CNT05 )                                                CNT05
                                   ,SUM(A.CNT06 )                                                CNT06
                                   ,SUM(A.CNT07 )                                                CNT07
                                   ,SUM(A.CNT08 )                                                CNT08
                                   ,SUM(A.CNT09 )                                                CNT09
                                   ,SUM(A.CNT10 )                                                CNT10
                                   ,SUM(A.CNT11 )                                                CNT11
                                   ,SUM(A.CNT12 )                                                CNT12
                                   ,GROUPING(A.MED_DEPT)||GROUPING(NVL(B.LSH_STF_NO,A.MEDDR_ID))  GROUP_ING
                               FROM (

/*----3_2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                     select
                                            a.med_dept                                                   med_dept
                                            --------------------------------------------------------------------------------------
                                            -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 이 logic 막고.. meddr_id 그냥 사용
                                            --------------------------------------------------------------------------------------
                                           ,a.meddr_id                                                   meddr_id
                                            --------------------------------------------------------------------------------------
                                            -- 수정전 logic
                                            --------------------------------------------------------------------------------------
                                           --,nvl((select wk_nm   from ccusermt a where wk_id = meddr_id),meddr_id)  meddr_id --||' '||meddr_id
                                            --------------------------------------------------------------------------------------
                                           ,sum(a.o_cnt+a.i_cnt)                                          cntall
                                           ,sum(case when to_char(a.med_dte,'mm') = '01'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt01
                                           ,sum(case when to_char(a.med_dte,'mm') = '02'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt02
                                           ,sum(case when to_char(a.med_dte,'mm') = '03'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt03
                                           ,sum(case when to_char(a.med_dte,'mm') = '04'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt04
                                           ,sum(case when to_char(a.med_dte,'mm') = '05'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt05
                                           ,sum(case when to_char(a.med_dte,'mm') = '06'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt06
                                           ,sum(case when to_char(a.med_dte,'mm') = '07'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt07
                                           ,sum(case when to_char(a.med_dte,'mm') = '08'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt08
                                           ,sum(case when to_char(a.med_dte,'mm') = '09'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt09
                                           ,sum(case when to_char(a.med_dte,'mm') = '10'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt10
                                           ,sum(case when to_char(a.med_dte,'mm') = '11'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt11
                                           ,sum(case when to_char(a.med_dte,'mm') = '12'  then
                                                          a.o_cnt+a.i_cnt
                                                     else  0 end)                                        cnt12
                                            --------------------------------------------------------------------------------------
                                            -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 이 logic 막는다
                                            --------------------------------------------------------------------------------------
                                           --,grouping(a.med_dept)||grouping(a.meddr_id)    group_ing
                                       from
                                            (
/*----3_1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                           SELECT
                                                    MED_DTE
                                                   ,MED_DEPT
                                                   ,MEDDR_ID
                                                   ,CASE :IN_SELYN
                                                         WHEN '1' THEN
                                                              CHSPCRSV_CNT+JESPCRSV_CNT+SHRSV_CNT
                                                         WHEN '2' THEN
                                                              CHUNSPCRSV_CNT+JEUNSPCRSV_CNT+SHUNSPCRSV_CNT
                                                         ELSE
                                                              RSV_CNT+TODAY_CNT
                                                    END                      O_CNT
                                                   ,0                        I_CNT
                                              FROM APSTATMT2
                                                  ,(
                                                    SELECT TO_DATE(:IN_YYYY   ||'0101','YYYYMMDD')  STAR_DTE
                                                          ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY   ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                     LAST_DAY(TO_DATE(:IN_YYYY   ||'1201','YYYYMMDD'))
                                                                ELSE
                                                                     TRUNC(SYSDATE)-1
                                                           END END_DTE
                                                      FROM DUAL
                                                   )
                                             WHERE MED_DTE BETWEEN STAR_DTE  AND  END_DTE
                                               AND DTL_TYP = '06'
                                               AND PATSITE IN ('O','E')
                                               AND CASE WHEN :IN_LOOK = '1' THEN '1'
                                                        WHEN :IN_LOOK = '2' THEN 'X'
                                                        ELSE :IN_LOOK
                                                   END  =  :IN_LOOK




                                             UNION ALL



                                             SELECT
                                                   MED_DTE
                                                  ,MED_DEPT
                                                  ,MEDDR_ID
                                                  ,0               O_CNT
                                                  ,CASE :IN_SELYN
                                                        WHEN '1' THEN
                                                             JESPCRCP_CNT
                                                        WHEN '2' THEN
                                                             JEUNSPCRCP_CNT
                                                        ELSE
                                                             JESPCRSV_CNT
                                                   END
                                              FROM APSTATMT2
                                             WHERE MED_DTE IN (
                                                               SELECT
                                                                      DISTINCT
                                                                      CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY   ||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                                LAST_DAY(TO_DATE(:IN_YYYY   ||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                                           ELSE
                                                                                TRUNC(SYSDATE) -1
                                                                      END
                                                                 FROM DICT
                                                                WHERE ROWNUM <= 12
                                                              )
                                               AND DTL_TYP = 'M01'
                                               AND PATSITE = 'I'
                                               AND WK_KEY  = '1'
                                               AND CASE WHEN :IN_LOOK = '1' THEN 'X'
                                                        WHEN :IN_LOOK = '2' THEN '2'
                                                        ELSE :IN_LOOK
                                                   END  =  :IN_LOOK

/*3-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



                                                 ) A
                                       -------------------------------------------------------------------------------------------
                                       -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 rollup 제거및 having 조건 제거
                                       -------------------------------------------------------------------------------------------
                                       GROUP BY
                                             A.MED_DEPT
                                            ,A.MEDDR_ID
                                       HAVING SUM(A.O_CNT+A.I_CNT) != 0
                                       -------------------------------------------------------------------------------------------
                                       -- 수정전 logic
                                       -------------------------------------------------------------------------------------------
                                       --group by
                                       --        rollup( a.med_dept
                                       --               ,a.meddr_id
                                       --               )
                                       --having    sum(a.o_cnt+a.i_cnt) != 0
                                       --     and grouping(a.med_dept)||grouping(a.meddr_id) in ('00','11')
                                       -------------------------------------------------------------------------------------------
/*3-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                  ) A
                                  , CNLRRUSD  B     -- ASIS 시스템사용자마스타 테이블(CCUSERMT)
                              WHERE B.STF_NO(+) = NVL(A.MEDDR_ID,'*')
                              GROUP BY
                                    ROLLUP(A.MED_DEPT,NVL(B.LSH_STF_NO,A.MEDDR_ID))
                             HAVING SUM(A.CNTALL) != 0
                                AND GROUPING(A.MED_DEPT)||GROUPING(NVL(B.LSH_STF_NO,A.MEDDR_ID)) IN ('00','11')
/*3-3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )
/*3-4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

             )
/*3-5번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
          ) AAA
/*3-6번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
