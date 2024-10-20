﻿SELECT B.PME_CLS_CD
                     , A.POB_NO

                     , POB_NO
                  FROM ACPPRPID A
                     , PCTPCPAM B
                 WHERE A.PT_NO = '01741540'
                   AND A.PT_NO = B.PT_NO
                   AND A.PME_CLS_CD = B.PME_CLS_CD
                   AND TRUNC(SYSDATE) BETWEEN A.INS_APY_DT
                                          AND A.INS_END_DT

;

SELECT * FROM (select PT_NO, INS_END_DT, COUNT(*) AS CNT FROM ACPPRPID GROUP BY PT_NO, INS_END_DT) WHERE CNT >1;
SELECT * FROM ACPPRPID WHERE PT_NO = '01330731';
-----------------------------------------------------------------------------------------------------------------------
ACPPRETM; ACPPRODM;
SELECT FRVS_RMDE_TP_CD,COUNT(*) FROM ACPPRODM GROUP BY FRVS_RMDE_TP_CD ;
SELECT * FROM ACPPRODM WHERE FRVS_RMDE_TP_CD =2 ;
SELECT * FROM (SELECT COMN_GRP_CD,COMN_GRP_CD_NM, COUNT(*) CNT FROM CCCCCLTC GROUP BY COMN_GRP_CD,COMN_GRP_CD_NM) WHERE CNT >1;


SELECT * FROM ACPPROSD;
