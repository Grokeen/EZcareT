

--- 응급실고도화 32번 행려환자신청
select * from
 (
select pt_no, count(*) as cnt from ACPPIHLD group by pt_no

)                            where cnt >1
;


select * from ACPPIHLD where pt_no = '00099435';


PCTPCPAM

     


--------------------------------------------------------------------------------------------


   exec :FROMDATE := '20241031';
   exec :TODATE := '20241031';
   exec :in_pt_no := '01877655';
   exec :sendfg := 'N';



select
     A.PT_NO
    ,A.CFSC_CD
    ,A.APLC_ICD10_CD_CNTE

   ,NVL
    (
        DECODE
        (
            NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , XBIL.FT_GET_CANCER ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) ) ,
            CASE
                WHEN A.CFSC_CD IN ( 'V800' , 'V810' )

                -- 2024-10-31 김용록 : 치매환자 상병 오류로 수정(G310 -> G3100)
                THEN replace ( A.APLC_ICD10_CD_CNTE , '.' , '' )
                --THEN SUBSTR ( XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD ) , 1 , 4 )
                ELSE XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
            END
        ) , ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) )
    )                                                             as ss




    ,NVL
    (
        DECODE
        (
            NVL ( A.SRIL_CDOC_APLC_TP_CD , 'J3' ) , 'J3' , XBIL.FT_GET_CANCER ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) ) ,
            CASE
                WHEN A.CFSC_CD IN ( 'V800' , 'V810' )

                THEN SUBSTR ( XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD ) , 1 , 4 )
                
                ELSE XBIL.FT_GET_SC ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) , 0 || A.APLC_ICD10_DUP_SEQ_CD )
            END
        ) , ( replace ( A.APLC_ICD10_CD_CNTE , '.' , '' ) )
    )                                                             as ss




   from   ACPPRGHD A
        , PCTPCPAM B
        , CNLRRUSD C
        , CNLRRUSD E
        , XBIL.PCTPCPAV F
   WHERE  A.PT_NO  = B.PT_NO
     AND C.STF_NO  = A.LSH_STF_NO
     --2024.07.05 김재강 의료급여환자도 보이도록 요청
     AND A.HLTH_INS_MDC_TP_CD IN ('BB','E1','E2','E6')


--     AND A.APLC_DT BETWEEN TO_DATE(:FROMDATE,'YYYYMMDD')
--                       AND TO_DATE(:TODATE,'YYYYMMDD')
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

     AND A.CFSC_CD IN ('V800' ,'V810')

--     AND A.PT_NO = NVL(:IN_PT_NO, A.PT_NO)
     -- 2024.07.24 김재강 : 입원/외래 조회조건 추가
     AND A.MDRC_ID IN (SELECT MDRC_ID
                         FROM MRDDRECM
                        WHERE PACT_TP_CD = NVL(:IN_PACT_TP_CD,PACT_TP_CD)
                      )



;;;        01302893
       WHERE SS NOT IN ()


    ;



                     ;;;

  select UPR_ICD10_CD
		 into sDetail_basecd
		 from CCVMVCFD
		 where ICD10_CD = sTmp
		   and ICD10_DUP_SEQ_CD = 0
		   and UPR_ICD10_CD is not null
		   and rownum = 1
