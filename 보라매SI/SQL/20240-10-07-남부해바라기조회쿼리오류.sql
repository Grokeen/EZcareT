


select * from ACPPROSD

order by lsh_dtm desc


;;

FRVS_CMED_YN      -- 초재진구분코드
RMDE_CMED_YN      -- 재진선택여부

-- 보조유형 선택 안하면 안들어가는게 맞나 확인
PSE_CLS_CD

-- 선택진료의사여부
CMED_DR_YN

-- 안 눈렀을 떄 N들어가게
EXM_CMED_YN
DGNS_CMED_YN


;;;


select * from ACPPRPTD
order by lsh_dtm desc


;;;


select * from ACDPCSPD where med_dept_cd = '01220';



SELECT
*
FROM ACPPEDPD
WHERE GRTY_AMT_INPT_TP_CD = '23'





;;;


exec :IN_NEW_MEDR_SID := '5F158';
exec :IN_NEW_MED_DT := ''   ;

select
CASE WHEN TRUNC(SYSDATE)>= TO_DATE('20170301', 'YYYYMMDD') THEN  (NVL(XCOM.FT_CNL_SELSTFINFO( '2', :IN_NEW_MEDR_SID, TO_CHAR(TO_DATE(:IN_NEW_MED_DT,'YYYYMMDD'),'YYYY-MM-DD'))
                                                                                                               , XCOM.FT_CNL_SELSTFINFO( '2', :IN_NEW_MEDR_SID, TO_CHAR(SYSDATE,'YYYY-MM-DD'))))
                                                ELSE (NVL(NVL(XCOM.FT_CNL_SELSTFINFO( '2', :IN_NEW_MEDR_SID, '20170228')
                                                      , XCOM.FT_CNL_SELSTFINFO( '2', :IN_NEW_MEDR_SID, TO_CHAR(SYSDATE,'YYYY-MM-DD'))), XCOM.FT_CNL_SELSTFINFO( '2', :IN_NEW_MEDR_SID, '20170301')))
                                            END AS AA

from dual;
