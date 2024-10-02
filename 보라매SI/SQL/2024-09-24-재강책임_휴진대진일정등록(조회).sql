

exec :IN_DR_STF_NO := '05292';  --운영  -- 05292     -- 01920
exec :IN_DR_STF_NO := '01815';  --스테이징
exec :IN_CHECK_ALL := 'all';

SELECT /*+ HIS.PA.AC.PE.SC.SelectDoctorPlusWork */
   DR_SID	  	                                   AS DR_SID                     /* 1.구분 */
   ,FC_GET_DEPT_NM(MED_DEPT_CD)                  AS DEPT_NM                    /* 2.진료과 */
   ,FT_STF_INF(DR_STF_NO,'STF_NM')               AS STF_NM                     /* 3.진료의사 */
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
              ELSE TO_CHAR(FLOOR(TO_NUMBER(SPLM_MED_TM)/60))
    END
    ||':'||
    CASE WHEN (TO_NUMBER(SPLM_MED_TM)-FLOOR(TO_NUMBER(SPLM_MED_TM)/60)*60)> 0
              THEN TO_CHAR(TO_NUMBER(SPLM_MED_TM)-FLOOR(TO_NUMBER(SPLM_MED_TM)/60)*60)
              ELSE '00'
    END                                          AS SPLM_MED_HH                 /* 6-1.보충시간(테이블) */
   ,CASE WHEN FLOOR((APY_END_DTM- APY_STR_DTM)*24) < 10 THEN '0'||TO_CHAR(FLOOR((APY_END_DTM- APY_STR_DTM)*24))
                                                        ELSE TO_CHAR(FLOOR((APY_END_DTM- APY_STR_DTM)*24))
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
   ,FSR_DTM                                       AS FSR_DTM                    /* 8.최초등록일시 */
   ,FSR_STF_NO                                    AS FSR_STF_NO                 /* 9.최초등록자 */
   ,LSH_DTM                                       AS LSH_DTM                    /* 10.수정일자 */
   ,LSH_STF_NO                                    AS LSH_STF_NO                 /* 11.수정자 */

   ,TO_CHAR(SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))
                                                  AS SUM_SPLM_MED_TM            /* 12.남은휴진분 */
   ,CASE WHEN FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)<10
              THEN '0'||TO_CHAR(FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60))
              ELSE TO_CHAR(FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60))
    END
    ||':'||
    CASE WHEN ((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))-FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)*60)> 0
              THEN TO_CHAR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))-FLOOR((SUM(TO_NUMBER(SPLM_MED_TM)) OVER (PARTITION BY :IN_DR_STF_NO))/60)*60)
              ELSE '00'
    END                                          AS SUM_SPLM_MED_TM2             /* 12-0.남은휴진시간 */
   ,CNCL_DT                                      AS CNCL_DT                      /* 13.취소날짜 */
FROM ACDPCSPD
WHERE (NVL2(:IN_CHECK_ALL,NULL,CNCL_DT) IS NULL)
  AND DR_STF_NO = :IN_DR_STF_NO
ORDER BY OLD_APY_STR_DTM DESC
  ;


--------------------------------------------------------------------------------------------------------------------------




select
*
FROM ACDPCSPD
where splm_med_tm is null
AND ROWNUM <10;

SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MI'), SYSDATE FROM DUAL;
select * from acdpcspd order by dr_sid desc;
select * from acdpcspd where  cncl_dt is not null;
select to_char(sysdate,'yyyy-mm-dd am hh:mi:ss') from dual;

-- asis 데이터 이상한 거 찾기 -----------------------------------------------------------
select
   dr_stf_no                                    as stf_no
   ,FT_STF_INF(dr_stf_no,'STF_NM')               as stf_nm
  ,apy_str_dtm
  ,apy_end_dtm
  ,case when substr(to_char(trunc((apy_end_dtm- apy_str_dtm)*24*60)),-1,1) = '9'
           then to_char(round(trunc((apy_end_dtm- apy_str_dtm)*24*60),-1))
           else to_char(trunc((apy_end_dtm- apy_str_dtm)*24*60))
      end     as bbb
  ,SPLM_MED_TM

from acdpcspd


;
select count(*)
from acdpcspd

;
select SUM(TO_NUMBER(SPLM_MED_TM)) as ss          /* 남은휴진시간 */
from acdpcspd where  DR_STF_NO = :IN_DR_STF_NO; ;
select * from acdpcspd where  DR_STF_NO = '01852'; ;
select * from PDESMSAM where stf_no = '01852';


;
where case when substr(to_char(trunc((apy_end_dtm- apy_str_dtm)*24*60)),-1,1) = '9'
           then to_char(round(trunc((apy_end_dtm- apy_str_dtm)*24*60),-1))
           else to_char(trunc((apy_end_dtm- apy_str_dtm)*24*60))
      end
      != SPLM_MED_TM
order by to_number(to_char(apy_str_dtm,'yyyymmdd')) desc
