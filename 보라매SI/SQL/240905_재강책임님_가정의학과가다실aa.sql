
EXEC :PT_NO       := '01463828';
EXEC :MED_DEPT_CD := '05296';

SELECT
    A.PT_NO PT_NO ,
    A.PME_CLS_CD PME_CLS_CD ,
    A.PSE_CLS_CD PSE_CLS_CD ,
    B.INS_END_DT INS_END_DT
    FROM
    ACPPRODM A ,
    ACPPRPID B
    WHERE A.PT_NO = NVL ( :PT_NO , A.PT_NO )
    AND A.MED_DEPT_CD = NVL ( :MED_DEPT_CD , A.MED_DEPT_CD )
    AND A.PT_NO = B.PT_NO
    AND A.PME_CLS_CD = DECODE ( A.PME_CLS_CD , 'AA' , A.PME_CLS_CD , B.PME_CLS_CD )
    AND A.PSE_CLS_CD NOT IN('N00','N01','N02','N03','N04','N05','N10','N20','N21','N30','N31','N90','N80','N81','N82','N83','N06','N07','N22','N32')
    and A.APCN_DTM IS NULL
    AND A.MED_DT = (select max(MED_DT) FROM ACPPRODM z
                                    WHERE z.PT_NO = A.PT_NO
                                    and  z.MED_DEPT_CD = A.MED_DEPT_CD
                                    and  Z.HSP_TP_CD = A.HSP_TP_CD
                                    and  z.apcn_dtm is null -- 2021.02.10 apcn_dtm 제외 조건 추가
                                    and  z.MED_DT <= SYSDATE      )
    AND A.MED_DT BETWEEN B.INS_APY_DT AND NVL ( B.INS_END_DT , SYSDATE)



;;;
;;;
;;;


SELECT /* HIS.PA.AC.PE.AP.SelEachPtMtdClassfiedByTheLatestPmePse */
NVL ( INFO.PME_CLS_CD , PAT.PME_CLS_CD ) PME_CLS_CD , /* 여기서 AA가 나오는데 */
NVL ( INFO.PSE_CLS_CD , PAT.PSE_CLS_CD ) PSE_CLS_CD ,
INFO.INS_END_DT INS_END_DT ,
DECODE
( substr(FT_ACP_FRVS_RMDE_TP
    (  :IN_JOBTYPE
        , :OLD_MED_DEPT_CD
        , :MED_DEPT_CD
        , PAT.PT_NO
        ,''
        , :MEDR_STF_NO
        , 'CALL' ),1,2) , '초진' , '1'
    , '재진' , '2'
    , '신환' , '3'
    , '재초' , '4' )
FRVS_RMDE_TP_CD
,
FT_ACP_FRVS_RMDE_TP
(   :IN_JOBTYPE
    , :OLD_MED_DEPT_CD
    , :MED_DEPT_CD
    , PAT.PT_NO
    , ''
    , :MEDR_STF_NO
    , 'CALL' )
FRVS_RMDE_TP_NM
,
FT_ACP_DEPENT_INF
(    'Y'
    , PAT.PT_NO
    , :MED_DEPT_CD )
DEPENT_INF
FROM
PCTPCPAM PAT ,
(
    SELECT
    A.PT_NO PT_NO ,
    A.PME_CLS_CD PME_CLS_CD ,
    A.PSE_CLS_CD PSE_CLS_CD ,
    B.INS_END_DT INS_END_DT
    FROM
    ACPPRODM A ,
    ACPPRPID B
    WHERE A.PT_NO = NVL ( :PT_NO , A.PT_NO )
    AND A.MED_DEPT_CD = NVL ( :MED_DEPT_CD , A.MED_DEPT_CD )
    AND A.PT_NO = B.PT_NO
    AND A.PME_CLS_CD = DECODE ( A.PME_CLS_CD , 'AA' , A.PME_CLS_CD , B.PME_CLS_CD )
    AND A.PSE_CLS_CD NOT IN('N00','N01','N02','N03','N04','N05','N10','N20','N21','N30','N31','N90','N80','N81','N82','N83','N06','N07','N22','N32')
    and A.APCN_DTM IS NULL
    AND A.MED_DT = (select max(MED_DT) FROM ACPPRODM z
                                    WHERE z.PT_NO = A.PT_NO
                                    and  z.MED_DEPT_CD = A.MED_DEPT_CD
                                    and  Z.HSP_TP_CD = A.HSP_TP_CD
                                    and  z.apcn_dtm is null -- 2021.02.10 apcn_dtm 제외 조건 추가
                                    and  z.MED_DT <= SYSDATE      )
    AND A.MED_DT BETWEEN B.INS_APY_DT AND NVL ( B.INS_END_DT , SYSDATE )
)
INFO
WHERE PAT.PT_NO = :PT_NO
AND INFO.PT_NO ( + ) = PAT.PT_NO
AND ROWNUM = 1

;;;
