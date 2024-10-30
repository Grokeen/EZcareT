
EXEC :IN_YYYY := '2024';
EXEC :IN_LOOK := '3';            --'1' 외래 ,'2' 입원  ,3 전체
EXEC :IN_SELYN := '3';           -- '1' 선택 ,'2' 비선택 ,else 전체

  ;;


-- 진료과별/의사별 일평균 환자수


 /* 2024-10-28 김용록 : 4-2번에 GROUP BY 절이 상이하다는 오류로 실행이 안되는 걸 방지하고자 max문을 남발했는데, 쿼리 속도가 매우 느리니 나중에 변경이 필요합니다. -> 환자종류별진료실적도 같은 문제지만, max문을 남발하지 않았습니다.  */
/*#### 4번 진료과별/의사별 일평균 환자수 시작 ##################----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*4-5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
            select
              case when group_ing = '00' then--rank = 1 and
                        med_dept_nm
                   when group_ing = '11' then
                        '합계'
                   else  null
              end        med_dept_nm
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
         from
             (
/*4-4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                 select
                     NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)                       AS MED_DEPT_NM
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


/*4-3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
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
                       FROM (

/*4-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/








                               SELECT
                                    A.MED_DEPT                                                             MED_DEPT

                                    --------------------------------------------------------------------------------------
                                    -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 수정
                                    --------------------------------------------------------------------------------------
                                   ,NVL(D.LSH_STF_NO,A.MEDDR_ID)                                            MEDDR_ID
                                    --------------------------------------------------------------------------------------
                                    --수정전 LOGIC
                                    --------------------------------------------------------------------------------------
                                    --,NVL((SELECT WK_NM   FROM CCUSERMT A WHERE WK_ID = MEDDR_ID),MEDDR_ID) MEDDR_ID
                                    --------------------------------------------------------------------------------------




                                    /* 2024-10-28 김용록 : GROUP BY 형식이 아니라는 오류에 '/' 뒤에 MAX()문 추가 , -> 전체적으로 쿼리 속도 저하 문제 있음 확인 후 변경 필요. */
                                   ,
                                     CASE WHEN SUM(A.O_CNT) = 0 THEN 0 ELSE ROUND(SUM(A.O_CNT)/MAX(C.DAYCNT_ALL)) END             --    뒤에 MAX()문 추가
                                     +
                                     CASE WHEN SUM(A.I_CNT) = 0 THEN 0 ELSE ROUND(SUM(A.I_CNT)/MAX(B.DAYCNT_ALL)) END      CNTALL   --      뒤에 MAX()문 추가


                                    ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01'  THEN A.O_CNT ELSE 0 END)/  MAX(C.DAYCNT1) )   --    뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01'  THEN A.I_CNT ELSE 0 END)/    MAX(B.DAYCNT1) )  --     뒤에 MAX()문 추가
                                     END                                                           CNT01
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02'  THEN A.O_CNT ELSE 0 END)/     MAX(C.DAYCNT2))--       뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02'  THEN A.I_CNT ELSE 0 END)/   MAX(B.DAYCNT2) )   --      뒤에 MAX()문 추가
                                     END                                                           CNT02
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03'  THEN A.O_CNT ELSE 0 END)/  MAX(C.DAYCNT3))       --     뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03'  THEN A.I_CNT ELSE 0 END)/  MAX(B.DAYCNT3))    --     뒤에 MAX()문 추가
                                     END                                                           CNT03
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04'  THEN A.O_CNT ELSE 0 END)/   MAX(C.DAYCNT4))   --      뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04'  THEN A.I_CNT ELSE 0 END)/  MAX(B.DAYCNT4))   --      뒤에 MAX()문 추가
                                     END                                                           CNT04
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05'  THEN A.O_CNT ELSE 0 END)/    MAX(C.DAYCNT5))   --    뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05'  THEN A.I_CNT ELSE 0 END)/   MAX(B.DAYCNT5))   --    뒤에 MAX()문 추가
                                     END                                                           CNT05
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06'  THEN A.O_CNT ELSE 0 END)/   MAX(C.DAYCNT6))   --뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06'  THEN A.I_CNT ELSE 0 END)/ MAX(B.DAYCNT6))   --   뒤에 MAX()문 추가
                                     END                                                           CNT06
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07'  THEN A.O_CNT ELSE 0 END)/   MAX(C.DAYCNT7))  --뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07'  THEN A.I_CNT ELSE 0 END)/  MAX(B.DAYCNT7)) --뒤에 MAX()문 추가
                                     END                                                           CNT07
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08'  THEN A.O_CNT ELSE 0 END)/ MAX(C.DAYCNT8))  --    뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08'  THEN A.I_CNT ELSE 0 END)/ MAX(B.DAYCNT8) )  --      뒤에 MAX()문 추가
                                     END                                                           CNT08
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09'  THEN A.O_CNT ELSE 0 END)/  MAX(C.DAYCNT9) )     --    뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09'  THEN A.I_CNT ELSE 0 END)/  MAX(B.DAYCNT9) ) --    뒤에 MAX()문 추가
                                     END                                                           CNT09
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10'  THEN A.O_CNT ELSE 0 END)/   MAX(C.DAYCNT10) )  --    뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10'  THEN A.I_CNT ELSE 0 END)/   MAX(B.DAYCNT10)  )  --   뒤에 MAX()문 추가
                                     END                                                           CNT10
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11'  THEN A.O_CNT ELSE 0 END)/  MAX(C.DAYCNT11) )    --뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11'  THEN A.I_CNT ELSE 0 END)/ MAX(B.DAYCNT11) )  --   뒤에 MAX()문 추가
                                     END                                                           CNT11
                                   ,
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12'  THEN A.O_CNT ELSE 0 END)/ MAX(C.DAYCNT12) )  --   뒤에 MAX()문 추가
                                     END
                                     +
                                     CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                               0
                                          ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12'  THEN A.I_CNT ELSE 0 END)/  MAX(B.DAYCNT12)  ) --  뒤에 MAX()문 추가
                                     END                                                           CNT12

                                    --------------------------------------------------------------------------------------
                                    -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 수정
                                    --------------------------------------------------------------------------------------
                                   ,GROUPING(A.MED_DEPT)||GROUPING(NVL(D.LSH_STF_NO,A.MEDDR_ID))     GROUP_ING

                                    --------------------------------------------------------------------------------------
                                    -- 수정전 LOGIC
                                    --------------------------------------------------------------------------------------
                                   --,GROUPING(A.MED_DEPT)||GROUPING(A.MEDDR_ID)    GROUP_ING
                                    --------------------------------------------------------------------------------------
                            FROM


