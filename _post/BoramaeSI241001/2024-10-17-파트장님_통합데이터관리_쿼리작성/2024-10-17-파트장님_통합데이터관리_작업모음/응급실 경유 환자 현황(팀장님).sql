EXEC :IN_FYYYYMM := '20240801';
EXEC :IN_TYYYYMM := '20240831';

        SELECT
                MED_DEPT_NM                                                   "진료과"
              , GUBUN                                                     "구분"
              , SUM(PT_CNT)                                               "환자수"
              , SUM(SIN_CNT)                                              "신환 환자수"
--              , DECODE(SUM(PT_CNT),0,0
--                                  ,ROUND(SUM(PT_CNT) / 2 ,0))             "일평균"
              ----------------------------------------------------------------------------------
              -- 환자수 산정순위
              -- 1:DOA 2:병동입원 3:사망 4:타원 5:귀가
              ----------------------------------------------------------------------------------
              , SUM(WARD_CNT)                                             "입원"
              , SUM(OPER_CNT)                                             "수술"
              , SUM(HOME_CNT)                                             "귀가"
              , SUM(TRAN_CNT)                                             "타원"
              , SUM(DEAD_CNT)                                             "사망"
              , SUM(DOA_CNT )                                             "DOA"
              , SUM(ETC_CNT )                                             "기타"
              , SUM(SICU_CNT)                                             "SICU"
              , SUM(MICU_CNT)                                             "MICU"
              , SUM(NICU_CNT)                                             "NICU"
              , SUM(CICU_CNT)                                             "CICU"
              , SUM(ETCWARD_CNT)                                          "일반병동"
