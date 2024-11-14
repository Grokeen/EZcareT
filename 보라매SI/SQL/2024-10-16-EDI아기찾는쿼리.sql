


select SS_BHINPMY ,SS_BHINP_AMT from AIN0202T
--where SS_BHINPMY is not null
where SS_BHINP_AMT is not null
and rownum < 10;



SELECT SRIL_CFMT_NO,   A.* FROM ACPPRGhD A WHERE pt_no ='00184805';
SELECT SRIL_CFMT_NO,   A.* FROM ACPPRGhD A WHERE SRIL_CFMT_NO = '9999999999' and A.aplc_dt > '2024-09-07'; --pt_no ='01653660';
SELECT SRIL_CFMT_NO,   A.* FROM ACPPRGCD A WHERE pt_no ='01653660';



 SELECT CFSC_CD, A.* FROM ACPPRGHD A WHERE ROWNUM <10 ORDER BY LSH_DTM DESC;


EXEC :FROMDATE := '20240907';
EXEC :TODATE := '20241231';
EXEC :SENDFG := '0';     -- 0: 전체 / 1: 수신된 자료 제외
EXEC :IN_PT_NO := '';
EXEC :IN_PACT_TP_CD := '';

SELECT /*+ INDEX(ACPPRGHD APREGHVT_SI05) */ /* HIS.PA.AC.PI.PI.SELSERIOUSILLNESSAPPLICATIONFORMEDIREG1_1 */

       CCC AS "산정특례번호",
       PT_NO,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,

       -- 2024-10-30 김용록 : 중복 제거(C16, 확진일을 최근 일자로 가져오게 처리)
       MAX(C16) AS C16,C17,C18,C19,C20,C21,C22,C23,C24,C25,C26,C27,
       C28,C29,C30,C31,C32,C33,C34,C35,C36,C37,C38,C39,C40,C41,C42,
       C43,C44,C45,C46,C47,C48,C49,C50,C51,C52,C53,C54,C55,C56,
       MEDDEPT,SENDYN,SENDDATE,MSG,DOCTOR_NOTE_ID,AIDYN,DUP_CNCR_YN

