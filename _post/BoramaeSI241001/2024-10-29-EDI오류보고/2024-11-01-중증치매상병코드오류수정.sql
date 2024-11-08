



EXEC :FROMDATE := '20240701';
EXEC :TODATE :='20241104';
EXEC :SEMDFG := '0';


SELECT * FROM (
SELECT
A.PT_NO
,
CASE WHEN ASCII(UPPER(NVL ( A.HLTH_INS_ETPS_NM , ' ' ))) > 45217 THEN replace ( replace ( replace ( NVL ( A.HLTH_INS_ETPS_NM , ' ' ) , 'C' , '' ) , 'B' , '' ) , 'A' , '' )
     WHEN ASCII(UPPER(NVL ( A.HLTH_INS_ETPS_NM , ' ' ))) BETWEEN '65' AND '90' THEN NVL ( A.HLTH_INS_ETPS_NM , ' ' )
     ELSE NVL ( A.HLTH_INS_ETPS_NM , ' ' )
END AS C2



,
DECODE ( NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , 'V193' , A.CFSC_CD ) C17,



DECODE
(
    NVL
    (
        DECODE
        (
            NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , 'ZZZ'--XBIL.FT_GET_CANCER ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) ) ,



--            CASE
--                WHEN REPLACE(REPLACE(A.CFSC_CD,CHR(13),''),CHR(10),'') IN ( 'V800' , 'V810' )
--                    /* 2024-11-01 김용록 : 정신과 사병기호가 G3100인데, G310으로 나와 사회보험EDI에 파일 불러올 때, 에러 발생하여 변경 */
--                    THEN-- SUBSTR (
--                    --XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
--
--                    'SDS'
--                    -- , 1 , 4 )
--                          --XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
--                          --A.APLC_ICD10_CD_CNTE
--                    ELSE --XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
--                    'DSDS'
--            END
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
                WHEN A.CFSC_CD IN ( 'V800' , 'V810' )
                THEN SUBSTR ( XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD ) , 1 , 5 )
                ELSE XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
            END
        ) , ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) )
    )
)C18           ,













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
END C19
--,
--
--XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ), 0 || A.APLC_ICD10_DUP_SEQ_CD ) AS KK1,
--
--replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) AS KK2,
--
-- A.APLC_ICD10_CD_CNTE AS KK3,
--A.CFSC_CD      ,
--A.CFSC_CD              AS SS
--

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

) WHERE C17 IN('V800','V810')
  --AND C18 != 'F001'
  --AND C18 !='G300'