--              , SUM(CPR_CNT)                                              "CPR"
           FROM (
              ----------------------------------------------------------------------------------
              --외래
              ----------------------------------------------------------------------------------
									 SELECT
									         A.PT_NO
									         , A.EMRM_ARVL_DTM
									         , A.MED_DEPT_CD
									         , XCOM.FT_PDE_SELDEPTNM(A.MED_DEPT_CD,A.HSP_TP_CD) MED_DEPT_NM
									         , '외래'                                                           GUBUN
									         , 1                                                                PT_CNT
									         , DECODE(A.FRVS_RMDE_TP_CD,'3',1,0)                                SIN_CNT ---- DECODE(A.MED_TYP,'3',1,0)
									         , DECODE(E.EM_MED_RSLT,'1',1,0)                                    WARD_CNT
									         , DECODE(E.EM_MED_RSLT,'6',1,0)                                    OPER_CNT
									         , DECODE(E.EM_MED_RSLT,'2',1,0)                                    HOME_CNT
									         , DECODE(E.EM_MED_RSLT,'3',1,0)                                    TRAN_CNT
									         , DECODE(E.EM_MED_RSLT,'4',1,0)                                    DEAD_CNT
									         , DECODE(E.EM_MED_RSLT,'4',(DECODE(E.MED_RSLT_CLS1,'1',1,0)),0)    DOA_CNT
									         , DECODE(E.EM_MED_RSLT,'0',1,0)                                    ETC_CNT
									         , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'SICU',1,0)),0) SICU_CNT
									         , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'MICU',1,0)),0) MICU_CNT
									         , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'NICU',1,0)),0) NICU_CNT
									         , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'CCU' ,1,0)),0) CICU_CNT
									         , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'SICU',0,
									                                                            'MICU',0,
									                                                            'NICU',0,
									                                                            'CCU' ,0,1)),0) ETCWARD_CNT
									      FROM ACPPRETM A
									         , ASIS_HORD.MNREPERT E
									     WHERE A.CHOT_DTM  BETWEEN TO_DATE(:IN_FYYYYMM,'YYYY-MM-DD')
									                           AND TO_DATE(:IN_TYYYYMM,'YYYY-MM-DD') + .99999
									       AND A.ADS_DT    IS NULL
									       AND A.APCN_DTM   IS NULL
									       AND A.PACT_ID = 'ME'||E.PT_NO||TO_CHAR(E.ARV_DTM,'YYYYMMDDHH24MI')

									UNION ALL

									SELECT X.PT_NO
									     , X.EMRM_ARVL_DTM
									     , X.MED_DEPT_CD
									     , X.MED_DEPT_NM
									     , X.GUBUN
									     , X.PT_CNT
									     , X.SIN_CNT
									     , DECODE(X.EM_MED_RSLT,'입원',1,0)                                      WARD_CNT
									     , DECODE(X.EM_MED_RSLT,'수술/시술',1,0)                                 OPER_CNT
									     , DECODE(X.EM_MED_RSLT,'귀가',1,0)                                      HOME_CNT
									     , DECODE(X.EM_MED_RSLT,'전원',1,0)                                      TRAN_CNT
									     , DECODE(X.EM_MED_RSLT,'사망',1,0)                                      DEAD_CNT
									     , DECODE(X.EM_MED_RSLT,'사망',(DECODE(X.EM_MED_RSLT_ETC,'1',1,0)),0)    DOA_CNT
									     , DECODE(X.EM_MED_RSLT,'기타(사라짐, 경찰서연행 등)',1,0)                 ETC_CNT
									     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'SICU',1,0)),0) SICU_CNT
									     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'MICU',1,0)),0) MICU_CNT
									     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'NICU',1,0)),0) NICU_CNT
									     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'CCU' ,1,0)),0) CICU_CNT
									     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'SICU',0,
									                                                             'MICU',0,
									                                                             'NICU',0,
									                                                             'CCU' ,0,1)),0) ETCWARD_CNT



									  FROM (
									        SELECT A.PT_NO
									              ,A.EMRM_ARVL_DTM
									              ,A.MED_DEPT_CD
									              ,XCOM.FT_PDE_SELDEPTNM(A.MED_DEPT_CD,A.HSP_TP_CD) MED_DEPT_NM
									              ,'외래' GUBUN
									              ,1 PT_CNT
									              ,DECODE(A.FRVS_RMDE_TP_CD,'3',1,0) SIN_CNT -- AS-IS DECODE(A.FRVS_RMDE_TP_CD,'3',1,0) 원무에서 작성
									              ,XMED.FT_MRN_INITVAL(B.NREC_ID, '587', '') EM_MED_RSLT      -- 진료결과
									              ,XMED.FT_MRN_INITVAL(B.NREC_ID, '588', '') EM_MED_RSLT_ETC  -- 간호단위 (진료결과 입원 입력시 나타나는 병동리스트)
									          FROM ACPPRETM A
									              ,MRNNRFAD B
									         WHERE A.PACT_ID = B.PACT_ID
									           AND B.NREC_FORM_CD = '701' --퇴실간호기록
									           AND B.LST_YN = 'Y'
									           AND B.USE_YN = 'Y'
									           AND A.ADS_DT IS NULL
									           AND A.APCN_DTM IS NULL
									           AND A.CHOT_DTM BETWEEN TO_DATE(:IN_FYYYYMM,'YYYY-MM-DD') AND TO_DATE(:IN_TYYYYMM,'YYYY-MM-DD')
									        ORDER BY A.PT_NO
									       ) X


                 UNION ALL

              ----------------------------------------------------------------------------------
              --입원
              ----------------------------------------------------------------------------------
                 SELECT A.PT_NO
                      , A.EMRM_ARVL_DTM
                      , C.MED_DEPT_CD
                      , XCOM.FT_PDE_SELDEPTNM(C.MED_DEPT_CD,A.HSP_TP_CD) MED_DEPT_NM
                      , '입원'                                                           GUBUN
                      , 1                                                                PT_CNT
                      , DECODE(A.FRVS_RMDE_TP_CD,'3',1,0) 								         SIN_CNT
                      , DECODE(E.EM_MED_RSLT,'1',1,0)                                    WARD_CNT
                      , DECODE(E.EM_MED_RSLT,'6',1,0)                                    OPER_CNT
                      , DECODE(E.EM_MED_RSLT,'2',1,0)                                    HOME_CNT
                      , DECODE(E.EM_MED_RSLT,'3',1,0)                                    TRAN_CNT
                      , DECODE(E.EM_MED_RSLT,'4',1,0)                                    DEAD_CNT
                      --------------------------------------------------------------------------
                      -- 2010.11.01 DOA 관련 참조 컬럼 변경(이순화 차장님 확인)
                      --------------------------------------------------------------------------
                      --기존LOGIC
                      --------------------------------------------------------------------------
                      --, DECODE(E.EM_MED_RSLT,'4',(DECODE(E.MED_RSLT_ETC1,'1',1,0)),0)    DOA_CNT
                      , DECODE(E.EM_MED_RSLT,'4',(DECODE(E.MED_RSLT_CLS1,'1',1,0)),0)    DOA_CNT
                      --------------------------------------------------------------------------
                      , DECODE(E.EM_MED_RSLT,'0',1,0)                                    ETC_CNT
                      , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'SICU',1,0)),0) SICU_CNT
                      , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'MICU',1,0)),0) MICU_CNT
                      , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'NICU',1,0)),0) NICU_CNT
                      , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'CCU' ,1,0)),0) CICU_CNT
                      , DECODE(E.EM_MED_RSLT,'1',(DECODE(E.MED_RSLT_ETC1,'SICU',0,
                                                                         'MICU',0,
                                                                         'NICU',0,
                                                                         'CCU' ,0,1)),0) ETCWARD_CNT
                   FROM ACPPRETM A
                      , ACPPRAAM B
                      , ACPPRTSD C
                      , ASIS_HORD.MNREPERT E


						     WHERE A.CHOT_DTM  BETWEEN TO_DATE(:IN_FYYYYMM,'YYYY-MM-DD')
						                           AND TO_DATE(:IN_TYYYYMM,'YYYY-MM-DD') + .99999
                    AND A.ADS_DT    IS NOT NULL
                    AND A.APCN_DTM   IS NULL
                    AND A.ADS_PACT_ID = B.PACT_ID
