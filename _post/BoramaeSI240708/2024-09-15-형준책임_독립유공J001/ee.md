<sql id="HIS.PA.AC.PC.AM.SelectDischargeBillPrinting00">
<!--
    Clss : text
    Desc : 입원환자 수납시 수납에 필요한 기본정보 조회   
    AS-IS : pkg_bil_acd100.pc_ac_ip_receipt_select
    Author : ezCareTech 박관
    Create date : 2012-09-18
    Update date : 2012-09-18 
    Update date : 2016-11-29  정종우. 유형정보  유형상세테이블에서 조회하도록 수정하고 정렬순서 지정
-->

 
 

SELECT /*  HIS.PA.AC.PC.AM.SELECTDISCHARGEBILLPRINTING00 */
   A.RPY_PACT_ID                                             RPY_PACT_ID  --수납원무접수ID
     ,  ''                                                        RPY_CLS_SEQ  --수납유형순번
     ,  B.PME_CLS_CD                                              PME_CLS_CD   --급종
     ,  B.PSE_CLS_CD                                              PSE_CLS_CD   --보조급종
     ,  '주-전체'                                                   MAIN_SUB_YN  -- 주부여부
     ,  TO_CHAR(MIN(APY_STR_DT), 'YYYY-MM-DD')                    APY_STR_DT
     ,  TO_CHAR(MAX(APY_END_DT), 'YYYY-MM-DD')                    APY_END_DT
     ,  NVL(MAX(A.RROBT_TP_CD), 'N')                              RROBT_TP_CD    --희귀난치성계산여부
     ,  MAX(A.CLNL_RSCH_NO)                                       LABNO        --임상연구번호
     ,  DECODE(MIN(A.BSCR_TP_CD), 'P', '심사완료'
                                , 'I', '심사중'
                                     , '미심사')                     BSCR_TP_CD
     ,  MIN(A.PRNT_YN)                                            PRNT_YN  --계산서출력여부
     ,  MAX(A.DRG_DTMN_YN)                                             DRG_YN  --DRG 확정여부
     ,  MAX((SELECT INDV_UNCL_RSN_CD
               FROM ACPPEIPD AA
              WHERE AA.RPY_PACT_ID = A.RPY_PACT_ID
                AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                AND AA.APY_STR_DT  = A.APY_STR_DT
                AND AA.RPY_STS_CD = 'Y'
                AND AA.INDV_UNCL_RSN_CD IN ('16','40')
                AND AA.CNCL_DT IS NULL
                AND ROWNUM = 1 ))                          INDV_UNCL_RSN_CD
     ,  TO_CHAR(SUM((SELECT SUM(NVL(UNCL_AMT,0))
                       FROM ACPPEIPD AA
                      WHERE AA.RPY_PACT_ID = A.RPY_PACT_ID
                        AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                        AND AA.APY_STR_DT  = A.APY_STR_DT
--                        AND AA.RPY_STS_CD = 'Y'
                        AND AA.INDV_UNCL_RSN_CD IN ('16','40')
--                        AND AA.CNCL_DT IS NULL
                                               )), '999,999,999')  UNCL_AMT
     ,  D.COMN_CD_NM                                              PSE_CLS_NM   --보조급종명
     ,  'N'           J001_YN

     ,  'N'           J002_YN

     ,  'N'           E012_YN

     ,  'N'           E013_YN
     ,  '0'           VAT 
  FROM ACPPRIRE A
     , ACPPRAAM B
     , CCCCCSTE D
 WHERE A.PT_NO   = :IN_PT_NO
   AND B.ADS_DT  = (SELECT MAX(C.ADS_DT)
                      FROM ACPPRAAM C
                     WHERE C.PT_NO   = B.PT_NO
                       AND C.APCN_DTM IS NULL
                       AND C.ADS_DT <= NVL(TO_DATE(:IN_ADS_DT,'YYYYMMDD'), TRUNC(SYSDATE)))

   AND A.RPY_PACT_ID = B.PACT_ID
   AND A.MAIN_SUB_YN = 'Y'
   AND A.APCN_DTM IS NULL
   AND D.COMN_GRP_CD = '357'
   AND B.PSE_CLS_CD = D.COMN_CD 

 GROUP BY  B.PME_CLS_CD
        ,  B.PSE_CLS_CD
        ,  A.MAIN_SUB_YN
        --,  A.DRG_DTMN_YN
        ,  A.RPY_PACT_ID
        ,  D.COMN_CD_NM   

 UNION ALL

