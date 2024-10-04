/* 혹여나, 틀린 부분이 있을 시, 말씀해주시면 바로 수정하겠습니다. */


/* 테이블 생성 쿼리입니다. */
CREATE TABLE HBIL.ACPPRPOT(                    --경찰트라우마진료의뢰서 
   HSP_TP_CD       VARCHAR2(2)    NOT NULL     --병원구분코드
  ,PT_NO           VARCHAR2(8)    NOT NULL     --환자번호
  ,REG_DT          DATE           NOT NULL     --등록일자
  ,REG_SEQ         NUMBER         NOT NULL     --등록순번
  ,RFFM_TP_CD      VARCHAR2(2)                 --의뢰서구분코드
  ,PT_RRN          VARCHAR2(13)                --환자주민등록번호
  ,POST_NO         VARCHAR2(6)                 --우편번호
  ,POST_NO_SEQ     NUMBER                      --우편번호순번
  ,BSC_ADDR        VARCHAR2(120)               --기본주소
  ,DTL_ADDR        VARCHAR2(120)               --상세주소
  ,TEL_NO          VARCHAR2(20)                --전화번호
  ,MTEL_NO         VARCHAR2(20)                --휴대폰번호
  ,PACT_TP_CD      VARCHAR2(1)                 --원무접수구분코드(입원외래구분)
  ,MED_DEPT_CD     VARCHAR2(7)                 --진료과코드
  ,MEDR_STF_NO     VARCHAR2(5)                 --진료의직원번호
  ,MED_DTM         DATE                        --진료일시
  ,PME_CLS_CD      VARCHAR2(2)                 --환자급종유형코드
  ,PSE_CLS_CD      VARCHAR2(3)                 --환자보조유형코드
  ,FRVS_RMDE_TP_CD VARCHAR2(1)                 --초진재진구분코드
  ,CMED_DR_YN      VARCHAR2(1)                 --선택진료의사여부
  ,PRNT_RMK_CNTE   VARCHAR2(6)                 --출력비고내용
  ,RMK_CNTE        VARCHAR2(4000)              --비고내용
  ,FRVS_CMED_YN    VARCHAR2(1)                 --초진선택여부
  ,RMDE_CMED_YN    VARCHAR2(1)                 --재진선택여부
  ,EXM_CMED_YN     VARCHAR2(1)                 --검사선택여부
  ,DGNS_CMED_YN    VARCHAR2(1)                 --진단선택여부
  ,CNCL_DT         DATE                        --취소일자
  ,CNCL_STF_NO     VARCHAR2(5)                 --취소직원번호
  ,BLDG_MGMT_NO    VARCHAR2(50)                --건물관리번호
  ,FSR_STF_NO      VARCHAR2(5)    NOT NULL     --최초등록직원번호
  ,FSR_DTM         DATE           NOT NULL     --최초등록일시
  ,FSR_PRGM_NM     VARCHAR2(500)  NOT NULL     --최초등록프로그램명
  ,FSR_IP_ADDR     VARCHAR2(50)   NOT NULL     --최초등록IP주소
  ,LSH_STF_NO      VARCHAR2(5)    NOT NULL     --최종변경직원번호
  ,LSH_DTM         DATE           NOT NULL     --최종변경일시
  ,LSH_PRGM_NM     VARCHAR2(500)  NOT NULL     --최종변경프로그램명
  ,LSH_IP_ADDR     VARCHAR2(50)   NOT NULL     --최종변경IP주소
) TABLESPACE TSBIL_D01; 




