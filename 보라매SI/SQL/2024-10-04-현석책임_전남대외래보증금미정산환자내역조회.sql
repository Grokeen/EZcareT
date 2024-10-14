
;;













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



EXEC :HIS_HSP_TP_CD := '';
EXEC :IN_FROMDATE 	:= '20230401';
EXEC :IN_TODATE 		:= '20240401' ;

EXEC :IN_STF_NO 		:= '';
EXEC :IN_PT_NO 			:= '';
EXEC :IN_UP_AMT			:= '';
EXEC :IN_PACT_TP_CD := 'A';

WITH TEMP AS
(
SELECT A.PT_NO                                                                         AS PT_NO        /* 환자번호 */
     , FT_ACP_PATNAME(A.PT_NO)                                                         AS PT_NM        /* 환자명 */
     , TO_CHAR(A.MED_DT,'yyyy-MM-dd')                                                  AS MED_DT       /* 진료일자 */
     , A.MED_DEPT_CD                                                                   AS MED_DEPT_CD  /* 진료부서코드 */

     , FT_PCT_GETCTAD(A.PT_NO,'0','01')                                                AS TEL_NO       /* 환자전화번호 */

     , TO_CHAR(NVL(A.RPY_DT,SYSDATE),'YYYY-MM-DD')                                     AS RPY_DT       /* 수납일자 */
     , A.RPY_AMT                                                                       AS RPY_AMT      /* 수납금액 */
     , A.RPY_STF_NO                                                                    AS RPY_STF_NO   /* 수납직원번호 */
     , A.GRTY_AMT_RMK                                                                  AS STRG_AMT_RMK /* 보증금액비고 */

     , ( SELECT TO_CHAR(MIN(X.MED_DT),'YYYY-MM-DD')
           FROM ACPPRODM X  /* 외래예약접수기본 테아불 */
          WHERE X.MED_DT >= TO_DATE(:IN_TODATE ,'YYYYMMDD')   --20220629 박수현 최근예약일을 당일포함하여 조회하는 것으로 변경(김미경선생님 요청)
            AND X.PT_NO = A.PT_NO
            AND X.APCN_DTM IS NULL)                                                    AS RCN_RSV_DT   /* 최근예약일 */

     , ( SELECT NVL(SUM(NVL(X.UNCL_AMT,0) -  NVL(X.RPY_AMT,0) - NVL(X.WOFF_AMT,0)),0)
           FROM ACPPEUND X /* 미수발생정보 테이블 */
          WHERE X.PT_NO = A.PT_NO
            AND X.UNCL_CTG_CD  = '1'  -- 미수분류코드
            -- 전남대 주석 , 보라매 확인 필요
            -- AND NVL(X.UNCL_RSN_CD,'*') &lt;&gt; '77'   -- 직원(급여공제)미수는 보이지 않도록 한다.(황계장)
            AND X.RPY_STS_YN  != 'Y' )                                                 AS UNCL_AMT     /* 미수금액 */

     , CASE WHEN A.GRTY_AMT_INPT_TP_CD IN ('23', '24') THEN '입원'
            ELSE '외래'
       END                                                                             AS PACT_TP_NM   /* 입원외래구분 */

     , FT_PCT_GETCTAD(A.PT_NO,'0','51')                                                AS PT_ADDR      /* 환자주소 */


 FROM ACPPEDPD A   /* 보증금액수납정보 테이블 */
WHERE  A.RPY_STF_NO = NVL(:IN_STF_NO,A.RPY_STF_NO)
  AND (A.RPY_DT BETWEEN TO_DATE(:IN_FROMDATE ,'yyyymmdd')
                    AND TO_DATE(:IN_TODATE   ,'yyyymmdd'))
  AND A.PRO_DT IS NULL /* 처리일자 */
  -- 보라매는 입원은 제외(외래)
  AND A.GRTY_AMT_INPT_TP_CD NOT IN ('21','22','25','26', '28', '29', '13', '14', '24')
  AND (  (:IN_PACT_TP_CD = 'A'  AND A.PACT_TP_CD IN ('O', 'E', 'I') )
      OR (:IN_PACT_TP_CD = 'O'  AND A.PACT_TP_CD IN ('O', 'E'))
      OR (:IN_PACT_TP_CD = 'I'  AND A.PACT_TP_CD IN ('I')) )

  <IsEqual Property="IN_JOBTYPE" CompareValue="U">
  AND A.RPY_AMT >= TO_NUMBER(:IN_UP_AMT)
  </IsEqual><IsEqual Property="IN_JOBTYPE" CompareValue="B">
  AND (A.RPY_AMT BETWEEN TO_NUMBER(:IN_FROM_AMT)
                     AND TO_NUMBER(:IN_TO_AMT))
  </IsEqual>

)
SELECT PT_NO                                AS PT_NO
     , PT_NM                                AS PT_NM
     , MED_DT                               AS MED_DT
     , MED_DEPT_CD                          AS MED_DEPT_CD
     , TEL_NO                               AS TEL_NO
     , RPY_DT                               AS RPY_DT
     , TO_CHAR(RPY_AMT,'999,999,999')       AS RPY_AMT
     , RPY_STF_NO                           AS RPY_STF_NO
     , STRG_AMT_RMK                         AS STRG_AMT_RMK
     , RCN_RSV_DT                           AS RCN_RSV_DT
     , TO_CHAR(UNCL_AMT,'999,999,999')      AS UNCL_AMT
     , PACT_TP_NM                           AS PACT_TP_NM
     , PT_ADDR                              AS PT_ADDR
 FROM TEMP

UNION ALL

SELECT '합계'                               AS PT_NO
     , NULL                                 AS PT_NM
     , NULL                                 AS MED_DT
     , '총 ' || COUNT(PT_NO) || ' 건'       AS MED_DEPT_CD
     , NULL                                 AS TEL_NO
     , NULL                                 AS RPY_DT
     , TO_CHAR(SUM(RPY_AMT),'999,999,999')  AS RPY_AMT
     , NULL                                 AS RPY_STF_NO
     , NULL                                 AS STRG_AMT_RMK
     , NULL                                 AS RCN_RSV_DT
     , TO_CHAR(SUM(UNCL_AMT),'999,999,999') AS UNCL_AMT
     , NULL                                 AS PACT_TP_NM
     , NULL                                 AS PT_ADDR
  FROM TEMP
 HAVING COUNT(PT_NO) > 0
 ORDER BY RPY_DT
        , MED_DT
        , PT_NO



;;;


SELECT A.CTAD_TP_CD , X.COMN_CD_NM FROM
PCTPCPTD A
, CCCCCSTE X
WHERE X.COMN_GRP_CD          = '23A'
AND X.COMN_CD              = A.CTAD_TP_CD