SELECT  A.RPY_PACT_ID                                        RPY_PACT_ID  --수납원무접수ID
     ,  TO_CHAR(A.RPY_CLS_SEQ)                               RPY_CLS_SEQ  --수납유형순번
     ,  A.PME_CLS_CD                                         PME_CLS_CD   --급종
     ,  A.PSE_CLS_CD                                         PSE_CLS_CD   --보조급종
     ,  '주'                                                  MAIN_SUB_YN  -- 주부여부
     ,  TO_CHAR(APY_STR_DT, 'YYYY-MM-DD')                    APY_STR_DT
     ,  TO_CHAR(APY_END_DT, 'YYYY-MM-DD')                    APY_END_DT
     ,  NVL(A.RROBT_TP_CD, 'N')                              RROBT_TP_CD    --희귀난치성계산여부
     ,  A.CLNL_RSCH_NO                                       LABNO        --임상연구번호
     ,  DECODE(A.BSCR_TP_CD, 'P', '심사완료'
                           , 'I', '심사중'
                               , '미심사')                     BSCR_TP_CD
     ,  A.PRNT_YN                                             PRNT_YN  --계산서출력여부
     ,  A.DRG_DTMN_YN                                         DRG_YN  --DRG 확정여부
     ,  (SELECT INDV_UNCL_RSN_CD
               FROM ACPPEIPD AA
              WHERE AA.RPY_PACT_ID = A.RPY_PACT_ID
                AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                AND AA.APY_STR_DT  = A.APY_STR_DT
                AND AA.RPY_STS_CD = 'Y'
                AND AA.INDV_UNCL_RSN_CD IN ('16','40')
                AND AA.CNCL_DT IS NULL
                AND ROWNUM = 1)                          INDV_UNCL_RSN_CD
     ,  TO_CHAR((SELECT SUM(NVL(UNCL_AMT,0))
                       FROM ACPPEIPD AA
                      WHERE AA.RPY_PACT_ID = A.RPY_PACT_ID
                        AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                        AND AA.APY_STR_DT  = A.APY_STR_DT
                        AND AA.RPY_STS_CD = 'Y'
                        AND AA.INDV_UNCL_RSN_CD IN ('16','40')
                        AND AA.CNCL_DT IS NULL), '999,999,999')   UNCL_AMT
     ,  D.COMN_CD_NM                                              PSE_CLS_NM   --보조급종명
     , --20240914 성현석 계약처 하드코딩 제거
       --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'J001' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --)
       'N' AS J001_YN 
     , --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'J002' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --) 
       'N' AS J002_YN 
     , --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'E012' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --) 
       'N' AS E012_YN 
     , --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'E013' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --)
       'N' AS E013_YN 

     -- 0 : 이상없음 
     -- 1 : VT유형에 VT가 없음
     -- 2 : 유형분리 필요
     -- 3 : 유형변경 필요   
     -- 4 : 단순 알림(퇴식끼니) 
     , DECODE((
                SELECT XBIL.FT_ACP_VAT_CHECK( A.PT_NO , NULL , 'I' , A.RPY_PACT_ID , A.RPY_CLS_SEQ ) 
                FROM   DUAL 
               ) , 'NO', DECODE(SUBSTR(A.PSE_CLS_CD, 1, 2), 'VT', '1' , '0')
                 , 'MX', '2'
                 , 'VT', DECODE(SUBSTR(A.PSE_CLS_CD, 1, 2), 'VT', '0'
                                                                , '3')
                 , 'ML', '4' 
                 , '0')  VAT
  FROM ACPPRIRE A
     , ACPPRAAM B
     , CCCCCSTE D
 WHERE A.PT_NO   = :IN_PT_NO
   AND B.ADS_DT  = (SELECT MAX(C.ADS_DT)
                      FROM ACPPRAAM C
                     WHERE C.PT_NO   = B.PT_NO
                       AND C.APCN_DTM IS NULL
                       AND C.ADS_DT <= NVL(TO_DATE(:IN_ADS_DT,'YYYYMMDD'), TRUNC(SYSDATE)))

   AND A.RPY_PACT_ID = B.PACT_ID
   AND A.MAIN_SUB_YN = 'Y'
   AND A.APCN_DTM IS NULL
   AND D.COMN_GRP_CD = '357'
   AND B.PSE_CLS_CD = D.COMN_CD 

 UNION ALL

 SELECT A.RPY_PACT_ID                                             RPY_PACT_ID  --수납원무접수ID
     ,  TO_CHAR(A.RPY_CLS_SEQ)                                    RPY_CLS_SEQ  --수납유형순번
     ,  A.PME_CLS_CD                                              PME_CLS_CD      --급종
     ,  A.PSE_CLS_CD                                              PSE_CLS_CD       --보조급종
     ,  '부'                                                       MAIN_SUB_YN  -- 주부여부
     ,  TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                       APY_STR_DT
     ,  TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                       APY_END_DT
     ,  NVL(A.RROBT_TP_CD, 'N')                                   RROBT_TP_CD       --희귀난치성계산여부
     ,  A.CLNL_RSCH_NO                                            CLNL_RSCH_NO    --임상연구번호
     ,  DECODE(A.BSCR_TP_CD, 'P', '심사완료'
                           , 'I', '심사중'
                                , '미심사')                        BSCR_TP_CD
     ,  A.PRNT_YN                                                 PRNT_YN  --계산서출력여부
     ,  DECODE(A.BSCR_TP_CD, 'P', B.DRG_YN
                                , B.ADIT_DRG_APY_YN)              DRG_YN  --DRG 확정여부
     ,  (SELECT INDV_UNCL_RSN_CD
               FROM ACPPEIPD AA
              WHERE AA.RPY_PACT_ID = A.RPY_PACT_ID
                AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                AND AA.APY_STR_DT  = A.APY_STR_DT
                AND AA.RPY_STS_CD = 'Y'
                AND AA.INDV_UNCL_RSN_CD IN ('16','40')
                AND AA.CNCL_DT IS NULL
                AND ROWNUM = 1)                                  INDV_UNCL_RSN_CD
     ,  (SELECT TO_CHAR(SUM(NVL(UNCL_AMT,0)), '999,999,999')
               FROM ACPPEIPD AA
              WHERE AA.RPY_PACT_ID = A.RPY_PACT_ID
                AND AA.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                AND AA.APY_STR_DT  = A.APY_STR_DT
                AND AA.RPY_STS_CD = 'Y'
                AND AA.INDV_UNCL_RSN_CD IN ('16','40')
                AND AA.CNCL_DT IS NULL)                           UNCL_AMT
     ,  D.COMN_CD_NM                                              PSE_CLS_NM   --보조급종명
     , -- 20240914 성현석 계약처 하드코딩 제거
       --  (
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'J001' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --)
       'N'  AS J001_YN 
     , --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'J002' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --)
       'N' AS J002_YN 
     , --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'E012' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --)
       'N' AS E012_YN 
     , --(
       -- SELECT XBIL.FT_ACP_EMPNO_EXIST_YN( 'E013' , A.RPY_PACT_ID , A.RPY_CLS_SEQ , A.APY_STR_DT ) 
       -- FROM   DUAL 
       --)
       'N' AS E013_YN 
     -- 0 : 이상없음 
     -- 1 : VT유형에 VT가 없음
     -- 2 : 유형분리 필요
     -- 3 : 유형변경 필요  
     -- 4 : 단순 알림(퇴식끼니) 
     , DECODE((
                SELECT XBIL.FT_ACP_VAT_CHECK( A.PT_NO , NULL , 'I' , A.RPY_PACT_ID , A.RPY_CLS_SEQ ) 
                FROM   DUAL 
               ) , 'NO', DECODE(SUBSTR(A.PSE_CLS_CD, 1, 2), 'VT', '1' , '0')
                 , 'MX', '2'
                 , 'VT', DECODE(SUBSTR(A.PSE_CLS_CD, 1, 2), 'VT', '0'
                                                                , '3')
                 , 'ML', '4' 
                 , '0')  VAT
  FROM ACPPRIRE A
     , ACPPRAAM B
     , CCCCCSTE D
 WHERE A.PT_NO   = :IN_PT_NO
   AND A.RPY_PACT_ID = B.PACT_ID
   AND B.ADS_DT  = (SELECT MAX(C.ADS_DT)
                      FROM ACPPRAAM C
                     WHERE C.PT_NO   = B.PT_NO
                       AND C.APCN_DTM IS NULL
                       AND C.ADS_DT <= NVL(TO_DATE(:IN_ADS_DT,'YYYYMMDD'), TRUNC(SYSDATE)))
   AND A.MAIN_SUB_YN = 'N'
   AND A.APCN_DTM IS NULL
   AND D.COMN_GRP_CD = '357'
   AND B.PSE_CLS_CD = D.COMN_CD 
 ORDER BY MAIN_SUB_YN DESC, RPY_CLS_SEQ ,APY_STR_DT






 </sql>