FROM (

SELECT

 (SELECT SRIL_CFMT_NO FROM ACPPRGCD ABC WHERE A.MDRC_ID = ABC.MDRC_ID) AS CCC

,A.PT_NO PT_NO ,
replace ( A.HLTH_INSC_NO , '-' , '' ) C1 ,
CASE WHEN ASCII(UPPER(NVL ( A.HLTH_INS_ETPS_NM , ' ' ))) > 45217 THEN replace ( replace ( replace ( NVL ( A.HLTH_INS_ETPS_NM , ' ' ) , 'C' , '' ) , 'B' , '' ) , 'A' , '' )
     WHEN ASCII(UPPER(NVL ( A.HLTH_INS_ETPS_NM , ' ' ))) BETWEEN '65' AND '90' THEN NVL ( A.HLTH_INS_ETPS_NM , ' ' )
     ELSE NVL ( A.HLTH_INS_ETPS_NM , ' ' )
END AS C2 ,
/*
CASE WHEN ASCII(UPPER(B.PT_NM)) > 45217 THEN REPLACE ( REPLACE ( REPLACE ( B.PT_NM , 'C' , '' ) , 'B' , '' ) , 'A' , '' )
     WHEN ASCII(UPPER(B.PT_NM)) BETWEEN '65' AND '90' THEN B.PT_NM
     ELSE B.PT_NM
END AS C3 ,
*/
-- 2021.09.17 백명수 한글이름의 영문 들어가있는것과, 숫자 들어가있는것 제외 추가.. 외국인이름이 영문으로만 되어 있을수 있어서 체크로직 포함
CASE WHEN REGEXP_INSTR(B.PT_NM, '[가-힝]') > 0 AND REGEXP_INSTR(B.PT_NM, '[a-zA-Z]') > 0 THEN
                    REGEXP_REPLACE(B.PT_NM,'[0-9]|[a-zA-Z]')
          ELSE  REGEXP_REPLACE(B.PT_NM,'[0-9]')
END AS C3 ,
PLS_DECRYPT_B64_ID(B.PT_RRN, 800) C4,



-- 2024-09-23 김용록 : C5, C6 전화번호 공백 제거
REPLACE(NVL( XBIL.FT_TELNO_ADJUST ( A.HMPS_TEL_NO ) , XBIL.FT_TELNO_ADJUST ( F.MTEL_NO )),' ','' ) C5 ,
NVL  /* NVL1 시작 */
( REPLACE(DECODE /* DECODE1 시작 */
    ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.SMS_TEL_NO ) , 1 , 3 )
        , '010' , DECODE
                     ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 )
                         , '010' , ''
                         , '011' , ''
                         , '016' , ''
                         , '017' , ''
                         , '018' , ''
                         , '019' , ''
                         , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) )
        , '011' , DECODE
                     ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 )
                         , '010' , ''
                         , '011' , ''
                         , '016' , ''
                         , '017' , ''
                         , '018' , ''
                         , '019' , ''
                         , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) )

        , '016' , DECODE
                     ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 )
                         , '010' , ''
                         , '011' , ''
                         , '016' , ''
                         , '017' , ''
                         , '018' , ''
                         , '019' , ''
                         , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) )
        , '017' , DECODE
                     ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 ) ,
                           '010' , ''
                         , '011' , ''
                         , '016' , ''
                         , '017' , ''
                         , '018' , ''
                         , '019' , ''
                         , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) )
        , '018' ,  DECODE
                     ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 )
                         , '010' , ''
                         , '011' , ''
                         , '016' , ''
                         , '017' , ''
                         , '018' , ''
                         , '019' , ''
                         , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) )
        , '019' , DECODE
                     ( SUBSTR ( XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) , 1 , 3 )
                         , '010' , ''
                         , '011' , ''
                         , '016' , ''
                         , '017' , ''
                         , '018' , ''
                         , '019' , ''
                         , XBIL.FT_TELNO_ADJUST ( F.OHS_TEL_NO ) )
        , XBIL.FT_TELNO_ADJUST ( F.MTEL_NO ) ),' ','')  /* DECODE1 끝 */
    , REPLACE(NVL ( XBIL.FT_TELNO_ADJUST ( A.HMPS_TEL_NO ) , XBIL.FT_TELNO_ADJUST ( F.MTEL_NO ) ),' ','') ) /* NVL1 끝 */
C6,




NVL ( replace(A.HMPS_POST_NO, '-', ''), ' ' ) C7,
NVL
( TRIM
    ( NVL
        ( TRIM
            ( SUBSTR
                ( XBIL.FT_ACP_GET_ADDRESS
                    ( A.ADDR_VER_CTRA_CD
                        , A.HMPS_POST_NO
                        , A.HMPS_POST_NO_SEQ
                        , A.STTT_DONG_CD
                        , A.MTN_YN
                        , A.MAIN_LTNR
                        , A.SUB_LTNR
                        , A.BLDG_MGMT_NO
                        , ''
                        , ''
                    ) , 1 , INSTR
                    ( XBIL.FT_ACP_GET_ADDRESS
                        ( A.ADDR_VER_CTRA_CD
                            , A.HMPS_POST_NO
                            , A.HMPS_POST_NO_SEQ
                            , A.STTT_DONG_CD
                            , A.MTN_YN
                            , A.MAIN_LTNR
                            , A.SUB_LTNR
                            , A.BLDG_MGMT_NO
                            , ''
                            , ''
                        ) , '  ' )
                )
            ) , SUBSTR
            ( XBIL.FT_ACP_GET_ADDRESS
                ( F.BSC_ADDR_VER_CTRA_CD
                    , F.BSC_POST_NO
                    , F.BSC_POST_NO_SEQ
                    , F.BSC_STTT_DONG_CD
                    , F.BSC_MTN_YN
                    , F.BSC_MAIN_LTNR
                    , F.BSC_SUB_LTNR
                    , F.BSC_BLDG_MGMT_NO
                    , ''
                    , ''
                ) , 1 , INSTR
                ( XBIL.FT_ACP_GET_ADDRESS
                    ( F.BSC_ADDR_VER_CTRA_CD
                        , F.BSC_POST_NO
                        , F.BSC_POST_NO_SEQ
                        , F.BSC_STTT_DONG_CD
                        , F.BSC_MTN_YN
                        , F.BSC_MAIN_LTNR
                        , F.BSC_SUB_LTNR
                        , F.BSC_BLDG_MGMT_NO
                        , ''
                        , ''
                    ) , '  ' )
            )
        )
    ) , F.BSC_BSC_ADDR )
