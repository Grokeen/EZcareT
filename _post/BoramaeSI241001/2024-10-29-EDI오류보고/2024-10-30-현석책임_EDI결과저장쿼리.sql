


select * from ACPPRGHD
where rownum < 10

;;;;

SELECT /* HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg2 */
               A.PT_NO                       PT_NO
             , TO_CHAR(A.APLC_DT,'YYYYMMDD') APLC_DT
             , A.HMPS_POST_NO                HMPS_POST_NO
             , A.HMPS_POST_NO_SEQ            HMPS_POST_NO_SEQ
             , XBIL.FT_PCT_GETCTAD(A.PT_NO,'0','51')                HM_DTL_ADDR
             , DECODE(B.PT_NO,NULL,'N','Y')  YN
             , A.MDRC_ID                     MDRC_ID
             , A.APLC_ICD10_DUP_SEQ_CD       APLC_ICD10_DUP_SEQ_CD
          FROM ACPPRGHD A
             , ACPPRGCD B
             , PCTPCPAM D
         WHERE 1 = 1 -- SUBSTRB(A.SMFL_LDAT_CNTE,72,13) = :IN_RRN
           --AND D.PT_RRN = PLS_ENCRYPT_B64_ID(:IN_RRN,800)
           AND D.PT_NO = A.PT_NO
           --AND A.SRIL_CDOC_APLC_TP_CD = DECODE(A.CFSC_CD,'V800','SD','V810','SD',DECODE(SUBSTR(:IN_REQTYPE,1,2),'01','J3','05', 'SC', '21', '21', '23', '23', '14', '14', '07', 'TB', '11', 'SS', '08', 'TC', '22','LT','99', A.SRIL_CDOC_APLC_TP_CD, 'J3'))
           AND A.HLTH_INS_MDC_TP_CD = 'BB'
           --20231213 성현석 BRMH 보라매는 본원 하나만 존재하여 해당 세팅을 주석처리
           AND A.HSP_TP_CD = '7'
           AND A.SRIL_APLC_CNCL_DTM IS NULL
           AND B.PT_NO(+)             = A.PT_NO
           AND B.HLTH_INS_MDC_TP_CD(+)       = A.HLTH_INS_MDC_TP_CD
           --AND B.SRIL_CFMT_NO(+)      = :IN_REQTYPE
           AND A.EDI_TRSM_YN = 'Y'
           --AND (A.EDI_RCV_YN IS NULL  OR A.EDI_RCV_YN = 'N')          --//YWJ20170112 기존막음
           AND (
           	    A.EDI_RCV_YN IS NULL  OR A.EDI_RCV_YN = 'N'
           	    or (A.EDI_RCV_YN = 'Y' and A.SRIL_APLC_SNBK_CD_CNTE <> '11')        --이미 수신파일이 왔지만 정상처리 되지 않는 내역까지 재업로드 가능하게        YWJ20170112 신규추가
           	   )
           AND A.EDI_TRSM_DT BETWEEN SYSDATE - 60 AND SYSDATE  -- 자꾸 과거 잘못된 데이터에 업로드 되는 경우가 있어 최근 신청서 업뎃되도록 수정
           AND ROWNUM = 1
