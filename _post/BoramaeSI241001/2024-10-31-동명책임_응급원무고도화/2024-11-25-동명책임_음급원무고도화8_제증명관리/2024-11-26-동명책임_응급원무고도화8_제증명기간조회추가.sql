


EXEC :IN_PT_NO := '01145846';
EXEC :IN_PACT_TP_CD := '0000273487';
EXEC :IN_FROM_DT := '20211125';
EXEC :IN_TO_DT := '20241126';

--@1 수가 있는 거만 조회한다.
     SELECT /* HIS.PA.AC.PE.CF.CtfsIssuAskSQL */
       DISTINCT
       A.MED_DT
      ,A.MIF_CD
      ,(SELECT '[원본] '
             FROM CCCCCUTE D
            WHERE D.COMN_GRP_CD = 'MD00794'
              AND D.DTRL1_NM = A.MIF_CD
              AND ROWNUM =1)
           ||D.KOR_MIF_NM                                               MIF_NM
      ,A.PACT_TP_CD
      ,DECODE(A.PACT_TP_CD,'I','입원'
                          ,'O','외래'
                          ,'E','응급')                              PACT_TP_NM
      ,A.MED_DEPT_CD
      ,B.DEPT_NM                                                  MED_DEPT_NM
      ,DECODE(A.PACT_TP_CD,'I',E.WD_DEPT_CD,'')                   WD_DEPT_CD
      ,A.DR_STF_NO
      ,C.STF_NM                                                   DR_STF_NM
      ,A.ISSU_QTY
      ,A.OFSL_SEAL_DT
      ,A.OFSL_SEAL_YN
      ,A.PT_NO
      ,A.ADS_DT
      ,A.ACPT_SEQ
      ,A.ACPT_DT
      ,A.RPY_SEQ
      ,A.ISSU_SEQ
      ,A.ISSU_RMK
      ,DECODE(A.PACT_TP_CD, 'O', '', E.WD_DEPT_CD||'-'||E.PRM_NO) TOT_WD_DEPT_CD
--      ,SIGN(E.ORD_DYS )                                           ORD_DYS
      ,CASE WHEN A.OFSL_SEAL_DT IS NULL
            THEN 'N'
            ELSE 'Y'
             END                                                  CHK_YN
      ,'Y'                                                        DOD_EXIST_YN
      ,''                                                         MDRC_ID
  FROM ACPPRDOD A
      ,PDEDBMSM B
      ,CNLRRUSD C
      ,AIMIRPMC D
      ,ACPPRTSD E
 WHERE 1=1
   AND A.PT_NO        =  :IN_PT_NO
--   AND (   (:IN_PACT_TP_CD  = 'A')
--        OR (:IN_PACT_TP_CD != 'A' AND A.PACT_TP_CD = :IN_PACT_TP_CD ))

   AND A.MED_DEPT_CD  =  B.DEPT_CD(+)
   AND A.DR_STF_NO    =  C.STF_NO(+)
   AND A.MIF_CD       =  D.MIF_CD
   AND D.APY_STR_DT   = (SELECT MAX(APY_STR_DT)
                           FROM AIMIRPMC X
                          WHERE 1=1
                            AND X.MIF_CD      = A.MIF_CD
                            AND X.APY_STR_DT <= A.MED_DT)

   AND A.PT_NO          = E.PT_NO(+)
   AND A.MED_DT         BETWEEN E.APY_STR_DT(+)
                            AND E.APY_END_DT(+)

   AND E.APCN_DTM(+) IS NULL
   --AND A.PT_NO        =  E.PT_NO(+)
   --AND A.RPY_DT       =  E.CALC_DT(+)
   --AND A.MIF_CD       =  E.ORD_CD(+)
   --AND A.ADS_DT       =  E.MED_DT(+)
   --AND A.ISSU_QTY     =  E.ORD_DYS(+)*E.USE_QTY(+)
   --AND A.ISSU_QTY    <> 0
   -- 20240321 BRMH 성현석 의무기록발급수수료 제외
   AND A.MIF_CD  NOT IN ('Y83Q3','Y83Z')
   AND A.MIF_CD IS NOT NULL
 --@2 처지지시 및 기록이 있는 항목들만 조회한다.

   -- 2024-11-26 김용록 : 응급원무고도화 30번, 제증명조회에 기간 조회 추가
   AND A.MED_DT  BETWEEN TO_DATE(:IN_FROM_DT ,'YYYYMMDD')
                     AND TO_DATE( :IN_TO_DT ,'YYYYMMDD') + .99999
 UNION ALL

