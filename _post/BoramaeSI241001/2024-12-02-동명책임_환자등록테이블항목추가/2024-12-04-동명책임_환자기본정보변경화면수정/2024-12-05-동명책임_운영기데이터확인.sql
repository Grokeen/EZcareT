﻿


SELECT COUNT(PT_NO)
 FROM PCTPCPAM
WHERE 1=1
  AND LENGTH(REPLACE(BSC_CRCP_MTEL_NO, '-','')) != 11
  AND LENGTH(REPLACE(PLS_ENCRYPT_B64_ID(BSC_CRCP_RRN, 800), '-','')) != 13
  AND LENGTH(REPLACE(BSC_CRCP_CARD_NO, '-','')) != 16
  AND LENGTH(REPLACE(BSC_CRCP_BZM_REG_NO, '-','')) != 10


;

SELECT  PT_NO
      , LENGTH(BSC_CRCP_MTEL_NO) TEL
      , BSC_CRCP_MTEL_NO
      , LENGTH(PLS_DECRYPT_B64_ID(BSC_CRCP_RRN, 800)) rrn
      , PLS_DECRYPT_B64_ID(BSC_CRCP_RRN, 800)
      , LENGTH(BSC_CRCP_CARD_NO)      card
      , BSC_CRCP_CARD_NO
      , LENGTH(BSC_CRCP_BZM_REG_NO  ) biz
      , BSC_CRCP_BZM_REG_NO
FROM PCTPCPAM
WHERE 1=1
  --and pt_no = '01741540' ;
  AND --(BSC_CRCP_MTEL_NO IS NOT NULL
   --OR BSC_CRCP_RRN IS NOT NULL
  -- OR
   BSC_CRCP_CARD_NO IS NOT NULL
   --OR BSC_CRCP_BZM_REG_NO IS NOT NULL)
  and (select LENGTH(BSC_CRCP_CARD_NO)
         from dual) != 18
