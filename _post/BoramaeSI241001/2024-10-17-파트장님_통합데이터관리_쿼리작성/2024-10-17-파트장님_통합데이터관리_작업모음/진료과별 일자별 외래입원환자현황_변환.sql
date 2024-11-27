EXEC :IN_IO_GUBUN := '1';

EXEC :IN_FROMYYMM := '202408';








/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
           SELECT  (
                    NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)
                )                   AS  "진료과명"
             ,  SUM(
                NVL(A.D01, 0) + NVL(A.D02, 0) + NVL(A.D03, 0) + NVL(A.D04, 0) + NVL(A.D05, 0)
             +  NVL(A.D06, 0) + NVL(A.D07, 0) + NVL(A.D08, 0) + NVL(A.D09, 0) + NVL(A.D10, 0)
             +  NVL(A.D11, 0) + NVL(A.D12, 0) + NVL(A.D13, 0) + NVL(A.D14, 0) + NVL(A.D15, 0)
             +  NVL(A.D16, 0) + NVL(A.D17, 0) + NVL(A.D18, 0) + NVL(A.D19, 0) + NVL(A.D20, 0)
             +  NVL(A.D21, 0) + NVL(A.D22, 0) + NVL(A.D23, 0) + NVL(A.D24, 0) + NVL(A.D25, 0)
             +  NVL(A.D26, 0) + NVL(A.D27, 0) + NVL(A.D28, 0) + NVL(A.D29, 0) + NVL(A.D30, 0)
             +  NVL(A.D31, 0))      AS  "진료과계"

             ,  SUM(NVL(A.D01, 0))  AS  "01 일"
             ,  SUM(NVL(A.D02, 0))  AS  "02 일"
             ,  SUM(NVL(A.D03, 0))  AS  "03 일"
             ,  SUM(NVL(A.D04, 0))  AS  "04 일"
             ,  SUM(NVL(A.D05, 0))  AS  "05 일"
             ,  SUM(NVL(A.D06, 0))  AS  "06 일"
             ,  SUM(NVL(A.D07, 0))  AS  "07 일"
             ,  SUM(NVL(A.D08, 0))  AS  "08 일"
             ,  SUM(NVL(A.D09, 0))  AS  "09 일"
             ,  SUM(NVL(A.D10, 0))  AS  "10 일"
             ,  SUM(NVL(A.D11, 0))  AS  "11 일"
             ,  SUM(NVL(A.D12, 0))  AS  "12 일"
             ,  SUM(NVL(A.D13, 0))  AS  "13 일"
             ,  SUM(NVL(A.D14, 0))  AS  "14 일"
             ,  SUM(NVL(A.D15, 0))  AS  "15 일"
             ,  SUM(NVL(A.D16, 0))  AS  "16 일"
             ,  SUM(NVL(A.D17, 0))  AS  "17 일"
             ,  SUM(NVL(A.D18, 0))  AS  "18 일"
             ,  SUM(NVL(A.D19, 0))  AS  "19 일"
             ,  SUM(NVL(A.D20, 0))  AS  "20 일"
             ,  SUM(NVL(A.D21, 0))  AS  "21 일"
             ,  SUM(NVL(A.D22, 0))  AS  "22 일"
             ,  SUM(NVL(A.D23, 0))  AS  "23 일"
             ,  SUM(NVL(A.D24, 0))  AS  "24 일"
             ,  SUM(NVL(A.D25, 0))  AS  "25 일"
             ,  SUM(NVL(A.D26, 0))  AS  "26 일"
             ,  SUM(NVL(A.D27, 0))  AS  "27 일"
             ,  SUM(NVL(A.D28, 0))  AS  "28 일"
             ,  SUM(NVL(A.D29, 0))  AS  "29 일"
             ,  SUM(NVL(A.D30, 0))  AS  "30 일"
             ,  SUM(NVL(A.D31, 0))  AS  "31 일"
          FROM  (




/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                         SELECT  A.MED_DEPT
                         ,  NVL(A.D01, 0) + NVL(A.D02, 0) + NVL(A.D03, 0) + NVL(A.D04, 0) + NVL(A.D05, 0)
                         +  NVL(A.D06, 0) + NVL(A.D07, 0) + NVL(A.D08, 0) + NVL(A.D09, 0) + NVL(A.D10, 0)
                         +  NVL(A.D11, 0) + NVL(A.D12, 0) + NVL(A.D13, 0) + NVL(A.D14, 0) + NVL(A.D15, 0)
                         +  NVL(A.D16, 0) + NVL(A.D17, 0) + NVL(A.D18, 0) + NVL(A.D19, 0) + NVL(A.D20, 0)
                         +  NVL(A.D21, 0) + NVL(A.D22, 0) + NVL(A.D23, 0) + NVL(A.D24, 0) + NVL(A.D25, 0)
                         +  NVL(A.D26, 0) + NVL(A.D27, 0) + NVL(A.D28, 0) + NVL(A.D29, 0) + NVL(A.D30, 0)
                         +  NVL(A.D31, 0)   DEPT_SUM
                         ,  NVL(A.D01, 0)   D01
                         ,  NVL(A.D02, 0)   D02
                         ,  NVL(A.D03, 0)   D03
                         ,  NVL(A.D04, 0)   D04
                         ,  NVL(A.D05, 0)   D05
                         ,  NVL(A.D06, 0)   D06
                         ,  NVL(A.D07, 0)   D07
                         ,  NVL(A.D08, 0)   D08
                         ,  NVL(A.D09, 0)   D09
                         ,  NVL(A.D10, 0)   D10
                         ,  NVL(A.D11, 0)   D11
                         ,  NVL(A.D12, 0)   D12
                         ,  NVL(A.D13, 0)   D13
                         ,  NVL(A.D14, 0)   D14
                         ,  NVL(A.D15, 0)   D15
                         ,  NVL(A.D16, 0)   D16
                         ,  NVL(A.D17, 0)   D17
                         ,  NVL(A.D18, 0)   D18
                         ,  NVL(A.D19, 0)   D19
                         ,  NVL(A.D20, 0)   D20
                         ,  NVL(A.D21, 0)   D21
                         ,  NVL(A.D22, 0)   D22
                         ,  NVL(A.D23, 0)   D23
                         ,  NVL(A.D24, 0)   D24
                         ,  NVL(A.D25, 0)   D25
                         ,  NVL(A.D26, 0)   D26
                         ,  NVL(A.D27, 0)   D27
                         ,  NVL(A.D28, 0)   D28
                         ,  NVL(A.D29, 0)   D29
                         ,  NVL(A.D30, 0)   D30
                         ,  NVL(A.D31, 0)   D31
                      FROM  (



/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                     SELECT  *
                                       FROM  (

/* 1-1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

--01. 외래
                                            SELECT  TO_CHAR(Y.MED_DTE, 'DD')        DAY_CLS
                                                 ,  CASE
                                                        WHEN Y.MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                                                        WHEN Y.MED_DEPT = 'BCGS'            THEN 'GS'
                                                        WHEN Y.MED_DEPT = 'BCOL'            THEN 'OL'
                                                        WHEN Y.MED_DEPT = 'BCPS'            THEN 'PS'
                                                        WHEN Y.MED_DEPT = 'BCDR'            THEN 'DR'
                                                        WHEN Y.MED_DEPT = 'CVGS'            THEN 'GS'
                                                        WHEN Y.MED_DEPT = 'CVIMC'           THEN 'IMC'
                                                        WHEN Y.MED_DEPT = 'CVTS'            THEN 'TS'
                                                        WHEN Y.MED_DEPT = 'DEIME'           THEN 'IME'
                                                        WHEN Y.MED_DEPT = 'OGO2'            THEN 'OG'
                                                        WHEN Y.MED_DEPT = 'RCIMR'           THEN 'IMR'
                                                        WHEN Y.MED_DEPT = 'RCNP'            THEN 'NP'
                                                        WHEN Y.MED_DEPT = 'RCTS'            THEN 'TS'
                                                        WHEN Y.MED_DEPT = 'THDR'            THEN 'DR'
                                                        WHEN Y.MED_DEPT = 'THGS'            THEN 'GS'
                                                        WHEN Y.MED_DEPT = 'THIME'           THEN 'IME'
                                                        WHEN Y.MED_DEPT = 'THNM'            THEN 'NM'
                                                        WHEN Y.MED_DEPT = 'THOL'            THEN 'OL'
                                                        WHEN Y.MED_DEPT = 'ONP'             THEN 'NP'
                                                        ELSE Y.MED_DEPT
                                                    END                             MED_DEPT
                                                 ,  SUM(Y.RSV_CNT + Y.TODAY_CNT)    TCNT
                                              FROM  APSTATMT2   Y
                                             WHERE  Y.MED_DTE   BETWEEN TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')
                                                                    AND CASE
                                                                            WHEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE) - 1
                                                                            THEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD'))
                                                                            ELSE TRUNC(SYSDATE) - 1
                                                                        END
                                               AND  Y.DTL_TYP   =   '06'
                                               AND  Y.PATSITE   IN  ('O', 'E')
                                               AND  CASE
                                                        WHEN :IN_IO_GUBUN = '1' THEN '1'
                                                        WHEN :IN_IO_GUBUN = '2' THEN '2'
                                                        ELSE '3'
                                                    END         =   CASE
                                                                        WHEN :IN_IO_GUBUN = '1' THEN 'X'
                                                                        WHEN :IN_IO_GUBUN = '2' THEN '2'
                                                                        ELSE '3'
                                                                    END
                                             GROUP  BY
                                                    TO_CHAR(Y.MED_DTE, 'DD')
                                                 ,  CASE
                                                        WHEN Y.MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                                                        WHEN Y.MED_DEPT = 'BCGS'            THEN 'GS'
                                                        WHEN Y.MED_DEPT = 'BCOL'            THEN 'OL'
                                                        WHEN Y.MED_DEPT = 'BCPS'            THEN 'PS'
                                                        WHEN Y.MED_DEPT = 'BCDR'            THEN 'DR'
                                                        WHEN Y.MED_DEPT = 'CVGS'            THEN 'GS'
                                                        WHEN Y.MED_DEPT = 'CVIMC'           THEN 'IMC'
                                                        WHEN Y.MED_DEPT = 'CVTS'            THEN 'TS'
                                                        WHEN Y.MED_DEPT = 'DEIME'           THEN 'IME'
                                                        WHEN Y.MED_DEPT = 'OGO2'            THEN 'OG'
                                                        WHEN Y.MED_DEPT = 'RCIMR'           THEN 'IMR'
                                                        WHEN Y.MED_DEPT = 'RCNP'            THEN 'NP'
                                                        WHEN Y.MED_DEPT = 'RCTS'            THEN 'TS'
                                                        WHEN Y.MED_DEPT = 'THDR'            THEN 'DR'
                                                        WHEN Y.MED_DEPT = 'THGS'            THEN 'GS'
                                                        WHEN Y.MED_DEPT = 'THIME'           THEN 'IME'
                                                        WHEN Y.MED_DEPT = 'THNM'            THEN 'NM'
                                                        WHEN Y.MED_DEPT = 'THOL'            THEN 'OL'
                                                        WHEN Y.MED_DEPT = 'ONP'             THEN 'NP'
                                                        ELSE Y.MED_DEPT
                                                    END
/* 1-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                             UNION ALL

/* 1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                            SELECT  TO_CHAR(Y.MED_DTE, 'DD')        DAY_CLS
                                                 ,  Y.MED_DEPT
                                                 ,  SUM(Y.TCNT)                     TCNT
                                              FROM  (


/* 0-1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                        SELECT  Y.MED_DTE
                                                             ,  CASE
                                                                    WHEN Y.MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                                                                    WHEN Y.MED_DEPT = 'BCGS'            THEN 'GS'
                                                                    WHEN Y.MED_DEPT = 'BCOL'            THEN 'OL'
                                                                    WHEN Y.MED_DEPT = 'BCPS'            THEN 'PS'
                                                                    WHEN Y.MED_DEPT = 'BCDR'            THEN 'DR'
                                                                    WHEN Y.MED_DEPT = 'CVGS'            THEN 'GS'
                                                                    WHEN Y.MED_DEPT = 'CVIMC'           THEN 'IMC'
                                                                    WHEN Y.MED_DEPT = 'CVTS'            THEN 'TS'
                                                                    WHEN Y.MED_DEPT = 'DEIME'           THEN 'IME'
                                                                    WHEN Y.MED_DEPT = 'OGO2'            THEN 'OG'
                                                                    WHEN Y.MED_DEPT = 'RCIMR'           THEN 'IMR'
                                                                    WHEN Y.MED_DEPT = 'RCNP'            THEN 'NP'
                                                                    WHEN Y.MED_DEPT = 'RCTS'            THEN 'TS'
                                                                    WHEN Y.MED_DEPT = 'THDR'            THEN 'DR'
                                                                    WHEN Y.MED_DEPT = 'THGS'            THEN 'GS'
                                                                    WHEN Y.MED_DEPT = 'THIME'           THEN 'IME'
                                                                    WHEN Y.MED_DEPT = 'THNM'            THEN 'NM'
                                                                    WHEN Y.MED_DEPT = 'THOL'            THEN 'OL'
                                                                    WHEN Y.MED_DEPT = 'ONP'             THEN 'NP'
                                                                    ELSE Y.MED_DEPT
                                                                END                             MED_DEPT
                                                             ,  Y.JESPCRSV_CNT                  TCNT
                                                          FROM  APSTATMT2   Y
                                                         WHERE  Y.MED_DTE   BETWEEN TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')
                                                                                AND CASE
                                                                                        WHEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE) - 1
                                                                                        THEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD'))
                                                                                        ELSE TRUNC(SYSDATE) - 1
                                                                                    END
                                                           AND  Y.DTL_TYP   =   'M01'
                                                           AND  Y.PATSITE   =   'I'
                                                           AND  Y.WK_KEY    =   '1'
/* 0-1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                     UNION ALL
/* 0-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                      SELECT  Y.MED_DTE + 1                   MED_DTE
                                                             ,  CASE
                                                                    WHEN Y.MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                                                                    WHEN Y.MED_DEPT = 'BCGS'            THEN 'GS'
                                                                    WHEN Y.MED_DEPT = 'BCOL'            THEN 'OL'
                                                                    WHEN Y.MED_DEPT = 'BCPS'            THEN 'PS'
                                                                    WHEN Y.MED_DEPT = 'BCDR'            THEN 'DR'
                                                                    WHEN Y.MED_DEPT = 'CVGS'            THEN 'GS'
                                                                    WHEN Y.MED_DEPT = 'CVIMC'           THEN 'IMC'
                                                                    WHEN Y.MED_DEPT = 'CVTS'            THEN 'TS'
                                                                    WHEN Y.MED_DEPT = 'DEIME'           THEN 'IME'
                                                                    WHEN Y.MED_DEPT = 'OGO2'            THEN 'OG'
                                                                    WHEN Y.MED_DEPT = 'RCIMR'           THEN 'IMR'
                                                                    WHEN Y.MED_DEPT = 'RCNP'            THEN 'NP'
                                                                    WHEN Y.MED_DEPT = 'RCTS'            THEN 'TS'
                                                                    WHEN Y.MED_DEPT = 'THDR'            THEN 'DR'
                                                                    WHEN Y.MED_DEPT = 'THGS'            THEN 'GS'
                                                                    WHEN Y.MED_DEPT = 'THIME'           THEN 'IME'
                                                                    WHEN Y.MED_DEPT = 'THNM'            THEN 'NM'
                                                                    WHEN Y.MED_DEPT = 'THOL'            THEN 'OL'
                                                                    WHEN Y.MED_DEPT = 'ONP'             THEN 'NP'
                                                                    ELSE Y.MED_DEPT
                                                                END                             MED_DEPT
                                                             ,  Y.JESPCRSV_CNT * -1             TCNT
                                                          FROM  APSTATMT2   Y
                                                         WHERE  Y.MED_DTE   BETWEEN TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')
                                                                                AND CASE
                                                                                        WHEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE) - 1
                                                                                        THEN LAST_DAY(TO_DATE(:IN_FROMYYMM ||'01','YYYYMMDD')) - 1
                                                                                        ELSE TRUNC(SYSDATE) - 2
                                                                                    END
                                                           AND  Y.DTL_TYP   =   'M01'
                                                           AND  Y.PATSITE   =   'I'
                                                           AND  Y.WK_KEY    =   '1'

/* 0-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                       )   Y
                                             WHERE  CASE
                                                        WHEN :IN_IO_GUBUN = '1' THEN '1'
                                                        WHEN :IN_IO_GUBUN = '2' THEN '2'
                                                        ELSE '3'
                                                    END         =   CASE
                                                                        WHEN :IN_IO_GUBUN = '1' THEN '1'
                                                                        WHEN :IN_IO_GUBUN = '2' THEN 'X'
                                                                        ELSE '3'
                                                                    END

                                             GROUP  BY
                                                    TO_CHAR(Y.MED_DTE, 'DD')
                                                 ,  Y.MED_DEPT



/* 1-2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                               )
                                 PIVOT  (
                                            SUM(TCNT) FOR DAY_CLS
                                                   IN  ( '01' AS "D01",'02' AS "D02",'03' AS "D03",'04' AS "D04",'05' AS "D05"
                                                        ,'06' AS "D06",'07' AS "D07",'08' AS "D08",'09' AS "D09",'10' AS "D10"
                                                        ,'11' AS "D11",'12' AS "D12",'13' AS "D13",'14' AS "D14",'15' AS "D15"
                                                        ,'16' AS "D16",'17' AS "D17",'18' AS "D18",'19' AS "D19",'20' AS "D20"
                                                        ,'21' AS "D21",'22' AS "D22",'23' AS "D23",'24' AS "D24",'25' AS "D25"
                                                        ,'26' AS "D26",'27' AS "D27",'28' AS "D28",'29' AS "D29",'30' AS "D30"
                                                        ,'31' AS "D31",'32' AS "P01"
                                                       )
                                        )
/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )   A


/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                      )   A
         GROUP  BY
                ROLLUP((A.MED_DEPT))
         ORDER  BY
                A.MED_DEPT

/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