SELECT  /*+ INDEX(A MOOORTRM_SI04)*/
       TRUNC(A.REC_DTM)           AS ORD_DT
      ,A.ORD_CD              MIF_CD
      ,'[무료] '||D.COMN_CD_NM                                              MIF_NM
      ,A.PACT_TP_CD
      ,DECODE(A.PACT_TP_CD,'I','입원'
                          ,'O','외래'
                          ,'E','응급')                             PACT_TP_NM
      ,A.MED_DEPT
      ,XBIL.FC_GET_DEPT_NM(A.MED_DEPT)                       MED_DEPT_NM
      ,DECODE(A.PACT_TP_CD,'I',A.WD_DEPT_CD,'')                  WD_DEPT_CD
      ,A.RTM_PBL_STF_NO
      ,XCOM.FT_CNL_SELSTFINFO('4',A.RTM_PBL_STF_NO,'')          DR_STF_NM
      ,NVL(B.ISSU_QTY,1)                                        ISSU_QTY
      ,B.OFSL_SEAL_DT
      ,NVL(B.OFSL_SEAL_YN,'N')                                  OFSL_SEAL_YN
      ,A.PT_NO
      ,B.ADS_DT
      ,NVL(B.ACPT_SEQ,-1)                                       ACPT_SEQ
      ,NVL(B.ACPT_DT,A.ORD_DTE)                                  ACPT_DT
      ,-1                                                        RPY_SEQ
      ,B.ISSU_SEQ
      ,B.ISSU_RMK
      ,DECODE(A.PACT_TP_CD, 'O', '', A.WD_DEPT_CD||'-'||A.PRM_NO) TOT_WD_DEPT_CD
      ,CASE WHEN B.OFSL_SEAL_DT IS NULL
            THEN 'N'
            ELSE 'Y'
             END                                                  CHK_YN
      ,NVL2(B.PT_NO, 'Y','N') DOD_EXIST_YN
      ,TO_CHAR(A.MDRC_ID )                                        MDRC_ID
  FROM ( SELECT A.*
              ,NVL(C.ORD_DT,TRUNC(A.REC_DTM))            AS ORD_DTE
              ,NVL(C.RTM_PBR_AADP_CD ,A.WRTR_DEPT_CD)    AS MED_DEPT
              ,NVL(C.RTM_PBL_STF_NO,A.WRT_STF_NO)        AS RTM_PBL_STF_NO
              ,NVL(C.ORD_CD,'CCF000004')                 AS ORD_CD
 	         FROM MRDDRECM A
	            , MOOORTRM C
	        WHERE A.PT_NO       =:IN_PT_NO
	          AND (   (:IN_PACT_TP_CD  = 'A')
                  OR (:IN_PACT_TP_CD != 'A' AND A.PACT_TP_CD = :IN_PACT_TP_CD ))
            AND A.PT_NO       = C.PT_NO
--            AND A.MDRC_FOM_SEQ = C.MDRC_FOM_SEQ
            AND A.MDRC_ID   = C.MDRC_ID
            AND A.WRTR_DEPT_CD  =  C.RTM_PBR_AADP_CD
            AND A.LST_YN      = 'Y'
            AND A.MDRC_WRT_STS_CD > 10
          	AND A.MDRC_DC_TP_CD = 'C'
          	AND C.ODDSC_TP_CD(+) ='C'
          	AND A.MDFM_CLS_CD = 'D009'
       )  A
     , ACPPRDOD B
     , CCCCCUTE D
 WHERE 1=1
   AND A.PT_NO       = :IN_PT_NO
   AND A.PT_NO       = B.PT_NO(+)
   AND A.ORD_DTE     = B.ADS_DT(+)
   AND A.MDRC_ID     = B.MDRC_ID(+)
   AND A.MED_DEPT    = B.MED_DEPT_CD (+)
   AND B.MIF_CD(+) IS NULL
   AND D.COMN_GRP_CD = 'MD00794'
   AND DECODE(A.MDFM_ID,-1,A.OLD_MDFM_CLS_CD,A.MDFM_ID) = D.COMN_CD
   AND D.DTRL1_NM IS NULL

   -- 2024-11-26 김용록 : 응급원무고도화 30번, 제증명조회에 기간 조회 추가
   AND A.REC_DTM  BETWEEN TO_DATE(:IN_FROM_DT ,'YYYYMMDD')
                      AND TO_DATE( :IN_TO_DT ,'YYYYMMDD') + .99999
  --
 ORDER BY 1 DESC
        , 2

