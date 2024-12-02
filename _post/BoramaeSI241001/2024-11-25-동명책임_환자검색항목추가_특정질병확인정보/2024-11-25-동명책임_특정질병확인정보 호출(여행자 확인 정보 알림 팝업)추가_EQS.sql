exec :PT_NO	:='00141200';
exec :STF_NO	:='01815';
exec :ACTIVE_YN	:='Y';
exec :PACT_TP_CD	:='I';
exec :PACT_ID	:='0000009315';



SELECT  /* 진료-주민번호와라이센스번호조회-HIS.MC.Core.SelectRrnAndLcnsNo*/
        (
          SELECT  PLS_DECRYPT_B64_ID(A.PT_RRN, '800')                                          AS PT_RRN
            FROM  PCTPCPAM  A
           WHERE  A.PT_NO   = :PT_NO
        )           AS PT_RRN         -- 환자의 주민번호
      , (
          SELECT  NVL(MAX(TRIM(B.QF_LCNS_PMSS_NO)), '      ')       AS LCNS_NO    -- 없으면 공백6자리로 한다.
            FROM  RPPSDSNE  B   -- [자격면허사항상세]
           WHERE  B.STF_NO         = :STF_NO
             AND  B.QF_LCNS_TP_CD  IN ('122', '128') -- 치과의사(122), 의사(128)
             AND  ROWNUM <= 1
        )           AS LCNS_NO         -- 라이센스번호
      , :PT_NO      AS PT_NO
      , :STF_NO     AS STF_NO
      , ( SELECT  NVL(MAX('Y'), DECODE(:ACTIVE_YN, 'N', 'Y', 'N'))  AS TO_DAY_POPUP_YN
            FROM  MOODSPOP   C    -- [질병관리본부 알림 팝업 정보]
           WHERE  C.STF_NO          = :STF_NO
             AND  C.PT_NO           = :PT_NO
             AND  C.DUR_MGMT_TP_CD  = '1'
             AND  C.REG_DT          = TRUNC(SYSDATE)

        )           AS TO_DAY_POPUP_YN    -- 오늘하루 팝업 안함 여부 (Y:팝업안함, N:팝업) - 엑티브 환자만 팝업함
      , ( SELECT  NVL(MAX('Y'), DECODE(:ACTIVE_YN, 'N', 'Y', 'N'))  AS PACT_ID_POPUP_YN
            FROM  MOODSPOP   C    -- [질병관리본부 알림 팝업 정보]
           WHERE  C.STF_NO          = :STF_NO
             AND  C.PT_NO           = :PT_NO
             AND  C.DUR_MGMT_TP_CD  = '2'
             AND  ('I'               = :PACT_TP_CD
                    OR 'E'               = :PACT_TP_CD)
             AND  C.PACT_ID         = :PACT_ID

        )           AS PACT_ID_POPUP_YN   -- 선택수진 팝업 안함 여부 (Y:팝업안함, N:팝업) - 병동환자만 대상 - 엑티브 환자만 팝업함
  FROM DUAL
