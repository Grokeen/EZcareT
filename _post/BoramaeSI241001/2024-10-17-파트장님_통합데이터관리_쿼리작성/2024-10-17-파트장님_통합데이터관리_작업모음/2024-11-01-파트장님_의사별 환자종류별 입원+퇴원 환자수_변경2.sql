



EXEC :in_fyyyymm  := '2024';
EXEC :in_look := '1';
EXEC :in_age_typ := '3';
EXEC :in_rep_typ := '1';
EXEC :in_look_typ := '1';

/* 7번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
            select
                   case when grouping(med_dept)||grouping(meddr_id) = '11' then
                            '전체'
                           else
                            (select
                                              dept_nm
                               from ccdepart a where dept_cd = med_dept)
                       end                                       "진료과"
                  ,case when grouping(med_dept)||grouping(meddr_id) = '00' then
                            (select wk_nm from ccusermt a where wk_id = meddr_id)
                        when grouping(med_dept)||grouping(meddr_id) = '11' then
                            '합계'
                           else
                            '소계'
                       end                                       "진료의"
            ;;;

/* 6번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

            SELECT
                   CASE WHEN GROUPING(MED_DEPT)||GROUPING(MEDDR_ID) = '11' THEN
                            '합계'
                           ELSE
                            ( XBIL.FC_GET_DEPT_NM(MED_DEPT))
                       END                                      AS  "진료과"



                  ,CASE WHEN GROUPING(MED_DEPT)||GROUPING(MEDDR_ID) = '00' THEN
                                                                                 NVL((XCOM.FT_CNL_SELSTFINFO('4',MEDDR_ID,NULL)) , MEDDR_ID)
                        WHEN GROUPING(MED_DEPT)||GROUPING(MEDDR_ID) = '11' THEN
                            '전체'
                           ELSE
                            '소계'
                       END                                      AS  "진료의"
                  ,case when sum(hapgae  ) = 0 or sum(hapgae1  ) = 0 then 0 else round(sum(hapgae1  )/sum(hapgae  ),1) end   "합계"
                  ,case when sum(bohum   ) = 0 or sum(bohum1   ) = 0 then 0 else round(sum(bohum1   )/sum(bohum   ),1) end   "보험"
                  ,case when sum(boho1   ) = 0 or sum(boho11   ) = 0 then 0 else round(sum(boho11   )/sum(boho1   ),1) end   "보호1"
                  ,case when sum(boho2   ) = 0 or sum(boho21   ) = 0 then 0 else round(sum(boho21   )/sum(boho2   ),1) end   "보호2"
                  ,case when sum(hangyer ) = 0 or sum(hangyer1 ) = 0 then 0 else round(sum(hangyer1 )/sum(hangyer ),1) end   "행여"
                  ,case when sum(sanjae  ) = 0 or sum(sanjae1  ) = 0 then 0 else round(sum(sanjae1  )/sum(sanjae  ),1) end   "산재"
                  ,case when sum(gongsang) = 0 or sum(gongsang1) = 0 then 0 else round(sum(gongsang1)/sum(gongsang),1) end   "공상"
                  ,case when sum(general ) = 0 or sum(general1 ) = 0 then 0 else round(sum(general1 )/sum(general ),1) end   "일반"
                  ,case when sum(traffic ) = 0 or sum(traffic1 ) = 0 then 0 else round(sum(traffic1 )/sum(traffic ),1) end   "교통"
                  ,case when sum(gita    ) = 0 or sum(gita1    ) = 0 then 0 else round(sum(gita1    )/sum(gita    ),1) end   "기타"
              from
                  (


/* 5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                   --------------------------------------------------------------------------------------
                   -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 추가함..
                   --------------------------------------------------------------------------------------
                   SELECT
                          A.MED_DEPT                                      MED_DEPT
                         ,A.MEDDR_ID                                      MEDDR_ID
                         ,A.GUBUN                                         GUBUN
                         ,sum(a.hapgae   )                                hapgae
                         ,sum(a.hapgae1  )                                hapgae1
                         ,sum(a.bohum    )                                bohum
                         ,sum(a.bohum1   )                                bohum1
                         ,sum(a.boho1    )                                boho1
                         ,sum(a.boho11   )                                boho11
                         ,sum(a.boho2    )                                boho2
                         ,sum(a.boho21   )                                boho21
                         ,sum(a.hangyer  )                                hangyer
                         ,sum(a.hangyer1 )                                hangyer1
                         ,sum(a.sanjae   )                                sanjae
                         ,sum(a.sanjae1  )                                sanjae1
                         ,sum(a.gongsang )                                gongsang
                         ,sum(a.gongsang1)                                gongsang1
                         ,sum(a.general  )                                general
                         ,sum(a.general1 )                                general1
                         ,sum(a.traffic  )                                traffic
                         ,sum(a.traffic1 )                                traffic1
                         ,sum(a.gita     )                                gita
                         ,sum(a.gita1    )                                gita1
                     FROM (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                           SELECT
                                  -----------------------------------------------------------
                                  -- 2010.10.01 센터관련 적용
                                  -----------------------------------------------------------
                                  CASE WHEN MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                                       WHEN MED_DEPT = 'BCGS'            THEN 'GS'
                                       WHEN MED_DEPT = 'BCOL'            THEN 'OL'
                                       WHEN MED_DEPT = 'BCPS'            THEN 'PS'
                                       WHEN MED_DEPT = 'BCDR'            THEN 'DR'

                                       WHEN MED_DEPT = 'CVGS'            THEN 'GS'
                                       WHEN MED_DEPT = 'CVIMC'           THEN 'IMC'
                                       WHEN MED_DEPT = 'CVTS'            THEN 'TS'
                                       WHEN MED_DEPT = 'DEIME'           THEN 'IME'
                                       WHEN MED_DEPT = 'OGO2'            THEN 'OG'

                                       WHEN MED_DEPT = 'RCIMR'           THEN 'IMR'
                                       WHEN MED_DEPT = 'RCNP'            THEN 'NP'
                                       WHEN MED_DEPT = 'RCTS'            THEN 'TS'

                                       WHEN MED_DEPT = 'THDR'            THEN 'DR'
                                       WHEN MED_DEPT = 'THGS'            THEN 'GS'
                                       WHEN MED_DEPT = 'THIME'           THEN 'IME'
                                       WHEN MED_DEPT = 'THNM'            THEN 'NM'
                                       WHEN MED_DEPT = 'THOL'            THEN 'OL'
                                       WHEN MED_DEPT = 'ONP'            THEN 'NP'

                                  ELSE MED_DEPT
                                  END                                                          MED_DEPT
                                 ,MEDDR_ID
                                 ,sum(
                                      case :in_rep_typ
                                           when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                           when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                           else 0
                                      end
                                     )                                                         hapgae
                                 ,sum(
                                      case :in_rep_typ
                                           when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                           when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                           else 0
                                      end
                                     )                                                         hapgae1
                                 ,sum(
                                      case when pattype in ('B1','B2','B6','BB') then
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         bohum
                                 ,sum(
                                      case when pattype in ('B1','B2','B6','BB') then
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         bohum1
                                 ,sum(
                                      case when pattype in ('E1','E2','E6')      then
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         boho1
                                 ,sum(
                                      case when pattype in ('E1','E2','E6')     then
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         boho11
                                 ,0                                                            boho2
                                 ,0                                                            boho21
                                 ,sum(
                                      case when pattype in ('E8')                then
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         hangyer
                                 ,sum(
                                      case when pattype in ('E8')                then
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         hangyer1
                                 ,sum(
                                      case when pattype in ('SA','SB','SP')            then
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         sanjae
                                 ,sum(
                                      case when pattype in ('SA','SB','SP')           then
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         sanjae1
                                 ,0                                                            gongsang
                                 ,0                                                            gongsang1
                                 ,sum(
                                      case when pattype in ('AA')                then
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         general
                                 ,sum(
                                      case when pattype in ('AA')                then
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         general1
                                 ,sum(
                                      case when pattype in ('TA')                then
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         traffic
                                 ,sum(
                                      case when pattype in ('TA')                then
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         traffic1
                                 ,sum(
                                      case when pattype in ( 'B1','B2','B6','BB'
                                                            ,'E1','E2','E6'
                                                            ,'E8'
                                                            ,'SA','SB','SP'
                                                            ,'AA'
                                                            ,'TA'
                                                           )                     then
                                                0
                                           else
                                                case :in_rep_typ
                                                     when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                                     when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                                     else 0
                                                end
                                      end
                                     )                                                         gita
                                 ,sum(
                                      case when pattype in ( 'B1','B2','B6','BB'
                                                            ,'E1','E2','E6'
                                                            ,'E8'
                                                            ,'SA','SB','SP'
                                                            ,'AA'
                                                            ,'TA'
                                                           )                     then
                                                0
                                           else
                                                case :in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                      end
                                     )                                                         gita1
                                 ,'1' gubun
                             FROM APSTATMT2
                            WHERE MED_DTE IN
                                              (







/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                               SELECT  END_DTE
                                                 FROM
                                                     (



/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                                        SELECT
                                                             DISTINCT
                                                             CASE WHEN :IN_LOOK IN ('1','2') THEN
                                                                       CASE WHEN LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD')) <= TRUNC(SYSDATE) -1  THEN
                                                                                 LAST_DAY(TO_DATE(SUBSTR(:IN_FYYYYMM ,1,4)||LPAD(ROWNUM,2,'0')||'01','YYYYMMDD'))
                                                                            ELSE
                                                                                 TRUNC(SYSDATE) -1
                                                                       END
                                                                 ELSE
                                                                       TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                             END       END_DTE
                                                            ,ROW_NUMBER() OVER(PARTITION BY ROWNUM ORDER BY ROWNUM) RANK
                                                        FROM DICT
                                                       WHERE ROWNUM <= 12
/* 1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                     )
                                                WHERE END_DTE BETWEEN CASE :IN_LOOK
                                                                           WHEN '1' THEN
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD'))
                                                                                     ELSE
                                                                                          TRUNC(SYSDATE)-1
                                                                                END
                                                                           WHEN '2' THEN
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD'))
                                                                                     ELSE
                                                                                          TRUNC(SYSDATE)-1
                                                                                END
                                                                           WHEN '3' THEN
                                                                                TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                           ELSE
                                                                                TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                      END
                                                                  AND CASE :IN_LOOK
                                                                           WHEN '1' THEN
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD'))
                                                                                     ELSE
                                                                                          TRUNC(SYSDATE)-1
                                                                                END
                                                                           WHEN '2' THEN
                                                                                CASE WHEN LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                          LAST_DAY(TO_DATE(:IN_TYYYYMM ||'01','YYYYMMDD'))
                                                                                     ELSE
                                                                                          TRUNC(SYSDATE)-1
                                                                                END
                                                                           WHEN '3' THEN
                                                                                TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                           ELSE
                                                                                TO_DATE(:IN_TYYYYMM ,'YYYYMMDD')
                                                                      END




/* 2번 긑----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                              )



                              AND DTL_TYP = 'M01'
                              AND PATSITE = 'I'
                              AND WK_KEY  = '1'
                              AND WD_NO
                                        NOT IN
                                               (CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'ER99'
                                                END
                                                ,
                                                CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'OR99'
                                                END
                                                ,
                                                CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'OGOB'
                                                END
                                                ,
                                                CASE :IN_LOOK_TYP WHEN '1' THEN '*'
                                                                 ELSE 'NB'
                                                END
                                               )
                              AND CASE WHEN :IN_AGE_TYP = '3' THEN
                                       '*'
                                       ELSE
                                           CASE WHEN TO_NUMBER(AGE_TYP) >= 65 THEN
                                                     '1'
                                                ELSE
                                                     '2'
                                           END
                                  END  =  CASE WHEN :IN_AGE_TYP = '3' THEN
                                                    '*'
                                               ELSE
                                                    :IN_AGE_TYP
                                          END
                            GROUP BY
                                  -----------------------------------------------------------
                                  -- 2010.10.01 센터관련 적용
                                  -----------------------------------------------------------
                                  CASE WHEN MED_DEPT IN ('HPC1','HPC11') THEN 'HPC'
                                       WHEN MED_DEPT = 'BCGS'            THEN 'GS'
                                       WHEN MED_DEPT = 'BCOL'            THEN 'OL'
                                       WHEN MED_DEPT = 'BCPS'            THEN 'PS'
                                       WHEN MED_DEPT = 'BCDR'            THEN 'DR'

                                       WHEN MED_DEPT = 'CVGS'            THEN 'GS'
                                       WHEN MED_DEPT = 'CVIMC'           THEN 'IMC'
                                       WHEN MED_DEPT = 'CVTS'            THEN 'TS'
                                       WHEN MED_DEPT = 'DEIME'           THEN 'IME'
                                       WHEN MED_DEPT = 'OGO2'            THEN 'OG'

                                       WHEN MED_DEPT = 'RCIMR'           THEN 'IMR'
                                       WHEN MED_DEPT = 'RCNP'            THEN 'NP'
                                       WHEN MED_DEPT = 'RCTS'            THEN 'TS'

                                       WHEN MED_DEPT = 'THDR'            THEN 'DR'
                                       WHEN MED_DEPT = 'THGS'            THEN 'GS'
                                       WHEN MED_DEPT = 'THIME'           THEN 'IME'
                                       WHEN MED_DEPT = 'THNM'            THEN 'NM'
                                       WHEN MED_DEPT = 'THOL'            THEN 'OL'
                                       WHEN MED_DEPT = 'ONP'            THEN 'NP'

                                  ELSE MED_DEPT
                                  END
                                 ,MEDDR_ID



/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          )        A


                    GROUP BY
                          A.MED_DEPT
                         ,A.MEDDR_ID
                         ,A.GUBUN



/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                  )
             GROUP BY
                      ROLLUP(MED_DEPT,MEDDR_ID)
             HAVING  SUM(HAPGAE) != 0
             ORDER BY
                     MED_DEPT



/* 5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
             ;;
            )
             group by
                      rollup(med_dept,meddr_id)
              having  sum(hapgae) != 0  or  sum(hapgae1) != 0
             order by
                      med_dept
/* 7번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



;;;

EXEC :in_fyyyymm  := '2024';
EXEC :in_look := '1';
EXEC :in_age_typ := '3';
EXEC :in_rep_typ := '8';
EXEC :in_look_typ := '2';
