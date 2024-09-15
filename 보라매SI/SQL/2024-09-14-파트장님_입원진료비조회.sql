EXEC :IN_MED_STR_DT := '20230825';
EXEC :IN_MED_END_DT := '20240825';
exec :IN_RPY_PACT_ID  := 'M0500792041202403220002'  ;
exec  :IN_RPY_CLS_SEQ := 'AMEALM' ;


SELECT /* HIS.PA.AC.PC.OP.OTPTEMERGENCYMEDCOSTASK_17 */
       A.RPY_CLS_SEQ                                         AS RPY_CLS_SEQ
     , A.PME_CLS_CD                                          AS PME_CLS_CD
     , A.PSE_CLS_CD                                          AS PSE_CLS_CD
     , XBIL.FT_ACP_COMN_CD_NM_SINGLE('356', A.PME_CLS_CD)    AS PME_CLS_CD_NM
     , XBIL.FT_ACP_COMN_CD_NM_SINGLE('357', A.PSE_CLS_CD)    AS PSE_CLS_CD_NM
     , TO_CHAR(A.APY_STR_DT, 'YYYY-MM-DD')                   AS APY_STR_DT
     , TO_CHAR(A.APY_END_DT, 'YYYY-MM-DD')                   AS APY_END_DT
     , A.MAIN_SUB_YN                                         AS MAIN_SUB_YN
  FROM ACPPRIRE A
 WHERE A.RPY_PACT_ID  = NVL(:IN_RPY_PACT_ID,A.RPY_PACT_ID)
   AND A.APY_STR_DT <= TO_DATE(:IN_MED_STR_DT, 'YYYYMMDD')
   AND A.APY_END_DT >= TO_DATE(:IN_MED_END_DT, 'YYYYMMDD')
   AND A.APCN_DTM IS NULL -- 접수취소여부
   AND NOT EXISTS (SELECT 'NOT EXISTS'
                     FROM ACPPRIRE Z
                    WHERE A.RPY_PACT_ID = NVL(:IN_RPY_PACT_ID,A.RPY_PACT_ID)
                      AND A.RPY_CLS_SEQ = :IN_RPY_CLS_SEQ
                      AND A.APY_STR_DT  = TO_DATE(:IN_APY_STR_DT, 'YYYYMMDD')
                      )

 ;


 SELECT * FROM ACPPRIRE WHERE ROWNUM <10;

select *
from MSGCRRVD
where pt_no = '00792041'
--and ord_Dt = '2024-08-25'
;
select *
from ACPPRARD
where pt_no = '00792041'
   AND ORD_ID = 'M0500792041202309130004'
;


SELECT *
FROM ACPPRARH
WHERE PT_NO = '00792041';

SELECT *
FROM AIMIRPMC
WHERE ROWNUM <10
   AND MIF_CD = 'AMEALM'

;
;
AND PT_NO = '00792941';

SELECT *
FROM ACPPEICE
WHERE ROWNUM < 10
AND   RPY_PACT_ID = 'M0500792041202309130004'
            
;


SELECT*
FROM ACPPRIRE
WHERE PT_NO = '00792041'

;




