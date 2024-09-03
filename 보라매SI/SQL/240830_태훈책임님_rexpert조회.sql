--중증신청서 작성환자 찾기
EXEC :IN_FROM_DATE := '20240801';
EXEC :IN_TO_DATE := '20240831';
EXEC :IN_SRIL_TP_CD := 'J3';
select *
from acpprghd
where aplc_dt between to_date(:IN_FROM_DATE, 'yyyy-mm-dd')
                  and to_date(:IN_TO_DATE, 'yyyy-mm-dd')
  and sril_cdoc_aplc_tp_cd = :IN_SRIL_TP_CD;

--중증확인증신청구분코드: acpprghd - SRIL_CDOC_APLC_TP_CD
----건강보험: HLTH_INS_MDC_TP_CD = BB / 의료급여: HLTH_INS_MDC_TP_CD = EE
--select *
--from cccccstv
--where comn_grp_cd = 'PA083';
