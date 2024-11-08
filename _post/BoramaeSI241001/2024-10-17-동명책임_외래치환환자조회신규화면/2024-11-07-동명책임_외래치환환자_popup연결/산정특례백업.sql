--
--
--
--select * from ACPPRRDE where rownum < 10;
select *
	from acpprghd
where pt_no ='01302763'
--TH11_CNCR_LST_DGNS_YN




;;;

EXEC :FROMDATE := '20241101';
EXEC :TODATE := '20241104';
EXEC :SENDFG := '0';
SELECT
    A.PT_NO
    ,DECODE ( A.TH11_CNCR_LST_DGNS_YN , 'Y' , '1' , '0' ) C35

   ,replace (
       replace (
           DECODE ( A.TH11_CNCR_LST_DGNS_YN , 'Y' , XMED.FT_MRD_GET_ELMT_SEQ_INFO('MDFM_ELMT_ID', a.MDRC_ID, a.MDRC_FOM_SEQ, '2038')
                                                  , '' )
           , CHR ( 13 ) , ' ' )
       , CHR ( 10 ) , ' '
    )  AS C36


    , A.TH11_CNCR_LST_DGNS_YN  AS S1
    ,  a.MDRC_ID AS S2
    , a.MDRC_FOM_SEQ AS S3

    , a.MDRC_ID AS S4
    , a.MDRC_FOM_SEQ AS S5
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
     AND A.SRIL_CDOC_APLC_TP_CD NOT IN('21', '23', 'SS', 'SD', 'SC', '14', 'TB', 'TC', 'LT')
     --AND A.PT_NO = '01302763'
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM
                        WHERE PACT_TP_CD = NVL(NULL,PACT_TP_CD)
                      )
;;;




SELECT * FROM MRDDRECM WHERE PT_NO ='01302763';
SELECT * FROM MRDDRECE WHERE MDRC_ID ='56910274';
SELECT * FROM ACPPRGHD WHERE PT_NO ='01302763';
SELECT * FROM ACPPRGCD WHERE PT_NO ='01302763';




EXEC :IN_MDFM_ELMT_ID := '2038';
EXEC :IN_MDRC_FOM_SEQ := '1';
EXEC :IN_MDRC_ID := '56910274';


            WITH RECMAIN AS
            ( SELECT M.MDFM_ID
                   , M.MDFM_FOM_SEQ
                   , N.MDFM_CPEM_ID
                   , N.REC_VAL_SEQ
                   , N.MDFM_CPEM_NO
                   , TO_CLOB(N.MDFM_ELMT_INPT_CNTE)        REC_VALUE
                   , A.ELMT_CCLS_CD
                   , A.MDFM_CPEM_CNTE
                FROM MRDDRECM M, MRDDRECE N, MRFMFCID A
               WHERE M.MDRC_ID = :IN_MDRC_ID
                 AND M.MDRC_FOM_SEQ = :IN_MDRC_FOM_SEQ
                 AND M.MDRC_DC_TP_CD = 'C'
                 AND M.MDRC_ID = N.MDRC_ID
                 AND M.MDRC_FOM_SEQ = N.MDRC_FOM_SEQ
                 AND M.MDFM_ID = A.MDFM_ID
                 AND M.MDFM_FOM_SEQ = A.MDFM_FOM_SEQ
                 AND N.MDFM_CPEM_ID = A.MDFM_CPEM_ID
                 AND A.MDFM_ELMT_ID = TO_NUMBER(:IN_MDFM_ELMT_ID)

              UNION ALL

              SELECT M.MDFM_ID
                   , M.MDFM_FOM_SEQ
                   , N.MDFM_CPEM_ID
                   , N.REC_VAL_SEQ
                   , N.MDFM_CPEM_NO
                   , CASE WHEN A.ELMT_CCLS_CD = '7' then TO_CLOB(N.INTG_IMG_FILE_PATH_NM)
                     ELSE N.DCST_LDAT
                     END        REC_VALUE
                   , A.ELMT_CCLS_CD
                   , A.MDFM_CPEM_CNTE
                FROM MRDDRECM M, MRDDRLFE N, MRFMFCID A
               WHERE M.MDRC_ID = :IN_MDRC_ID        -- 진료기록ID
                 AND M.MDRC_FOM_SEQ = :IN_MDRC_FOM_SEQ
                 AND M.MDRC_DC_TP_CD = 'C'
                 AND M.MDRC_ID = N.MDRC_ID
                 AND M.MDRC_FOM_SEQ = N.MDRC_FOM_SEQ
                 AND M.MDFM_ID = A.MDFM_ID
                 AND M.MDFM_FOM_SEQ = A.MDFM_FOM_SEQ
                 AND N.MDFM_CPEM_ID = A.MDFM_CPEM_ID
                 AND A.MDFM_ELMT_ID = TO_NUMBER(:IN_MDFM_ELMT_ID)
            )
            SELECT CASE WHEN (Z.ELMT_CCLS_CD = 5 OR Z.ELMT_CCLS_CD = 6) AND DBMS_LOB.COMPARE(Z.REC_VALUE, '1', 1, 1) = 0 THEN TO_CLOB(Z.MDFM_CPEM_CNTE)
                   ELSE Z.REC_VALUE
                   END                         REC_VALUE

              FROM RECMAIN Z;;



;;;;
select * from MRDDRECM where rownum < 10;     -- mdfm_id
select * from MRDDRLFE where rownum < 10;
select * from MRFMFCID where rownum < 10;      -- 상병기호  mdfm_id  , mdfm_sctn_cls_cd
