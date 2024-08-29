EXEC :MY_PT_NO :='01741540' ;
EXEC :MY_RPY_PACT_ID := '0008141120';





SELECT
   RPY_PACT_ID
   ,PT_NO
   ,(SELECT
        SUM(UNN_BRDN_AMT)
	   FROM ACPPEOCE /* 외래계산상세 */
	   WHERE PT_NO = B.PT_NO AND RPY_PACT_ID = B.RPY_PACT_ID)     AS "조합부담해주는금액"
   ,(SELECT
        SUM(PBDN_AMT)
	   FROM ACPPEOCE /* 외래계산상세 */
	   WHERE PT_NO = B.PT_NO AND RPY_PACT_ID = B.RPY_PACT_ID)     AS "니가 내야할 금액"

   ,(SELECT
         CASE WHEN APBT_DTM IS NULL THEN '외래진료비수납'
              ELSE '키오스크'
         END AS APBT_DTM
	   FROM ACPPECPE /* 카드수납상세 */
     WHERE PT_NO =B.PT_NO AND RPY_PACT_ID = B.RPY_PACT_ID)      AS "결제방법"

   ,B.APY_STR_DT                                     AS "APY_STR_DT 적용시작일자"
   ,B.ORPY_CLS_CD                                 AS "외래수납유형코드"
   ,(SELECT DEPT_CD||' '||DEPT_NM FROM PDEDBMSM WHERE DEPT_CD = B.MED_DEPT_CD) AS "진료과"
   ,B.CARD_RPY_AMT	            AS "CARD_RPY_AMT 카드수납금액"
   ,B.CASH_RPY_AMT	            AS "CASH_RPY_AMT 현금수납금액"
   ,B.MTCS_AMT	                AS "MTCS_AMT 진료비합계금액"
,B.INS_SUM_AMT	                AS "INS_SUM_AMT 보험합계금액"
,B.NINS_SUM_AMT	            AS "NINS_SUM_AMT 비보험합계금액"
,B.CMED_SUM_AMT	            AS "CMED_SUM_AMT 선택진료합계금액"
,B.UNN_BRDN_AMT        	    AS "UNN_BRDN_AMT 조합부담금액"
,B.PBDN_AMT	                AS "PBDN_AMT 본인부담금액"
,B.TAMT_PBDN_AMT	            AS "TAMT_PBDN_AMT 총액본인부담금액"
,B.MRPY_AMT	                AS "MRPY_AMT 중간수납금액"
,B.PV_RPY_AMT	                AS "PV_RPY_AMT 기수납금액"
,B.PYAC_AMT	                AS "PYAC_AMT 대불신청금액"
,B.HLU_DMD_AMT	                AS "HLU_DMD_AMT 건강생활유지비청구금액"
,B.RROBT_SUP_AMT	            AS "RROBT_SUP_AMT 희귀난치성지원금액"
,B.PNCK_SUP_CST_DMD_AMT	    AS "PNCK_SUP_CST_DMD_AMT 산전검사지원비청구금액"
,B.VAT_AMT	                    AS "VAT_AMT 부가세금액"
,B.CMED_VAT_AMT	            AS "CMED_VAT_AMT 선택진료부가세금액"
,B.RPY_AMT	                    AS "RPY_AMT 수납금액"
,B.W1_UNIT_COF_AMT	            AS "W1_UNIT_COF_AMT 1원단위절사금액"
,B.UNCL_AMT	                AS "UNCL_AMT 미수금액"
,B.UNCL_INAM_AMT	            AS "UNCL_INAM_AMT 미수입금금액"

