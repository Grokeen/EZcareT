
;

SELECT 'Y'
                         FROM ACPPEOCE AA /* 외래계산상세 테이블 */
                        WHERE 1=1
                          AND ROWNUM = 1
--                          AND AA.RPY_PACT_ID = A.RPY_PACT_ID
--                          AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                          AND AA.MIF_CD = 'A6050'     -- ASIS는 응급의료관료와 진료구역관찰료가 둘 다 체크인 것 중 A6050을 찾아 Y/N이 같이 있는지 YY 인지 따져 팝업
                                                      --        - ASIS 화면     : BIL/ACC/CALS/OCALS/CREATEERDIPPAY.ASPX
                                                      --        - ASIS 프로시저 : pkg_bil_eprsv.pc_check_A6050
                          AND MIF_STTS_CTG_CD = '010' -- 010 : 응급의료관리료

                          --AND DECODE( NVL(X.EMRG_MED_ZN_YN, 'N'), 'Y', 'Y','N')  -- 진료구역관찰료(위에 있어서 제거)
                          ;




select 1
      ,a.MIF_CD
      ,a.MIF_STTS_CTG_CD
      ,a.*
  from ACPPEOCE a
 where 1=1
   and pt_no = '01741540'


 ;


 /* 응급진료비수납 화면에 띄우기 */
 select
       A.CHOT_DTM
--     , a.MED_RSV_DTE
       , A.EMRG_MED_ZN_YN   AS "진료구역관찰료"
     , a.*
 from ACPPRETM a     -- 응급접수기본 테이블
where 1=1
 and CHOT_DTM >= '2024-12-12'
 and pt_no = '01741540'

ORDER BY A.CHOT_DTM DESC

;
SELECT 1
      ,MIF_CD        AS "수가코드"
      ,MIF_STTS_CTG_CD    AS "010:응급의료관리료"
      ,AA.*
  FROM ACPPEOCE AA /* 외래계산상세 테이블 */
 WHERE 1=1
   AND AA.PT_NO = '01741540'
 ORDER BY APY_STR_DT DESC





;

HIS.PA.AC.PC.OP.EMERGENCYMEDCOSTRECEIVEPAYMENTMNG_01
;

 select
      a.*
      --,count(*) as cnt
 from ACPPEDPD a
where 1=1
 and pt_no = '01741540'



;
SELECT PT_RRN
      ,SUBSTR(PT_RRN,0,6) || '-' || SUBSTR(PT_RRN,7,1) ||'******'
FROM PCTPCPAM
WHERE PT_NO = '01741540'
