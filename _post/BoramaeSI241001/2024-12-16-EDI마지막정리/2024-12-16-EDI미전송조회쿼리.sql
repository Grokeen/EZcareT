



EXEC :FROMDATE := '20241201';
EXEC :TODATE := '20241231';



SELECT /*+ HIS.PA.AC.PI.PI.SelSeriousIllnessApplicationFormEDIReg_Statistics */

  (SELECT '암 : ' || COUNT(*) ||'(건)'
    FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')
     AND A.APLC_DT BETWEEN TO_DATE('20240907','YYYYMMDD')
                       AND TO_DATE( TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
     AND DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*') = '*'
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
     AND A.SRIL_CDOC_APLC_TP_CD NOT IN('21', '23', 'SS', 'SD', 'SC', '14', 'TB', 'TC', 'LT')
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM M
                        WHERE 1=1
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ

                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                      )
     )                    AS REG1_0 -- 암 신청서


   ,(SELECT '희귀난치 : ' || COUNT(*) ||'(건)'
      FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F

   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')
     AND A.APLC_DT BETWEEN TO_DATE('20240907','YYYYMMDD')
                       AND TO_DATE( TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')

     -- 미전송 찾기
     AND DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*') = '*'
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

     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM M
                        WHERE 1=1
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ

                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                        )
     )                      AS REG1_1  -- 희귀난치 신청서

   ,(SELECT '결핵 : ' || COUNT(*) ||'(건)'
   FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')
     AND A.APLC_DT BETWEEN TO_DATE('20240907','YYYYMMDD')
                       AND TO_DATE( TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
     AND DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*') = '*'
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
     AND A.SRIL_CDOC_APLC_TP_CD IN('TB', 'TC')
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM  M
                        WHERE 1=1
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ

                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                      )
     )                      AS REG1_2   -- 결핵 신청서




   ,(SELECT '잠복결핵 : ' || COUNT(*) ||'(건)'
    FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')
     AND A.APLC_DT BETWEEN TO_DATE('20240907','YYYYMMDD')
                       AND TO_DATE( TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
     AND DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*') = '*'
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
     AND A.SRIL_CDOC_APLC_TP_CD = 'LT'
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM  M
                        WHERE 1=1
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ

                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                      )
     )                       AS REG1_3  -- 잠복결핵 신청서



   ,(SELECT '화상 : ' || COUNT(*) ||'(건)'
   FROM  ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')
     AND A.APLC_DT BETWEEN TO_DATE('20240907','YYYYMMDD')
                       AND TO_DATE( TO_CHAR(SYSDATE,'YYYYMMDD'),'YYYYMMDD')
     AND DECODE(A.EDI_TRSM_YN,'Y',A.EDI_TRSM_YN,'*') = '*'
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
     AND A.SRIL_CDOC_APLC_TP_CD = '09'
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM    M
                        WHERE 1=1
                          -- 2024-12-04 김용록 : 마지막 작성 서식으로 가져오게 처리
                          AND A.MDRC_FOM_SEQ = M.MDRC_FOM_SEQ

                          -- 2024-11-15 김용록 : MDRC_ID 조건 추가
                          AND LST_YN = 'Y' -- 최종 승인
                          AND MDRC_FOM_SEQ = (SELECT MAX(MDRC_FOM_SEQ) OVER (PARTITION BY MDRC_ID)
                                                FROM DUAL) -- 최종 작성
                      )
     )
                                    AS REG1_4    -- 화상 신청서
FROM DUAL


;


