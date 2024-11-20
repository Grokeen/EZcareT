
exec :IN_PT_NO := '01997130';


;;
SELECT  /*+XMED.PKG_MOO_SRILRRNSCFSCINFASK.FT_MOO_GETSPECIALCASESTATUS_25*/
                '1' REG_GBN
            , APY_STR_DT
            , APY_END_DT
            , SRIL_CDOC_APLC_TP_CD
            , CFSC_CD
        FROM  ACPPRGHD  -- 중증산정특례신청서정보 (본원)
        WHERE  PT_NO     = :IN_PT_NO
--        AND    HLTH_INS_MDC_TP_CD   = sPatType
--        AND    APY_STR_DT <= sysdate
        AND    SRIL_CDOC_APLC_TP_CD   IN ('SC','TB','SS','TC','SD','21','23','14','LT')  -- 2016.03.31 극희귀 추가,  -- 2016.06.27 신규 결핵 추가, -- 2017.09.26 치매 추가   --2018.12 희귀:21 , 중증난치:23 추가 ,2019.01 기타염색체 추가
        AND    SRIL_APLC_CNCL_DTM   IS NULL                           -- 2021.06.17 잠복결핵 추가
          AND     APY_STR_DT   IS NOT NULL
          AND     APY_END_DT   IS NOT NULL


          union all

          ;
        select  '2' reg_gbn
            , APY_STR_DT
            , APY_END_DT
            , SRIL_CDOC_APLC_TP_CD
--            , CASE WHEN SRIL_CDOC_APLC_TP_CD IN ('TB', 'TC') THEN CASE WHEN SUBSTR(SRIL_CFMT_NO,1,2) IN ('05','11') THEN 'V206'
--                                                                       WHEN SUBSTR(SRIL_CFMT_NO,1,2) = '07'         THEN 'V246' ELSE ''
--                                                                  END
--                   WHEN SRIL_CDOC_APLC_TP_CD = 'SD' THEN FT_MOO_GET_DMTA_VCODE(sPatType, PCOR_ICD10_CD_CNTE, dDementiaCheckDate) -- 치매 V코드
--              END CFSC_CD

            -- 2018-07-09 타병원의 경우 V코드만 가지고 판단할수 없기에 V코드를 V246으로 통일하고 상병코드만 매칭시킨다.
            , CASE WHEN SRIL_CDOC_APLC_TP_CD IN ('TB', 'TC') THEN 'V246'
--                   WHEN SRIL_CDOC_APLC_TP_CD = 'SD' THEN FT_MOO_GET_DMTA_VCODE(sPatType, PCOR_ICD10_CD_CNTE, dDementiaCheckDate) -- 치매 V코드
              END CFSC_CD

        from  ACPPRGCD -- 중증진료확인증정보 (타병원)
        WHERE  PT_NO     = :IN_PT_NO
--        AND    HLTH_INS_MDC_TP_CD   = sPatType
--        AND    APY_STR_DT   <= sysdate
        AND    SRIL_CDOC_APLC_TP_CD   IN ( 'SC','TB','SS','TC','SD','21','23','14','LT')
        AND    SRIL_APLC_CNCL_DTM   IS NULL
        AND     APY_STR_DT  IS NOT NULL
        AND     APY_END_DT    IS NOT NULL
        AND     OTHSP_PBL_YN = 'Y'   --타병원여부Y
            ORDER BY  SRIL_CDOC_APLC_TP_CD, APY_END_DT, REG_GBN DESC



;

select * from acpprghd
where pt_no = :in_pt_no;
