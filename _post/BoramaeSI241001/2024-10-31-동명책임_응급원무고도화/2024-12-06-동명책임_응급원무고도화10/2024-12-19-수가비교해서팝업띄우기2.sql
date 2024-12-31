

SELECT PT_NO FROM ACPPRGCD
WHERE ROWNUM < 10
ORDER BY PT_NO DESC




;
select apy_end_Dt,a.*
  from ACPPRGCD a
 where 1=1
--   and pt_no = '01501498'
   and apy_end_dt >  '2024-12-18'
   and apy_str_dt >  '2024-12-18'
 order by 1


;

select 1
      ,a.*
  from cccccste a
where 1=1
--  and comn_cd_nm like '%응급의료관리료%'
  and comn_grp_cd = '350'
--  and comn_cd = '010'
--  and  comn_cd_nm like '%수가%'
--   or  comn_cd like 'A6050'

  ;

select 1
       ,a.*
  from CCCCCLTC a
where 1=1
  and comn_grp_cd = '350' -- 수가 통계 분류코드
--  and COMN_GRP_CD = 'A6050'
;


select 1
       ,a.MIFI_TP_CD
       ,a.*
  from ACPPEIOE a
where rownum < 100
;


select 1
       ,a.pt_no
       ,a.lsh_dtm
       ,a.MIF_CD
       ,a.MIF_STTS_CTG_CD
       ,a.MIF_ACCM_CTG_CD
       ,a.MIF_LCLS_CD
       ,a.MIF_MCLS_CD
       ,a.MIFRS_CTG_CD
       ,a.MIFI_TP_CD
       ,a.MIF_TP_CD
       ,a.MIF_APY_TP_CD

       ,a.*
  from ACPPEOCE a   /* 외래계산상세 테이블 */
where 1=1
  and MIF_CD in ( 'A6050')  -- 수가코드 A6050(ASIS) = 응급의료관리료 산정 진료과
  and MIF_STTS_CTG_CD = '010'  -- 그룹코드 : '350' / 코드 : '010' = 응급의료관리료
  and rownum < 1000
order by a.lsh_dtm desc

       ;



 /* 응급진료비수납 화면에 띄우기 */
 select
       A.CHOT_DTM
--     , a.MED_RSV_DTE
       , A.EMRG_MED_ZN_YN   AS "진료구역관찰료"
     , a.*
 from ACPPRETM a     -- 응급접수기본 테이블
where 1=1
 and CHOT_DTM >= '2024-12-18'
-- and pt_no = '01741540'

ORDER BY A.CHOT_DTM DESC

;

select 1
       ,a.*
  from ACPPRORE a
 where 1=1
   and rownum < 10
--   and apy_str_dt > '2024-12-18'
   and pt_no = '00500944'


;

-- 응급진료비 조회할 때, 나오는 화면 정보
select *
 from ACPPRORE  /* 응급 */
 where 1=1
   and pt_no = '00500944'
--   and fsr_dtm > '2024-12-18'
 order by fsr_dtm desc
  ;

select 1
      ,a.EMRM_ARVL_DTM
      ,a.*
  from ACPPRETM a
 where rownum < 100
 order by a.EMRM_ARVL_DTM desc

;




select 1
--      ,a.MEF_RPY_CLS_CD
--      ,a.*
       ,a.*
  from ACPPRETM a
 where 1=1
--   and a.MIF_CD IS NULL
--order by a.APY_STR_DT
                ;
