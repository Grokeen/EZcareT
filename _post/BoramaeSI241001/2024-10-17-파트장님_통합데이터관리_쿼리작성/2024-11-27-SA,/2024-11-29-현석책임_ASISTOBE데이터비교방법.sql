SELECT   sum(CASE WHEN PME_CLS_CD    = 'BB'
                           AND SUBSTR(PSE_CLS_CD,1,1) NOT IN ('C','E','F')
                           THEN 1
                           ELSE 0
                  END) A    --보험

               , sum(CASE WHEN PME_CLS_CD    = 'BB' AND SUBSTR(PSE_CLS_CD,1,1) IN ('C','E','F')
                           THEN 1
                           ELSE 0
                  END) B    --차상위

               , sum(CASE WHEN PME_CLS_CD    IN ('E1','E2','E6')  AND PSE_CLS_CD NOT IN ('A04','A05')
                           THEN 1
                           ELSE 0
                   END) C    --보호

                , sum(CASE WHEN PME_CLS_CD    = 'AA'
                           THEN 1
                           ELSE 0
                   END) D    --일반

                , sum(CASE WHEN PME_CLS_CD IN ('SA')
                           THEN 1
                           ELSE 0
                   END) E       --산재/공상

                , sum(CASE WHEN PME_CLS_CD    = 'TD'
                           THEN 1
                           ELSE 0
                   END) F    --교통

                , sum(CASE WHEN PME_CLS_CD    = 'E1' AND PSE_CLS_CD IN ('A04','A05')
                           THEN 1
                           ELSE 0
                    END) G    --행려

                , sum(CASE WHEN PME_CLS_CD NOT IN ('B1','B2','B6','BB'
                                              ,'E1','E2','E6'
                                              ,'AA'
                                              ,'SA'
                                              ,'TD')
                           THEN 1
                           ELSE 0
                    END) H    --기타
	from ACPPRODM
where med_dt between '20110801' and '20110831'
--72488	1001	8361	8164	162	491	50	309
--72488	1001	8361	8165	162	491	50	310

;--------------------------------------------------------------------------------------------------



SELECT                        SUM(CASE WHEN PATTYPE = 'BB'              THEN 1 ELSE 0 END) A
                            , SUM(CASE WHEN PATTYPE IN ('B1','B2','B6') THEN 1 ELSE 0 END) B
                            , SUM(CASE WHEN PATTYPE IN ('E1','E2','E6') THEN 1 ELSE 0 END) C
                            , SUM(CASE WHEN PATTYPE = 'AA'              THEN 1 ELSE 0 END) D
                            , SUM(CASE WHEN PATTYPE IN ('SA','SB','SP') THEN 1 ELSE 0 END) E
                            , SUM(CASE WHEN PATTYPE = 'TA'              THEN 1 ELSE 0 END) F
                            , SUM(CASE WHEN PATTYPE = 'E8'              THEN 1 ELSE 0 END) G
                            , SUM(CASE WHEN (PATTYPE NOT IN ('B1','B2','B6','BB','E1','E2','E6','AA','SA','SB','SP','TA' ,'E8'))
                                                                        THEN 1 ELSE 0 END) H
	from asis_hbil.apoprsvt
where med_dte between '20110801' and '20110831'
;;

select *
	from asis_hbil.apemgrct
`
