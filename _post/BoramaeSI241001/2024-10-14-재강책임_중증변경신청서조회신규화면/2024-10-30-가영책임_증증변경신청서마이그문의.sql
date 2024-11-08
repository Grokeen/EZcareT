



-- apinsspt 급여질환별자격
-- C829
SELECT
   diss1_cd
   ,a.*
FROM APINSSPT a
 WHERE PT_NO = '00776940'
;;;

select
   *
from MEDNNCDT
where rownum < 10;

;;;


select *
  from APREGHVT@dlo_bmis1
 where PT_NO  = '00776940'

;;;

-- C884
SELECT
   EDI_TRSM_YN
   ,APLC_ICD10_CD_CNTE
   ,A.*
  FROM ACPPRGHD A  --본원
 WHERE PT_NO = '00776940'
;;;


select *
from APREGHVT_NEWT
where pt_no = '00776940';



;;;

-- ########################################### 아래는 ACPPRGHD 마이그 쿼리 ###################################################


INSERT /*+ APPEND */
INTO MIG_HBIL.ACPPRGHD ACPPRGHD (
                PT_NO
                                        , HLTH_INS_MDC_TP_CD
                                        , SRIL_CDOC_APLC_TP_CD
                                        , MDRC_ID
                                        , SRIL_APLC_SEQ
                                        , MDRC_FOM_SEQ
                                        , HSP_TP_CD
                                        , HLTH_INSC_NO
                                        , HLTH_INS_ETPS_NM
                                        , APLC_DT
                                        , APCT_NM
                                        , APCT_TEL_NO
                                        , PT_REL_DTL_TP_CD
                                        , SRIL_CFMT_NO
                                        , SRPP_ACPT_DT
                                        , EDI_TRSM_YN
                                        , EDI_TRSM_DT
                                        , EDI_RCV_YN
                                        , EDI_RCV_DT
                                        , MTD_NM
                                        , MED_PT_NO
                                        , CNCR_DGNS_CFMT_DT
                                        , APLC_ICD10_CD_CNTE
                                        , APLC_ICD10_DUP_SEQ_CD
                                        , DGNS_NM
                                        , SONO_DGNS_YN
                                        , CT_DGNS_YN
                                        , MRI_DGNS_YN
                                        , ETC_DGNS_YN
                                        , TH1_LST_DGNS_MTHD_CNTE
                                        , TH2_LST_DGNS_YN
                                        , TH3_LST_DGNS_YN
                                        , TH4_LST_DGNS_YN
                                        , TH5_LST_DGNS_YN
                                        , TH5_LST_DGNS_MTHD_CNTE
                                        , TH6_LST_DGNS_YN
                                        , TH6_LST_DGNS_ETC_EXM_CD
                                        , TH6_LST_DGNS_MTHD_CNTE
                                        , TH7_LST_DGNS_YN
                                        , TH7_LST_DGNS_MTHD_CNTE
                                        , APFR_WRT_DT
                                        , RCORG_NM
                                        , RCORG_NO
                                        , ASDR_STF_NO
                                        , ASDR_NM
                                        , ASDR_LCNS_NO
                                        , FST_WRT_DT
                                        , PACT_TP_CD
                                        , ADS_DT
                                        , SRIL_APCT_SGNT_CNTE
                                        , SRIL_RTNC_MTHD_CD
                                        , SRIL_APLC_CCRC_YN
                                        , CFSC_CD
                                        , HMPS_POST_NO
                                        , HMPS_POST_NO_SEQ
                                        , ADDR_VER_CTRA_CD
                                        , HMPS_ADDR
                                        , HMPS_TEL_NO
                                        , EMAL_ADDR
                                        , RRNS_OBST_RREG_YN
                                        , TH1_REG_SEQ
                                        , TH2_REG_SEQ
                                        , HIRA_MED_SBJT_CD
                                        , SMFL_LDAT_CNTE
                                        , RMK_CNTE
                                        , SRIL_APLC_CNCL_DTM
                                        , SRIL_APLC_CNCL_STF_NO
                                        , SRIL_APLC_CNCL_RSN_CD
                                        , APY_STR_DT
                                        , APY_END_DT
                                        , SRIL_APLC_SNBK_CD_CNTE
                                        , SRIL_APLC_SNBK_MSG_CNTE
                                        , MDFM_UDP_YN
                                        , DUP_SKNS_YN
                                        , PSNY_PTBD_AMT_EXMT_YN
                                        , HSHR_RRN
                                        , STTT_DONG_CD
                                        , MTN_YN
                                        , MAIN_LTNR
                                        , SUB_LTNR
                                        , BLDG_MGMT_NO
                                        , SKNS_REG_MDF_DTM
                                        , BOBD_PT_NO
                                        , BIND_DTM
                                        , BIND_STF_NO
                                        , FSR_STF_NO
                                        , FSR_DTM
                                        , FSR_PRGM_NM
                                        , FSR_IP_ADDR
                                        , LSH_STF_NO
                                        , LSH_DTM
                                        , LSH_PRGM_NM
                                        , LSH_IP_ADDR
                                        , PRBY_APFR_TP_CD
                                        , PRBY_APFR_TP_RMK_CNTE
                                        , PRBY_APFR_CHG_APLC_TP_CD
                                        , PRBY_APFR_CHG_CNTE
                                        , PRBY_APFR_BGCHG_CNTE
                                        , PRBY_APFR_AFCHG_CNTE
                                        , NWBN_FTHR_NM
                                        , NWBN_MTHR_NM
                                        , BRTH_DT
                                        , PRGN_PRD_CNTE
                                        , BDWT_CNTE
                                        , APCT_MBL_TEL_NO
                                        , SMS_RCV_CCRC_YN
                                        , DUP_CNCR_YN
                                        , TH1_CFSC_LST_DGNS_YN
                                        , TH2_CFSC_LST_DGNS_YN
                                        , TH3_CFSC_LST_DGNS_YN
                                        , TH4_CFSC_LST_DGNS_YN
                                        , TH5_CFSC_LST_DGNS_YN
                                        , TH6_CFSC_LST_DGNS_YN
                                        , TH6_CFSC_LST_DGNS_MTHD_CNTE
                                        , CFSC_SPBIO_YN
                                        , CFSC_GNTC_EXM_YN
                                        , CFSC_HSTL_EXM_YN
                                        , CFSC_COPN_YN
                                        , CFSC_COPN_CNTE
                                        , CFSC_ETC_YN
                                        , CFSC_ETC_CNTE
                                        , CFSC_PT_OPNN_CNTE
                                        , CFSC_DISS_INF_FAMH_YN
                                        , CFSC_FAMH_GFT_YN
                                        , CFSC_FAMH_GMT_YN
                                        , CFSC_FAMH_MGF_YN
                                        , CFSC_FAMH_MGM_YN
                                        , CFSC_FAMH_FTHR_YN
                                        , CFSC_FAMH_MTHR_YN
                                        , CFSC_FAMH_BRTR_YN
                                        , CFSC_FAMH_SSTS_YN
                                        , CFSC_FAMH_MALE_CHLR_YN
                                        , CFSC_FAMH_FEML_CHLR_YN
                                        , SPCT_QF_NO
                                        , DR_SPLT_SBJT_NM
                                        , DR_SPLT_SBJT_CD
                                        , CFSC_RREG_YN
                                        , CNCR_DGNS_TOPO_YN
                                        , CNCR_DGNS_MTST_YN
                                        , TH1_CNCR_HSTL_EXM_YN
                                        , TH2_CNCR_HSTL_EXM_YN
                                        , TH3_CNCR_LST_DGNS_YN
                                        , TH4_CNCR_LST_DGNS_YN
                                        , TH4_CNCR_LST_DGNS_CNTE
                                        , TH5_CNCR_LST_DGNS_YN
                                        , TH6_CNCR_LST_DGNS_YN
                                        , TH6_CNCR_LST_DGNS_CNTE
                                        , TH7_CNCR_LST_DGNS_YN
                                        , TH8_CNCR_LST_DGNS_YN
                                        , TH9_CNCR_LST_DGNS_YN
                                        , TH10_CNCR_LST_DGNS_YN
                                        , TH11_CNCR_LST_DGNS_YN
                                        , TH11_CNCR_LST_DGNS_CNTE
                                        , TH1_CNCR_HSTL_YN
                                        , TH2_CNCR_HSTL_YN
                                        , TH3_CNCR_HSTL_YN
                                        , TH4_CNCR_HSTL_YN
                                        , TH5_CNCR_HSTL_YN
                                        , TH5_CNCR_HSTL_CNTE
                                        , TH6_CNCR_HSTL_CNTE
                                        , TH1_TB_DGNS_YN
                                        , TH2_TB_DGNS_YN
                                        , TH3_TB_DGNS_YN
                                        , TH4_TB_DGNS_YN
                                        , TH5_TB_DGNS_YN
                                        , TH5_TB_DGNS_CNTE
                                        , TH6_TB_DGNS_YN
                                        , TH7_TB_DGNS_YN
                                        , TH8_TB_DGNS_YN
                                        , TH9_TB_DGNS_YN
                                        , TH9_TB_DGNS_CNTE
                                        , TH10_TB_DGNS_YN
                                        , TH10_TB_DGNS_CNTE
                                        , TB_OTHSP_EXRS_YN
                                        , TB_OTHSP_PCTR_EXRS_YN
                                        , TB_OTHSP_SMER_INCB_EXRS_YN
                                        , TB_OTHSP_HSTL_EXRS_YN
                                        , TB_OTHSP_ETC_EXRS_YN
                                        , ISSU_RCORG_NO
                                        , PRBY_APFR_MEMB_TP_CD
                                        , TH1_LT_DGNS_YN
                                        , TH2_LT_DGNS_YN
                                        , TH3_LT_DGNS_YN
                                        , TH4_LT_DGNS_YN
                                        , TH5_LT_DGNS_YN
                                        , TH6_LT_DGNS_YN
                                        , TH61_LT_DGNS_YN
                                        , TH62_LT_DGNS_YN
)
SELECT * FROM
 (
SELECT
APREGHVT.PT_NO                                      PT_NO /* 단순복사 - 환자번호 */
       , NVL(APREGHVT.CFSC_KND_CD,'BB')                      HLTH_INS_MDC_TP_CD /* 연산추출 - 건강보험의료급여구분코드 */
       , APREGHVT.SRIL_CDOC_APLC_TP_CD                       SRIL_CDOC_APLC_TP_CD /* 단순복사 - 중증확인증신청구분코드 */
       , APREGHVT.DOC_NOTE_ID                                MDRC_ID /* 단순복사 - 진료기록ID */
       , ROW_NUMBER() OVER(PARTITION BY APREGHVT.PT_NO
                                ,APREGHVT.CFSC_KND_CD
                                     ,APREGHVT.SRIL_CDOC_APLC_TP_CD
                                     ,APREGHVT.DOC_NOTE_ID
                                     ORDER BY APREGHVT.EDITDATE) SRIL_APLC_SEQ /* 연산추출 - 중증신청순번 */
       , APREGHVT.NOTE_RLS_NO                                MDRC_FOM_SEQ /* 단순복사 - 진료기록개정순번 */
       , '7'                                                 HSP_TP_CD /* 연산추출 - 병원구분코드 */
       , APREGHVT.LICENCNO                                   HLTH_INSC_NO /* 단순복사 - 건강보험증번호 */
       , APREGHVT.INSNAME                                    HLTH_INS_ETPS_NM /* 단순복사 - 건강보험가입자명 */
       , APREGHVT.REQDATE                                    APLC_DT /* 단순복사 - 신청일자 */
       , APREGHVT.REQNAME                                    APCT_NM /* 단순복사 - 신청인명 */
       , APREGHVT.REQTELNO                                   APCT_TEL_NO /* 단순복사 - 신청인전화번호 */
       , case when mp1.tobe_tbl_nm is null then APREGHVT.RELATION else mp1.TOBE_CODE end PT_REL_DTL_TP_CD /* 매핑변환 - 환자관계상세구분코드 */
       , APREGHVT.REGISTNO                                   SRIL_CFMT_NO /* 단순복사 - 중증확인번호 */
       , APREGHVT.REGDATE                                    SRPP_ACPT_DT /* 단순복사 - 중증신청서접수일자 */
       , APREGHVT.SENDYN                                     EDI_TRSM_YN /* 단순복사 - EDI송신여부 */
       , APREGHVT.SENDDATE                                   EDI_TRSM_DT /* 단순복사 - EDI송신일자 */
       , APREGHVT.RECPYN                                     EDI_RCV_YN /* 단순복사 - EDI수신여부 */
       , APREGHVT.RECPDATE                                   EDI_RCV_DT /* 단순복사 - EDI수신일자 */
       , APREGHVT.MEDDEPT                                    MTD_NM /* 단순복사 - 진료과명 */
       , APREGHVT.MEDPTNO                                    MED_PT_NO /* 단순복사 - 진료환자번호 */
       , APREGHVT.DIAGNODATE                                 CNCR_DGNS_CFMT_DT /* 단순복사 - 암진단확인일자 */
       , APREGHVT.ICDTCODE                                   APLC_ICD10_CD_CNTE /* 단순복사 - 신청ICD10코드내용 */
       , DENSE_RANK() OVER(PARTITION BY APREGHVT.DOC_NOTE_ID ORDER BY APREGHVT.ICDTCODE) APLC_ICD10_DUP_SEQ_CD /* 연산추출 - 신청ICD10중복순번코드 */
       , APREGHVT.ICDTNAME                                   DGNS_NM /* 단순복사 - 진단명 */
       , DECODE(SUBSTR(APREGHVT.DIAGNOCHK1,1,1), '1', 'Y', '0', 'N')  SONO_DGNS_YN /* 연산추출 - SONO진단여부 */
       , DECODE(SUBSTR(APREGHVT.DIAGNOCHK1,2,1), '1', 'Y', '0', 'N') CT_DGNS_YN /* 연산추출 - CT진단여부 */
       , DECODE(SUBSTR(APREGHVT.DIAGNOCHK1,3,1), '1', 'Y', '0', 'N') MRI_DGNS_YN /* 연산추출 - MRI진단여부 */
       , DECODE(SUBSTR(APREGHVT.DIAGNOCHK1,4,1), '1', 'Y', '0', 'N') ETC_DGNS_YN /* 연산추출 - 기타진단여부 */
       , APREGHVT.DIAGNOREM1                                 TH1_LST_DGNS_MTHD_CNTE /* 단순복사 - 1번째최종진단방법내용 */
       , APREGHVT.DIAGNOCHK2                                 TH2_LST_DGNS_YN /* 단순복사 - 2번째최종진단여부 */
       , APREGHVT.DIAGNOCHK3                                 TH3_LST_DGNS_YN /* 단순복사 - 3번째최종진단여부 */
       , APREGHVT.DIAGNOCHK4                                 TH4_LST_DGNS_YN /* 단순복사 - 4번째최종진단여부 */
       , APREGHVT.DIAGNOCHK5                                 TH5_LST_DGNS_YN /* 단순복사 - 5번째최종진단여부 */
       , NULL                                                TH5_LST_DGNS_MTHD_CNTE /* 전환제외 - 5번째최종진단방법내용 */
       , APREGHVT.DIAGNOCHK6                                 TH6_LST_DGNS_YN /* 단순복사 - 6번째최종진단여부 */
       , APREGHVT.DIAGNOEXM6                                 TH6_LST_DGNS_ETC_EXM_CD /* 단순복사 - 6번째최종진단기타검사코드 */
       , NULL                                                TH6_LST_DGNS_MTHD_CNTE /* 전환제외 - 6번째최종진단방법내용 */
       , APREGHVT.DIAGNOCHK7                                 TH7_LST_DGNS_YN /* 단순복사 - 7번째최종진단여부 */
       , APREGHVT.DIAGNOREM7                                 TH7_LST_DGNS_MTHD_CNTE /* 단순복사 - 7번째최종진단방법내용 */
       , APREGHVT.REGSETDATE                                 APFR_WRT_DT /* 단순복사 - 신청서작성일자 */
       , APREGHVT.HSPNAME                                    RCORG_NM /* 단순복사 - 요양기관명 */
       , APREGHVT.HSPCODE                                    RCORG_NO /* 단순복사 - 요양기관번호 */
       , APREGHVT.MEDDRID                                    ASDR_STF_NO /* 단순복사 - 담당의직원번호 */
       , APREGHVT.MEDDRNAME                                  ASDR_NM /* 단순복사 - 담당의명 */
       , APREGHVT.MEDDRLIC                                   ASDR_LCNS_NO /* 단순복사 - 담당의면허번호 */
       , APREGHVT.FSTDATE                                    FST_WRT_DT /* 단순복사 - 최초작성일자 */
       , DECODE(APREGHVT.DIAGNOSITE,'외래','O'
                                 ,'응급','E'
                                 ,'입원','I') PACT_TP_CD /* 연산추출 - 원무접수구분코드 */
       , APREGHVT.ADMDATE                                    ADS_DT /* 단순복사 - 입원일자 */
       , APRGIMGT_SIGN1.SIGN_CHAR                            SRIL_APCT_SGNT_CNTE /* 단순복사 - 중증신청인서명내용 */
       , DECODE(APREGHVT.CALL_TYPE,'1','S'                                ,'2','E'                                ,'9','S'                                    , NULL) SRIL_RTNC_MTHD_CD /* 연산추출 - 중증결과통보방법코드 */
       , 'Y'                                                 SRIL_APLC_CCRC_YN /* 특정값 - 중증신청동의여부 */
       , CASE WHEN VCODE='V193V193'  THEN 'V193' ELSE  VCODE END CFSC_CD /* 연산추출 - 산정특례코드 */
       , APREGHVT.PATZIPCD                                   HMPS_POST_NO /* 단순복사 - 수진자우편번호 */
       , TO_NUMBER(APREGHVT.PATZIPSEQ)                       HMPS_POST_NO_SEQ /* 연산추출 - 수진자우편번호순번 */
       , '2'                                                 ADDR_VER_CTRA_CD /* 특정값 - 주소버전기준코드 */
       , APREGHVT.PATADDR                                    HMPS_ADDR /* 단순복사 - 수진자주소 */
       , APREGHVT.PATTELNO                                   HMPS_TEL_NO /* 단순복사 - 수진자전화번호 */
       , APREGHVT.EMAIL                                      EMAL_ADDR /* 단순복사 - 이메일주소 */
       , CASE WHEN APREGHVT.SRIL_CDOC_APLC_TP_CD IN ('21','23') -- 희귀/난치
            THEN APREGHVT.REWRIT_YN
            ELSE NULL END RRNS_OBST_RREG_YN /* 연산추출 - 희귀난치재등록여부 */
       , ROW_NUMBER() OVER(PARTITION BY APREGHVT.PT_NO, APREGHVT.SRIL_CDOC_APLC_TP_CD,APREGHVT.DOC_NOTE_ID ORDER BY APREGHVT.REQDATE) TH1_REG_SEQ /* 연산추출 - 1번째등록순번 */
       , 1                                                   TH2_REG_SEQ /* 특정값 - 2번째등록순번 */
       , (SELECT AS_DP_CD
          FROM ASIS_HCOM.CCDEPART CCDEPART
         WHERE CCDEPART.DEPT_CD = APREGHVT.MEDDEPTCD
           AND CCDEPART.HSP_CLS = APREGHVT.HSPCL AND ROWNUM=1 ) HIRA_MED_SBJT_CD /* 연산추출 - 심평원진료과목코드 */
       , NULL                                                SMFL_LDAT_CNTE /* 전환제외 - 샘파일자료내용 */
       , NULL                                                RMK_CNTE /* 전환제외 - 비고내용 */
       , APREGHVT.BIL_CNCL_DTE                               SRIL_APLC_CNCL_DTM /* 단순복사 - 중증신청취소일시 */
       , APREGHVT.BIL_CNCL_ID                                SRIL_APLC_CNCL_STF_NO /* 단순복사 - 중증신청취소직원번호 */
       , NVL2(APREGHVT.BIL_CNCL_DTE,'99',NULL)               SRIL_APLC_CNCL_RSN_CD /* 연산추출 - 중증신청취소사유코드 */
       , NVL(APREGHVT.REGSETDATE,REQDATE)                    APY_STR_DT /* 연산추출 - 적용시작일자 */
       , NULL                                                APY_END_DT /* 전환제외 - 적용종료일자 */
       , APREGHVT.EDI_RSLT_CD                                SRIL_APLC_SNBK_CD_CNTE /* 단순복사 - 중증신청반송코드내용 */
       , APREGHVT.EDI_RSLT_MSG                               SRIL_APLC_SNBK_MSG_CNTE /* 단순복사 - 중증신청반송메시지내용 */
       , 'N'                                                 MDFM_UDP_YN /* 특정값 - 진료서식갱신여부 */
       , DECODE(DENSE_RANK() OVER(PARTITION BY APREGHVT.DOC_NOTE_ID ORDER BY APREGHVT.ICDTCODE),'1','N'                                                                          ,'Y') DUP_SKNS_YN /* 연산추출 - 중복상병여부 */
       , 'N'                                                 PSNY_PTBD_AMT_EXMT_YN /* 특정값 - 본인부분부담금액면제여부 */
       , CASE WHEN LENGTH(APREGHVT.PATSSNO )=36 THEN NULL ELSE  PETRA.pls_encrypt_b64_id(  SCP.DEC_STR('PE8',APREGHVT.PATSSNO ) ,800) END HSHR_RRN /* 연산추출 - 세대주주민등록번호 */
       , APMATCMT.LAW_DONG_CD                                STTT_DONG_CD /* 단순복사 - 법정동코드 */
       , APMATCMT.SAN_YN                                     MTN_YN /* 단순복사 - 산여부 */
       , TO_CHAR(APMATCMT.JIBUN_MAIN)                        MAIN_LTNR /* 연산추출 - 지번본번 */
       , TO_CHAR(APMATCMT.JIBUN_SUB)                         SUB_LTNR /* 연산추출 - 지번부번 */
       , APPATBAT.BUILDING_NO                                BLDG_MGMT_NO /* 단순복사 - 건물관리번호 */
       , NULL                                                SKNS_REG_MDF_DTM /* 전환제외 - 상병등록수정일시 */
       , NULL                                                BOBD_PT_NO /* 전환제외 - 합본이전환자번호 */
       , NULL                                                BIND_DTM /* 전환제외 - 합본일시 */
       , NULL                                                BIND_STF_NO /* 전환제외 - 합본직원번호 */
       , 'MIG00'                                FSR_STF_NO /* 특정값 - 최초등록직원번호 */
       , TO_DATE('20240907','YYYYMMDD')                                   FSR_DTM /* 특정값 - 최초등록일시 */
       , 'MIG ETL'                               FSR_PRGM_NM /* 특정값 - 최초등록프로그램명 */
       , '0.0.0.0'                               FSR_IP_ADDR /* 특정값 - 최초등록IP주소 */
       , 'MIG00'                                LSH_STF_NO /* 특정값 - 최종변경직원번호 */
       , TO_DATE('20240907','YYYYMMDD')                                   LSH_DTM /* 특정값 - 최종변경일시 */
       , 'MIG ETL'                               LSH_PRGM_NM /* 특정값 - 최종변경프로그램명 */
       , '0.0.0.0'                               LSH_IP_ADDR /* 특정값 - 최종변경IP주소 */
       , NULL                                                PRBY_APFR_TP_CD /* 전환제외 - 조산아신청서구분코드 */
       , NULL                                                PRBY_APFR_TP_RMK_CNTE /* 전환제외 - 조산아신청서구분비고내용 */
       , NULL                                                PRBY_APFR_CHG_APLC_TP_CD /* 전환제외 - 조산아신청서변경신청구분코드 */
       , NULL                                                PRBY_APFR_CHG_CNTE /* 전환제외 - 조산아신청서변경내용 */
       , NULL                                                PRBY_APFR_BGCHG_CNTE /* 전환제외 - 조산아신청서변경이전내용 */
       , NULL                                                PRBY_APFR_AFCHG_CNTE /* 전환제외 - 조산아신청서변경이후내용 */
       , NULL                                                NWBN_FTHR_NM /* 전환제외 - 신생아부친명 */
       , NULL                                                NWBN_MTHR_NM /* 전환제외 - 신생아모친명 */
       , NULL                                                BRTH_DT /* 전환제외 - 출생일자 */
       , NULL                                                PRGN_PRD_CNTE /* 전환제외 - 임신기간내용 */
       , NULL                                                BDWT_CNTE /* 전환제외 - 체중내용 */
       , APPATBAT.TEL_NO                                     APCT_MBL_TEL_NO /* 단순복사 - 신청인휴대전화번호 */
       , 'N'                                                 SMS_RCV_CCRC_YN /* 특정값 - SMS수신동의여부 */
       , CASE WHEN APREGHVT.REWRIT_YN IN ('3','4') THEN 'Y'
ELSE
 DECODE(APREGHVT.SRIL_CDOC_APLC_TP_CD,'J3','N') END DUP_CNCR_YN /* 연산추출 - 중복암여부 */
       , CASE WHEN INSTR(APREGHVT.SRIL_CDOC_APLC_TP_CD,'Y')>0 THEN  'Y'
            ELSE 'N'
            END TH1_CFSC_LST_DGNS_YN /* 연산추출 - 1번째산정특례최종진단여부 */
       , APREGHVT.CLINIC_CD                                  TH2_CFSC_LST_DGNS_YN /* 단순복사 - 2번째산정특례최종진단여부 */
       , SUBSTR(APREGHVT.DIAGNOCHK1_RARE,1,1)                TH3_CFSC_LST_DGNS_YN /* 연산추출 - 3번째산정특례최종진단여부 */
       , SUBSTR(APREGHVT.DIAGNOCHK1_RARE,2,1)                TH4_CFSC_LST_DGNS_YN /* 연산추출 - 4번째산정특례최종진단여부 */
       , SUBSTR(APREGHVT.DIAGNOCHK1_RARE,3,1)                TH5_CFSC_LST_DGNS_YN /* 연산추출 - 5번째산정특례최종진단여부 */
       , SUBSTR(APREGHVT.DIAGNOCHK1_RARE,4,1)                TH6_CFSC_LST_DGNS_YN /* 연산추출 - 6번째산정특례최종진단여부 */
       , APREGHVT.DIAGNOREM1_RARE                            TH6_CFSC_LST_DGNS_MTHD_CNTE /* 단순복사 - 6번째산정특례최종진단방법내용 */
       , APREGHVT.DIAGNOCHK2_RARE                            CFSC_SPBIO_YN /* 단순복사 - 산정특례특수생화학여부 */
       , APREGHVT.DIAGNOCHK3_RARE                            CFSC_GNTC_EXM_YN /* 단순복사 - 산정특례유전학검사여부 */
       , APREGHVT.DIAGNOCHK4_RARE                            CFSC_HSTL_EXM_YN /* 단순복사 - 산정특례조직학검사여부 */
       , APREGHVT.DIAGNOCHK5_RARE                            CFSC_COPN_YN /* 단순복사 - 산정특례임상소견여부 */
       , APREGHVT.DIAGNOREM6_RARE                            CFSC_COPN_CNTE /* 단순복사 - 산정특례임상소견내용 */
       , NVL2(APREGHVT.DIAGNOREM6_RARE,'Y','N')              CFSC_ETC_YN /* 연산추출 - 산정특례기타여부 */
       , APREGHVT.DIAGNOREM6_RARE                            CFSC_ETC_CNTE /* 단순복사 - 산정특례기타내용 */
       , NULL                                                CFSC_PT_OPNN_CNTE /* 전환제외 - 산정특례환자소견내용 */
       , NVL2(NVL(SUBSTR(MEDNNCDT.CONTS18,8,1),'0'),'Y','N') CFSC_DISS_INF_FAMH_YN /* 연산추출 - 산정특례질병정보가족력여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,1,1),'Y','N')          CFSC_FAMH_GFT_YN /* 연산추출 - 산정특례가족력조부여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,2,1),'Y','N')          CFSC_FAMH_GMT_YN /* 연산추출 - 산정특례가족력조모여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,3,1),'Y','N')          CFSC_FAMH_MGF_YN /* 연산추출 - 산정특례가족력외조부여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,4,1),'Y','N')          CFSC_FAMH_MGM_YN /* 연산추출 - 산정특례가족력외조모여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,5,1),'Y','N')          CFSC_FAMH_FTHR_YN /* 연산추출 - 산정특례가족력부친여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,6,1),'Y','N')          CFSC_FAMH_MTHR_YN /* 연산추출 - 산정특례가족력모친여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,7,1),'Y','N')          CFSC_FAMH_BRTR_YN /* 연산추출 - 산정특례가족력형제여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,8,1),'Y','N')          CFSC_FAMH_SSTS_YN /* 연산추출 - 산정특례가족력자매여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,9,1),'Y','N')          CFSC_FAMH_MALE_CHLR_YN /* 연산추출 - 산정특례가족력남자자녀여부 */
       , NVL2(SUBSTR(MEDNNCDT.CONTS36,10,1),'Y','N')         CFSC_FAMH_FEML_CHLR_YN /* 연산추출 - 산정특례가족력여자자녀여부 */
       , NULL                                                SPCT_QF_NO /* 전환제외 - 전문의자격번호 */
       , NULL                                                DR_SPLT_SBJT_NM /* 전환제외 - 의사전문과목명 */
       , NULL                                                DR_SPLT_SBJT_CD /* 전환제외 - 의사전문과목코드 */
       , CASE WHEN APREGHVT.REWRIT_YN IN('Y','2','4')
            THEN 'Y'
            ELSE 'N' END CFSC_RREG_YN /* 연산추출 - 산정특례재등록여부 */
       , NULL                                                CNCR_DGNS_TOPO_YN /* 전환제외 - 암진단원발부위여부 */
       , NULL                                                CNCR_DGNS_MTST_YN /* 전환제외 - 암진단전이여부 */
       , NULL                                                TH1_CNCR_HSTL_EXM_YN /* 전환제외 - 1번째암조직학검사여부 */
       , NULL                                                TH2_CNCR_HSTL_EXM_YN /* 전환제외 - 2번째암조직학검사여부 */
       , NULL                                                TH3_CNCR_LST_DGNS_YN /* 전환제외 - 3번째암최종진단여부 */
       , NULL                                                TH4_CNCR_LST_DGNS_YN /* 전환제외 - 4번째암최종진단여부 */
       , NULL                                                TH4_CNCR_LST_DGNS_CNTE /* 전환제외 - 4번째암최종진단내용 */
       , NULL                                                TH5_CNCR_LST_DGNS_YN /* 전환제외 - 5번째암최종진단여부 */
       , NULL                                                TH6_CNCR_LST_DGNS_YN /* 전환제외 - 6번째암최종진단여부 */
       , NULL                                                TH6_CNCR_LST_DGNS_CNTE /* 전환제외 - 6번째암최종진단내용 */
       , NULL                                                TH7_CNCR_LST_DGNS_YN /* 전환제외 - 7번째암최종진단여부 */
       , NULL                                                TH8_CNCR_LST_DGNS_YN /* 전환제외 - 8번째암최종진단여부 */
       , NULL                                                TH9_CNCR_LST_DGNS_YN /* 전환제외 - 9번째암최종진단여부 */
       , NULL                                                TH10_CNCR_LST_DGNS_YN /* 전환제외 - 10번째암최종진단여부 */
       , NULL                                                TH11_CNCR_LST_DGNS_YN /* 전환제외 - 11번째암최종진단여부 */
       , NULL                                                TH11_CNCR_LST_DGNS_CNTE /* 전환제외 - 11번째암최종진단내용 */
       , NULL                                                TH1_CNCR_HSTL_YN /* 전환제외 - 1번째암조직학여부 */
       , NULL                                                TH2_CNCR_HSTL_YN /* 전환제외 - 2번째암조직학여부 */
       , NULL                                                TH3_CNCR_HSTL_YN /* 전환제외 - 3번째암조직학여부 */
       , NULL                                                TH4_CNCR_HSTL_YN /* 전환제외 - 4번째암조직학여부 */
       , NULL                                                TH5_CNCR_HSTL_YN /* 전환제외 - 5번째암조직학여부 */
       , NULL                                                TH5_CNCR_HSTL_CNTE /* 전환제외 - 5번째암조직학내용 */
       , NULL                                                TH6_CNCR_HSTL_CNTE /* 전환제외 - 6번째암조직학내용 */
       , NULL                                                TH1_TB_DGNS_YN /* 전환제외 - 1번째결핵진단여부 */
       , NULL                                                TH2_TB_DGNS_YN /* 전환제외 - 2번째결핵진단여부 */
       , NULL                                                TH3_TB_DGNS_YN /* 전환제외 - 3번째결핵진단여부 */
       , NULL                                                TH4_TB_DGNS_YN /* 전환제외 - 4번째결핵진단여부 */
       , NULL                                                TH5_TB_DGNS_YN /* 전환제외 - 5번째결핵진단여부 */
       , NULL                                                TH5_TB_DGNS_CNTE /* 전환제외 - 5번째결핵진단내용 */
       , NULL                                                TH6_TB_DGNS_YN /* 전환제외 - 6번째결핵진단여부 */
       , NULL                                                TH7_TB_DGNS_YN /* 전환제외 - 7번째결핵진단여부 */
       , NULL                                                TH8_TB_DGNS_YN /* 전환제외 - 8번째결핵진단여부 */
       , NULL                                                TH9_TB_DGNS_YN /* 전환제외 - 9번째결핵진단여부 */
       , NULL                                                TH9_TB_DGNS_CNTE /* 전환제외 - 9번째결핵진단내용 */
       , NULL                                                TH10_TB_DGNS_YN /* 전환제외 - 10번째결핵진단여부 */
       , NULL                                                TH10_TB_DGNS_CNTE /* 전환제외 - 10번째결핵진단내용 */
       , NULL                                                TB_OTHSP_EXRS_YN /* 전환제외 - 결핵타병원검사결과여부 */
       , NULL                                                TB_OTHSP_PCTR_EXRS_YN /* 전환제외 - 결핵타병원영상검사결과여부 */
       , NULL                                                TB_OTHSP_SMER_INCB_EXRS_YN /* 전환제외 - 결핵타병원도말배양검사결과여부 */
       , NULL                                                TB_OTHSP_HSTL_EXRS_YN /* 전환제외 - 결핵타병원조직학검사결과여부 */
       , NULL                                                TB_OTHSP_ETC_EXRS_YN /* 전환제외 - 결핵타병원기타검사결과여부 */
       , APREGHVT.HSPCODE                                    ISSU_RCORG_NO /* 단순복사 - 발급요양기관번호 */
       , NULL                                                PRBY_APFR_MEMB_TP_CD /* 전환제외 - 조산아신청서다태아구분코드 */
       , NULL                                                TH1_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH2_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH3_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH4_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH5_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH6_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH61_LT_DGNS_YN /* 전환제외 -  */
       , NULL                                                TH62_LT_DGNS_YN /* 전환제외 -  */
  FROM ( SELECT  /*+ use_hash(MEDRNMAT) use_hash(APREGHVT) */  APREGHVT.*
, CASE WHEN REQTYPE = '01'
				           THEN 'J3' -- 중증암
				           WHEN REQTYPE = '05' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y'      -- 중증치매여부
				           THEN 'SD' -- 중증치매
				           WHEN REQTYPE = '05' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y'      -- 난치여부
									 THEN '23' -- 중증난치질환
									 WHEN REQTYPE = '05' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N'
									 THEN '21' -- 희귀질환
									 WHEN REQTYPE = '06'
									 THEN 'TB' -- 결핵
									 WHEN REQTYPE = '07'
									 THEN '09' -- 중증화상
									 WHEN REQTYPE = '16'
									 THEN 'LT' -- 잠복결핵
									 WHEN REQTYPE = '09'
				           THEN 'J3' -- 중증암(+희귀난치 인데 작업어케해야할지 모르겠음, 전산팀에 물어보자)
				           END AS SRIL_CDOC_APLC_TP_CD       -- 003. 중증확인증신청구분코드
				    ,MEDRNMAT.CFSC_KND_CD
        FROM ASIS_HBIL.APREGHVT APREGHVT
           ,(SELECT /*+ INDEX(MEDRNMAT MEDRNMAT_SI06) */   CASE WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('458','459') THEN 'Y'       -- 난치 산정특례
			                   WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('456','457','187','213','214') THEN 'N'  -- 희귀 산정특례
			                   END                          AS INCURABLE_YN
			            , MEDRNMAT.DOC_NOTE_ID              AS DOC_NOTE_ID
			            , MEDRNMAT.RLS_NO                   AS RLS_NO
			            ,    DECODE(MEDRNMAT.DOCNOTE_TYP_ID , '185', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                                          , '186', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                                          , '187', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                                          , '358', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                                          , '442', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증치매)
                                                          , '456', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                                          , '458', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(난치)
                                                          , '464', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                                          , '465', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                                          , '466', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                                          , '551', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(잠복결핵)
                                                          , '203', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                                          , '211', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(중증)
                                                          , '212', 'EE'                                                                                                                                                                                      -- 의료급여 산정특례 신청서(중증화상)
                                                          , '213', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                                          , '214', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 신청서(중증/희귀)
                                                          , '359', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                                          , '457', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                                          , '459', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(난치)
                                                          , '467', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(중증)
                                                          , '468', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                                          , '469', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                              )  AS CFSC_KND_CD
                        , DECODE(DOCNOTE_TYP_ID,'442' ,'Y'
			                                   ,'456' ,'N'
			                                   ,'458' ,'N')  AS IS_ALZHEIMER
			            , MEDRNMAT.DEPT_CD                  AS DEPT_CD
			            , MEDRNMAT.WK_ID                    AS WK_ID
			            , MEDRNMAT.PT_SECT                  AS PACT_TP_CD
			            , TRUNC(MEDRNMAT.CRT_DTE)           AS CRT_DTE
			         FROM ASIS_HEMR.MEDRNMAT MEDRNMAT -- 중증치매 기록지
          ---치매---
			        WHERE MEDRNMAT.DOCNOTE_TYP_ID IN (  '185'
                                                      , '186'
                                                      , '187'
                                                      , '358'
                                                      , '442'
                                                      , '456'
                                                      , '458'
                                                      , '464'
                                                      , '465'
                                                      , '466'
                                                      , '551'
                                                      , '203'
                                                      , '211'
                                                      , '212'
                                                      , '213'
                                                      , '214'
                                                      , '359'
                                                      , '457'
                                                      , '459'
                                                      , '467'
                                                      , '468'
                                                      , '469'
                                                     )
     			 	) MEDRNMAT
      WHERE APREGHVT.REQTYPE NOT IN('98','99')
        AND APREGHVT.REQTYPE IS NOT NULL
        AND APREGHVT.DOC_NOTE_ID = TO_CHAR(MEDRNMAT.DOC_NOTE_ID(+))
        AND APREGHVT.NOTE_RLS_NO = TO_CHAR(MEDRNMAT.RLS_NO(+))) APREGHVT
   LEFT OUTER JOIN  ASIS_HBIL.APRGIMGT APRGIMGT_SIGN1 on APREGHVT.SIGNSTR = APRGIMGT_SIGN1.SIGN_NO
   LEFT OUTER JOIN  ASIS_HEMR.MEDNNCDT MEDNNCDT on APREGHVT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID
   AND APREGHVT.NOTE_RLS_NO = MEDNNCDT.RLS_NO
   LEFT OUTER JOIN  ASIS_HBIL.APPATBAT APPATBAT on APREGHVT.PT_NO  = APPATBAT.PT_NO
   LEFT OUTER JOIN  ASIS_HCOM.APMATCMT APMATCMT on APPATBAT.BUILDING_NO = APMATCMT.BLD_NO


  LEFT OUTER JOIN MP_CODE mp1 ON COALESCE(mp1.ASIS_CODE,'*NULL VALUE*') = COALESCE(APREGHVT.RELATION,'*NULL VALUE*')
         and UPPER(mp1.TOBE_TBL_NM) = 'ACPPRGHD'
         and UPPER(mp1.TOBE_COL_NM) = 'PT_REL_DTL_TP_CD'
         and mp1.DB_USER_ID IS NULL
         and UPPER(mp1.ASIS_TBL_NM) = 'APREGHVT'
         and UPPER(mp1.ASIS_COL_NM) = 'RELATION'
