WITH TEMP AS
(
;;






exec :HIS_HSP_TP_CD := '';
EXEC :IN_TODATE := '20240901' ;
EXEC :IN_FROMDATE := '20241001';
:IN_STF_NO;
:IN_UP_AMT;






;;;

<sql id="HIS.PA.AS.OO.SelRfndRpyPtclPrntPtRoll">
<!--
    Clss :  text
    Desc : 환불수납내역출력 조회
    Author : 이기동
    Create date : 2016-06-16
    Update date : 2016-06-16

    as-is : apd300.ap_aciprfmt_select(원무은행환불정보조회)
                    HIS.PA.AC.PE.PS.SelectRefundInformationAsk

    -PT_REL_TP_CD 에서  PT_REL_DTL_TP_CD 로 변경
-->
;;;


SELECT A.PT_NO                                                                     AS PT_NO        /* 환자번호 */
     , B.PT_NM                                                                     AS PT_NM        /* 환자명 */
     , TO_CHAR(A.MED_DT,'yyyy-MM-dd')                                              AS MED_DT       /* 진료일자 */
     , A.MED_DEPT_CD                                                               AS MED_DEPT_CD  /* 진료부서코드 */

     , ( SELECT Z.TEL_NO
           FROM PCTPCPTD Z
          WHERE Z.PT_NO = A.PT_NO
            --AND Z.HSP_TP_CD = A.HSP_TP_CD
            AND Z.CTAD_TP_CD = '00'
            AND ROWNUM = 1 )                                                       AS TEL_NO       /* 환자전화번호 */


-- 전남대 발생일자 없음     , TO_CHAR(NVL(A.OCUR_DT, A.RPY_DT),'YYYY-MM-DD')                              AS RPY_DT       /* 수납일자 */

     , TO_CHAR(NVL(A.RPY_DT,SYSDATE),'YYYY-MM-DD')                                 AS RPY_DT       /* 수납일자 */
     , A.RPY_AMT                                                                   AS RPY_AMT      /* 수납금액 */
     , A.RPY_STF_NO                                                                AS RPY_STF_NO   /* 수납직원번호*/
--     , A.STRG_AMT_RMK                   -- 전남대 STRG_AMT_RMK 보관금액비고
     , 'NULL'                                                                          AS STRG_AMT_RMK /* 비고 */


     , ( SELECT TO_CHAR(MIN(X.MED_DT),'YYYY-MM-DD')
           FROM ACPPRODM X
          WHERE --X.HSP_TP_CD = :HIS_HSP_TP_CD
            --AND
            X.MED_DT >= TO_DATE(:IN_TODATE ,'YYYYMMDD')   --20220629 박수현 최근예약일을 당일포함하여 조회하는 것으로 변경(김미경선생님 요청)
            AND X.PT_NO = A.PT_NO
            AND X.APCN_DTM IS NULL)                                                      AS RCN_RSV_DT /* 최근예약일 */


-- 전남대에서 들고올 때 부터 주석
--     , ( SELECT NVL(SUM(X.UNCL_AMT_BLNC),0)
--                   FROM ACPPEUED X
--                  WHERE X.HSP_TP_CD = :HIS_HSP_TP_CD
--                    AND X.PT_NO = A.PT_NO
--                    AND NVL(X.END_YN,'N') = 'N'
--                    AND X.UNCL_AMT != X.UNCL_RPY_AMT) UNCL_AMT



     , ( SELECT NVL(SUM(NVL(X.UNCL_AMT,0) -  NVL(X.RPY_AMT,0) - NVL(X.WOFF_AMT,0)),0)
           FROM ACPPEUND X
          WHERE -- 전남대병원구분코드 X.HSP_TP_CD = :HIS_HSP_TP_CD
            --AND
            X.PT_NO = A.PT_NO
            AND X.UNCL_CTG_CD  = '1'             -- 미수분류코드
--전남대 뭐냐 이거            AND NVL(X.UNCL_RSN_CD,'*') &lt;&gt; '77'   -- 직원(급여공제)미수는 보이지 않도록 한다.(황계장)
            AND X.RPY_STS_YN  != 'Y' )                                              AS UNCL_AMT    /* 미수금액 */



     , CASE WHEN A.GRTY_AMT_INPT_TP_CD IN ('23', '24') THEN '입원'
            ELSE '외래'
       END                                                                          AS PACT_TP_NM  /* 입원외래구분 */


     ,(
         SELECT K.BSC_ADDR||' '||K.DTL_ADDR||' ('||K.POST_NO||')'
           FROM PCTPCPTD K
               --,CCCCCSTE X
          WHERE K.PT_NO = A.PT_NO
            --전남대병원구분코드 AND K.HSP_TP_CD = A.HSP_TP_CD
            AND --TRUNC(SYSDATE) BETWEEN K.AVL_STR_DT AND K.AVL_END_DT
 -- 전남대           AND X.COMN_GRP_CD  = '23A'
 -- 전남대           AND X.DTRL2_NM     = 'ADDR'
            --AND X.COMN_CD      = K.CTAD_TP_CD
            --AND
            ROWNUM = 1
          )                                                                          AS PT_ADDR   /* 환자주소 */

  FROM ACPPEDPD A
     , PCTPCPAM B--PCTPCPAM_DAMO B
     --, PCTPCPTD C

WHERE ROWNUM < 10;



 ;;;

 WHERE --전남대병원구분코드 A.HSP_TP_CD = :HIS_HSP_TP_CD
   --AND
   A.RPY_DT BETWEEN TO_DATE(:IN_FROMDATE ,'yyyymmdd')
                    AND TO_DATE(:IN_TODATE ,'yyyymmdd')
   --전남대 AND A.PRO_DT IS NULL
   AND A.RPY_STF_NO = NVL(:IN_STF_NO,A.RPY_STF_NO)
   --전남대 무냐 AND A.GRTY_AMT_INPT_TP_CD NOT IN ('21','22','25','26', '28', '29', '13', '14', '24')
   /* 저남대 뭐냐2 AND ( (:IN_PACT_TP_CD = 'A'  AND A.PACT_TP_CD IN ('O', 'E', 'I') )
     OR  (:IN_PACT_TP_CD = 'O'  AND A.PACT_TP_CD IN ('O', 'E'))
     OR  (:IN_PACT_TP_CD = 'I'  AND A.PACT_TP_CD IN ('I')) )
    */



;;
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
