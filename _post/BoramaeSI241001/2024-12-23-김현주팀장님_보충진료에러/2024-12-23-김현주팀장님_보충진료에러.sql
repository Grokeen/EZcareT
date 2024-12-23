  SELECT /*+ HIS.PA.AC.PE.SC.SelectDoctorPlusWork */
            DISTINCT

            -- 2024-12-06 김용록 : 김현주 팀장님 잘 안 보이신다는 요청사항, (*****[조*연] -> 조*연) 만 나오게 변경
            FT_STF_INF(SUB.DR_STF_NO,'STF_NM') AS STF_NM2
           ,NVL2(SUB.MED_DEPT_CD,SUB.MED_DEPT_CD||'['||FC_GET_DEPT_NM(SUB.MED_DEPT_CD)||']','')
                                                             AS DEPT_NM                     /* 2.진료과 */
           ,ACYR.*

           ,SUB.SUP_MEMO                                       AS SUP_MEMO                   /* 7.기타 */
           ,TO_CHAR(SUB.FSR_DTM,'YYYY-MM-DD AM HH12:MI')       AS FSR_DTM                    /* 8.최초등록일시 */

           -- 2024-12-06 김용록 : 김현주 팀장님 잘 안 보이신다는 요청사항, (*****[조*연] -> 조*연) 만 나오게 변경
           ,FT_STF_INF(SUB.LSH_STF_NO,'STF_NM')               AS FSR_STF_NO                 /* 9.최초등록자 */
           ,TO_CHAR(SUB.LSH_DTM,'YYYY-MM-DD AM HH12:MI')      AS LSH_DTM                    /* 10.수정일자 */

           -- 2024-12-06 김용록 : 김현주 팀장님 잘 안 보이신다는 요청사항, (*****[조*연] -> 조*연) 만 나오게 변경
           ,FT_STF_INF(SUB.LSH_STF_NO,'STF_NM')                AS LSH_STF_NO                 /* 11.수정자 */
           , CASE WHEN SUB.TM_UNIT_CD = 'AM' THEN '오전'
                         WHEN SUB.TM_UNIT_CD = 'PM' THEN '오후'
                         ELSE '종일'
              END                                             AS TM_UNIT_CD                   /* 14.오전오후구분 */

           ,NVL2(SUB.CNCL_DT,'Y','N')                         AS CNCL_DT                      /* 13.취소날짜 */
           ,TO_CHAR(SUB.APY_STR_DTM,'YYYYMMDDHH24MI')         AS OLD_APY_STR_DTM            /* 4-0.보충진료시작일시(update) */
           ,TO_CHAR(SUB.APY_END_DTM,'YYYYMMDDHH24MI')         AS OLD_APY_END_DTM            /* 5-0.보충진료종료일시(update) */
