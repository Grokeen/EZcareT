







/* M322-심사결과관리 */
   /* 테이블 코멘트 수정 */
      /* 요양급여비용(의료급여비용) 이의신청(재심사조정청구)서 접수(반송)증1 */ 
      COMMENT ON COLUMN HBIL.AIF2101T.CMPY_SCRG_DGR_NO     IS '정산심사차수코드';    -- 정산심사차수 -> 정산심사차수코드
      COMMENT ON COLUMN HBIL.AIF2101T.PRTL_ACPT_NO         IS '포탈접수번호';      -- 포털접수번호 -> 포탈접수번호
      COMMENT ON COLUMN HBIL.AIF2101T.VERSION              IS '버전구분';        -- VERSION구분 -> 버전구분

   /* 테이블 컬럼명 수정 */ 
      /* 요양급여비용(의료급여비용) 이의신청(재심사조정청구)서 접수(반송)증1 */    
      ALTER TABLE HBIL.AIF2101T RENAME COLUMN VERSION TO VER_TP;              -- VERSION구분 :   VERSION -> VER_TP
      ALTER TABLE HBIL.AIF2101T RENAME COLUMN IHVNO   TO FORM_NO;             -- 서식번호     :   IHVNO -> FORM_NO