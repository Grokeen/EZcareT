
EXEC :IN_FROM_DATE := '202408';
EXEC :IN_TO_DATE := '202408';
EXEC :IN_YYYY := '2024';
EXEC :IN_LOOK := '3';            --'1' 외래 ,'2' 입원  ,3 전체
EXEC :IN_SELYN := '3';           -- '1' 선택 ,'2' 비선택 ,else 전체





/*#### 3번 진료과별/의사별 환자현황 시작 ##################----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/ 





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
                                                    SELECT TO_DATE(:IN_YYYY||'0101','YYYYMMDD')  STAR_DTE
                                                          ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                     LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD'))
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
                                                                      CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                                LAST_DAY(TO_DATE(:IN_YYYY||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
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

;;;


