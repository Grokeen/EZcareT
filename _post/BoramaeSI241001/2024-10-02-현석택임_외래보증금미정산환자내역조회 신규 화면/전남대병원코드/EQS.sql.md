









```sql
<sql id="HIS.PA.AC.PC.OP.SelOtpStorageAmountNonCompletePaymentAsk"><!--
    Clss : text
    Desc : 외래보증금미정산환자내역조회 
    Author : 김형준
    Create date : 2021-09-21
    Update date : 2021-09-21
                : 2021-11-01 김형준 , 가퇴원 정산 관련 보관금 추가 
                : 2022-02-24 김형준 , 입원 중간금 가퇴원금 추가 
-->

WITH TEMP AS 
(

SELECT A.PT_NO
     , B.PT_NM
     , TO_CHAR(A.MED_DT,'yyyy-MM-dd') MED_DT
     , A.MED_DEPT_CD
     , ( SELECT Z.TEL_NO
           FROM PCTPCPTD Z
          WHERE Z.PT_NO = A.PT_NO 
            AND Z.HSP_TP_CD = A.HSP_TP_CD 
            AND Z.CTAD_TP_CD = '00'
            AND ROWNUM = 1 ) TEL_NO 
     , TO_CHAR(nvl(A.OCUR_DT, A.RPY_DT),'yyyy-MM-dd') RPY_DT 
     , A.RPY_AMT
     , A.RPY_STF_NO
     , A.STRG_AMT_RMK
     , ( SELECT TO_CHAR(MIN(X.MED_DT),'yyyy-MM-dd') 
           FROM ACPPRODM X 
          WHERE X.HSP_TP_CD = :HIS_HSP_TP_CD  
            AND X.MED_DT >= TO_DATE(:IN_TODATE ,'yyyymmdd')   --20220629 박수현 최근예약일을 당일포함하여 조회하는 것으로 변경(김미경선생님 요청) 
            AND X.PT_NO = A.PT_NO 
            AND APCN_YN = 'N') RCN_RSV_DT
--     , ( SELECT NVL(SUM(X.UNCL_AMT_BLNC),0) 
--                   FROM ACPPEUED X 
--                  WHERE X.HSP_TP_CD = :HIS_HSP_TP_CD  
--                    AND X.PT_NO = A.PT_NO 
--                    AND NVL(X.END_YN,'N') = 'N' 
--                    AND X.UNCL_AMT != X.UNCL_RPY_AMT) UNCL_AMT
     , ( SELECT NVL(SUM(NVL(X.UNCL_AMT,0) -  NVL(X.RPY_AMT,0) - NVL(X.WOFF_AMT,0)),0)
           FROM ACPPEUND X 
          WHERE X.HSP_TP_CD = :HIS_HSP_TP_CD 
            AND X.PT_NO = A.PT_NO 
            AND X.UNCL_CTG_CD  = '1'             -- 미수분류코드
            AND NVL(X.UNCL_RSN_CD,'*') &lt;&gt; '77'   -- 직원(급여공제)미수는 보이지 않도록 한다.(황계장)
            AND X.RPY_STS_YN  != 'Y' ) UNCL_AMT 
     , CASE WHEN A.GRTY_AMT_INPT_TP_CD IN ('23', '24') THEN '입원'
            ELSE '외래'
       END AS PACT_TP_NM  
     ,(
         SELECT K.BSC_ADDR||' '||K.DTL_ADDR||' ('||K.POST_NO||')'   
           FROM PCTPCPTD K
               ,CCCCCSTE X
          WHERE K.PT_NO = A.PT_NO
            AND K.HSP_TP_CD = A.HSP_TP_CD
            AND TRUNC(SYSDATE) BETWEEN K.AVL_STR_DT AND K.AVL_END_DT
            AND X.COMN_GRP_CD  = '23A'
            AND X.DTRL2_NM     = 'ADDR'
            AND X.COMN_CD      = K.CTAD_TP_CD
            AND ROWNUM = 1
          ) PT_ADDR
     
  FROM ACPPEDPD A
     , PCTPCPAM_DAMO B
     --, PCTPCPTD C
 WHERE A.HSP_TP_CD = :HIS_HSP_TP_CD 
   AND A.RPY_DT BETWEEN TO_DATE(:IN_FROMDATE ,'yyyymmdd')
                    AND TO_DATE(:IN_TODATE ,'yyyymmdd')
   AND A.PRO_DT IS NULL
   AND A.RPY_STF_NO = NVL(:IN_STF_NO,A.RPY_STF_NO) 
   AND A.GRTY_AMT_INPT_TP_CD NOT IN ('21','22','25','26', '28', '29', '13', '14', '24') 
   AND ( (:IN_PACT_TP_CD = 'A'  AND A.PACT_TP_CD IN ('O', 'E', 'I') )
     OR  (:IN_PACT_TP_CD = 'O'  AND A.PACT_TP_CD IN ('O', 'E'))
     OR  (:IN_PACT_TP_CD = 'I'  AND A.PACT_TP_CD IN ('I')) )     
   
   AND B.PT_NO(+) = A.PT_NO
   <IsEqual Property="IN_JOBTYPE" CompareValue="U">
   AND A.RPY_AMT >= TO_NUMBER(:IN_UP_AMT)
   </IsEqual><IsEqual Property="IN_JOBTYPE" CompareValue="B">
   AND A.RPY_AMT BETWEEN TO_NUMBER(:IN_FROM_AMT) 
                     AND TO_NUMBER(:IN_TO_AMT)
   </IsEqual>

)
SELECT PT_NO
     , PT_NM
     , MED_DT
     , MED_DEPT_CD
     , TEL_NO
     , RPY_DT 
     , TO_CHAR(RPY_AMT,'999,999,999') RPY_AMT
     , RPY_STF_NO
     , STRG_AMT_RMK
     , RCN_RSV_DT
     , TO_CHAR(UNCL_AMT,'999,999,999') UNCL_AMT
     , PACT_TP_NM
     , PT_ADDR
  FROM TEMP 
 
UNION ALL
SELECT '합계' PT_NO
     , NULL PT_NM
     , NULL MED_DT
     , '총 ' || COUNT(PT_NO) || ' 건'  MED_DEPT_CD
     , NULL TEL_NO
     , NULL RPY_DT 
     , TO_CHAR(SUM(RPY_AMT),'999,999,999') RPY_AMT
     , NULL RPY_STF_NO
     , NULL STRG_AMT_RMK
     , NULL RCN_RSV_DT
     , TO_CHAR(SUM(UNCL_AMT),'999,999,999') UNCL_AMT
     , NULL PACT_TP_NM
     , NULL PT_ADDR
  FROM TEMP
 HAVING COUNT(PT_NO) > 0  
 ORDER BY RPY_DT
        , MED_DT
        , PT_NO
</sql>
```