----------------------------------------------------------------------------------------------------------------------------------
EXEC :MIF_ACCM_CTG_CD := 'BB';
exec :IN_RPY_PACT_ID  := ''  ;
exec :IN_RPY_CLS_SEQ := 'AMEALM' ;
EXEC :IN_APY_STR_DT := '20230825';
EXEC :IN_APY_END_DT := '20240914';






             SELECT  /* HIS.PA.AC.PC.OP.OTPTEMERGENCYMEDCOSTASK_15 */
                    DECODE(A.VAT_ADN_YN, 'Y', '#'||B.MIF_CD, B.MIF_CD)                                              SUGACODE
                  , B.KOR_MIF_NM  ||
                  --,  DECODE(NVL(A.CMED_INCS_DMD_YN,'N'),'Y','(산재)','')|| B.KOR_MIF_NM  ||
                     decode(substr(a.ord_id,1,4),'DIET',DECODE( substr(a.ord_id, LENGTH(A.ORD_ID) ,1),'1','-조식','2','-중식','3','-석식')
                                                                        ,NULL)                                      KORNAME

                  ,  DECODE(A.CNCL_DTM,NULL,A.MIFI_TP_CD,'*' || A.MIFI_TP_CD )                                      INSTYPE          -- 수가보험구분코드
                  ,  TO_CHAR(A.ORD_UNPR)                                                                            PRICE            -- 처방단가
                  ,  TO_CHAR(A.HSP_ADN_ICLS_AMT)                                                                    SUMPRICE         -- 병원가산포함금액
                  ,  TO_CHAR(A.CMED_AMT)                                                                            SPCPRICE         -- 선택진료금액
                  --,  DECODE(B.MIF_INPT_UNIT_CD,'4', DECODE(A.ANST_MI_CNT, 0, TO_CHAR(A.ANST_TM_CNT * A.ORD_DYS)
                  --                                                         , TO_CHAR(A.ANST_TM_CNT))
                  --,  TO_CHAR(A.USE_QTY))                                                                            USEQTY           -- 사용수량
                  ,  TO_CHAR(A.USE_QTY)                                                                             USEQTY           -- 사용수량
                  ,  TO_CHAR(A.ADN_QTY)                                                                             ADDQTY           -- 가산수량
                  ,  TO_CHAR(A.ORD_NOTM)                                                                            USECNT           -- 처방횟수
                  --,  DECODE(B.MIF_INPT_UNIT_CD,'4',TO_CHAR(A.ANST_MI_CNT * A.ORD_DYS)
                  --                        ,TO_CHAR(A.ORD_DYS))                                                      USEDAY           -- 처방일수
                  ,  TO_CHAR(A.ORD_DYS)                                                                             USEDAY           -- 처방일수
                  ,  TO_CHAR(A.FMT_DT,'YYYY-MM-DD')                                                                 EXAMDATE         -- 수행일자
                  ,  A.ADD_CPUT_MIF_CD                                                                              NEXTCODE         -- 추가산정수가코드
                  ,  XCOM.FT_CNL_SELSTFINFO('4',A.LSH_STF_NO,TO_CHAR(A.MED_DT,'YYYYMMDD'))
                     || '-' || A.OCUR_PACT_TP_CD                                                                    RCPID            -- 최종변경직원번호
                  ,  TO_CHAR(A.CNCL_DTM,'YYYY-MM-DD')                                                               REJTDATE         -- 취소일시
--                  ,  TO_CHAR(A.PBDN_AMT)                                                                            OWNAMT           -- 본인부담금액
                  ,  TO_CHAR(CASE WHEN A.ADS_DT >= TO_DATE('20161119','YYYYMMDD') THEN A.PBDN_AMT
                                    ELSE
                                         TO_NUMBER(TRIM(SUBSTR(XBIL.FT_ACP_CALCULATE_OWNAMT( A.PT_NO
                                                                                           , A.PACT_TP_CD
                                                                                           , A.PME_CLS_CD
                                                                                           , A.PSE_CLS_CD
                                                                                           , A.MED_DT
                                                                                           , A.MIFI_TP_CD
                                                                                           , A.MIF_ACCM_CTG_CD
                                                                                           , A.HSP_ADN_ICLS_AMT
                                                                                           , ''   --IN_DRUGYN
                                                                                           , ''   --RAREYN
                                                                                           , ''   --SBRDNTYPE
                                                                                           , ''   -- TOTGUBUN
                                                                                           , A.MED_DEPT_CD
                                                                                           , A.RPY_PACT_ID
                                                                                           , A.RPY_CLS_SEQ
                                                                                           , NULL  -- RPY_SEQ
                                                                                           , A.SEPAD_TP_CD
                                                                                           , A.SEPAD_FAMT_AMT
                                                                                           , A.MIF_ACCM_CTG_DTL_CD
                                                                                           ),1,10)))
                               END)                                                                                  OWNAMT
                  ,  TO_CHAR(A.MED_DT,'YYYYMMDD')                                                                   MEDDATE          -- 처방일자
                  ,  TO_CHAR(A.CALC_SEQ)                                                                            SEQNO            -- 계산순번
                  ,  XCOM.FT_CNL_SELSTFINFO('4',A.CHDR_STF_NO,TO_CHAR(A.MED_DT,'YYYYMMDD'))                         SPCDRNM          -- 선택의직원성명
                  ,  TO_CHAR(A.LSH_DTM,'YYYYMMDD HH24:MI')                                                          EDITDATE         -- 최종변경일시
                  ,  DECODE(SIGN(A.LSH_DTM-NVL(G.PRNT_DTM,A.LSH_DTM+1)),-1,'BEFORE',
                                                                             'AFTER')                               EDITTYPE         -- 수정구분
                  ,  NVL(E.AADP_CD,'**')                                                                            EDITDEPT         -- 수정자의 진료과
                  ,  G.SIHS_YN                                                                                      STAYYN           -- 입원여부
                  ,  G.PRNT_TP_YN                                                                                   PRINTYN          --프린트여부
                  ,  NVL(A.PROR_ML_YN,'N')                                                                          OBJTCLS          --보호자식여부
                  ,  A.ORD_ID                                                                                       ORD_ID           --처방ID
                  ,  A.ORD_INPT_TBL_NM                                                                              ORD_TBL_NM       --처방입력테이블명
                  ,  A.MIF_ACCM_CTG_CD                                                                              MIF_ACCM_CTG_CD  --항목별구분코드
