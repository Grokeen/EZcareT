

select  '[[:punct:]]', REGEXP_REPLACE(NVL ( ')(김용록)(' ,'' ), '[[:punct:]]')   from dual



;;
SELECT *
FROM FXQUERYSTORE
WHERE QUERYID = 'HSF_QE_QUERYSTORE_Q'
;;;;




<sql id="HIS.PA.AC.PE.SC.SelectDoctorPlusWork">
<!--
    Clss :  text
    Desc : 휴진대진일정등록 화면(보충진료등록 조회)
    Author : 김용록
    Create date : 2024-09-25
    Update date : 2024-09-25
    as-is : pkg_bil_schdr.pc_ap_apaddcht_select
-->


;;;;



EXEC :IN_DR_STF_NO := '01004';
EXEC :IN_FROM_DT := '20241001';
EXEC :IN_TO_DT := '20241112';
EXEC :IN_DR_STF_NO := '';
EXEC :IN_CHECK_SPLMMEDTM := 'y';

SELECT /*+ HIS.PA.AC.PE.SC.SelectDoctorPlusWork */
    DR_SID		                                   AS DR_SID                     /* 1.구분 */
   ,MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']'
                                                 AS DEPT_NM                    /* 2.진료과 */

   ,DR_STF_NO||'['||FT_STF_INF(DR_STF_NO,'STF_NM')||']'
                                                 AS STF_NM                     /* 3.진료의사 */

   ,TO_CHAR(APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') AS APY_STR_DTM                /* 4.보충진료시작일시 */
   ,TO_CHAR(APY_STR_DTM,'YYYYMMDDHH24MI')        AS OLD_APY_STR_DTM            /* 4-0.보충진료시작일시(update) */
   ,TO_CHAR(APY_END_DTM,'YYYY-MM-DD AM HH12:MI') AS APY_END_DTM                /* 5.보충진료종료일시 */
   ,TO_CHAR(APY_END_DTM,'YYYYMMDDHH24MI')        AS OLD_APY_END_DTM            /* 5-0.보충진료종료일시(update) */

   ,SPLM_MED_TM                                  AS SPLM_MED_TM                /* 6.보충분(테이블) */
   ,CASE WHEN SUBSTR(TO_CHAR(TRUNC((APY_END_DTM- APY_STR_DTM)*24*60)),-1,1) = '9'
              THEN TO_CHAR(ROUND(TRUNC((APY_END_DTM- APY_STR_DTM)*24*60),-1))
              ELSE TO_CHAR(TRUNC((APY_END_DTM- APY_STR_DTM)*24*60))
    END                                          AS SPLM_MED_TM2               /* 6-0.보충분(end-str) */


   ,CASE WHEN FLOOR(TO_NUMBER(SPLM_MED_TM)/60)<10
              THEN '0'||TO_CHAR(FLOOR(TO_NUMBER(SPLM_MED_TM)/60))
         WHEN FLOOR(TO_NUMBER(SPLM_MED_TM)/60)>10
              THEN TO_CHAR(FLOOR(TO_NUMBER(SPLM_MED_TM)/60))
         ELSE '00'
    END
    ||':'||
    CASE WHEN (TO_NUMBER(SPLM_MED_TM)-FLOOR(TO_NUMBER(SPLM_MED_TM)/60)*60)> 0
              THEN TO_CHAR(TO_NUMBER(SPLM_MED_TM)-FLOOR(TO_NUMBER(SPLM_MED_TM)/60)*60)
              ELSE '00'
    END                                          AS SPLM_MED_HH                 /* 6-1.보충시간(테이블) */


   ,CASE WHEN FLOOR((APY_END_DTM- APY_STR_DTM)*24) < 10 THEN '0'||TO_CHAR(FLOOR((APY_END_DTM- APY_STR_DTM)*24))
         WHEN FLOOR((APY_END_DTM- APY_STR_DTM)*24) > 10 THEN TO_CHAR(FLOOR((APY_END_DTM- APY_STR_DTM)*24))
         ELSE '00'
    END
    ||':'||
    CASE WHEN ((APY_END_DTM- APY_STR_DTM)*24*60) - (FLOOR((APY_END_DTM- APY_STR_DTM)*24)*60) > 0
             THEN TO_CHAR((CASE WHEN SUBSTR(TO_CHAR(TRUNC((APY_END_DTM- APY_STR_DTM)*24*60)),-1,1) = '9'
                                     THEN ROUND(TRUNC((APY_END_DTM- APY_STR_DTM)*24*60),-1)
                                     ELSE TRUNC((APY_END_DTM- APY_STR_DTM)*24*60)
                           END ) - (FLOOR((APY_END_DTM- APY_STR_DTM)*24)*60))
             ELSE '00'
     END                                          AS SPLM_MED_HH2               /* 6-2.보충시간(end-str) */


   ,SUP_MEMO                                      AS SUP_MEMO                   /* 7.기타 */
   ,TO_CHAR(FSR_DTM,'YYYY-MM-DD AM HH12:MI')      AS FSR_DTM                    /* 8.최초등록일시 */
   ,DR_STF_NO||'['||FT_STF_INF(FSR_STF_NO,'STF_NM')||']'
                                                  AS FSR_STF_NO                 /* 9.최초등록자 */

   ,TO_CHAR(LSH_DTM,'YYYY-MM-DD AM HH12:MI')      AS LSH_DTM                    /* 10.수정일자 */
   ,DR_STF_NO||'['||FT_STF_INF(LSH_STF_NO,'STF_NM')||']'
                                                  AS LSH_STF_NO                 /* 11.수정자 */

   ,TO_CHAR(SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))
                                                  AS SUM_SPLM_MED_TM            /* 12.남은휴진분 */
   ,CASE WHEN FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)<10
              THEN '0'||TO_CHAR(FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60))
         WHEN FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)>10
              THEN TO_CHAR(FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60))
         ELSE '00'
    END
    ||':'||
    CASE WHEN ((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))-FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)*60)> 0
              THEN TO_CHAR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))-FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)*60)
         ELSE '00'
    END                                          AS SUM_SPLM_MED_TM2             /* 12-0.남은휴진시간 */
   ,NVL2(CNCL_DT,'Y','N')                        AS CNCL_DT                      /* 13.취소날짜 */
   ,CASE WHEN TM_UNIT_CD = 'AM' THEN '오전'
         WHEN TM_UNIT_CD = 'PM' THEN '오후'
         ELSE '종일'
    END                                          AS TM_UNIT_CD                   /* 14.오전오후구분 */
   --,:IN_CHECK_ALL || :IN_CHECK_SPLMMEDTM         AS EQSTESTCULMN                 /* EQS에서 테스트하기 위한 컬럼 */

FROM ACDPCSPD        /* 의사보충일정정보 테이블 */
WHERE DR_STF_NO = :IN_DR_STF_NO
--    <IsNotEmpty Property="IN_CHECK_ALL">
--        <IsNotNull Property="IN_CHECK_ALL" >
           AND CNCL_DT IS NULL
--        </IsNotNull>
--    </IsNotEmpty>
    AND (NVL2(:IN_CHECK_SPLMMEDTM, NULL, SPLM_MED_TM) IS NULL)

    /* 2024-11-12 김용록 : 김현주 팀장님 요청사항 수정(기간 조회 조건 추가 / 화면 보기 어려움 등) */
    AND (APY_STR_DTM BETWEEN TO_DATE(:IN_FROM_DT ,'YYYYMMDD')
                         AND TO_DATE(:IN_TO_DT ,'YYYYMMDD') + .99999)



ORDER BY 4 DESC


;;;
</sql>
