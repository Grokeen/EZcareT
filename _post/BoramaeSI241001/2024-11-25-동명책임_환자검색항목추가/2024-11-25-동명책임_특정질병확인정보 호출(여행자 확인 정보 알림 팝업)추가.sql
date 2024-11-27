select a.OTPT_RSV_TP_CD,a.* from ACPPRODM   a
where rownum < 1000
and a.med_dt < sysdate
order by med_dt desc;


select a.PACT_TP_CD
     , a.*
from AHMIPBAM a
where rownum < 100;


select a.pt_no, a.PACT_TP_CD ,a.*
from ACPPRPTD a
where a.REG_DT < sysdate
and rownum < 10
order by  a.REG_DT desc;

select a.OTPT_RSV_TP_CD,a.* from ACPPRODM   a
where rownum < 1000
and pt_no = '01547248'
and a.med_dt < sysdate
order by med_dt desc;



select * from MOODSPOP
where rownum < 10;




exec  :PT_NO := '';
exec  :stf_no := '01815';
exec  :pact_tp_cd := 'O';
exec  :pact_id := '';
SELECT  /* 진료-주민번호와라이센스번호조회-HIS.MC.Core.SelectRrnAndLcnsNo*/
--        (
--          SELECT  PLS_DECRYPT_B64_ID(A.PT_RRN, '800')                                          AS PT_RRN
--            FROM  PCTPCPAM  A
--            WHERE  A.PT_NO   = :PT_NO
--        )           AS PT_RRN         -- 환자의 주민번호
     -- ,
--      (
--          SELECT  NVL(MAX(TRIM(B.QF_LCNS_PMSS_NO)), '      ')       AS LCNS_NO    -- 없으면 공백6자리로 한다.
--            FROM  RPPSDSNE  B   -- [자격면허사항상세]
--           WHERE  B.STF_NO         = :STF_NO
--             AND
--             B.QF_LCNS_TP_CD  IN ('122', '128') -- 치과의사(122), 의사(128)
--             AND  ROWNUM <= 1
--        )           AS LCNS_NO         -- 라이센스번호
    --  , :PT_NO      AS PT_NO
    --  , :STF_NO     AS STF_NO
     -- ,
      ( SELECT  NVL(MAX('Y'), DECODE(:ACTIVE_YN, 'N', 'Y', 'N'))  AS TO_DAY_POPUP_YN
            FROM  MOODSPOP   C    -- [질병관리본부 알림 팝업 정보]
           WHERE -- C.STF_NO          = :STF_NO
             --AND  C.PT_NO           = :PT_NO
             --AND
              C.DUR_MGMT_TP_CD  = '1'
             AND  C.REG_DT          = TRUNC(SYSDATE)

        )           AS TO_DAY_POPUP_YN    -- 오늘하루 팝업 안함 여부 (Y:팝업안함, N:팝업) - 엑티브 환자만 팝업함
      , ( SELECT  NVL(MAX('Y'), DECODE(:ACTIVE_YN, 'N', 'Y', 'N'))  AS PACT_ID_POPUP_YN
            FROM  MOODSPOP   C    -- [질병관리본부 알림 팝업 정보]
           WHERE  --C.STF_NO          = :STF_NO
            -- AND  C.PT_NO           = :PT_NO
             --AND
             C.DUR_MGMT_TP_CD  = '2'
--             AND  ('I'               = :PACT_TP_CD
--                    OR 'E'               = :PACT_TP_CD)
--             AND  C.PACT_ID         = :PACT_ID

        )           AS PACT_ID_POPUP_YN   -- 선택수진 팝업 안함 여부 (Y:팝업안함, N:팝업) - 병동환자만 대상 - 엑티브 환자만 팝업함
  FROM DUAL          ;







 select * from
(
  select
        ( SELECT  NVL(MAX('Y'), DECODE('Y', 'N', 'Y', 'N'))  AS PACT_ID_POPUP_YN
            FROM  MOODSPOP   C    -- [질병관리본부 알림 팝업 정보]
           WHERE  C.STF_NO          = m.STF_NO
             AND  C.PT_NO           = m.PT_NO
             and  C.DUR_MGMT_TP_CD  = '2'
             AND  C.PACT_ID         = m.PACT_ID)    as      PACT_ID_POPUP_YN

        ,   (SELECT  NVL(MAX('Y'), DECODE('Y', 'N', 'Y', 'N'))  AS TO_DAY_POPUP_YN
            FROM  MOODSPOP   C    -- [질병관리본부 알림 팝업 정보]
           WHERE  C.STF_NO          = m.STF_NO
             AND  C.PT_NO           = m.PT_NO
             AND  C.DUR_MGMT_TP_CD  = '1'
             AND  C.REG_DT          = TRUNC(SYSDATE))           as  TO_DAY_POPUP_YN

        ,(SELECT  NVL(MAX(TRIM(B.QF_LCNS_PMSS_NO)), '      ')       AS LCNS_NO    -- 없으면 공백6자리로 한다.
            FROM  RPPSDSNE  B   -- [자격면허사항상세]
           WHERE  B.STF_NO         = m.STF_NO
             AND  B.QF_LCNS_TP_CD  IN ('122', '128') -- 치과의사(122), 의사(128)
             AND  ROWNUM <= 1) as "라이센스"
         , m.*

  from MOODSPOP       m
   -- AND  m.REG_DT          = TRUNC(SYSDATE)
   )   where pt_no = '04890484' ;



select a.aplc_icd10_cd_cnte
      ,a.mdrc_id  -- 55262939
      ,a.*
  from acpprghd a /* 중증산정특례신청서정보 테이블 */
where pt_no ='01914467';

select a.sril_cdoc_aplc_tp_cd
      ,a.pcor_icd10_cd_cnte
      ,a.apy_str_dt
      ,a.apy_end_dt
      ,a.mdrc_id   -- 55262939
      ,a.*
from acpprgcd a     /* 중증진료확인증정보 테이블 */
where pt_no ='01914467';






select * from cccccltc
where
comn_grp_cd_nm like '%상병%';
--comn_grp_cd = 'BIL027';
select * from cccccste
where 1=1
  AND comn_grp_cd = 'SMR00065'
--  AND COMN_CD_NM = 'BIL027'
  ;
