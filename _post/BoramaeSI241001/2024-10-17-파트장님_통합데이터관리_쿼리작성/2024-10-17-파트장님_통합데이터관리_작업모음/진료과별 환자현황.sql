﻿GRANT EXECUTE ON XBIL.FC_GET_DEPT_NM TO XMED; 
/*#### 1번 진료과별 환자현황 시작 ##################----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*----1_4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT /*+ pkg_mis_pts_pts_pts02.pc_sel_pts02_income020 */
  -------------------------------------------------------------------
--              CASE WHEN RANK = 1 THEN --AND GROUP_ING = '0'
--                        MED_DEPT_NM
--                   WHEN GROUP_ING = '1' THEN
--                        '합계'
--                   ELSE  NULL
--              END        MED_DEPT_NM
-------------------------------------------------------------------
              CASE WHEN RANK = 1 THEN --AND GROUP_ING = '0'
                   CASE WHEN GROUP_ING = 1 THEN
                        '합계'
                        ELSE MED_DEPT_NM
                   END
              END                      AS "진료과"

--             DECODE(GROUP_ING, '1', '합계'
--                             , MED_DEPT_NM)
             ,''                   AS  "진료의사ID"
             ,CNTALL   AS "총합"
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
         FROM   (

/*----1_3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


								     SELECT
                     NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)                       AS MED_DEPT_NM



                    ,''                                                                 AS MEDDR_ID
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
                    ,1 RANK
                FROM (



/*----1_2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
													SELECT
--                            CASE WHEN MED_DEPT = 'BCGS' THEN
--                                      'GS'
--                                 WHEN MED_DEPT IN ('HPC1','HPC11') THEN
--                                      'HPC'
--                                 ELSE
--                                      MED_DEPT
--                            END                                                          MED_DEPT
                            A.MED_DEPT                                                   MED_DEPT
                           ,''                                                           MEDDR_ID
                           ,SUM(A.O_CNT+A.I_CNT)                                         CNTALL
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '01'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT01
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '02'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT02
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '03'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT03
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '04'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT04
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '05'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT05
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '06'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT06
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '07'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT07
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '08'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT08
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '09'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT09
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '10'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT10
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '11'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT11
                           ,SUM(CASE WHEN TO_CHAR(A.MED_DTE,'MM') = '12'  THEN
                                          A.O_CNT+A.I_CNT
                                     ELSE  0 END)                                        CNT12
--                           ,GROUPING(CASE WHEN A.MED_DEPT = 'BCGS' THEN
--                                               'GS'
--                                          WHEN A.MED_DEPT IN ('HPC1','HPC11') THEN
--                                               'HPC'
--                                          ELSE
--                                               A.MED_DEPT
--                                     END)    GROUP_ING
                           ,GROUPING(A.MED_DEPT)    GROUP_ING
                       FROM (



/*----1_1번 시작 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
   													 SELECT
                                    MED_DTE              AS MED_DTE
                                   ,MED_DEPT             AS MED_DEPT
                                   ,MEDDR_ID             AS MEDDR_ID
                                   ,case :in_selyn            -- '1' 선택 ,'2' 비선택 ,else 전체
                                         when '1' then
                                              CHSPCRSV_CNT+JESPCRSV_CNT+SHRSV_CNT
                                         when '2' then
                                              CHUNSPCRSV_CNT+JEUNSPCRSV_CNT+SHUNSPCRSV_CNT
                                         else
                                              RSV_CNT+TODAY_CNT
                                    end                    AS  o_cnt


                                   ,0                      AS  i_cnt
                              from APSTATMT2

                             where /* 진료일자 범위 */
															 MED_DTE BETWEEN TRUNC(TO_DATE(:IN_YYYY                    ||'0101','YYYYMMDD'))
															             AND (CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY                   ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1
															                       THEN LAST_DAY(TO_DATE(:IN_YYYY                   ||'1201','YYYYMMDD'))
                                                     ELSE TRUNC(SYSDATE)-1
                                                 END)
                               and DTL_TYP = '06'
                               and PATSITE in ('O','E')
                               AND CASE WHEN :IN_LOOK = '1' THEN 'X'
                                        WHEN :IN_LOOK = '2' THEN '2'
                                        ELSE :IN_LOOK
                                   END  =  :IN_LOOK


														 UNION ALL
														 SELECT
                                   MED_DTE             AS MED_DTE
                                  ,MED_DEPT            AS MED_DEPT
                                  ,MEDDR_ID            AS MEDDR_ID
                                  ,0                   AS o_cnt


                                  ,case :in_selyn               -- '1' 선택 ,'2' 비선택 ,else 전체
                                        when '1' then
                                             JESPCRCP_CNT
                                        when '2' then
                                             JEUNSPCRCP_CNT
                                        else
                                             JESPCRSV_CNT
                                   end                AS  i_cnt
                              from APSTATMT2
                             where

                               /* 진료일자 IN (각 달의 마지막 날) */
															 MED_DTE IN (
															             SELECT DISTINCT
                                                  CASE WHEN LAST_DAY(TO_DATE(:IN_YYYY                   ||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1
                                                       THEN LAST_DAY(TO_DATE(:IN_YYYY                   ||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                       ELSE TRUNC(SYSDATE) -1
                                                  END
                                             FROM DICT
                                            WHERE ROWNUM <= 12
															 						)
                               AND DTL_TYP = 'M01'
                               AND PATSITE = 'I'
                               AND WK_KEY  = '1'
--                               and WD_NO not in ('ER99','OR99','OGOB','NB')


                               -- 2024-10-25 in_look = 2 일때 만 쿼리 실행
                               AND CASE WHEN :IN_LOOK = '1' THEN 'X'
                                        WHEN :IN_LOOK = '2' THEN '2'
                                        ELSE :IN_LOOK
                                   END  =  :IN_LOOK

/*----1_1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


										) a
                      GROUP BY
--                               ROLLUP(
--                                       CASE WHEN A.MED_DEPT = 'BCGS' THEN
--                                                 'GS'
--                                            WHEN A.MED_DEPT IN ('HPC1','HPC11') THEN
--                                                 'HPC'
--                                            ELSE
--                                                 A.MED_DEPT
--                                       END
--                                     )
                               ROLLUP(A.MED_DEPT)
                      HAVING  SUM(A.O_CNT+A.I_CNT) != 0

/*----1_2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                     )
/*----1_3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
               )
/*----11_4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*#### 1번 진료과별 환자현황 끝 ##################----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