/*4-1-1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                             ( SELECT
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
                             WHERE /* 진료일자 범위 */
															 MED_DTE BETWEEN TRUNC(TO_DATE(:IN_YYYY  ||'0101','YYYYMMDD'))
															             AND (CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY  ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1
															                       THEN LAST_DAY(TO_DATE(:IN_YYYY  ||'1201','YYYYMMDD'))
                                                     ELSE TRUNC(SYSDATE)-1
                                                 END)
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
                             WHERE MED_DTE IN (SELECT DISTINCT CASE WHEN LAST_DAY(TO_DATE( :IN_YYYY ||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1
                                                            THEN LAST_DAY(TO_DATE( :IN_YYYY ||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                            ELSE TRUNC(SYSDATE) -1
                                                       END
                                                 FROM DICT
                                                WHERE ROWNUM <= 12
                                              )
                               AND DTL_TYP = 'M01'
                               AND PATSITE = 'I'
                               AND WK_KEY  = '1'
--                               AND WD_NO NOT IN ('ER99','OR99','OGOB','NB')
                               AND CASE WHEN :IN_LOOK = '1' THEN 'X'
                                        WHEN :IN_LOOK = '2' THEN '2'
                                        ELSE :IN_LOOK
                                   END  =  :IN_LOOK
                         ) A ,


/*4-1-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*4-1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                        (
                                 SELECT
                                     FT_CNT_OPDAY( TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')
                                                  ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1
                                                        THEN LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD'))
                                                        ELSE TRUNC(SYSDATE)-1
                                                   END
                                                  ,'1')               AS DAYCNT_ALL


                                    ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT1

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT2

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT3

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT4

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT5

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT6

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT7

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT8

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT9

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT10

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT11

                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT12
                               FROM DUAL

                              ) B,

/*4-1-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*4-1-3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                              ( SELECT
                                    FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT_ALL
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT1
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT2
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0301','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT3
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0401','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT4
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0501','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT5
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0601','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT6
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0701','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT7
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0801','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT8
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'0901','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT9
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1001','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT10
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT11
                                   ,FT_CNT_OPDAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY ||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT12
                               FROM DUAL
                               ) C,


/*4-1-3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                             CNLRRUSD D

                             WHERE D.STF_NO(+) = NVL(A.MEDDR_ID,'*')
                               GROUP BY
                                    ROLLUP( MED_DEPT , NVL(D.LSH_STF_NO , A.MEDDR_ID)  )

                              /* 2024-10-28 김용록 : GROUP BY 형식이 아니라는 오류에 '/' 뒤에 MAX()문 추가 */
                              HAVING CASE WHEN SUM(A.O_CNT) = 0 THEN 0 ELSE TRUNC( SUM(A.O_CNT) / MAX(C.DAYCNT_ALL) ) END              -- 뒤에 MAX()문 추가
                                     +
                                     CASE WHEN SUM(A.I_CNT) = 0 THEN 0 ELSE TRUNC(SUM(A.I_CNT)/ MAX(B.DAYCNT_ALL)) END  != 0           -- 뒤에 MAX()문 추가
                                 AND GROUPING(A.MED_DEPT) || GROUPING(NVL(D.LSH_STF_NO,A.MEDDR_ID)) IN ('00','11')



/*4-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                           )
/*4-3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                      )


/*4-4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                  )

/*4-5번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

