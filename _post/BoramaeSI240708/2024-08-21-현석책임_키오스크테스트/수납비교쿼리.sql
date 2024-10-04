------------------------------------------------

-- 본인확인
SELECT *
	FROM  /* 환자본인확인정보 */
WHERE PT_NO ='01966485';
------------------------------------------------

-- 개인정보
SELECT *
	FROM PCTPDSPD /* 개인정보동의여부 */
WHERE PT_NO ='01966485'  ;
------------------------------------------------
SELECT *
	FROM ACPPEOPD /* 외래수납정보 */
WHERE PT_NO ='01966485'
ORDER BY 1,2,3,5,4;

SELECT *
	FROM ACPPEOPD /* 외래수납정보 */
WHERE PT_NO ='01966485'
  AND RPY_PACT_ID ='0008140144'
ORDER BY 1,2,3,5,4;

SELECT RPY_PACT_ID,RPY_CLS_SEQ ,APY_STR_DT, ORPY_CLS_CD,MTCS_AMT,INS_SUM_AMT,NINS_SUM_AMT,CMED_SUM_AMT,UNN_BRDN_AMT,PBDN_AMT,TAMT_PBDN_AMT,MRPY_AMT,PV_RPY_AMT,PYAC_AMT,HLU_DMD_AMT,RROBT_SUP_AMT,PNCK_SUP_CST_DMD_AMT,VAT_AMT,CMED_SUM_AMT,RPY_AMT,UNCL_AMT,UNCL_INAM_AMT,CARD_RPY_AMT,CASH_RPY_AMT,CRCP_AMT
	FROM ACPPEOPD /* 외래수납정보 */
WHERE PT_NO ='01966485'
  AND RPY_PACT_ID ='0008140144'
ORDER BY 1,2,3,5,4;


------------------------------------------------

SELECT SUM(UNN_BRDN_AMT),SUM(PBDN_AMT)
	FROM ACPPEOCE /* 외래계산 상세 */
WHERE PT_NO ='01966485'
  AND RPY_PACT_ID ='0008140217' ;
------------------------------------------------

SELECT *
	FROM ACPPECPE /* 카드수납상세 */
WHERE PT_NO ='01966485'
 AND SETL_APBT_ID = '0019039232'
ORDER BY 1,2,3,5,4;
------------------------------------------------