--                  ,  DECODE(A.ORD_CD,A.MIF_CD,'G','S')                                                              MIF_GUBUN        -- 그룹오더구분(G = 부모, S = 자식)
                  , DECODE(A.ORD_CD,A.MIF_CD,'G'  , DECODE(NVL(:MIF_ACCM_CTG_CD,'00'),  '89'
                                            , DECODE( (SELECT K.SEPAD_TP_CD
                                                         FROM ACPPEICE K
                                                        WHERE K.RPY_PACT_ID = A.RPY_PACT_ID
                                                          AND K.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                                                          AND K.ORD_ID = A.ORD_ID
                                                          AND K.ORD_CD = A.ORD_CD
                                                          AND K.ORD_CD = K.MIF_CD
                                                          AND K.PME_CLS_CD = A.PME_CLS_CD
                                                          AND K.PSE_CLS_CD = A.PSE_CLS_CD
                                                          AND ROWNUM = 1
                                                           ), '0', DECODE(A.SEPAD_TP_CD, '0', 'S', 'G'), 'S')
                                                              , 'S')
                                                           )                                                        MIF_GUBUN        -- 그룹오더구분(G = 부모, S = 자식)
                  ,  A.ORD_MDF_TP_CD                                                                                EDITTYPE         --  처방수정구분코드
                  ,  F.AOA_WKDP_CD                                                                                  MEDDEPT          --  진료부서코드
                  ,  G.BSCR_TP_CD                                                                                   BSCR_TP_CD       --사전심사구분코드
                  ,  TO_CHAR(A.MED_DT,'YYYYMMDD')                                                                   MED_DT --진료일자    --처방의 진료과 20130405
                  ,  A.RPY_PACT_ID                                                                                  RPY_PACT_ID      --수납원무접수ID
                  ,  A.RPY_CLS_SEQ                                                                                  RPY_CLS_SEQ      --수납유형순번
                  ,  FT_ACD_RT_RJT_CODE('2', A.ORD_ID, A.ORD_INPT_TBL_NM)                                           RETURNYN
                  ,  FT_ACD_RT_RJT_CODE('3', A.ORD_ID, A.ORD_INPT_TBL_NM)                                           NOTE
                  ,  decode(a.ORD_INPT_TBL_NM, 'MOOOREXM', (select SUBSTRB(J.COMN_CD_NM ,1,4)
                                                             from MOOOREXM k
                                                                , CCCCCSTE j
                                                            where k.pt_no   = a.pt_no
                                                              and k.ORD_ID  = a.ord_id
                                                              AND j.COMN_CD = k.EXM_PRGR_STS_CD
                                                              AND j.COMN_GRP_CD     = '414'
                                                              AND ROWNUM = 1)
                                                         , '') EXAMSTAT
                  ,  B.INS_EDI_CD                                                                                   EDICODE
                  ,  FT_ACD_ORD_EXAMDATE(a.ORD_INPT_TBL_NM, a.ORD_ID, a.RPY_PACT_ID)                                EXAMDATE_ORDER
                  ,  decode(a.EXCP_SEPAD_TP_CD, 'B', b.EXCP_SEPAD_TP_CD
                                              , 'E', b.EXCP_SEPAD_TP_CD
                                                   , null)                                                          CINSORDINTYPE   -- 선별급여
                  ,  b.EXCP_SEPAD_TP_CD                                                                             CINSMIFINTYPE   -- 선별급여 (수가)
                  , A.MED_ORD_CD                                                                                 AS ORDCODE --2024.07.15 신동명 추가
                  , (SELECT TO_CHAR(Z.APY_STR_DT, 'YYYYMMDD')
                       FROM ACPPRIRE Z
                      WHERE Z.RPY_PACT_ID = A.RPY_PACT_ID
                        AND Z.RPY_CLS_SEQ = A.RPY_CLS_SEQ
                        AND A.MED_DT BETWEEN Z.APY_STR_DT
                                         AND Z.APY_END_DT) AS APY_STR_DT
                  ,  A.WK_SEQ                                AS WK_SEQ  -- 2024.09.06 김재강 추가
               FROM  ACPPRAAM G
                  ,  CNLRRUSD E
                  ,  AIMIRPMC B
                  ,  ACPPEICE A
                  ,  CNLRRUSD F                   --처방의 진료과 20130405
              WHERE
                   A.RPY_PACT_ID = NVL(:IN_RPY_PACT_ID,A.RPY_PACT_ID)
                 AND  A.RPY_CLS_SEQ = DECODE( :IN_RPY_CLS_SEQ ,'0',A.RPY_CLS_SEQ , :IN_RPY_CLS_SEQ)
                 AND  A.MED_DT   BETWEEN  :IN_APY_STR_DT
                                    AND  :IN_APY_END_DT

                AND  (( A.CNCL_DTM IS NOT NULL AND NVL(ORD_MDF_TP_CD,'*') IN ( 'Q','D')) OR ( A.CNCL_DTM IS NULL ))
                AND ((A.MIF_ACCM_CTG_CD   IN (NVL(SUBSTRB(:MIF_ACCM_CTG_CD,1,2),A.MIF_ACCM_CTG_CD), SUBSTRB(:MIF_ACCM_CTG_CD,3,2), SUBSTRB(:MIF_ACCM_CTG_CD,5,2), SUBSTRB(:MIF_ACCM_CTG_CD,7,2)
                                                , SUBSTRB(:MIF_ACCM_CTG_CD,9,2), SUBSTRB(:MIF_ACCM_CTG_CD,11,2), SUBSTRB(:MIF_ACCM_CTG_CD,13,2), SUBSTRB(:MIF_ACCM_CTG_CD,15,2)
                                                , SUBSTRB(:MIF_ACCM_CTG_CD,17,2),SUBSTRB(:MIF_ACCM_CTG_CD,19,2), SUBSTRB(:MIF_ACCM_CTG_CD,21,2), SUBSTRB(:MIF_ACCM_CTG_CD,23,2)
                                                , SUBSTRB(:MIF_ACCM_CTG_CD,25,2),SUBSTRB(:MIF_ACCM_CTG_CD,27,2), SUBSTRB(:MIF_ACCM_CTG_CD,29,2), SUBSTRB(:MIF_ACCM_CTG_CD,31,2)
                                                , SUBSTRB(:MIF_ACCM_CTG_CD,33,2),SUBSTRB(:MIF_ACCM_CTG_CD,35,2), SUBSTRB(:MIF_ACCM_CTG_CD,37,2), SUBSTRB(:MIF_ACCM_CTG_CD,39,2)) AND NVL(A.SEPAD_TP_CD,'*')  NOT IN  ('A', 'B','D', 'E' ) )
                OR  (NVL(:MIF_ACCM_CTG_CD,'00') = '30' AND  A.MIFI_TP_CD  = '3' AND NVL(A.SEPAD_TP_CD,'*')  NOT IN  ('A', 'B','D', 'E' )  )
                OR  (NVL(:MIF_ACCM_CTG_CD,'00') = '20'
                     AND  (A.RPY_PACT_ID,A.RPY_CLS_SEQ,A.MED_DT,A.CALC_SEQ,A.WK_SEQ) IN (SELECT X.RPY_PACT_ID,X.RPY_CLS_SEQ,X.MED_DT,X.CALC_SEQ,X.WK_SEQ
                                                                                                 FROM ACPPEICE X
                                                                                                WHERE X.RPY_PACT_ID  = A.RPY_PACT_ID
                                                                                                  AND X.RPY_CLS_SEQ  = A.RPY_CLS_SEQ
                                                                                                  AND X.MED_DT       = A.MED_DT
                                                                                                  AND X.ORD_CD       = A.ORD_CD
                                                                                                  AND X.MIF_TP_CD    = 'G'
                                                                                                  AND X.MIF_ACCM_CTG_CD   = '20') AND NVL(A.SEPAD_TP_CD,'*')  NOT IN  ('A', 'B','D', 'E' ) )
                OR  (NVL(:MIF_ACCM_CTG_CD,'00') = '89' AND  NVL(A.SEPAD_TP_CD,'*')  IN  ('A', 'B','D', 'E') )   -- 2023.03.15. 영수증 양식 변경 참조
                                OR  NVL(:MIF_ACCM_CTG_CD, '00') = '00'
                )

                --AND  NVL(A.ARCL_DMD_FUS_CD_YN, 'N')  != 'Y'    --분당 추가필드인듯.. 일단 주석처리함.  JJW 20160126

                --20161108 JJW 투약주사료 관련 조건 추가함. 긴가민가하네.. PKG_ACP_CALC_IP.PC_ACP_IP_RCPLIST_SEL   과 연계되고 있음

                AND  ( CASE WHEN SUBSTRB(:MIF_ACCM_CTG_CD,1,3) IN ('051','061','581') THEN :MIF_ACCM_CTG_CD
                       WHEN SUBSTRB(:MIF_ACCM_CTG_CD,1,3) IN ('05','06','58') THEN :MIF_ACCM_CTG_CD || CASE WHEN  A.ACMT_TP_CD ='1' THEN '' ELSE A.ACMT_TP_CD  END
                       ELSE A.MIF_ACCM_CTG_CD || A.ACMT_TP_CD END) = A.MIF_ACCM_CTG_CD || A.ACMT_TP_CD

                AND  B.MIF_CD     =  A.MIF_CD
                AND  B.APY_STR_DT = (SELECT  MAX(BB.APY_STR_DT)
                                       FROM  AIMIRPMC BB
                                      WHERE  BB.MIF_CD     = B.MIF_CD
                                        AND  BB.APY_STR_DT <= A.MED_DT)

                AND  E.STF_NO(+) = A.LSH_STF_NO
                AND  G.PACT_ID   = A.RPY_PACT_ID
--                AND  G.APCN_YN   = 'N'  --필드 삭제되고 접수취소일자 유무로 판단. JJW 20160126
                AND G.APCN_DTM IS NULL
                AND  F.STF_NO(+) = A.CHDR_STF_NO        --처방의 진료과 20130405
              ORDER  BY
                     A.PT_NO
                  ,  A.RPY_PACT_ID
                  ,  A.MED_DT
                  ,  A.ORD_ID --추가
                  ,  A.ADD_CPUT_MIF_CD
                  ,  CALC_SEQ, A.WK_SEQ  , MIF_GUBUN --테스트중
--                  ,  A.WK_SEQ, CALC_SEQ , MIF_GUBUN --원래소스
;
