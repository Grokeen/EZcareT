

EXEC :IN_YYYY := '2024';
EXEC :IN_SELYN := '3';   --3:전체/1:선택/2:비선택
EXEC :IN_LOOK := '1';   --1:외래/2:입원

WITH C AS
(
                            SELECT
                                    XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT_ALL
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT1
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT2
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0301','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0301','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0301','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT3
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0401','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0401','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0401','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT4
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0501','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0501','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0501','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT5
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0601','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0601','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0601','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT6
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0701','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0701','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0701','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT7
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0801','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0801','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0801','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT8
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0901','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0901','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0901','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT9
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'1001','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1001','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1001','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT10
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'1101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT11
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'3')               DAYCNT12
                               FROM
                                    DUAL
), B AS
(
                             SELECT
                                     XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT_ALL
                                    ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT1
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT2
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0301','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0301','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0301','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT3
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0401','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0401','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0401','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT4
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0501','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0501','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0501','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT5
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0601','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0601','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0601','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT6
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0701','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0701','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0701','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT7
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0801','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0801','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0801','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT8
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'0901','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'0901','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'0901','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT9
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'1001','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1001','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1001','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT10
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'1101','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1101','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT11
                                   ,XSUP.FT_CNT_OPDAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')
                                                ,CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                           LAST_DAY(TO_DATE(:IN_YYYY||'1201','YYYYMMDD'))
                                                      ELSE
                                                           TRUNC(SYSDATE)-1
                                                 END
                                                ,'1')               DAYCNT12
                               FROM
                                    DUAL

)

select       MED_DEPT_NM  "진료과"
             ,MEDDR_ID    "의사"
             ,CNTALL      "계"
             ,CNT01       "1월"
             ,CNT02       "2월"
             ,CNT03       "3월"
             ,CNT04       "4월"
             ,CNT05       "5월"
             ,CNT06       "6월"
             ,CNT07       "7월"
             ,CNT08       "8월"
             ,CNT09       "9월"
             ,CNT10       "10월"
             ,CNT11       "11월"
             ,CNT12       "12월"

