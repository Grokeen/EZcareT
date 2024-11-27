

     SELECT /*+ HIS.PA.AC.PE.SC.SelectDoctorPlusWork_Statistics */

          (SELECT SUB.DR_STF_NO||'['||FT_STF_INF(SUB.DR_STF_NO,'STF_NM')||']'
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)     AS STF_NM2
         ,A.*
          --
         ,(SELECT SUP_MEMO
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)     AS SUP_MEMO                   /* 7.기타 */


         ,(SELECT TO_CHAR(FSR_DTM,'YYYY-MM-DD AM HH12:MI')
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)     AS FSR_DTM                    /* 8.최초등록일시 */


          ,(SELECT LSH_STF_NO||'['||FT_STF_INF(LSH_STF_NO,'STF_NM')||']'
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)     AS FSR_STF_NO                 /* 9.최초등록자 */


          ,(SELECT TO_CHAR(LSH_DTM,'YYYY-MM-DD AM HH12:MI')
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)      AS LSH_DTM                    /* 10.수정일자 */


          ,(SELECT LSH_STF_NO||'['||FT_STF_INF(LSH_STF_NO,'STF_NM')||']'
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)      AS LSH_STF_NO                 /* 11.수정자 */



           ,(SELECT CASE WHEN TM_UNIT_CD = 'AM' THEN '오전'
                         WHEN TM_UNIT_CD = 'PM' THEN '오후'
                         ELSE '종일'
                    END
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)     AS TM_UNIT_CD                   /* 14.오전오후구분 */


           ,(SELECT NVL2(CNCL_DT,'Y','N')
             FROM ACDPCSPD SUB       /* 의사보충일정정보 테이블 */
            WHERE SUB.DR_STF_NO = A.STF_NM
              AND TO_CHAR(SUB.APY_STR_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_STR_DTM
              AND TO_CHAR(SUB.APY_END_DTM,'YYYY-MM-DD AM HH12:MI') = A.APY_END_DTM)     AS CNCL_DT                      /* 13.취소날짜 */

           ,(SELECT
                SUM(K.NED_MED_TIME) OVER(PARTITION BY K.DEPT_CD ,K.MEDDR_NM)       NED_MED_TIME
            
             FROM
                (SELECT    Z.DEPT_NM                                            DEPT_CD
                          ,Z.WK_NM                                              MEDDR_NM
                          ,ROUND(SUM((Z.CALC_AM_TOT + Z.CALC_PM_TOT)),0)        NED_MED_TIME        --계산된 휴진별 휴진시간
                      FROM (
            
                          SELECT
                              K.DEPT_NM
                              ,CASE   WHEN K.DIFF <=89 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  >='20190401'  THEN  K.AM_CNT *0.25
                                      WHEN K.DIFF <=83 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  <'20190401'   THEN  K.AM_CNT *0.25
                                      WHEN K.DIFF <=55 AND K.DIFF >=28 THEN K.AM_CNT *0.5
                                      WHEN K.DIFF <=27 THEN  K.AM_CNT *1.0
                                      ELSE  0 END  CALC_AM_TOT
                              ,CASE   WHEN K.DIFF <=89 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  >='20190401' THEN  K.PM_CNT *0.25
                                      WHEN K.DIFF <=83 AND K.DIFF >=56  AND TRUNC(K.GW_FSTINST_DTM)  <'20190401'  THEN  K.PM_CNT *0.25
                                      WHEN K.DIFF <=55 AND K.DIFF >=28 THEN K.PM_CNT *0.5
                                      WHEN K.DIFF <=27 THEN  K.PM_CNT *1.0
                                      ELSE  0 END  CALC_PM_TOT
                              ,K.WK_NM
                            FROM (
            
                                 SELECT
                                      C.DEPT_NM                                      AS DEPT_NM
                                    , NVL((SELECT
                                               SUM(MAX(D.AM_NSP_TM))
                                             FROM   ACDPCTMD D  /* 의사휴진시간정보 테이블 */
                                       WHERE  D.REG_DTM BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) +0.99999
                                       AND    D.MED_DEPT_CD = A.MED_DEPT_CD
                                       AND    D.MEDR_STF_NO = A.DR_STF_NO
                                       AND    D.MED_DTM  BETWEEN A.APY_STR_DT AND A.APY_END_DT
                                       GROUP BY D.MED_DT    ),0)                     AS AM_CNT
            
                                    , NVL((SELECT SUM(MAX(D.PM_NSP_TM))
                                       FROM   ACDPCTMD D
                                       WHERE  D.REG_DTM BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) +0.99999
                                       AND    D.MED_DEPT_CD = A.MED_DEPT_CD
                                       AND    D.MEDR_STF_NO = A.DR_STF_NO
                                       AND    D.MED_DTM  BETWEEN A.APY_STR_DT AND A.APY_END_DT
                                       GROUP BY D.MED_DT  ) ,0)                       AS PM_CNT
                                    ,A.APY_STR_DT - TRUNC(A.FSR_DTM)                  AS DIFF
                                    ,D.STF_NM                                         AS WK_NM
                                    ,A.FSR_DTM                                        AS GW_FSTINST_DTM
                                FROM    ACDPCBAD   A   /* 의사휴진일정정보 테이블 */
                                        ,CCCCCSTE  B   /* 공통그룹코드상세 테이블 */
                                        ,PDEDBMSM  C   /* 부서기본 테이블 */
                                        ,CNLRRUSD  D   /* 시스템사용자정보 테이블 */
                                WHERE    1=1
                                <IsNotEmpty Property="IN_DR_STF_NO">
                                    <IsNotNull Property="IN_DR_STF_NO" >
                                        AND A.DR_STF_NO = :IN_DR_STF_NO
                                    </IsNotNull>
                                </IsNotEmpty>
            
                                AND      A.PACT_TP_CD    =  'O'
                                AND      A.NSP_RSN_TP_CD IN ('01','05','36','37','41','42')
                                AND      A.APY_STR_DT   >=  '20160104'
                                AND      B.COMN_GRP_CD   ='223'
                                AND      A.NSP_RSN_TP_CD = B.COMN_CD
                                AND      A.MED_DEPT_CD   = C.DEPT_CD
                                AND      A.DR_STF_NO     = D.STF_NO
            
                              )K
            
                          WHERE K.AM_CNT+K.PM_CNT >0
                        )Z
                  GROUP BY  Z.DEPT_NM
                            ,Z.WK_NM
                  )  K)                                        AS SUM_SPLM_MED_TM             /* 12.남은휴진분 */

       FROM(

            SELECT
                CASE WHEN     GROUPING (MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']')=0
                          AND GROUPING(DR_STF_NO) = 0
                          AND GROUPING(APY_STR_DTM)=0
                          AND GROUPING(APY_END_DTM)=0
                     THEN DR_SID
                 END		                                 AS DR_SID                     /* 1.구분 */


                ,CASE WHEN GROUPING (MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']')=0
                     THEN CASE WHEN GROUPING (DR_STF_NO)= 0
                               THEN CASE WHEN GROUPING (APY_STR_DTM)=0
                                         THEN CASE WHEN GROUPING (APY_END_DTM) =0
                                                   THEN MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']'
                                                   ELSE NULL
                                              END
                     							      ELSE MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']'
                                    END
                               ELSE NULL
                          END
                     ELSE NULL
                 END                                      AS DEPT_NM                     /* 2.진료과 */
               ,CASE WHEN GROUPING (DR_STF_NO)=0
                     THEN CASE WHEN GROUPING (APY_STR_DTM)= 0
                               THEN CASE WHEN GROUPING (APY_END_DTM)=0
                                         THEN DR_STF_NO
                    								     ELSE  NULL
                    								 END
                    					 ELSE DR_STF_NO
                    			 END
                     ELSE NULL
                END                                       AS STF_NM                     /* 3.진료의사 */
                ,CASE WHEN GROUPING (DR_STF_NO)=0
                      THEN CASE WHEN GROUPING (APY_STR_DTM)=0
                                THEN CASE WHEN GROUPING (APY_END_DTM)=0
                                          THEN TO_CHAR(APY_STR_DTM,'YYYY-MM-DD AM HH12:MI')
                                          ELSE NULL
                                      END
                					      ELSE NULL
                            END
                      ELSE NULL
                  END                                     AS APY_STR_DTM                  /* 4.보충진료시작일시 */



                ,CASE WHEN GROUPING (DR_STF_NO) =0
                      THEN CASE GROUPING (APY_STR_DTM)
                                WHEN 0 THEN TO_CHAR(APY_END_DTM,'YYYY-MM-DD AM HH12:MI')
                								ELSE '합계'
                					  END
                      ELSE NULL
                  END                                    AS APY_END_DTM                 /* 5.보충진료종료일시 */


                ,  CASE WHEN GROUPING(DR_STF_NO) = 0
                             THEN CASE WHEN GROUPING (DR_STF_NO)= 0
                                       THEN CASE WHEN GROUPING (APY_STR_DTM)=0
                                                 THEN CASE WHEN GROUPING (APY_END_DTM)=0
                                                           THEN TO_CHAR(MAX(SPLM_MED_TM))
                  								                         ELSE  NULL
                  								                     END
                  								                ELSE TO_CHAR(SUM(SPLM_MED_TM))
                  								           END
                  								      ELSE null
                  								 END
                        WHEN GROUPING(MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']')=1
                        THEN  NULL

                    END                                  AS DTM_SUM                   /* 6.총보충시간 */
             FROM ACDPCSPD        /* 의사보충일정정보 테이블 */
             WHERE 1=1
               AND (APY_STR_DTM BETWEEN TO_DATE(:IN_FROM_DT ,'YYYYMMDD')
                                    AND LAST_DAY(TO_DATE(:IN_TO_DT ,'YYYYMMDD')) + .99999 )
               AND (NVL2(:IN_CHECK_SPLMMEDTM, NULL, SPLM_MED_TM) IS NULL)
               AND (NVL2(:IN_CHECK_ALL,NULL,CNCL_DT) IS NULL)
            GROUP BY ROLLUP(  MED_DEPT_CD||'['||FC_GET_DEPT_NM(MED_DEPT_CD)||']'
                             ,DR_STF_NO
                             ,APY_STR_DTM
                             ,APY_END_DTM
                            )
                            , DR_SID

             UNION
             -- NULL 및 중복 제거
             SELECT
                 ''      AS DR_SID
                ,''      AS DEPT_NM
                ,''      AS STF_NM
                ,''      AS APY_STR_DTM
                ,''      AS APY_END_DTM
                ,''      AS DTM_SUM

             FROM DUAL



            ) A
        WHERE 1=1
    <IsNotEmpty Property="IN_DR_STF_NO">
        <IsNotNull Property="IN_DR_STF_NO" >
          AND STF_NM = :IN_DR_STF_NO
        </IsNotNull>
    </IsNotEmpty>

        ORDER BY
              STF_NM
            , APY_STR_DTM ASC