/* 테이블 코멘트입니다. */
COMMENT ON TABLE  HBIL.ACPPRPOT                 IS '경찰트라우마진료의뢰서';
COMMENT ON COLUMN HBIL.ACPPRPOT.HSP_TP_CD       IS '병원구분코드';
COMMENT ON COLUMN HBIL.ACPPRPOT.PT_NO           IS '환자번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.REG_DT          IS '등록일자';
COMMENT ON COLUMN HBIL.ACPPRPOT.REG_SEQ         IS '등록순번';
COMMENT ON COLUMN HBIL.ACPPRPOT.RFFM_TP_CD      IS '의뢰서구분코드';
COMMENT ON COLUMN HBIL.ACPPRPOT.PT_RRN          IS '환자주민등록번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.POST_NO         IS '우편번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.POST_NO_SEQ     IS '우편번호순번';
COMMENT ON COLUMN HBIL.ACPPRPOT.BSC_ADDR        IS '기본주소';
COMMENT ON COLUMN HBIL.ACPPRPOT.DTL_ADDR        IS '상세주소';
COMMENT ON COLUMN HBIL.ACPPRPOT.TEL_NO          IS '전화번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.MTEL_NO         IS '휴대폰번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.PACT_TP_CD      IS '원무접수구분코드(입원외래구분)';
COMMENT ON COLUMN HBIL.ACPPRPOT.MED_DEPT_CD     IS '진료과코드';
COMMENT ON COLUMN HBIL.ACPPRPOT.MEDR_STF_NO     IS '진료의직원번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.MED_DTM         IS '진료일시';
COMMENT ON COLUMN HBIL.ACPPRPOT.PME_CLS_CD      IS '환자급종유형코드';
COMMENT ON COLUMN HBIL.ACPPRPOT.PSE_CLS_CD      IS '환자보조유형코드';
COMMENT ON COLUMN HBIL.ACPPRPOT.FRVS_RMDE_TP_CD IS '초진재진구분코드';
COMMENT ON COLUMN HBIL.ACPPRPOT.CMED_DR_YN      IS '선택진료의사여부';
COMMENT ON COLUMN HBIL.ACPPRPOT.PRNT_RMK_CNTE   IS '출력비고내용';
COMMENT ON COLUMN HBIL.ACPPRPOT.RMK_CNTE        IS '비고내용';
COMMENT ON COLUMN HBIL.ACPPRPOT.FRVS_CMED_YN    IS '초진선택여부';
COMMENT ON COLUMN HBIL.ACPPRPOT.RMDE_CMED_YN    IS '재진선택여부';
COMMENT ON COLUMN HBIL.ACPPRPOT.EXM_CMED_YN     IS '검사선택여부';
COMMENT ON COLUMN HBIL.ACPPRPOT.DGNS_CMED_YN    IS '진단선택여부';
COMMENT ON COLUMN HBIL.ACPPRPOT.CNCL_DT         IS '취소일자';
COMMENT ON COLUMN HBIL.ACPPRPOT.CNCL_STF_NO     IS '취소직원번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.BLDG_MGMT_NO    IS '건물관리번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.FSR_STF_NO	    IS '최초등록직원번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.FSR_DTM	        IS '최초등록일시';
COMMENT ON COLUMN HBIL.ACPPRPOT.FSR_PRGM_NM     IS '최초등록프로그램명';
COMMENT ON COLUMN HBIL.ACPPRPOT.FSR_IP_ADDR     IS '최초등록IP주소';
COMMENT ON COLUMN HBIL.ACPPRPOT.LSH_STF_NO	    IS '최종변경직원번호';
COMMENT ON COLUMN HBIL.ACPPRPOT.LSH_DTM	        IS '최종변경일시';
COMMENT ON COLUMN HBIL.ACPPRPOT.LSH_PRGM_NM     IS '최종변경프로그램명';
COMMENT ON COLUMN HBIL.ACPPRPOT.LSH_IP_ADDR     IS '최종변경IP주소';



/* 인덱스 및 개인키 선언 쿼리입니다. */
CREATE UNIQUE INDEX HBIL.ACPPRPOT_PK ON HBIL.ACPPRPOT(REG_DT, REG_SEQ) TABLESPACE TSBIL_I01;

ALTER TABLE HBIL.ACPPRPOT 
   ADD (
      CONSTRAINT ACPPRPOT_PK
      PRIMARY KEY
         (REG_DT, REG_SEQ)
      USING INDEX HBIL.ACPPRPOT_PK
      ENABLE VALIDATE
   );


/* SYNONYM 생성 쿼리입니다. */
CREATE PUBLIC SYNONYM ACPPRPOT FOR HBIL.ACPPRPOT;  /* 경찰트라우마진료의뢰서 */


/* 테이블 권한 쿼리입니다. */
GRANT SELECT,INSERT,UPDATE,DELETE ON HBIL.ACPPRPOT TO XBIL, XMED, XSUP, XGAB, XCOM;



