



EXEC :FROMDATE :='20240907';
EXEC :TODATE :='20241205';

SELECT /*+ INDEX(ACPPRGHD APREGHVT_SI05) */ /* HIS.PA.AC.PI.PI.SELSERIOUSILLNESSAPPLICATIONFORMEDIREG1_1 */
         A.*
   FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','EE')
     AND A.APLC_DT BETWEEN TO_DATE(:FROMDATE,'YYYYMMDD')
                       AND TO_DATE(:TODATE,'YYYYMMDD')
     AND E.STF_NO = A.ASDR_STF_NO
     AND A.SRIL_APLC_CNCL_DTM IS NULL
     AND A.SRIL_APLC_CCRC_YN = 'Y'
     AND A.SRIL_APCT_SGNT_CNTE IS NOT NULL
     AND A.SRIL_CDOC_APLC_TP_CD IS NOT NULL
     AND NVL(A.ADDR_VER_CTRA_CD,0)>2
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM M
                        WHERE PACT_TP_CD = NVL(:IN_PACT_TP_CD,PACT_TP_CD)
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ
                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                      )
MINUS
SELECT /*+ INDEX(ACPPRGHD APREGHVT_SI05) */ /* HIS.PA.AC.PI.PI.SELSERIOUSILLNESSAPPLICATIONFORMEDIREG1_1 */
        A.*
   FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F

   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','EE')
     AND A.APLC_DT BETWEEN TO_DATE(:FROMDATE,'YYYYMMDD')
                       AND TO_DATE(:TODATE,'YYYYMMDD')
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
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM M
                        WHERE PACT_TP_CD = NVL(:IN_PACT_TP_CD,PACT_TP_CD)
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ

                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                      )