--			                    AND B.CNCL_DTE   IS NULL
                    AND B.PACT_ID = C.RPY_PACT_ID
                    AND C.APY_STR_DT = (SELECT MAX(F.APY_STR_DT)
					                                 FROM ACPPRTSD F
					                                WHERE F.RPY_PACT_ID = C.RPY_PACT_ID
					                                  AND F.APY_STR_DT <= TRUNC(A.CHOT_DTM)
					                              )
                    AND A.PACT_ID = 'ME'||E.PT_NO||TO_CHAR(E.ARV_DTM,'YYYYMMDDHH24MI')

                 UNION ALL

								SELECT X.PT_NO
									   , X.EMRM_ARVL_DTM
								     , X.MED_DEPT_CD
								     , X.MED_DEPT_NM
								     , X.GUBUN
								     , X.PT_CNT
								     , X.SIN_CNT
								     , DECODE(X.EM_MED_RSLT,'입원',1,0)                                      WARD_CNT
								     , DECODE(X.EM_MED_RSLT,'수술/시술',1,0)                                 OPER_CNT
								     , DECODE(X.EM_MED_RSLT,'귀가',1,0)                                      HOME_CNT
								     , DECODE(X.EM_MED_RSLT,'전원',1,0)                                      TRAN_CNT
								     , DECODE(X.EM_MED_RSLT,'사망',1,0)                                      DEAD_CNT
								     , DECODE(X.EM_MED_RSLT,'사망',(DECODE(X.EM_MED_RSLT_ETC,'1',1,0)),0)    DOA_CNT
								     , DECODE(X.EM_MED_RSLT,'기타(사라짐, 경찰서연행 등)',1,0)                 ETC_CNT
								     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'SICU',1,0)),0) SICU_CNT
								     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'MICU',1,0)),0) MICU_CNT
								     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'NICU',1,0)),0) NICU_CNT
								     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'CCU' ,1,0)),0) CICU_CNT
								     , DECODE(X.EM_MED_RSLT,'입원',(DECODE(X.EM_MED_RSLT_ETC,'SICU',0,
								                                                             'MICU',0,
								                                                             'NICU',0,
								                                                             'CCU' ,0,1)),0) ETCWARD_CNT
								  FROM (
								        SELECT A.PT_NO
								              ,A.EMRM_ARVL_DTM
								              ,A.MED_DEPT_CD
								              ,XCOM.FT_PDE_SELDEPTNM(A.MED_DEPT_CD,A.HSP_TP_CD) MED_DEPT_NM
								              ,'입원' GUBUN
								              ,1 PT_CNT
								              ,DECODE(A.FRVS_RMDE_TP_CD,'3',1,0) SIN_CNT -- AS-IS DECODE(A.MED_TYP,'3',1,0) 원무에서 작성
								              ,XMED.FT_MRN_INITVAL(D.NREC_ID, '587', '') EM_MED_RSLT      -- 진료결과
								              ,XMED.FT_MRN_INITVAL(D.NREC_ID, '588', '') EM_MED_RSLT_ETC  -- 간호단위 (진료결과 입원 입력시 나타나는 병동리스트)
								          FROM ACPPRETM A
								              ,ACPPRAAM B
								              ,ACPPRTSD C
								              ,MRNNRFAD D
								         WHERE 1=1
								        --   AND A.SIHS_YN = 'Y'
								           AND A.ADS_DT IS NOT NULL
								           AND A.APCN_DTM IS NULL
								           AND A.CHOT_DTM BETWEEN TO_DATE(:IN_FYYYYMM,'YYYY-MM-DD') AND TO_DATE(:IN_TYYYYMM,'YYYY-MM-DD')
								           AND A.ADS_PACT_ID = B.PACT_ID
								           AND B.PACT_ID = C.RPY_PACT_ID
								           AND C.APY_STR_DT = (SELECT MAX(F.APY_STR_DT)
								                                 FROM ACPPRTSD F
								                                WHERE F.RPY_PACT_ID = C.RPY_PACT_ID
								                                  AND F.APY_STR_DT <= TRUNC(A.CHOT_DTM))
								           AND A.PACT_ID = D.PACT_ID
								           AND D.NREC_FORM_CD = '701' --퇴실간호기록
								           AND D.LST_YN = 'Y'
								           AND D.USE_YN = 'Y'
								       ) X
                )
            GROUP BY
                  MED_DEPT_NM
                , GUBUN
            ORDER BY
                  2,1
