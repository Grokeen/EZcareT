
EXEC :IN_DOC_NO :='01004';



SELECT     K.DEPT_CD
          ,K.MEDDR_NM
          ,SUM(K.TOT_HDLY_TIME)                                 TOT_HDLY_TIME
          ,SUM(K.NED_MED_TIME)                                  NED_MED_TIME
          ,SUM(K.ADD_DONE_TIME)                                 ADD_DONE_TIME
          ,ROUND(SUM(K.ADD_MED_TIME) -SUM(K.ADD_DONE_TIME),0)   ADD_MED_TIME
 FROM
    (SELECT    Z.DEPT_NM                                            DEPT_CD
              ,Z.WK_NM                                              MEDDR_NM
              ,ROUND(SUM((Z.SUM_AM_CNT+Z.SUM_PM_CNT)),0)            TOT_HDLY_TIME       --순수 휴진시간
              ,ROUND(SUM((Z.CALC_AM_TOT + Z.CALC_PM_TOT)),0)        NED_MED_TIME        --계산된 휴진별 휴진시간
              ,0                                                    ADD_DONE_TIME       --보충진료 완료시간
              ,NVL(SUM((Z.CALC_AM_TOT+Z.CALC_PM_TOT))  ,0)          ADD_MED_TIME

          FROM (

              SELECT   
                   K.MEDDR_ID
                  ,K.DEPT_NM
                  ,K.FROM_DTE
                  ,K.TO_DTE
                  ,K.OFF_RSN
                  ,K.AM_CNT SUM_AM_CNT
                  ,K.PM_CNT SUM_PM_CNT
                  ,CASE   WHEN K.DIFF <=89 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  >='20190401'  THEN  K.AM_CNT *0.25
                          WHEN K.DIFF <=83 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  <'20190401'   THEN  K.AM_CNT *0.25
                          WHEN K.DIFF <=55 AND K.DIFF >=28 THEN K.AM_CNT *0.5
                           WHEN K.DIFF <=27  THEN  K.AM_CNT *1.0
                           ELSE  0 END  CALC_AM_TOT
                  ,CASE   WHEN K.DIFF <=89 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  >='20190401' THEN  K.PM_CNT *0.25
                        WHEN K.DIFF <=83 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  <'20190401'  THEN  K.PM_CNT *0.25
                      WHEN K.DIFF <=55 AND K.DIFF >=28 THEN K.PM_CNT *0.5
                         WHEN K.DIFF <=27  THEN  K.PM_CNT *1.0
                           ELSE  0 END  CALC_PM_TOT
                  ,K.DIFF
                  ,K.WK_NM
                FROM (

                     SELECT   A.DR_STF_NO                               MEDDR_ID
                        ,C.DEPT_NM                                      DEPT_NM
                        ,TO_CHAR(A.APY_STR_DT ,'YYYY-MM-DD')            FROM_DTE
                        ,TO_CHAR(A.APY_END_DT,'YYYY-MM-DD')             TO_DTE
                        ,B.COMN_CD_NM                                   OFF_RSN
                        , NVL((SELECT SUM(MAX(D.AM_NSP_TM))
                           FROM   ACDPCTMD D
                           WHERE  D.REG_DTM BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) +0.99999
                           AND    D.MED_DEPT_CD = A.MED_DEPT_CD
                           AND    D.MEDR_STF_NO = A.DR_STF_NO
                           AND    D.MED_DTM  BETWEEN A.APY_STR_DT AND A.APY_END_DT
                           GROUP BY D.MED_DT    ),0)                    AM_CNT

                        , NVL((SELECT SUM(MAX(D.PM_NSP_TM))
                           FROM   ACDPCTMD D
                           WHERE  D.REG_DTM BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) +0.99999
                           AND    D.MED_DEPT_CD = A.MED_DEPT_CD
                           AND    D.MEDR_STF_NO = A.DR_STF_NO
                           AND    D.MED_DTM  BETWEEN A.APY_STR_DT AND A.APY_END_DT
                           GROUP BY D.MED_DT  ) ,0)PM_CNT
                        ,A.APY_STR_DT -   TRUNC(A.FSR_DTM) DIFF
                        ,D.STF_NM           WK_NM
                        ,A.FSR_DTM          GW_FSTINST_DTM
                    FROM    ACDPCBAD   A   /* 의사휴진일정정보 테이블 */
                            ,CCCCCSTE  B   /* 공통그룹코드상세 테이블 */
                            ,PDEDBMSM  C   /* 부서기본 테이블 */
                            ,CNLRRUSD  D   /* 시스템사용자정보 테이블 */
                    WHERE    A.DR_STF_NO   = NVL(:IN_DOC_NO,A.DR_STF_NO)
                    AND      A.PACT_TP_CD   =  'O'
                    AND      A.NSP_RSN_TP_CD    IN   ('01','05','36','37','41','42')
                    AND      A.APY_STR_DT   >=  '20160104'
                    AND     B.COMN_GRP_CD   ='223'
                    AND     A.NSP_RSN_TP_CD = B.COMN_CD
                    AND     A.MED_DEPT_CD  =C.DEPT_CD
                    AND     A.DR_STF_NO = D.STF_NO

                  )K

              WHERE K.AM_CNT+K.PM_CNT >0
            )Z
      GROUP BY  Z.DEPT_NM
                ,Z.WK_NM
          UNION

            SELECT   B.DEPT_NM                            DEPT_CD
              ,C.STF_NM                            MEDDR_NM
              ,0                                TOT_HDLY_TIME       --순수 휴진시간
              ,0                                 NED_MED_TIME         --계산된 휴진별 휴진시간
              ,NVL(SUM(A.SPLM_MED_TM),0)                   ADD_DONE_TIME         --보충진료 완료시간
              ,0                                ADD_MED_TIME
               FROM  ACDPCSPD A
                  ,  PDEDBMSM B
                  ,  CNLRRUSD C
                WHERE A.DR_STF_NO   = NVL(:IN_DOC_NO,A.DR_STF_NO)
                AND  A.MED_DEPT_CD   = B.DEPT_CD
                AND  A.DR_STF_NO    = C.STF_NO
                AND  A.CNCL_DT   IS NULL
          GROUP BY   B.DEPT_NM
                    ,C.STF_NM
      )  K

   GROUP BY K.DEPT_CD
           ,K.MEDDR_NM
    ORDER BY K.MEDDR_NM
         ,K.DEPT_CD