from (SELECT
              CASE WHEN GROUP_ING = '0' THEN
                        MED_DEPT_NM
                   WHEN GROUP_ING = '1' THEN
                        '합계'
                   ELSE  NULL
              END        MED_DEPT_NM
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
         FROM
             (
              SELECT
                     NVL((SELECT
                                           DEPT_NM

                            FROM PDEDBMSM A
                           WHERE DEPT_CD = MED_DEPT),MED_DEPT)  MED_DEPT_NM
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
             SELECT
                              A.MED_DEPT                                                   MED_DEPT
                            , ''                                                           MEDDR_ID
                            , CASE WHEN A.O_CNTALL = 0 THEN 0 ELSE ROUND(A.O_CNTALL/C.DAYCNT_ALL) END
                  +
                               CASE WHEN A.I_CNTALL = 0 THEN 0 ELSE ROUND(A.I_CNTALL/B.DAYCNT_ALL) END      CNTALL
                            ,
                              CASE WHEN A.O_CNT01 = 0 THEN  0 ELSE ROUND(A.O_CNT01/C.DAYCNT1)     END
                              +
                              CASE WHEN A.I_CNT01 = 0 THEN  0 ELSE ROUND(A.I_CNT01/B.DAYCNT1)     END      CNT01
                            ,
                              CASE WHEN A.O_CNT02 = 0 THEN  0 ELSE ROUND(A.O_CNT02/C.DAYCNT2)     END
                              +
                              CASE WHEN A.I_CNT02 = 0 THEN  0 ELSE ROUND(A.I_CNT02/B.DAYCNT2)     END      CNT02
                            ,
                              CASE WHEN A.O_CNT03 = 0 THEN  0 ELSE ROUND(A.O_CNT03/C.DAYCNT3)     END
                              +
                              CASE WHEN A.I_CNT03 = 0 THEN  0 ELSE ROUND(A.I_CNT03/B.DAYCNT3)     END      CNT03
                            ,
                              CASE WHEN A.O_CNT04 = 0 THEN  0 ELSE ROUND(A.O_CNT04/C.DAYCNT4)     END
                              +
                              CASE WHEN A.I_CNT04 = 0 THEN  0 ELSE ROUND(A.I_CNT04/B.DAYCNT4)     END      CNT04
                            ,
                              CASE WHEN A.O_CNT05 = 0 THEN  0 ELSE ROUND(A.O_CNT05/C.DAYCNT5)     END
                              +
                              CASE WHEN A.I_CNT05 = 0 THEN  0 ELSE ROUND(A.I_CNT05/B.DAYCNT5)     END      CNT05
                            ,
                              CASE WHEN A.O_CNT06 = 0 THEN  0 ELSE ROUND(A.O_CNT06/C.DAYCNT6)     END
                              +
                              CASE WHEN A.I_CNT06 = 0 THEN  0 ELSE ROUND(A.I_CNT06/B.DAYCNT6)     END      CNT06
                            ,
                              CASE WHEN A.O_CNT07 = 0 THEN  0 ELSE ROUND(A.O_CNT07/C.DAYCNT7)     END
                              +
                              CASE WHEN A.I_CNT07 = 0 THEN  0 ELSE ROUND(A.I_CNT07/B.DAYCNT7)     END      CNT07
                            ,
                              CASE WHEN A.O_CNT08 = 0 THEN  0 ELSE ROUND(A.O_CNT08/C.DAYCNT8)     END
                              +
                              CASE WHEN A.I_CNT08 = 0 THEN  0 ELSE ROUND(A.I_CNT08/B.DAYCNT8)     END      CNT08
                            ,
                              CASE WHEN A.O_CNT09 = 0 THEN  0 ELSE ROUND(A.O_CNT09/C.DAYCNT9)     END
                              +
                              CASE WHEN A.I_CNT09 = 0 THEN  0 ELSE ROUND(A.I_CNT09/B.DAYCNT9)     END      CNT09
                            ,
                              CASE WHEN A.O_CNT10 = 0 THEN  0 ELSE ROUND(A.O_CNT10/C.DAYCNT10)     END
                              +
                              CASE WHEN A.I_CNT10 = 0 THEN  0 ELSE ROUND(A.I_CNT10/B.DAYCNT10)     END      CNT10
                            ,
                              CASE WHEN A.O_CNT11 = 0 THEN  0 ELSE ROUND(A.O_CNT11/C.DAYCNT11)     END
                              +
                              CASE WHEN A.I_CNT11 = 0 THEN  0 ELSE ROUND(A.I_CNT11/B.DAYCNT11)     END      CNT11
                            ,
                              CASE WHEN A.O_CNT12 = 0 THEN  0 ELSE ROUND(A.O_CNT12/C.DAYCNT12)     END
                              +
                              CASE WHEN A.I_CNT12 = 0 THEN  0 ELSE ROUND(A.I_CNT12/B.DAYCNT12)     END      CNT12
                            , A.GROUP_ING
                          FROM
                             (
                         SELECT

                                A.MED_DEPT                                                   MED_DEPT
                               ,''                                                           MEDDR_ID
                               , SUM(A.O_CNT)    "O_CNTALL"
                               , SUM(A.I_CNT)    "I_CNTALL"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01' THEN A.O_CNT ELSE 0 END)  "O_CNT01"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01' THEN A.I_CNT ELSE 0 END) "I_CNT01"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02' THEN A.O_CNT ELSE 0 END)  "O_CNT02"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02' THEN A.I_CNT ELSE 0 END)  "I_CNT02"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03' THEN A.O_CNT ELSE 0 END)  "O_CNT03"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03' THEN A.I_CNT ELSE 0 END)  "I_CNT03"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04' THEN A.O_CNT ELSE 0 END)  "O_CNT04"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04' THEN A.I_CNT ELSE 0 END)  "I_CNT04"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05' THEN A.O_CNT ELSE 0 END)  "O_CNT05"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05' THEN A.I_CNT ELSE 0 END)  "I_CNT05"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06' THEN A.O_CNT ELSE 0 END)  "O_CNT06"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06' THEN A.I_CNT ELSE 0 END)  "I_CNT06"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07' THEN A.O_CNT ELSE 0 END)  "O_CNT07"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07' THEN A.I_CNT ELSE 0 END)  "I_CNT07"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08' THEN A.O_CNT ELSE 0 END)  "O_CNT08"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08' THEN A.I_CNT ELSE 0 END)  "I_CNT08"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09' THEN A.O_CNT ELSE 0 END)  "O_CNT09"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09' THEN A.I_CNT ELSE 0 END)  "I_CNT09"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10' THEN A.O_CNT ELSE 0 END)  "O_CNT10"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10' THEN A.I_CNT ELSE 0 END)  "I_CNT10"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11' THEN A.O_CNT ELSE 0 END)  "O_CNT11"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11' THEN A.I_CNT ELSE 0 END)  "I_CNT11"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12' THEN A.O_CNT ELSE 0 END)  "O_CNT12"
                               , SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12' THEN A.I_CNT ELSE 0 END)  "I_CNT12"
                               --
                               ,GROUPING(A.MED_DEPT)    GROUP_ING


                           FROM
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
                                   AND WD_NO NOT IN ('ER99','OR99','OGOB','NB')
                                   AND CASE WHEN :IN_LOOK = '1' THEN 'X'
                                            WHEN :IN_LOOK = '2' THEN '2'
                                            ELSE :IN_LOOK
                                       END  =  :IN_LOOK
                                   ) A
                           GROUP BY
                                   ROLLUP(A.MED_DEPT)

                         ) A, B, C
                    WHERE CASE WHEN A.O_CNTALL = 0 THEN 0 ELSE TRUNC(A.O_CNTALL/C.DAYCNT_ALL) END
                  +
                              CASE WHEN A.I_CNTALL = 0 THEN 0 ELSE TRUNC(A.I_CNTALL/B.DAYCNT_ALL) END != 0
                    )

             )
             ) t