union all
SELECT
APREGHVT_NEWT.PT_NO                                 PT_NO /* 단순복사 - 환자번호 */
       , NVL(APREGHVT_NEWT.CFSC_KND_CD,'BB')                 HLTH_INS_MDC_TP_CD /* 연산추출 - 건강보험의료급여구분코드 */
       , APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD                  SRIL_CDOC_APLC_TP_CD /* 단순복사 - 중증확인증신청구분코드 */
       , APREGHVT_NEWT.DOC_NOTE_ID                           MDRC_ID /* 단순복사 - 진료기록ID */
       , DECODE(APREGHVT_NEWT.DOC_NOTE_ID,'46373581',2, ROW_NUMBER() OVER(PARTITION BY APREGHVT_NEWT.PT_NO
                                                                                    ,APREGHVT_NEWT.CFSC_KND_CD
                                                                                    ,APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD
                                                                                    ,APREGHVT_NEWT.DOC_NOTE_ID
                                                                                    ORDER BY APREGHVT_NEWT.EDIT_DTE)) SRIL_APLC_SEQ /* 연산추출 - 중증신청순번 */
       , APREGHVT_NEWT.RLS_NO                                MDRC_FOM_SEQ /* 단순복사 - 진료기록개정순번 */
       , '7'                                                 HSP_TP_CD /* 특정값 - 병원구분코드 */
       , RPAD(NVL(REPLACE(MEDNNCDT.CONTS02,'-',''),' '),11,' ') HLTH_INSC_NO /* 연산추출 - 건강보험증번호 */
       , (SELECT APINSURT.HUS_NM
          FROM ASIS_HBIL.APINSURT  APINSURT
         WHERE APINSURT.PT_NO     = APREGHVT_NEWT.PT_NO
           AND APINSURT.QUACQ_DTE = (SELECT MAX(APINSURT2.QUACQ_DTE)
                                       FROM ASIS_HBIL.APINSURT APINSURT2
                                      WHERE APINSURT2.PT_NO = APINSURT.PT_NO ) AND ROWNUM=1) HLTH_INS_ETPS_NM /* 연산추출 - 건강보험가입자명 */
       , APREGHVT_NEWT.REQ_DTE                               APLC_DT /* 단순복사 - 신청일자 */
       , APREGHVT_NEWT.REQ_NM                                APCT_NM /* 단순복사 - 신청인명 */
       , APREGHVT_NEWT.TEL_NO                                APCT_TEL_NO /* 단순복사 - 신청인전화번호 */
       , case when mp1.tobe_tbl_nm is null then APREGHVT_NEWT.PAT_REL else mp1.TOBE_CODE end PT_REL_DTL_TP_CD /* 매핑변환 - 환자관계상세구분코드 */
       , INS_REG_NO                                          SRIL_CFMT_NO /* 연산추출 - 중증확인번호 */
       , REQ_DTE                                             SRPP_ACPT_DT /* 연산추출 - 중증신청서접수일자 */
       , APREGHVT_NEWT.SEND_YN                               EDI_TRSM_YN /* 단순복사 - EDI송신여부 */
       , APREGHVT_NEWT.SEND_DTE                              EDI_TRSM_DT /* 단순복사 - EDI송신일자 */
       , APREGHVT_NEWT.RECP_YN                               EDI_RCV_YN /* 단순복사 - EDI수신여부 */
       , APREGHVT_NEWT.RECP_DTE                              EDI_RCV_DT /* 단순복사 - EDI수신일자 */
       , NVL(APREGHVT_NEWT.MED_DEPT,MEDNNCDT.CONTS04)        MTD_NM /* 연산추출 - 진료과명 */
       , APREGHVT_NEWT.PT_NO                                 MED_PT_NO /* 단순복사 - 진료환자번호 */
       , APREGHVT_NEWT.DIAGNO_DTE                            CNCR_DGNS_CFMT_DT /* 연산추출 - 암진단확인일자 */










         /*역이감나ㅣ올ㄴ어ㅏㅣ롬아ㅣㄴ러ㅏㅣㅇ너라ㅣㅇ너라ㅣ어라ㅣㅓ이ㅏ러아ㅣㅓ럄ㄴ어라ㅣ어리ㅏㄴ어라ㅣ어ㅏ어ㅏㅣ*/







       , NVL((SELECT CCCODEST.CSUBCD_NM
              FROM ASIS_HCOM.CCCODEST CCCODEST
             WHERE CCCODEST.CCD_TYP = 'MC14'
               AND CCCODEST.C_CD = REPLACE(REPLACE(MEDNNCDT.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND CCCODEST.USE_YN = 'Y' AND ROWNUM=1),REPLACE(REPLACE(MEDNNCDT.DZ_NO, CHR(13),''),CHR(10),' ')) APLC_ICD10_CD_CNTE /* 연산추출 - 신청ICD10코드내용 */
       , 1                                                   APLC_ICD10_DUP_SEQ_CD /* 특정값 - 신청ICD10중복순번코드 */
       , REPLACE(REPLACE(MEDNNCDT.DZ_NM, CHR(13),''),CHR(10),' ') DGNS_NM /* 연산추출 - 진단명 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS06,1,1), '1', 'Y', '0', 'N')  SONO_DGNS_YN /* 연산추출 - SONO진단여부 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS06,2,1), '1', 'Y', '0', 'N') CT_DGNS_YN /* 연산추출 - CT진단여부 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS06,3,1), '1', 'Y', '0', 'N') MRI_DGNS_YN /* 연산추출 - MRI진단여부 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS06,4,1), '1', 'Y', '0', 'N') ETC_DGNS_YN /* 연산추출 - 기타진단여부 */
       , MEDNNCDT.CONTS07                                    TH1_LST_DGNS_MTHD_CNTE /* 단순복사 - 1번째최종진단방법내용 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS05,2,1), '1', 'Y', '0', 'N') TH2_LST_DGNS_YN /* 연산추출 - 2번째최종진단여부 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS05,3,1), '1', 'Y', '0', 'N') TH3_LST_DGNS_YN /* 연산추출 - 3번째최종진단여부 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS05,4,1), '1', 'Y', '0', 'N') TH4_LST_DGNS_YN /* 연산추출 - 4번째최종진단여부 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS05,5,1), '1', 'Y', '0', 'N') TH5_LST_DGNS_YN /* 연산추출 - 5번째최종진단여부 */
       , NULL                                                TH5_LST_DGNS_MTHD_CNTE /* 전환제외 - 5번째최종진단방법내용 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS05,6,1), '1', 'Y', '0', 'N') TH6_LST_DGNS_YN /* 연산추출 - 6번째최종진단여부 */
       , NULL                                                TH6_LST_DGNS_ETC_EXM_CD /* 전환제외 - 6번째최종진단기타검사코드 */
       , NULL                                                TH6_LST_DGNS_MTHD_CNTE /* 전환제외 - 6번째최종진단방법내용 */
       , DECODE(SUBSTR(MEDNNCDT.CONTS05,7,1), '1', 'Y', '0', 'N') TH7_LST_DGNS_YN /* 연산추출 - 7번째최종진단여부 */
       , MEDNNCDT.CONTS08                                    TH7_LST_DGNS_MTHD_CNTE /* 단순복사 - 7번째최종진단방법내용 */
       , NVL(APREGHVT_NEWT.REQ_DTE,TRUNC(APREGHVT_NEWT.FSTINST_DTM)) APFR_WRT_DT /* 연산추출 - 신청서작성일자 */
       , '서울시보라매병원'                                          RCORG_NM /* 특정값 - 요양기관명 */
       , '11100249'                                          RCORG_NO /* 특정값 - 요양기관번호 */
       , APREGHVT_NEWT.ASDR_STF_NO                           ASDR_STF_NO /* 단순복사 - 담당의직원번호 */
       , MEDNNCDT.DR_NM                                      ASDR_NM /* 단순복사 - 담당의명 */
       , MEDNNCDT.LIC_NO                                     ASDR_LCNS_NO /* 단순복사 - 담당의면허번호 */
       , APREGHVT_NEWT.CRT_DTE                               FST_WRT_DT /* 단순복사 - 최초작성일자 */
       , APREGHVT_NEWT.PACT_TP_CD                            PACT_TP_CD /* 단순복사 - 원무접수구분코드 */
       , TO_DATE(MEDNNCDT.INHSP_DTE,'YYYY-MM-DD')            ADS_DT /* 연산추출 - 입원일자 */
       , APRGIMGT_SIGN1.SIGN_CHAR                            SRIL_APCT_SGNT_CNTE /* 단순복사 - 중증신청인서명내용 */
       ,  DECODE(APREGHVT_NEWT.CALL_TYP,'1','S'
                                    ,'2','E'
                                    ,'9','S'
                                        , NULL) SRIL_RTNC_MTHD_CD /* 연산추출 - 중증결과통보방법코드 */
       , NVL2(APREGHVT_NEWT.CNCL_DTE,'N','Y')                SRIL_APLC_CCRC_YN /* 연산추출 - 중증신청동의여부 */
       , CASE WHEN CONTS22='V193V193'  THEN 'V193' ELSE  CONTS22 END CFSC_CD /* 연산추출 - 산정특례코드 */
       , APPATBAT.ZIP_NO                                     HMPS_POST_NO /* 단순복사 - 수진자우편번호 */
       , TO_NUMBER(APPATBAT.ZIP_SEQ)                         HMPS_POST_NO_SEQ /* 연산추출 - 수진자우편번호순번 */
       , '3'                                                 ADDR_VER_CTRA_CD /* 특정값 - 주소버전기준코드 */
       , NVL2(APMATCMT.SI_DO_NM,APMATCMT.SI_DO_NM
           || NVL2(APMATCMT.SI_GUN_GU_NM,' ' || APMATCMT.SI_GUN_GU_NM,'')
           || ' '
           || NVL2(APMATCMT.LAW_RI_NM, NVL2(APMATCMT.LAW_EUP_NM, APMATCMT.LAW_EUP_NM || ' ' ,'') ,'')
           || APMATCMT.ROAD_NM
           || ' '
           || APMATCMT.BLD_MAIN
           || DECODE(APMATCMT.BLD_SUB,'0','', '-' || APMATCMT.BLD_SUB)
           || ' ('
           || NVL(APMATCMT.LAW_RI_NM, APMATCMT.LAW_EUP_NM)  --NULL값이 없어 따로 처리 안함...
           || CASE WHEN COALESCE(APMATCMT.SIGUN_BLD_NM, APMATCMT.DOC_BLD_NM, APMATCMT.SANG_BLD_NM) IS NULL THEN ')'
                   ELSE ', ' || COALESCE(APMATCMT.SIGUN_BLD_NM, APMATCMT.DOC_BLD_NM, APMATCMT.SANG_BLD_NM) || ')'
           END,NULL) HMPS_ADDR /* 연산추출 - 수진자주소 */
       , APREGHVT_NEWT.TEL_NO                                HMPS_TEL_NO /* 단순복사 - 수진자전화번호 */
       , RPAD(CASE WHEN APREGHVT_NEWT.CALL_TYP = '2' THEN NVL(APREGHVT_NEWT.EMAIL,' ') ELSE ' ' END,40,' ')  EMAL_ADDR /* 연산추출 - 이메일주소 */
       , NULL                                                RRNS_OBST_RREG_YN /* 전환제외 - 희귀난치재등록여부 */
       , 1                                                   TH1_REG_SEQ /* 특정값 - 1번째등록순번 */
       , 1                                                   TH2_REG_SEQ /* 특정값 - 2번째등록순번 */
       , (SELECT AS_DP_CD
          FROM ASIS_HCOM.CCDEPART CCDEPART
         WHERE CCDEPART.DEPT_CD = APREGHVT_NEWT.DEPT_CD
           AND CCDEPART.HSP_CLS = '7'
           AND ROWNUM =1) HIRA_MED_SBJT_CD /* 연산추출 - 심평원진료과목코드 */
       , NULL                                                SMFL_LDAT_CNTE /* 전환제외 - 샘파일자료내용 */
       , NULL                                                RMK_CNTE /* 전환제외 - 비고내용 */
       , APREGHVT_NEWT.CNCL_DTE                              SRIL_APLC_CNCL_DTM /* 단순복사 - 중증신청취소일시 */
       , APREGHVT_NEWT.CNCL_ID                               SRIL_APLC_CNCL_STF_NO /* 단순복사 - 중증신청취소직원번호 */
       , NVL2(APREGHVT_NEWT.CNCL_DTE,'99',NULL)              SRIL_APLC_CNCL_RSN_CD /* 연산추출 - 중증신청취소사유코드 */
       , NVL(TRUNC(APREGHVT_NEWT.CRT_DTE),	REQ_DTE)          APY_STR_DT /* 연산추출 - 적용시작일자 */
       , CASE WHEN APREGHVT_NEWT.CNCL_DTE IS NOT NULL
            THEN APREGHVT_NEWT.CNCL_DTE
            WHEN APREGHVT_NEWT.INS_TO_DTE IS NOT NULL
            THEN APREGHVT_NEWT.INS_TO_DTE
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD <> '09'
            THEN NVL(TRUNC(APREGHVT_NEWT.CRT_DTE),TRUNC(APREGHVT_NEWT.FSTINST_DTM)) + (5*365)
            ELSE NVL(TRUNC(APREGHVT_NEWT.CRT_DTE),TRUNC(APREGHVT_NEWT.FSTINST_DTM)) + (365)
            END APY_END_DT /* 연산추출 - 적용종료일자 */
       , APREGHVT_NEWT.EDI_RSLT_CD                           SRIL_APLC_SNBK_CD_CNTE /* 단순복사 - 중증신청반송코드내용 */
       , APREGHVT_NEWT.EDI_RSLT_MSG                          SRIL_APLC_SNBK_MSG_CNTE /* 단순복사 - 중증신청반송메시지내용 */
       , NULL                                                MDFM_UDP_YN /* 전환제외 - 진료서식갱신여부 */
       , 'N'                                                 DUP_SKNS_YN /* 특정값 - 중복상병여부 */
       , 'N'                                                 PSNY_PTBD_AMT_EXMT_YN /* 특정값 - 본인부분부담금액면제여부 */
       , PETRA.pls_encrypt_b64_id(  APPATBAT.SSN1  || substr(APPATBAT.SSN2,1,1) ||   SCP.DEC_STR('CRT1',SUBSTR( APPATBAT.SSN2 ,2,40))  ,800)
 HSHR_RRN /* 연산추출 - 세대주주민등록번호 */
       , APMATCMT.LAW_DONG_CD                                STTT_DONG_CD /* 단순복사 - 법정동코드 */
       , APMATCMT.SAN_YN                                     MTN_YN /* 단순복사 - 산여부 */
       , TO_CHAR(APMATCMT.JIBUN_MAIN)                        MAIN_LTNR /* 연산추출 - 지번본번 */
       , TO_CHAR(APMATCMT.JIBUN_SUB)                         SUB_LTNR /* 연산추출 - 지번부번 */
       , APPATBAT.BUILDING_NO                                BLDG_MGMT_NO /* 단순복사 - 건물관리번호 */
       , NULL                                                SKNS_REG_MDF_DTM /* 전환제외 - 상병등록수정일시 */
       , NULL                                                BOBD_PT_NO /* 전환제외 - 합본이전환자번호 */
       , NULL                                                BIND_DTM /* 전환제외 - 합본일시 */
       , NULL                                                BIND_STF_NO /* 전환제외 - 합본직원번호 */
       , NVL(APREGHVT_NEWT.FSTINST_ID,'MIG00')               FSR_STF_NO /* 연산추출 - 최초등록직원번호 */
       , NVL(APREGHVT_NEWT.FSTINST_DTM,TO_DATE('20240907','YYYYMMDD'))    FSR_DTM /* 연산추출 - 최초등록일시 */
       , 'MIG ETL'                               FSR_PRGM_NM /* 특정값 - 최초등록프로그램명 */
       , '0.0.0.0'                               FSR_IP_ADDR /* 특정값 - 최초등록IP주소 */
       , NVL(APREGHVT_NEWT.EDIT_ID,'MIG00')                  LSH_STF_NO /* 연산추출 - 최종변경직원번호 */
       , NVL(APREGHVT_NEWT.EDIT_DTE,TO_DATE('20240907','YYYYMMDD'))       LSH_DTM /* 연산추출 - 최종변경일시 */
       , 'MIG ETL'                               LSH_PRGM_NM /* 특정값 - 최종변경프로그램명 */
       , '0.0.0.0'                               LSH_IP_ADDR /* 특정값 - 최종변경IP주소 */
       , NULL                                                PRBY_APFR_TP_CD /* 전환제외 - 조산아신청서구분코드 */
       , NULL                                                PRBY_APFR_TP_RMK_CNTE /* 전환제외 - 조산아신청서구분비고내용 */
       , NULL                                                PRBY_APFR_CHG_APLC_TP_CD /* 전환제외 - 조산아신청서변경신청구분코드 */
       , NULL                                                PRBY_APFR_CHG_CNTE /* 전환제외 - 조산아신청서변경내용 */
       , NULL                                                PRBY_APFR_BGCHG_CNTE /* 전환제외 - 조산아신청서변경이전내용 */
       , NULL                                                PRBY_APFR_AFCHG_CNTE /* 전환제외 - 조산아신청서변경이후내용 */
       , NULL                                                NWBN_FTHR_NM /* 전환제외 - 신생아부친명 */
       , NULL                                                NWBN_MTHR_NM /* 전환제외 - 신생아모친명 */
       , NULL                                                BRTH_DT /* 전환제외 - 출생일자 */
       , NULL                                                PRGN_PRD_CNTE /* 전환제외 - 임신기간내용 */
       , NULL                                                BDWT_CNTE /* 전환제외 - 체중내용 */
       , APREGHVT_NEWT.TEL_NO                                APCT_MBL_TEL_NO /* 단순복사 - 신청인휴대전화번호 */
       , 'N'                                                 SMS_RCV_CCRC_YN /* 특정값 - SMS수신동의여부 */
       , decode(MEDNNCDT.conts35,'3','Y','4','Y','N')
       DUP_CNCR_YN /* 특정값 - 중복암여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(SUBSTR(MEDNNCDT.CONTS18,1,1), '1', 'Y', '0', 'N')
            END
 TH1_CFSC_LST_DGNS_YN /* 연산추출 - 1번째산정특례최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(SUBSTR(MEDNNCDT.CONTS19,5,1), '1', 'Y', '0', 'N')
            END
 TH2_CFSC_LST_DGNS_YN /* 연산추출 - 2번째산정특례최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(SUBSTR(MEDNNCDT.CONTS19,2,1), '1', 'Y', '0', 'N')
            END
 TH3_CFSC_LST_DGNS_YN /* 연산추출 - 3번째산정특례최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(SUBSTR(MEDNNCDT.CONTS19,1,1), '1', 'Y', '0', 'N')
            END
 TH4_CFSC_LST_DGNS_YN /* 연산추출 - 4번째산정특례최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(SUBSTR(MEDNNCDT.CONTS19,3,1), '1', 'Y', '0', 'N')
            END
 TH5_CFSC_LST_DGNS_YN /* 연산추출 - 5번째산정특례최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(SUBSTR(MEDNNCDT.CONTS19,4,1), '1', 'Y', '0', 'N')
            END TH6_CFSC_LST_DGNS_YN /* 연산추출 - 6번째산정특례최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN MEDNNCDT.CONTS20
            END TH6_CFSC_LST_DGNS_MTHD_CNTE /* 연산추출 - 6번째산정특례최종진단방법내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr( MEDNNCDT.conts18,2,1), '1', 'Y', '0', 'N')
            END CFSC_SPBIO_YN /* 연산추출 - 산정특례특수생화학여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr( MEDNNCDT.conts18,3,1), '1', 'Y', '0', 'N')
            END  CFSC_GNTC_EXM_YN /* 연산추출 - 산정특례유전학검사여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr( MEDNNCDT.conts18,4,1), '1', 'Y', '0', 'N')
            END CFSC_HSTL_EXM_YN /* 연산추출 - 산정특례조직학검사여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD') AND NVL(MEDNNCDT.CONTS21,'*') != '*'
              THEN 'Y'
              WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
              THEN 'N'
              END CFSC_COPN_YN /* 연산추출 - 산정특례임상소견여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
              THEN  MEDNNCDT.CONTS21
              END CFSC_COPN_CNTE /* 연산추출 - 산정특례임상소견내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
              THEN DECODE(substr(MEDNNCDT.conts18,6,1), '1', 'Y', '0', 'N')
              END CFSC_ETC_YN /* 연산추출 - 산정특례기타여부 */
       ,  case when substr(MEDNNCDT.conts18,6,1) = 1 then nvl(MEDNNCDT.conts31,' ') else '  ' end CFSC_ETC_CNTE /* 연산추출 - 산정특례기타내용 */
       , NULL                                                CFSC_PT_OPNN_CNTE /* 전환제외 - 산정특례환자소견내용 */
       ,  CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS18,8,1),'1','Y','N')        -- 변경
            END  CFSC_DISS_INF_FAMH_YN /* 연산추출 - 산정특례질병정보가족력여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
              THEN DECODE(substr(MEDNNCDT.CONTS36,1,1),'1','Y','N')        -- 변경
              END CFSC_FAMH_GFT_YN /* 연산추출 - 산정특례가족력조부여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
              THEN DECODE(substr(MEDNNCDT.CONTS36,2,1),'1','Y','N')       -- 변경
              END CFSC_FAMH_GMT_YN /* 연산추출 - 산정특례가족력조모여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,3,1),'1','Y','N')          -- 변경
            END CFSC_FAMH_MGF_YN /* 연산추출 - 산정특례가족력외조부여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,4,1),'1','Y','N')
            END CFSC_FAMH_MGM_YN /* 연산추출 - 산정특례가족력외조모여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,5,1),'1','Y','N')
            END CFSC_FAMH_FTHR_YN /* 연산추출 - 산정특례가족력부친여부 */
       ,  CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,6,1),'1','Y','N')
            END  CFSC_FAMH_MTHR_YN /* 연산추출 - 산정특례가족력모친여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,7,1),'1','Y','N')
            END CFSC_FAMH_BRTR_YN /* 연산추출 - 산정특례가족력형제여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,8,1),'1','Y','N')
            END CFSC_FAMH_SSTS_YN /* 연산추출 - 산정특례가족력자매여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,9,1),'1','Y','N')
            END CFSC_FAMH_MALE_CHLR_YN /* 연산추출 - 산정특례가족력남자자녀여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
            THEN DECODE(substr(MEDNNCDT.CONTS36,10,1),'1','Y','N')
            END CFSC_FAMH_FEML_CHLR_YN /* 연산추출 - 산정특례가족력여자자녀여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TB','TC','09')
              THEN  MEDNNCDT.CONTS20
              WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('23','21','SD')
              THEN MEDNNCDT.CONTS37
              ELSE NVL(MEDNNCDT.CONTS26,' ')
              END  SPCT_QF_NO /* 연산추출 - 전문의자격번호 */
       , MEDNNCDT.CONTS04                                    DR_SPLT_SBJT_NM /* 단순복사 - 의사전문과목명 */
       , NULL                                                DR_SPLT_SBJT_CD /* 전환제외 - 의사전문과목코드 */
       , decode(MEDNNCDT.conts35,'2','Y','4','Y','N')        CFSC_RREG_YN /* 특정값 - 산정특례재등록여부 */
       , DECODE(APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD,'J3',DECODE(MEDNNCDT.CONTS17,'1','Y','2','N',NULL)) CNCR_DGNS_TOPO_YN /* 연산추출 - 암진단원발부위여부 */
       , DECODE(APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD,'J3',DECODE(MEDNNCDT.CONTS17,'2','Y','1','N',NULL)) CNCR_DGNS_MTST_YN /* 연산추출 - 암진단전이여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS05,1,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH1_CNCR_HSTL_EXM_YN /* 연산추출 - 1번째암조직학검사여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS05,2,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH2_CNCR_HSTL_EXM_YN /* 연산추출 - 2번째암조직학검사여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS06,1,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH3_CNCR_LST_DGNS_YN /* 연산추출 - 3번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS06,2,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH4_CNCR_LST_DGNS_YN /* 연산추출 - 4번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS06,2,1) ='1'
            THEN rpad(replace(replace(replace(nvl(MEDNNCDT.conts07,' '),chr(13),' '),chr(10),' '),'''',' '),80,' ')
            END TH4_CNCR_LST_DGNS_CNTE /* 연산추출 - 4번째암최종진단내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS06,3,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH5_CNCR_LST_DGNS_YN /* 연산추출 - 5번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS06,4,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH6_CNCR_LST_DGNS_YN /* 연산추출 - 6번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS06,4,1) ='1'
            THEN rpad(replace(replace(Replace(nvl(MEDNNCDT.conts08,' '),chr(13),' '),chr(10),' '),'''',' '),80,' ')
            END TH6_CNCR_LST_DGNS_CNTE /* 연산추출 - 6번째암최종진단내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS18,1,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH7_CNCR_LST_DGNS_YN /* 연산추출 - 7번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS18,2,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH8_CNCR_LST_DGNS_YN /* 연산추출 - 8번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS18,3,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH9_CNCR_LST_DGNS_YN /* 연산추출 - 9번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS05,5,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH10_CNCR_LST_DGNS_YN /* 연산추출 - 10번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS05,6,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH11_CNCR_LST_DGNS_YN /* 연산추출 - 11번째암최종진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND SUBSTR(MEDNNCDT.CONTS05,6,1) = '1'
            THEN NVL(MEDNNCDT.CONTS31,' ')
             END TH11_CNCR_LST_DGNS_CNTE /* 연산추출 - 11번째암최종진단내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS19,1,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH1_CNCR_HSTL_YN /* 연산추출 - 1번째암조직학여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS19,2,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END  TH2_CNCR_HSTL_YN /* 연산추출 - 2번째암조직학여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS19,3,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH3_CNCR_HSTL_YN /* 연산추출 - 3번째암조직학여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS19,4,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH4_CNCR_HSTL_YN /* 연산추출 - 4번째암조직학여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS19,5,1) ='1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN 'N'
            END TH5_CNCR_HSTL_YN /* 연산추출 - 5번째암조직학여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3' AND substr(MEDNNCDT.CONTS19,5,1) ='1'
            THEN rpad(replace(replace(replace(nvl(MEDNNCDT.conts20,' '),chr(13),' '),chr(10),' '),'''',' '),120,' ')
            END  TH5_CNCR_HSTL_CNTE /* 연산추출 - 5번째암조직학내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'J3'
            THEN rpad(replace(replace(replace(nvl(MEDNNCDT.CONTS21,' '),chr(13),' '),chr(10),' '),'''',' '),400,' ')
            END TH6_CNCR_HSTL_CNTE /* 연산추출 - 6번째암조직학내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS06,1,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS06,1,1),'0') = '0'
            THEN 'N'
            END
 TH1_TB_DGNS_YN /* 연산추출 - 1번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS06,2,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS06,2,1),'0') = '0'
            THEN 'N'
            END TH2_TB_DGNS_YN /* 연산추출 - 2번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS06,3,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS06,3,1),'0') = '0'
            THEN 'N'
            END TH3_TB_DGNS_YN /* 연산추출 - 3번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS06,4,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS06,4,1),'0') = '0'
            THEN 'N'
            END TH4_TB_DGNS_YN /* 연산추출 - 4번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS06,5,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS06,5,1),'0') = '0'
            THEN 'N'
            END TH5_TB_DGNS_YN /* 연산추출 - 5번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS06,5,1) = '1'
            THEN rpad(replace(replace(replace(nvl(MEDNNCDT.conts07,' '),chr(13),' '),chr(10),' '),'''',' '),80,' ')
            END TH5_TB_DGNS_CNTE /* 연산추출 - 5번째결핵진단내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09')AND substr(MEDNNCDT.CONTS17,1,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS17,1,1),'0') = '0'
            THEN 'N'
            END
 TH6_TB_DGNS_YN /* 연산추출 - 6번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS17,2,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS17,2,1),'0') = '0'
            THEN 'N'
            END TH7_TB_DGNS_YN /* 연산추출 - 7번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS05,3,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.conts15,3,1),'0') = '0'
            THEN 'N'
            END TH8_TB_DGNS_YN /* 연산추출 - 8번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS05,4,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS05,4,1),'0') = '0'
            THEN 'N'
            END TH9_TB_DGNS_YN /* 연산추출 - 9번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS05,4,1) = '1'
            THEN rpad(replace(replace(replace(nvl(MEDNNCDT.conts08,' '),chr(13),' '),chr(10),' '),'''',' '),80,' ')
            END TH9_TB_DGNS_CNTE /* 연산추출 - 9번째결핵진단내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS05,5,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND NVL(substr(MEDNNCDT.CONTS05,5,1),'0') = '0'
            THEN 'N' END TH10_TB_DGNS_YN /* 연산추출 - 10번째결핵진단여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC','09') AND substr(MEDNNCDT.CONTS05,5,1) = '1'
            THEN MEDNNCDT.conts31
            END TH10_TB_DGNS_CNTE /* 연산추출 - 10번째결핵진단내용 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC') AND substr(MEDNNCDT.conts18,2,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC')
            THEN 'N'
            END  TB_OTHSP_EXRS_YN /* 연산추출 - 결핵타병원검사결과여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC') AND substr(MEDNNCDT.CONTS19,1,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC')
            THEN 'N'
            END TB_OTHSP_PCTR_EXRS_YN /* 연산추출 - 결핵타병원영상검사결과여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC') AND substr(MEDNNCDT.CONTS19,2,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC')
            THEN 'N'
            END TB_OTHSP_SMER_INCB_EXRS_YN /* 연산추출 - 결핵타병원도말배양검사결과여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC') AND substr(MEDNNCDT.CONTS19,3,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC')
            THEN 'N'
            END TB_OTHSP_HSTL_EXRS_YN /* 연산추출 - 결핵타병원조직학검사결과여부 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC') AND substr(MEDNNCDT.CONTS19,4,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD IN ('TC')
            THEN 'N'
            END TB_OTHSP_ETC_EXRS_YN /* 연산추출 - 결핵타병원기타검사결과여부 */
       , NULL                                                ISSU_RCORG_NO /* 전환제외 - 발급요양기관번호 */
       , NULL                                                PRBY_APFR_MEMB_TP_CD /* 전환제외 - 조산아신청서다태아구분코드 */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS05,1,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH1_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS05,2,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH2_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS05,3,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH3_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS05,4,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH4_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS05,5,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH5_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS05,6,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH6_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS06,1,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH61_LT_DGNS_YN /* 연산추출 -  */
       , CASE WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT' AND substr(MEDNNCDT.CONTS06,2,1) = '1'
            THEN 'Y'
            WHEN APREGHVT_NEWT.SRIL_CDOC_APLC_TP_CD = 'LT'
            THEN 'N'
            END TH62_LT_DGNS_YN /* 연산추출 -  */
  FROM ( SELECT /*+ use_hash(MEDRNMAT) use_hash(APREGHVT_NEWT) */  APREGHVT_NEWT.*
              , nvl(APREGHVT_NEWT.REG_NO,APINSSPT.REG_NO) AS INS_REG_NO
              , NVL(CASE WHEN APREGHVT_NEWT.REQ_TYP = '1'
                         THEN 'J3' -- 중증암
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y'      -- 중증치매여부
                         THEN 'SD' -- 중증치매
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y'      -- 난치여부
                         THEN '23' -- 중증난치질환
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N'
                         THEN '21' -- 희귀질환
                         WHEN APREGHVT_NEWT.REQ_TYP = '6'
                         THEN 'TC' -- 결핵
                         WHEN APREGHVT_NEWT.REQ_TYP = '7'
                         THEN '09' -- 중증화상
                         WHEN APREGHVT_NEWT.REQ_TYP = '16'
                         THEN 'LT' -- 잠복결핵
                         WHEN APREGHVT_NEWT.REQ_TYP = '9'
                         THEN 'J3' -- 중증암(+희귀난치 인데 작업어케해야할지 모르겠음, 전산팀에 물어보자)
                         END,'J3') AS SRIL_CDOC_APLC_TP_CD       -- 003. 중증확인증신청구분코드
                    ,DECODE(SUBSTR(NVL(APINSSPT.PATTYPE,'*'),1,1),'B','BB','E','EE', MEDRNMAT.CFSC_KND_CD) CFSC_KND_CD
                    ,MEDRNMAT.DEPT_CD            AS DEPT_CD
                    ,MEDRNMAT.WK_ID              AS ASDR_STF_NO
                    ,MEDRNMAT.PACT_TP_CD         AS PACT_TP_CD
                    ,MEDRNMAT.CRT_DTE            AS CRT_DTE
                    ,ROW_NUMBER() OVER(PARTITION BY  APREGHVT_NEWT.PT_NO, APREGHVT_NEWT.DOC_NOTE_ID,APREGHVT_NEWT.RLS_NO  ORDER BY ABS(APREGHVT_NEWT.REQ_DTE - APINSSPT.APPR_DTE) )   AS PRIORITY_SEQ
                    ,APINSSPT.INS_TO_DTE         AS INS_TO_DTE
        FROM ASIS_HBIL.APREGHVT_NEWT APREGHVT_NEWT
           ,(SELECT /*+ INDEX(MEDRNMAT MEDRNMAT_SI06) */   CASE WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('458','459') THEN 'Y'       -- 난치 산정특례
                               WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('456','457','187','213','214') THEN 'N'  -- 희귀 산정특례
                               END                          AS INCURABLE_YN
                        , MEDRNMAT.DOC_NOTE_ID              AS DOC_NOTE_ID
                        , MEDRNMAT.RLS_NO                   AS RLS_NO
                       , DECODE (MEDRNMAT.DOCNOTE_TYP_ID
                                 , '185', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                 , '186', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                 , '187', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                 , '358', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                 , '442', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증치매)
                                 , '456', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                 , '458', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(난치)
                                 , '464', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                 , '465', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                 , '466', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                 , '551', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(잠복결핵)
                                 , '203', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                 , '211', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(중증)
                                 , '212', 'EE'                                                                                                                                                                                      -- 의료급여 산정특례 신청서(중증화상)
                                 , '213', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                 , '214', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 신청서(중증/희귀)
                                 , '359', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                 , '457', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                 , '459', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(난치)
                                 , '467', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(중증)
                                 , '468', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                 , '469', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                              )         AS CFSC_KND_CD
                         , DECODE(DOCNOTE_TYP_ID,'442' ,'Y'
                                               ,'456' ,'N'
                                               ,'458' ,'N')  AS IS_ALZHEIMER
                        , MEDRNMAT.DEPT_CD                  AS DEPT_CD
                        , MEDRNMAT.WK_ID                    AS WK_ID
                        , MEDRNMAT.PT_SECT                  AS PACT_TP_CD
                        , TRUNC(MEDRNMAT.CRT_DTE)           AS CRT_DTE
                        , MEDRNMAT.PT_NO                          AS PT_NO
                     FROM ASIS_HEMR.MEDRNMAT MEDRNMAT -- 중증치매 기록지
                   ---치매---
                    WHERE MEDRNMAT.DOCNOTE_TYP_ID IN (  '185'
                                                      , '186'
                                                      , '187'
                                                      , '358'
                                                      , '442'
                                                      , '456'
                                                      , '458'
                                                      , '464'
                                                      , '465'
                                                      , '466'
                                                      , '551'
                                                      , '203'
                                                      , '211'
                                                      , '212'
                                                      , '213'
                                                      , '214'
                                                      , '359'
                                                      , '457'
                                                      , '459'
                                                      , '467'
                                                      , '468'
                                                      , '469'
                                                     )
                                       ) MEDRNMAT
                    ,(SELECT APINSSPT.PT_NO
                           , APINSSPT.SP_QU_TYP
                           , APINSSPT.REG_NO
      , APINSSPT.PATTYPE
                           , MIN(APINSSPT.APPR_DTE)   APPR_DTE
                           , MAX(APINSSPT.TO_DTE)     INS_TO_DTE
                        FROM ASIS_HBIL.APINSSPT  APINSSPT
                       WHERE APINSSPT.SP_QU_TYP IN ('G','S','X','H','Q','R','W','U')
                         AND APINSSPT.REG_NO IS NOT NULL
                       GROUP BY APINSSPT.PT_NO
                              , APINSSPT.SP_QU_TYP
                              , APINSSPT.REG_NO
  , APINSSPT.PATTYPE
                     )APINSSPT
      WHERE APREGHVT_NEWT.REQ_TYP NOT IN('98','99')
        AND APREGHVT_NEWT.REQ_TYP IS NOT NULL
        AND APREGHVT_NEWT.DOC_NOTE_ID = MEDRNMAT.DOC_NOTE_ID
        AND APREGHVT_NEWT.RLS_NO = MEDRNMAT.RLS_NO
        AND APREGHVT_NEWT.PT_NO = MEDRNMAT.PT_NO
     AND APINSSPT.REG_NO(+)     IS NOT NULL
        AND  APINSSPT.PT_NO(+)=APREGHVT_NEWT.PT_NO
        AND  APINSSPT.REG_NO(+)=APREGHVT_NEWT.REG_NO
        AND CASE WHEN APINSSPT.SP_QU_TYP(+) IN ('G')             AND APREGHVT_NEWT.REQ_TYP IN ('1','9') THEN 'Y'  --중증암
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('S')             AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y' THEN 'Y'  --중증치매
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('X')             AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y' THEN 'Y'  --중증난치
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('H','Q','R','X') AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N' THEN 'Y'  --중증희귀
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('W')             AND APREGHVT_NEWT.REQ_TYP = '6' THEN 'Y'  --결핵
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('U')             AND APREGHVT_NEWT.REQ_TYP = '16' THEN 'Y'  --잠복결핵
                 ELSE 'N'
                 END ='Y') APREGHVT_NEWT
   LEFT OUTER JOIN  ASIS_HBIL.APRGIMGT APRGIMGT_SIGN1 on APREGHVT_NEWT.SIGNSTR = APRGIMGT_SIGN1.SIGN_NO
   LEFT OUTER JOIN  ((SELECT MEDNNCDT.*
            , MEDNNPDT.DZ_NM
            , MEDNNPDT.DZ_NO
            , MEDNNPDT.DR_NM
            , MEDNNPDT.LIC_NO
            , MEDNNPDT.INHSP_DTE
         FROM ASIS_HEMR.MEDNNCDT MEDNNCDT
            , ASIS_HEMR.MEDNNPDT MEDNNPDT
        WHERE MEDNNPDT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID(+)
          AND MEDNNPDT.RLS_NO = MEDNNCDT.RLS_NO(+)
        )) MEDNNCDT on APREGHVT_NEWT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID
   AND APREGHVT_NEWT.RLS_NO = MEDNNCDT.RLS_NO
   LEFT OUTER JOIN  ASIS_HBIL.APPATBAT APPATBAT on APREGHVT_NEWT.PT_NO  = APPATBAT.PT_NO
   LEFT OUTER JOIN  ASIS_HCOM.APMATCMT APMATCMT on APPATBAT.BUILDING_NO = APMATCMT.BLD_NO
  LEFT OUTER JOIN MP_CODE mp1 ON COALESCE(mp1.ASIS_CODE,'*NULL VALUE*') = COALESCE(APREGHVT_NEWT.PAT_REL,'*NULL VALUE*')
         and UPPER(mp1.TOBE_TBL_NM) = 'ACPPRGHD'
         and UPPER(mp1.TOBE_COL_NM) = 'PT_REL_DTL_TP_CD'
         and mp1.DB_USER_ID IS NULL
         and UPPER(mp1.ASIS_TBL_NM) = 'APREGHVT_NEWT'
         and UPPER(mp1.ASIS_COL_NM) = 'PAT_REL'
 WHERE   PRIORITY_SEQ=1
 )