C8,
TRIM ( NVL ( A.HMPS_ADDR , F.BSC_DTL_ADDR ) ) C9,
NVL ( DECODE ( A.SRIL_RTNC_MTHD_CD , 'S' , '1' , 'M' , '2' ) , '1' ) C10,
DECODE ( A.SRIL_RTNC_MTHD_CD , 'S' , '' , A.EMAL_ADDR ) C11,
DECODE ( NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , '1' , 'SS' , '5' , 'SD' , '7' , '21', '2', '23', '8', 'SC', '2', '14', '9') C12,
DECODE ( A.SRIL_CDOC_APLC_TP_CD , 'J3' , 'N' , NVL ( A.RRNS_OBST_RREG_YN , 'N' ) ) C13,
NVL ( A.HIRA_MED_SBJT_CD , '01' ) C14,
DECODE ( A.PACT_TP_CD , 'I' , '1' , '2' ) C15,
LEAST( NVL ( TO_CHAR ( A.CNCR_DGNS_CFMT_DT , 'YYYYMMDD' ) , TO_CHAR ( A.APFR_WRT_DT , 'YYYYMMDD' ) ) , NVL ( TO_CHAR ( A.APFR_WRT_DT , 'YYYYMMDD' ) , '' ) ) C16,
DECODE ( NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , 'V193' , A.CFSC_CD ) C17,
DECODE
(
    NVL
    (
        DECODE
        (
            NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , XBIL.FT_GET_CANCER ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) ) ,
            CASE
                WHEN A.CFSC_CD IN ( 'V800' , 'V810' ) THEN SUBSTR ( XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD ) , 1 , 4 )
                ELSE XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
            END
        ) , ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) )
    ) , 'Z944'
    , A.CFSC_CD
    , 'N185'
    , A.CFSC_CD
    , 'N071'
    , A.CFSC_CD
    , 'N028'
    , A.CFSC_CD
    , NVL
    (
        DECODE
        (
            NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , XBIL.FT_GET_CANCER ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) ) ,
            CASE
                WHEN A.CFSC_CD IN ( 'V800' , 'V810' ) THEN SUBSTR ( XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD ) , 1 , 4 )
                ELSE XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
            END
        ) , ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) )
    )
)C18,
CASE
    WHEN LENGTH
    (
        CASE
            WHEN
            ( A.APLC_ICD10_DUP_SEQ_CD IS NULL OR A.APLC_ICD10_DUP_SEQ_CD = '0' OR A.APLC_ICD10_DUP_SEQ_CD = '1' OR A.APLC_ICD10_DUP_SEQ_CD = '00' )
            THEN '01'
            ELSE A.APLC_ICD10_DUP_SEQ_CD
        END
    ) = 1 THEN '0' ||
    (
        CASE
            WHEN
            ( A.APLC_ICD10_DUP_SEQ_CD IS NULL OR A.APLC_ICD10_DUP_SEQ_CD = '0' OR A.APLC_ICD10_DUP_SEQ_CD = '1' OR A.APLC_ICD10_DUP_SEQ_CD = '00' )
            THEN '01'
            ELSE A.APLC_ICD10_DUP_SEQ_CD
        END
    )
    ELSE
    (
        CASE
            WHEN
            ( A.APLC_ICD10_DUP_SEQ_CD IS NULL OR A.APLC_ICD10_DUP_SEQ_CD = '0' OR A.APLC_ICD10_DUP_SEQ_CD = '1' OR A.APLC_ICD10_DUP_SEQ_CD = '00' )
            THEN '01'
            ELSE A.APLC_ICD10_DUP_SEQ_CD
        END
    )