FROM
(SELECT
RPY_PACT_ID	                --AS "RPY_PACT_ID 수납원무접수ID"
,RPY_CLS_SEQ	                AS "RPY_CLS_SEQ 수납유형순번"
,APY_STR_DT	                --AS "APY_STR_DT 적용시작일자"
,ORPY_CLS_CD	               -- AS "ORPY_CLS_CD	외래수납유형코드"
,RPY_SEQ	                    AS "RPY_SEQ	수납순번"
,HSP_TP_CD	                AS "HSP_TP_CD 병원구분코드"
,PT_NO	                   -- AS "PT_NO 환자번호"
,PME_CLS_CD	                AS "PME_CLS_CD 환자급종유형코드"
,PSE_CLS_CD	                AS "PSE_CLS_CD 환자보조급종유형코드"
,CORG_CD	                    AS "CORG_CD 계약기관코드"
,MED_DT	                    AS "MED_DT 진료일자"
,MED_DEPT_CD	               -- AS "MED_DEPT_CD 진료부서코드"
,MEDR_SID	                AS "MEDR_SID 진료의직원식별ID"
,MEDR_STF_NO         	    --AS "MEDR_STF_NO 진료의직원번호"
,FRVS_RMDE_TP_CD	            AS "FRVS_RMDE_TP_CD 초진재진구분코드"
,TDY_ADS_TP_CD	            AS "TDY_ADS_TP_CD 당일입원구분코드"
,PACT_TP_CD	                AS "PACT_TP_CD 원무접수구분코드"
,RPY_SCRN_TP_CD	            AS "RPY_SCRN_TP_CD 수납화면구분코드"
,MTCS_AMT	                --AS "MTCS_AMT 진료비합계금액"
,INS_SUM_AMT	                --AS "INS_SUM_AMT 보험합계금액"
,NINS_SUM_AMT	            --AS "NINS_SUM_AMT 비보험합계금액"
,CMED_SUM_AMT	            --AS "CMED_SUM_AMT 선택진료합계금액"
,UNN_BRDN_AMT        	    --AS "UNN_BRDN_AMT 조합부담금액"
,PBDN_AMT	                --AS "PBDN_AMT 본인부담금액"
,TAMT_PBDN_AMT	            --AS "TAMT_PBDN_AMT 총액본인부담금액"
,MRPY_AMT	                --AS "MRPY_AMT 중간수납금액"
,PV_RPY_AMT	                --AS "PV_RPY_AMT 기수납금액"
,PYAC_AMT	                --AS "PYAC_AMT 대불신청금액"
,HLU_DMD_AMT	               -- AS "HLU_DMD_AMT 건강생활유지비청구금액"
,RROBT_SUP_AMT	            --AS "RROBT_SUP_AMT 희귀난치성지원금액"
,PNCK_SUP_CST_DMD_AMT	 --   AS "PNCK_SUP_CST_DMD_AMT 산전검사지원비청구금액"
,VAT_AMT	                  --  AS "VAT_AMT 부가세금액"
,CMED_VAT_AMT	          --  AS "CMED_VAT_AMT 선택진료부가세금액"
,RPY_AMT	              --      AS "RPY_AMT 수납금액"
,W1_UNIT_COF_AMT	          --  AS "W1_UNIT_COF_AMT 1원단위절사금액"
,UNCL_AMT	               -- AS "UNCL_AMT 미수금액"
,UNCL_INAM_AMT	         --   AS "UNCL_INAM_AMT 미수입금금액"
,INDV_UNCL_RSN_CD	        AS "INDV_UNCL_RSN_CD 개인미수사유코드"
,EMRG_INDV_UNCL_INPT_STF_NO
,EMRG_INDV_UNCL_INPT_DTM
,EMRG_INDV_UNCL_RMK_CNTE
,APRV_TP_CD	                AS "APRV_TP_CD 결재구분코드"
,SETL_APBT_ID	            AS "SETL_APBT_ID 결제승인ID"
,CARD_RPY_AMT	            --AS "CARD_RPY_AMT 카드수납금액"
,CASH_RPY_AMT	            --AS "CASH_RPY_AMT 현금수납금액"
,CRCP_AMT	                AS "CRCP_AMT 현금영수증금액"
,PAMT_SBST_YN	            AS "PAMT_SBST_YN 예치금대체여부"
,RPY_DT	                    AS "RPY_DT 수납일자"
,RPY_STF_NO	                AS "RPY_STF_NO 수납직원번호"
,CNCL_DTM	                AS "CNCL_DTM 취소일시"
,CNCL_CHG_STF_NO	            AS "CNCL_CHG_STF_NO 취소변경직원번호"
,ORD_RPY_STS_CD	            AS "ORD_RPY_STS_CD 처방수납상태코드"
,BNDL_RCP_RPY_SEQ	        AS "BNDL_RCP_RPY_SEQ 묶음영수증수납순번"
,BNDL_RCP_NO	                AS "BNDL_RCP_NO 묶음영수증번호"
,CLNL_RSCH_NO	            AS "CLNL_RSCH_NO 임상연구번호"
,RCP_NO	                    AS "RCP_NO 영수증번호"
,AMS_NO	                    AS "AMS_NO 투약번호"
,OLD_AMS_NO	                AS "OLD_AMS_NO 구투약번호"
,HSOT_AMS_NO	                AS "HSOT_AMS_NO 원외투약번호"
,OLD_HSOT_AMS_NO	            AS "OLD_HSOT_AMS_NO 구원외투약번호"
	FROM ACPPEOPD          /* 외래수납정보 */ ) B
WHERE B.PT_NO LIKE NVL(:MY_PT_NO,'%')
   AND B.RPY_PACT_ID LIKE NVL(:MY_RPY_PACT_ID,'%')
ORDER BY 1,2,5,7,6


;


EXEC :MY_PT_NO :='01741540' ;
EXEC :MY_RPY_PACT_ID := '0008141135';
-- 순환기내과    IMC77    10시 예약         : 9시20분       0008141120 -> 문제가 있음(4만원?)
-- 감염내과      IMI77    10시 30분 예약    : 10시 20분     0008141135
-- 혈액종양내과  IMH77    11시 예약         : 10시 25분     0008141137
-- 소화기내과    IMG77    11시 30분 예약    : 10시 59분     0008141142

-- 내분비대사내과 IME77    12시 예약
-- 호흡기내과    IMR77    9시 30분 예약      : 13시 40분    0008141152
-- 비뇨기과      UR777    11시 45분 예약
-- 안과         OT777    11시 15분 예약