LOG ERRORS INTO MIGT.ERR$ACPPRGHD
REJECT LIMIT UNLIMITED
;







COMMIT;
























----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

          ;;;

SELECT

        NVL((SELECT CCCODEST.CSUBCD_NM
              FROM  CCCODEST
             WHERE CCCODEST.CCD_TYP = 'MC14'
               AND CCCODEST.C_CD = REPLACE(REPLACE(MEDNNCDT.DZ_NO, CHR(13), ''), CHR(10), ' ')
               AND CCCODEST.USE_YN = 'Y' AND ROWNUM=1),REPLACE(REPLACE(MEDNNCDT.DZ_NO, CHR(13),''),CHR(10),' ')) APLC_ICD10_CD_CNTE /* 연산추출 - 신청ICD10코드내용 */

  FROM (

  ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   SELECT /*+ use_hash(MEDRNMAT) use_hash(APREGHVT_NEWT) */  APREGHVT_NEWT.*
              , nvl(APREGHVT_NEWT.REG_NO,APINSSPT.REG_NO) AS INS_REG_NO
              , NVL(CASE WHEN APREGHVT_NEWT.REQ_TYP = '1'
                         THEN 'J3' -- 중증암
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y'      -- 중증치매여부
                         THEN 'SD' -- 중증치매
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y'      -- 난치여부
                         THEN '23' -- 중증난치질환
                         WHEN APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N'
                         THEN '21' -- 희귀질환
                         WHEN APREGHVT_NEWT.REQ_TYP = '6'
                         THEN 'TC' -- 결핵
                         WHEN APREGHVT_NEWT.REQ_TYP = '7'
                         THEN '09' -- 중증화상
                         WHEN APREGHVT_NEWT.REQ_TYP = '16'
                         THEN 'LT' -- 잠복결핵
                         WHEN APREGHVT_NEWT.REQ_TYP = '9'
                         THEN 'J3' -- 중증암(+희귀난치 인데 작업어케해야할지 모르겠음, 전산팀에 물어보자)
                         END,'J3') AS SRIL_CDOC_APLC_TP_CD       -- 003. 중증확인증신청구분코드
                    ,DECODE(SUBSTR(NVL(APINSSPT.PATTYPE,'*'),1,1),'B','BB','E','EE', MEDRNMAT.CFSC_KND_CD) CFSC_KND_CD
                    ,MEDRNMAT.DEPT_CD            AS DEPT_CD
                    ,MEDRNMAT.WK_ID              AS ASDR_STF_NO
                    ,MEDRNMAT.PACT_TP_CD         AS PACT_TP_CD
                    ,MEDRNMAT.CRT_DTE            AS CRT_DTE
                    ,ROW_NUMBER() OVER(PARTITION BY  APREGHVT_NEWT.PT_NO, APREGHVT_NEWT.DOC_NOTE_ID,APREGHVT_NEWT.RLS_NO  ORDER BY ABS(APREGHVT_NEWT.REQ_DTE - APINSSPT.APPR_DTE) )   AS PRIORITY_SEQ
                    ,APINSSPT.INS_TO_DTE         AS INS_TO_DTE
        FROM APREGHVT_NEWT APREGHVT_NEWT
           ,(


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

           SELECT /*+ INDEX(MEDRNMAT MEDRNMAT_SI06) */   CASE WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('458','459') THEN 'Y'       -- 난치 산정특례
                               WHEN MEDRNMAT.DOCNOTE_TYP_ID IN ('456','457','187','213','214') THEN 'N'  -- 희귀 산정특례
                               END                          AS INCURABLE_YN
                        , MEDRNMAT.DOC_NOTE_ID              AS DOC_NOTE_ID
                        , MEDRNMAT.RLS_NO                   AS RLS_NO
                       , DECODE (MEDRNMAT.DOCNOTE_TYP_ID
                                 , '185', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                 , '186', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                 , '187', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                 , '358', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                 , '442', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증치매)
                                 , '456', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(희귀)
                                 , '458', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(난치)
                                 , '464', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(중증)
                                 , '465', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(중증화상)
                                 , '466', 'BB'                                                                                                                                                                                     -- 건강보험 산정특례 등록 신청서(결핵)
                                 , '551', 'BB'                                                                                                                                                                                   -- 건강보험 산정특례 등록 신청서(잠복결핵)
                                 , '203', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                 , '211', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(중증)
                                 , '212', 'EE'                                                                                                                                                                                      -- 의료급여 산정특례 신청서(중증화상)
                                 , '213', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                 , '214', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 신청서(중증/희귀)
                                 , '359', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                 , '457', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(희귀)
                                 , '459', 'EE'                                                                                                                                                                                        -- 의료급여 산정특례 신청서(난치)
                                 , '467', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(중증)
                                 , '468', 'EE'                                                                                                                                                                                   -- 의료급여 산정특례 등록 신청서(중증화상)
                                 , '469', 'EE'                                                                                                                                                                                     -- 의료급여 산정특례 등록 신청서(결핵)
                                              )         AS CFSC_KND_CD
                         , DECODE(DOCNOTE_TYP_ID,'442' ,'Y'
                                               ,'456' ,'N'
                                               ,'458' ,'N')  AS IS_ALZHEIMER
                        , MEDRNMAT.DEPT_CD                  AS DEPT_CD
                        , MEDRNMAT.WK_ID                    AS WK_ID
                        , MEDRNMAT.PT_SECT                  AS PACT_TP_CD
                        , TRUNC(MEDRNMAT.CRT_DTE)           AS CRT_DTE
                        , MEDRNMAT.PT_NO                          AS PT_NO
                     FROM  MEDRNMAT -- 중증치매 기록지
                   ---치매---
                    WHERE MEDRNMAT.DOCNOTE_TYP_ID IN (  '185'
                                                      , '186'
                                                      , '187'
                                                      , '358'
                                                      , '442'
                                                      , '456'
                                                      , '458'
                                                      , '464'
                                                      , '465'
                                                      , '466'
                                                      , '551'
                                                      , '203'
                                                      , '211'
                                                      , '212'
                                                      , '213'
                                                      , '214'
                                                      , '359'
                                                      , '457'
                                                      , '459'
                                                      , '467'
                                                      , '468'
                                                      , '469'
                                                     )


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                                       ) MEDRNMAT

                    ,(

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                    SELECT APINSSPT.PT_NO
                           , APINSSPT.SP_QU_TYP
                           , APINSSPT.REG_NO
      , APINSSPT.PATTYPE
                           , MIN(APINSSPT.APPR_DTE)   APPR_DTE
                           , MAX(APINSSPT.TO_DTE)     INS_TO_DTE
                        FROM APINSSPT  APINSSPT
                       WHERE APINSSPT.SP_QU_TYP IN ('G','S','X','H','Q','R','W','U')
                         AND APINSSPT.REG_NO IS NOT NULL
                       GROUP BY APINSSPT.PT_NO
                              , APINSSPT.SP_QU_TYP
                              , APINSSPT.REG_NO
  , APINSSPT.PATTYPE



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

                     )APINSSPT
      WHERE APREGHVT_NEWT.REQ_TYP NOT IN('98','99')
        AND APREGHVT_NEWT.REQ_TYP IS NOT NULL
        AND APREGHVT_NEWT.DOC_NOTE_ID = MEDRNMAT.DOC_NOTE_ID
        AND APREGHVT_NEWT.RLS_NO = MEDRNMAT.RLS_NO
        AND APREGHVT_NEWT.PT_NO = MEDRNMAT.PT_NO
     AND APINSSPT.REG_NO(+)     IS NOT NULL
        AND  APINSSPT.PT_NO(+)=APREGHVT_NEWT.PT_NO
        AND  APINSSPT.REG_NO(+)=APREGHVT_NEWT.REG_NO
        AND CASE WHEN APINSSPT.SP_QU_TYP(+) IN ('G')             AND APREGHVT_NEWT.REQ_TYP IN ('1','9') THEN 'Y'  --중증암
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('S')             AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.IS_ALZHEIMER,'N') = 'Y' THEN 'Y'  --중증치매
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('X')             AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'Y' THEN 'Y'  --중증난치
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('H','Q','R','X') AND APREGHVT_NEWT.REQ_TYP = '5' AND NVL(MEDRNMAT.INCURABLE_YN,'N') = 'N' THEN 'Y'  --중증희귀
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('W')             AND APREGHVT_NEWT.REQ_TYP = '6' THEN 'Y'  --결핵
                 WHEN APINSSPT.SP_QU_TYP(+) IN ('U')             AND APREGHVT_NEWT.REQ_TYP = '16' THEN 'Y'  --잠복결핵
                 ELSE 'N'
                 END ='Y') APREGHVT_NEWT
   LEFT OUTER JOIN  APRGIMGT APRGIMGT_SIGN1 on APREGHVT_NEWT.SIGNSTR = APRGIMGT_SIGN1.SIGN_NO
   LEFT OUTER JOIN  ((

   ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   SELECT MEDNNCDT.*
            , MEDNNPDT.DZ_NM
            , MEDNNPDT.DZ_NO
            , MEDNNPDT.DR_NM
            , MEDNNPDT.LIC_NO
            , MEDNNPDT.INHSP_DTE
         FROM MEDNNCDT MEDNNCDT
            , MEDNNPDT MEDNNPDT
        WHERE MEDNNPDT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID(+)
          AND MEDNNPDT.RLS_NO = MEDNNCDT.RLS_NO(+)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

        )) MEDNNCDT on APREGHVT_NEWT.DOC_NOTE_ID = MEDNNCDT.DOC_NOTE_ID
   AND APREGHVT_NEWT.RLS_NO = MEDNNCDT.RLS_NO
   LEFT OUTER JOIN  APPATBAT APPATBAT on APREGHVT_NEWT.PT_NO  = APPATBAT.PT_NO
   LEFT OUTER JOIN  APMATCMT APMATCMT on APPATBAT.BUILDING_NO = APMATCMT.BLD_NO
  LEFT OUTER JOIN MP_CODE mp1 ON COALESCE(mp1.ASIS_CODE,'*NULL VALUE*') = COALESCE(APREGHVT_NEWT.PAT_REL,'*NULL VALUE*')
         and UPPER(mp1.TOBE_TBL_NM) = 'ACPPRGHD'
         and UPPER(mp1.TOBE_COL_NM) = 'PT_REL_DTL_TP_CD'
         and mp1.DB_USER_ID IS NULL
         and UPPER(mp1.ASIS_TBL_NM) = 'APREGHVT_NEWT'
         and UPPER(mp1.ASIS_COL_NM) = 'PAT_REL'
 WHERE   PRIORITY_SEQ=1

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 )
LOG ERRORS INTO MIGT.ERR$ACPPRGHD
REJECT LIMIT UNLIMITED