--          --XMED.PC_AP_HDLYTMTIME_CALC.PC_AP_CLOSEDTIME_CALC으로 변경                                  AS SUM_SPLM_MED_TM            /* 12.남은휴진분 */

       FROM
           ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
           ,
           (
            SELECT
--                CASE GROUPING(DR_STF_NO) || GROUPING (DR_SID) || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
--                       WHEN  '0011' THEN null
--                       WHEN  '0000' THEN DR_SID
--                 END		                                 AS DR_SID                     /* 1.구분 */

                CASE GROUPING(DR_STF_NO)  || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
                       WHEN  '011' THEN DR_STF_NO
                       WHEN  '000' THEN DR_STF_NO
                END                                       AS STF_NM                     /* 3.진료의사 */

                ,CASE GROUPING(DR_STF_NO)  || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
                       WHEN  '011' THEN NULL
                       WHEN  '000' THEN  TO_CHAR(APY_STR_DTM,'YYYY-MM-DD AM HH12:MI')
                  END                                     AS APY_STR_DTM                  /* 4.보충진료시작일시 */

                ,CASE GROUPING(DR_STF_NO) || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
                       WHEN  '011' THEN '합계'
                       WHEN  '000' THEN TO_CHAR(APY_END_DTM,'YYYY-MM-DD AM HH12:MI')
                  END                                    AS APY_END_DTM                 /* 5.보충진료종료일시 */


                ,   CASE GROUPING(DR_STF_NO) ||  GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
                       WHEN  '011' THEN TO_CHAR(SUM(SPLM_MED_TM))
                       WHEN  '000' THEN TO_CHAR(SUM(SPLM_MED_TM))
                    END                                  AS SPLM_MED_TM              /* 6.총보충시간 */


--                , CASE GROUPING(DR_STF_NO) || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
--                       WHEN  '011' THEN GROUPING(DR_STF_NO) || GROUPING (DR_STF_NO) || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
--                       WHEN  '000' THEN GROUPING(DR_STF_NO) || GROUPING (DR_STF_NO) || GROUPING (APY_STR_DTM) || GROUPING (APY_END_DTM)
--                    END                                 as groupingVal
             FROM ACDPCSPD        /* 의사보충일정정보 테이블 */
             WHERE 1=1


               /* 2024-11-12 김용록 : 김현주 팀장님 요청사항 수정(기간 조회 조건 추가 / 화면 보기 어려움 등) */
               AND (APY_STR_DTM BETWEEN TO_DATE(:IN_FROM_DT ,'YYYYMMDD')
                                    AND LAST_DAY(TO_DATE(:IN_TO_DT ,'YYYYMMDD')) + .99999 )
--               AND (NVL2(:IN_CHECK_SPLMMEDTM, NULL, SPLM_MED_TM) IS NULL)
--               AND (NVL2(:IN_CHECK_ALL,NULL,CNCL_DT) IS NULL)
            GROUP BY ROLLUP(  DR_STF_NO
--                             ,DR_SID
                             ,APY_STR_DTM
                             ,APY_END_DTM
                            )


             UNION
             -- NULL 및 중복 제거
             SELECT
--                 ''      AS DR_SID
                ''      AS STF_NM
                ,''      AS APY_STR_DTM
                ,''      AS APY_END_DTM
                ,''      AS DTM_SUM
--                ,''      as groupingVal
             FROM DUAL

            ) ACYR
        WHERE 1=1
          and  ACYR.STF_NM = SUB.DR_STF_NO(+)
          AND  ACYR.APY_STR_DTM = TO_CHAR(SUB.APY_STR_DTM(+),'YYYY-MM-DD AM HH12:MI')
          AND  ACYR.APY_END_DTM = TO_CHAR(SUB.APY_END_DTM(+),'YYYY-MM-DD AM HH12:MI')

--    <IsNotEmpty Property="IN_DR_STF_NO">
--        <IsNotNull Property="IN_DR_STF_NO" >
--          AND ACYR.STF_NM = :IN_DR_STF_NO
--        </IsNotNull>
--    </IsNotEmpty>
--          AND DECODE( :IN_DR_STF_NO, NULL, ACYR.APY_STR_DTM, 'Y') IS NOT NULL



        ORDER BY
              ACYR.STF_NM
            , ACYR.APY_STR_DTM ASC


;
exec :IN_FROM_DT := '20241001';
exec :IN_TO_DT := '20241030';
exec :IN_CHECK_SPLMMEDTM := '';
exec :IN_CHECK_ALL := '';
exec :IN_DR_STF_NO := '01004';





select PC_AP_HDLYTMTIME_CALC.PC_AP_CLOSEDTIME_CALC(
                                                 :IN_DR_STF_NO
                                                , 'C0ADM'
                                                , '196.168.0.1'
                                                , 'Golden'
                                                , null
                                                )
  from dual
   ;



                                IN_DOC_NO                 IN   VARCHAR2
                               , HIS_STF_NO                IN   VARCHAR2
                               , HIS_IP_ADDR               IN   VARCHAR2
                               , HIS_PRGM_NM               IN   VARCHAR2
                               ,  OUT_CURSOR            OUT  RETURNCURSOR
                                )

;

VAR IO_ERRYN  VARCHAR2(1);
VAR IO_ERRMSG  VARCHAR2(4000);
VAR O_CURSOR1 REFCURSOR;
EXEC XMED.PC_AP_HDLYTMTIME_CALC.PC_AP_CLOSEDTIME_CALC('01004',:O_CURSOR1);
;

SELECT NED_MED_TIME FROM  XMED.PC_AP_HDLYTMTIME_CALC.PC_AP_CLOSEDTIME_CALC('01004',:O_CURSOR1);

