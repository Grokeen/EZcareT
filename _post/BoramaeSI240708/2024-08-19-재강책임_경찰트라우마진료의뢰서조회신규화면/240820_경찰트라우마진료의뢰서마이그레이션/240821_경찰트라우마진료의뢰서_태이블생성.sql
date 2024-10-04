/* 혹여나, 틀린 부분이 있을 시, 말씀해주시면 바로 수정하겠습니다. */

/* 테이블 삭제 쿼리입니다. */
DROP TABLE ACPPRPOT;

/* 테이블 생성 쿼리입니다. */
CREATE TABLE HBIL.ACPPRPTD(                    --경찰트라우마진료의뢰서정보 
   HSP_TP_CD       VARCHAR2(2)    NOT NULL     --병원구분코드
  ,PT_NO           VARCHAR2(8)    NOT NULL     --환자번호
  ,REG_DT          DATE           NOT NULL     --등록일자
  ,REG_SEQ         NUMBER         NOT NULL     --등록순번
  ,RFFM_TP_CD      VARCHAR2(2)                 --의뢰서구분코드
  ,PT_RRN          VARCHAR2(50)                --환자주민등록번호
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
  ,FRVS_CMED_YN    VARCHAR2(1)    NOT NULL     --초진선택여부
  ,RMDE_CMED_YN    VARCHAR2(1)    NOT NULL     --재진선택여부
  ,EXM_CMED_YN     VARCHAR2(1)    NOT NULL     --검사선택여부
  ,DGNS_CMED_YN    VARCHAR2(1)    NOT NULL     --진단선택여부
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
COMMENT ON TABLE  HBIL.ACPPRPTD                 IS '경찰트라우마진료의뢰서정보';
COMMENT ON COLUMN HBIL.ACPPRPTD.HSP_TP_CD       IS '병원구분코드';
COMMENT ON COLUMN HBIL.ACPPRPTD.PT_NO           IS '환자번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.REG_DT          IS '등록일자';
COMMENT ON COLUMN HBIL.ACPPRPTD.REG_SEQ         IS '등록순번';
COMMENT ON COLUMN HBIL.ACPPRPTD.RFFM_TP_CD      IS '의뢰서구분코드';
COMMENT ON COLUMN HBIL.ACPPRPTD.PT_RRN          IS '환자주민등록번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.POST_NO         IS '우편번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.POST_NO_SEQ     IS '우편번호순번';
COMMENT ON COLUMN HBIL.ACPPRPTD.BSC_ADDR        IS '기본주소';
COMMENT ON COLUMN HBIL.ACPPRPTD.DTL_ADDR        IS '상세주소';
COMMENT ON COLUMN HBIL.ACPPRPTD.TEL_NO          IS '전화번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.MTEL_NO         IS '휴대폰번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.PACT_TP_CD      IS '원무접수구분코드(입원외래구분)';
COMMENT ON COLUMN HBIL.ACPPRPTD.MED_DEPT_CD     IS '진료과코드';
COMMENT ON COLUMN HBIL.ACPPRPTD.MEDR_STF_NO     IS '진료의직원번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.MED_DTM         IS '진료일시';
COMMENT ON COLUMN HBIL.ACPPRPTD.PME_CLS_CD      IS '환자급종유형코드';
COMMENT ON COLUMN HBIL.ACPPRPTD.PSE_CLS_CD      IS '환자보조유형코드';
COMMENT ON COLUMN HBIL.ACPPRPTD.FRVS_RMDE_TP_CD IS '초진재진구분코드';
COMMENT ON COLUMN HBIL.ACPPRPTD.CMED_DR_YN      IS '선택진료의사여부';
COMMENT ON COLUMN HBIL.ACPPRPTD.PRNT_RMK_CNTE   IS '출력비고내용';
COMMENT ON COLUMN HBIL.ACPPRPTD.RMK_CNTE        IS '비고내용';
COMMENT ON COLUMN HBIL.ACPPRPTD.FRVS_CMED_YN    IS '초진선택여부';
COMMENT ON COLUMN HBIL.ACPPRPTD.RMDE_CMED_YN    IS '재진선택여부';
COMMENT ON COLUMN HBIL.ACPPRPTD.EXM_CMED_YN     IS '검사선택여부';
COMMENT ON COLUMN HBIL.ACPPRPTD.DGNS_CMED_YN    IS '진단선택여부';
COMMENT ON COLUMN HBIL.ACPPRPTD.CNCL_DT         IS '취소일자';
COMMENT ON COLUMN HBIL.ACPPRPTD.CNCL_STF_NO     IS '취소직원번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.BLDG_MGMT_NO    IS '건물관리번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.FSR_STF_NO	   IS '최초등록직원번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.FSR_DTM	      IS '최초등록일시';
COMMENT ON COLUMN HBIL.ACPPRPTD.FSR_PRGM_NM     IS '최초등록프로그램명';
COMMENT ON COLUMN HBIL.ACPPRPTD.FSR_IP_ADDR     IS '최초등록IP주소';
COMMENT ON COLUMN HBIL.ACPPRPTD.LSH_STF_NO	   IS '최종변경직원번호';
COMMENT ON COLUMN HBIL.ACPPRPTD.LSH_DTM	      IS '최종변경일시';
COMMENT ON COLUMN HBIL.ACPPRPTD.LSH_PRGM_NM     IS '최종변경프로그램명';
COMMENT ON COLUMN HBIL.ACPPRPTD.LSH_IP_ADDR     IS '최종변경IP주소';



/* 인덱스 및 개인키 선언 쿼리입니다. */
CREATE UNIQUE INDEX HBIL.ACPPRPTD_PK 
ON HBIL.ACPPRPTD(
      HSP_TP_CD,  --병원구분코드
      PT_NO,      --환자번호
      REG_DT,     --등록일자
      REG_SEQ     --등록순번
   )TABLESPACE TSBIL_I01;

ALTER TABLE HBIL.ACPPRPTD 
ADD (
   CONSTRAINT ACPPRPTD_PK
   PRIMARY KEY (
         HSP_TP_CD,  --병원구분코드
         PT_NO,      --환자번호
         REG_DT,     --등록일자
         REG_SEQ     --등록순번
      )USING INDEX HBIL.ACPPRPTD_PK
      ENABLE VALIDATE
   );


/* SYNONYM 생성 쿼리입니다. */
CREATE PUBLIC SYNONYM ACPPRPTD FOR HBIL.ACPPRPTD;  /* 경찰트라우마진료의뢰서 */


/* 테이블 권한 쿼리입니다. */
GRANT SELECT,INSERT,UPDATE,DELETE ON HBIL.ACPPRPTD TO XBIL, XMED, XSUP, XGAB, XCOM;