END
C19,
DECODE ( A.TH1_CFSC_LST_DGNS_YN , 'Y' , '1' , '0' ) C20 ,
DECODE ( A.TH2_CFSC_LST_DGNS_YN , 'Y' , '1' , '0' ) C21 ,
DECODE ( A.TH3_CFSC_LST_DGNS_YN , 'Y' , '1' , '0' ) C22 ,
DECODE ( A.TH4_CFSC_LST_DGNS_YN , 'Y' , '1' , '0' ) C23 ,
DECODE ( A.TH5_CFSC_LST_DGNS_YN , 'Y' , '1' , '0' ) C24 ,
DECODE ( A.TH6_CFSC_LST_DGNS_YN , 'Y' , '1' , '0' ) C25 ,
DECODE
( SUBSTR
( NVL
        ( DECODE ( NVL ( A.TH1_CFSC_LST_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
       || DECODE ( NVL ( A.TH2_CFSC_LST_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
       || DECODE ( NVL ( A.TH3_CFSC_LST_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
       || DECODE ( NVL ( A.TH4_CFSC_LST_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
       || DECODE ( NVL ( A.TH5_CFSC_LST_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
       || DECODE ( NVL ( A.TH6_CFSC_LST_DGNS_YN , 'N' ) , 'N' , '0' , '1' ) , '000000' ) , 6 , 1 ) , '1' , replace ( A.TH6_CFSC_LST_DGNS_MTHD_CNTE , '''' , '`' ) , '' )
C26,
DECODE ( A.CFSC_SPBIO_YN , 'Y' , '1' , '0' ) C27 ,
DECODE ( A.CFSC_GNTC_EXM_YN , 'Y' , '1' , '0' ) C28 ,
DECODE ( A.CFSC_HSTL_EXM_YN , 'Y' , '1' , '0' ) C29 ,
DECODE ( A.CFSC_COPN_YN , 'Y' , '1' , '0' ) C30 ,
replace ( replace ( DECODE ( A.CFSC_COPN_YN , 'Y' , replace ( A.CFSC_COPN_CNTE , '''' , '`' ) , '' ), CHR ( 13 ) , ' ' ) , CHR ( 10 ) , ' ' ) C31,
DECODE ( A.CFSC_ETC_YN , 'Y' , '1' , '0' ) C32,
replace ( replace ( DECODE ( A.CFSC_ETC_YN , 'Y' , XMED.FT_MRD_GET_ELMT_SEQ_INFO('MDFM_ELMT_ID', a.MDRC_ID, a.MDRC_FOM_SEQ, '2038') , '' ) , CHR ( 13 ) , ' ' ) , CHR ( 10 ) , ' ' ) C33 ,
DECODE ( A.CFSC_DISS_INF_FAMH_YN , 'N' , '1' , '0' ) C34,
DECODE ( A.CFSC_DISS_INF_FAMH_YN , 'Y' , '1' , '0' ) C35,
DECODE ( A.CFSC_FAMH_GFT_YN , 'Y' , '1' , '0' ) C36,
DECODE ( A.CFSC_FAMH_GMT_YN , 'Y' , '1' , '0' ) C37,
DECODE ( A.CFSC_FAMH_MGF_YN , 'Y' , '1' , '0' ) C38,
DECODE ( A.CFSC_FAMH_MGM_YN , 'Y' , '1' , '0' ) C39,
DECODE ( A.CFSC_FAMH_FTHR_YN , 'Y' , '1' , '0' ) C40,
DECODE ( A.CFSC_FAMH_MTHR_YN , 'Y' , '1' , '0' ) C41,
DECODE ( A.CFSC_FAMH_BRTR_YN , 'Y' , '1' , '0' ) C42,
DECODE ( A.CFSC_FAMH_SSTS_YN , 'Y' , '1' , '0' ) C43,
DECODE ( A.CFSC_FAMH_MALE_CHLR_YN , 'Y' , '1' , '0' ) C44,
DECODE ( A.CFSC_FAMH_FEML_CHLR_YN , 'Y' , '1' , '0' ) C45,
'서울특별시보라매병원' C46 ,
'11100249' C47 ,
substr(C.RRN, 0, 6) C48  ,
NVL ( A.ASDR_LCNS_NO , '' ) C49,
NVL ( replace ( replace ( E.STF_NM , 'B' , '' ) , 'A' , '' ) , '' ) C50 ,
NVL ( A.SPCT_QF_NO , '' ) C51,
NVL ( A.DR_SPLT_SBJT_NM , '' ) C52,
replace ( replace ( replace ( NVL ( A.APCT_NM , B.PT_NM ) , '(B)' , '' ) , 'B' , '' ) , 'A' , '' ) C53 ,
(SELECT DTRL1_NM
   FROM CCCCCSTE
  WHERE COMN_GRP_CD =  'BIL203'
    AND COMN_CD     =  DECODE ( A.PT_REL_DTL_TP_CD , '0' , '01' , '00' , '01' , A.PT_REL_DTL_TP_CD )
    AND USE_YN      =  'Y'
 ) C54,
--XCOM.FT_CCC_CODEDTRL ( 'BIL203' , DECODE ( A.PT_REL_DTL_TP_CD , '0' , '01' , '00' , '01' , A.PT_REL_DTL_TP_CD ) , '1' ) C54 ,
NVL ( TO_CHAR ( A.APFR_WRT_DT , 'YYYYMMDD' ) , '' ) C55 ,
NVL ( TO_CHAR ( A.APLC_DT , 'YYYYMMDD' ) , '' ) C56 ,
A.MTD_NM MEDDEPT ,
A.EDI_TRSM_YN SENDYN ,
NVL ( TO_CHAR ( A.EDI_TRSM_DT , 'YYYYMMDD' ) , '' ) SENDDATE ,
XBIL.FT_APREGIMG_CHK
( A.PT_NO , A.APLC_DT , replace ( A.HLTH_INSC_NO , '-' , '' ) ,
    LEAST ( NVL ( TO_CHAR ( A.CNCR_DGNS_CFMT_DT , 'YYYYMMDD' ) , TO_CHAR ( A.APFR_WRT_DT , 'YYYYMMDD' ) ) , NVL ( TO_CHAR ( A.APFR_WRT_DT , 'YYYYMMDD' ) , '' ) ) ,
    A.APFR_WRT_DT ,
    DECODE ( NVL ( A.SONO_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
    || DECODE ( NVL ( A.CT_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
    || DECODE ( NVL ( A.MRI_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
    || DECODE ( NVL ( A.ETC_DGNS_YN , 'N' ) , 'N' , '0' , '1' ) ,
    SUBSTR
    ( DECODE ( NVL ( A.SONO_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
        || DECODE ( NVL ( A.CT_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
        || DECODE ( NVL ( A.MRI_DGNS_YN , 'N' ) , 'N' , '0' , '1' )
        || DECODE ( NVL ( A.ETC_DGNS_YN , 'N' ) , 'N' , '0' , '1' ) , 4 , 1 ) ,
    DECODE ( DECODE ( A.SRIL_CDOC_APLC_TP_CD , 'J3' , A.TH7_LST_DGNS_YN , A.TH5_LST_DGNS_YN ) , 'Y' , '1' , '0' ) ,
    DECODE ( A.TH2_LST_DGNS_YN , 'Y' , '1' , '0' )
    ||DECODE ( A.TH3_LST_DGNS_YN , 'Y' , '1' , '0' )
    ||DECODE ( A.TH4_LST_DGNS_YN , 'Y' , '1' , '0' )
    ||DECODE ( A.TH5_LST_DGNS_YN , 'Y' , '1' , '0' )
    ||DECODE ( A.TH6_LST_DGNS_YN , 'Y' , '1' , '0' ) ,
    A.TH1_LST_DGNS_MTHD_CNTE , DECODE ( SRIL_CDOC_APLC_TP_CD , 'J3' , A.TH7_LST_DGNS_MTHD_CNTE , A.TH5_LST_DGNS_MTHD_CNTE ) )
MSG
,
A.MDRC_ID DOCTOR_NOTE_ID ,
A.HLTH_INS_MDC_TP_CD AIDYN ,
DECODE
(
    A.SRIL_CDOC_APLC_TP_CD , 'J3' ,
    CASE NVL ( A.RRNS_OBST_RREG_YN , 'N' ) || NVL ( A.DUP_CNCR_YN , 'N' )
        WHEN 'NN' THEN '1'
        WHEN 'YN' THEN '2'
        WHEN 'NY' THEN '3'
        WHEN 'YY' THEN '4'
        ELSE '1'
    END
    , ''
)
DUP_CNCR_YN
   FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')
     AND A.APLC_DT BETWEEN TO_DATE(:FROMDATE,'YYYYMMDD')
                       AND TO_DATE(:TODATE,'YYYYMMDD')
     AND DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*') = DECODE(:SENDFG,'1','*', DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*'))
     AND E.STF_NO = A.ASDR_STF_NO
     AND A.SRIL_APLC_CNCL_DTM IS NULL
     AND A.SRIL_APLC_CCRC_YN = 'Y'
     --20231213 성현석 BRMH 보라매는 본원 하나만 존재하여 해당 세팅을 주석처리
     --AND A.HSP_TP_CD = '1'
     AND F.PT_NO = A.PT_NO
     AND A.SRIL_APCT_SGNT_CNTE IS NOT NULL
     AND A.SRIL_CDOC_APLC_TP_CD IS NOT NULL
     AND F.PT_REL_TP_CD = '0'
     AND NVL(A.ADDR_VER_CTRA_CD,0)>2
     AND A.SRIL_CDOC_APLC_TP_CD IN('21', '23', 'SS', 'SD', 'SC', '14')
     AND A.PT_NO = NVL(:IN_PT_NO, A.PT_NO)
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM
                        WHERE PACT_TP_CD = NVL(:IN_PACT_TP_CD,PACT_TP_CD)
                      )

   -- 2024-10-30 김용록 : 중복 제거(C16, 확진일을 최근 일자로 가져오게 처리)
   )
                    --:IN_BABY_CHECKED
   WHERE CASE WHEN :IN_BABY_CHECKED = 'Y'

              THEN TO_NUMBER(SUBSTR(C4,0,6))
              ELSE TO_NUMBER(TO_CHAR(SYSDATE,'yymmdd'))
          END  BETWEEN TO_NUMBER(TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE, -11), 'dd'),'yymmdd')) -- 생후 11개월까지 = 영아
                             AND TO_NUMBER(TO_CHAR(SYSDATE,'yymmdd'))


   GROUP BY CCC,
            PT_NO,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,--C16
            C17,C18,C19,C20,C21,C22,C23,C24,C25,C26,C27,C28,C29,C30,C31,C32,
            C33,C34,C35,C36,C37,C38,C39,C40,C41,C42,C43,C44,C45,C46,C47,C48,
            C49,C50,C51,C52,C53,C54,C55,C56,MEDDEPT,SENDYN,SENDDATE,MSG,
            DOCTOR_NOTE_ID,AIDYN,DUP_CNCR_YN


   ORDER BY C16 DESC
    ;;;
select
    TO_NUMBER(TO_CHAR(SYSDATE,'yymmdd'))  AS SS
    , TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE, -11), 'dd'),'yymmdd') as a
    , sysdate-'335' as b
from dual;
EXEC :IN_BABY_CHECKED := 'Y';
