GRANT EXECUTE ON XBIL.FC_GET_DEPT_NM TO XSUP;
EXEC :IN_FROM_DATE := '202408';
EXEC :IN_TO_DATE := '202408';
EXEC :IN_YYYY := '2024';
EXEC :IN_LOOK := '3';            --'1' 외래 ,'2' 입원  ,3 전체
EXEC :IN_SELYN := '3';           -- '1' 선택 ,'2' 비선택 ,else 전체









/*#### 2번 진료과별 일평균 환자수 시작 ##################----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*----2_4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                    SELECT
              CASE WHEN GROUP_ING = '0' THEN
                        MED_DEPT_NM
                   WHEN GROUP_ING = '1' THEN
                        '합계'
                   ELSE  NULL
              END      AS "진료과"
             ,MEDDR_ID AS "진료의"
             ,CNTALL   AS "계"
             ,CNT01    AS "1월"
             ,CNT02    AS "2월"
             ,CNT03    AS "3월"
             ,CNT04    AS "4월"
             ,CNT05    AS "5월"
             ,CNT06    AS "6월"
             ,CNT07    AS "7월"
             ,CNT08    AS "8월"
             ,CNT09    AS "9월"
             ,CNT10    AS "10월"
             ,CNT11    AS "11월"
             ,CNT12    AS "12월"
         FROM
             (

/*----2_3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
              SELECT
                     NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)                                AS MED_DEPT_NM

                    ,MEDDR_ID
                    ,CNTALL
                    ,CNT01
                    ,CNT02
                    ,CNT03
                    ,CNT04
                    ,CNT05
                    ,CNT06
                    ,CNT07
                    ,CNT08
                    ,CNT09
                    ,CNT10
                    ,CNT11
                    ,CNT12
                    ,GROUP_ING
                    ,1      RANK
                FROM
                    (



/*----2_2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                       SELECT
                       			--
                            A.MED_DEPT                                                                       AS MED_DEPT
                           ,''                                                                               AS MEDDR_ID
                           ,
                             CASE WHEN SUM(A.O_CNT) = 0 THEN 0 ELSE ROUND(SUM( A.O_CNT)/ SUM(C.DAYCNT_ALL) ) END
                             +
                             CASE WHEN SUM(A.I_CNT) = 0 THEN 0 ELSE ROUND(SUM( A.I_CNT)/SUM(B.DAYCNT_ALL) ) END     AS CNTALL



                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT1))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT1))
                             END                                                                             AS CNT01



                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT2))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT2))
                             END                                                                             AS CNT02





                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT3))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT3))
                             END                                                                              AS CNT03




                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT4))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT4))
                             END                                                                              AS CNT04




                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT5))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT5))
                             END                                                                              AS CNT05



                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT6))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT6))
                             END                                                                              AS CNT06
                           ,


                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT7))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT7))
                             END                                                                              AS CNT07
                           ,

                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT8))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT8))
                             END                                                                              AS CNT08
                           ,



                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT9))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT9))
                             END                                                                              AS CNT09
                           ,



                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT10))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT10))
                             END                                                                              AS CNT10


                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT11))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT11))
                             END                                                                              AS CNT11


                           ,
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12' THEN A.O_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12'  THEN A.O_CNT ELSE 0 END)/SUM(C.DAYCNT12))
                             END
                             +
                             CASE WHEN SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12' THEN A.I_CNT ELSE 0 END) = 0 THEN
                                       0
                                  ELSE ROUND(SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12'  THEN A.I_CNT ELSE 0 END)/SUM(B.DAYCNT12))
                             END                                                                              AS CNT12



                           ,GROUPING(A.MED_DEPT)                                             GROUP_ING
                       FROM


/*----2_1_1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                        (
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
/*----2_1-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



/*----2_1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
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

                              ) B ,

/*----2_1-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*----2_1-3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                               (

                               SELECT
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
                               ) C
/*----2_1-3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                        GROUP BY  --A.MED_DEPT
                         ROLLUP( A.MED_DEPT )
                      HAVING  CASE WHEN SUM(A.O_CNT) = 0 THEN 0
                                   ELSE TRUNC(SUM(A.O_CNT)/SUM(C.DAYCNT_ALL))
                              END
                              +
                              CASE WHEN SUM(A.I_CNT) = 0 THEN 0
                                   ELSE TRUNC(SUM(A.I_CNT)/ SUM(B.DAYCNT_ALL))
                              END  != 0



/*----2_2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
              )
/*----2_3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
     )
/*----2_4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
