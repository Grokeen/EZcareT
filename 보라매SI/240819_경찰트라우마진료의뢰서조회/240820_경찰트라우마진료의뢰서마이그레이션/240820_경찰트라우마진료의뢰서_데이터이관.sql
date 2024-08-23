

/* 개인키가 누락되어 인덱스 삭제 및 인덱스 재등록,개인키 선언 쿼리입니다. */
DROP INDEX HBIL.ACPPRPOT_PK;

CREATE UNIQUE INDEX HBIL.ACPPRPOT_PK 
   ON HBIL.ACPPRPOT(
      HSP_TP_CD,  --병원구분코드
      PT_NO,      --환자번호
      REG_DT,     --등록일자
      REG_SEQ     --등록순번
      ) 
   TABLESPACE TSBIL_I01;

ALTER TABLE HBIL.ACPPRPOT 
   ADD (
      CONSTRAINT ACPPRPOT_PK
      PRIMARY KEY(
         HSP_TP_CD,  --병원구분코드
         PT_NO,      --환자번호
         REG_DT,     --등록일자
         REG_SEQ     --등록순번
         )
   USING INDEX HBIL.ACPPRPOT_PK
   ENABLE VALIDATE
   );


/* 컬럼 NOT NULL 변경 쿼리입니다.  */
ALTER TABLE HBIL.ACPPRPOT
   MODIFY (FRVS_CMED_YN    VARCHAR2(1) NOT NULL                --초진선택여부
          ,RMDE_CMED_YN    VARCHAR2(1) NOT NULL                --재진선택여부
          ,EXM_CMED_YN     VARCHAR2(1) NOT NULL                --검사선택여부
          ,DGNS_CMED_YN    VARCHAR2(1) NOT NULL                --진단선택여부
   );



/* 데이터 이관 시, 매핑 쿼리입니다. */
SELECT
    '7'                                                        AS HSP_TP_CD       -- '병원구분코드'
   ,APPOLTRT.PT_NO                                             AS PT_NO           -- '환자번호'
   ,APPOLTRT.REQ_DTE                                           AS REG_DT          -- '등록일자'
   ,APPOLTRT.REQ_SEQ                                           AS REG_SEQ         -- '등록순번'
   ,NULL                                                       AS RFFM_TP_CD      -- '의뢰서구분코드'
   ,PETRA.pls_encrypt_b64_id(  APPOLTRT.SSN1  || substr(APPOLTRT.SSN2,1,1) || SCP.DEC_STR('CRT1',SUBSTR( APPOLTRT.SSN2 ,2,40))  ,800)
                                                               AS PT_RRN          -- '환자주민등록번호'
   ,APPOLTRT.ZIP_NO                                            AS POST_NO         -- '우편번호'
   ,APPOLTRT.ZIP_SEQ                                           AS POST_NO_SEQ     -- '우편번호순번'
   ,NULL                                                       AS BSC_ADDR        -- '기본주소'
   ,APPOLTRT.ADDR                                              AS DTL_ADDR        -- '상세주소'
   ,APPOLTRT.TEL_NO                                            AS TEL_NO          -- '전화번호'
   ,APPOLTRT.TEL3_NO                                           AS MTEL_NO         -- '휴대폰번호'
   ,APPOLTRT.PATSITE                                           AS PACT_TP_CD      -- '원무접수구분코드(입원외래구분)'
   ,APPOLTRT.MED_DEPT                                          AS MED_DEPT_CD     -- '진료과코드'
   ,APPOLTRT.MEDDR_ID                                          AS MEDR_STF_NO     -- '진료의직원번호'
   ,APPOLTRT.MED_DTE                                           AS MED_DTM         -- '진료일시'
   ,APPOLTRT.PATTYPE                                           AS PME_CLS_CD      -- '환자급종유형코드'
   ,APPOLTRT.TYPE_CD                                           AS PSE_CLS_CD      -- '환자보조유형코드'
   ,APPOLTRT.MED_TYPE                                          AS FRVS_RMDE_TP_CD -- '초진재진구분코드'
   ,APPOLTRT.SPC_DR_YN                                         AS CMED_DR_YN      -- '선택진료의사여부'
   ,APPOLTRT.PRT_GUBN                                          AS PRNT_RMK_CNTE   -- '출력비고내용'
   ,APPOLTRT.RMK                                               AS RMK_CNTE        -- '비고내용'
   ,APPOLTRT.PRT_CHO_YN                                        AS FRVS_CMED_YN    -- '초진선택여부'
   ,APPOLTRT.PRT_JAE_YN                                        AS RMDE_CMED_YN    -- '재진선택여부'
   ,APPOLTRT.PRT_GUM_YN                                        AS EXM_CMED_YN     -- '검사선택여부'
   ,APPOLTRT.PRT_JIN_YN                                        AS DGNS_CMED_YN    -- '진단선택여부'
   ,APPOLTRT.CNCL_DTE                                          AS CNCL_DT         -- '취소일자'
   ,APPOLTRT.CNCL_ID                                           AS CNCL_STF_NO     -- '취소직원번호'
   ,APPOLTRT.BUILDING_NO                                       AS BLDG_MGMT_NO    -- '건물관리번호'
   ,APPOLTRT.EDIT_ID                                           AS FSR_STF_NO	    -- '최초등록직원번호'
   ,APPOLTRT.EDIT_DTM                                          AS FSR_DTM	        -- '최초등록일시'
   ,NULL                                                       AS FSR_PRGM_NM     -- '최초등록프로그램명'
   ,NULL                                                       AS FSR_IP_ADDR     -- '최초등록IP주소'
   ,APPOLTRT.EDIT_ID                                           AS LSH_STF_NO	    -- '최종변경직원번호'
   ,APPOLTRT.EDIT_DTM                                          AS LSH_DTM	        -- '최종변경일시'
   ,NULL                                                       AS LSH_PRGM_NM     -- '최종변경프로그램명'
   ,NULL                                                       AS LSH_IP_ADDR     -- '최종변경IP주소'

FROM ASIS_HBIL.APPOLTRT;                  /* '경찰트라우마진료의뢰서' APPOLTRT(ASIS) , ACPPRPOT(TOBE) */


/* 
- 환자주민번호 : PETRA.pls_encrypt_b64_id(  APPATBAT.SSN1  || substr(APPATBAT.SSN2,1,1) ||   SCP.DEC_STR('CRT1',SUBSTR( APPATBAT.SSN2 ,2,40))  ,800) 

    - ASIS 복호화 : SSN1||DAMO.DEC_VARCHAR_PE('HBIL','APPATBAT','SSN2',SSN2)
    - TOBE 암호화 : PLS_ENCRYPT_B64_ID(PT_RRN,800)
*/
