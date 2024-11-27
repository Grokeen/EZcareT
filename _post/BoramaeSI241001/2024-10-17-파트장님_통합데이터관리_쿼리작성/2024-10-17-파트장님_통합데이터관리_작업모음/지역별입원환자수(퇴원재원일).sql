EXEC :IN_FYYYYMM := '2024';
EXEC :IN_LOOK := '1';
EXEC :IN_REP_TYP := '1';
exec :IN_LOOK_TYP :='2';




/** *                      1.IN_FYYYYMM     =>시작일자 =   YYYY.년 ,  YYYYMM.년월  , YYYYMMDD.년월일   ,  YYYYMMDD.년월일
    *                      2.IN_TYYYYMM     =>종료일자 =   NULL    ,  NULL        , NULL             ,  YYYYMMDD.년월일
    *
    *                      3.IN_LOOK        =>열람구분 =   1.연보,  2.월보 , 3.일보 , 4.기간
    *                      4.IN_REP_TYP     =>퇴원구분 =   1. 입원환자(실입원)
    *                                                    2. 입원환자(실입원)과별배분
    *                                                    3. 퇴원환자(실퇴원)
    *                                                    4. 퇴원환자(실퇴원)과별배분
    *                                                    5. 재원환자(연입원)
    *                                                    6. 총재원수(연퇴원)
    *                                                    (X)  7 퇴원평균재원일
    *                                                    (X)  8 퇴원평균재원일 = 과별배분
    *                      5.IN_AGE_TYP     =>나이구분 = 1.65세이상 , 2.65세미만 ,3.전체
    *                      6.(X)       IN_LOOK_TYP    =>제외병동 = 1.포함,2.미포함  ER99,OR99,OGOB,NB
**/

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


             select
                   case when grouping(med_dept) = 0 then
                            NVL( ( XBIL.FC_GET_DEPT_NM(MED_DEPT)) , MED_DEPT)
                           else
                            '합계'
                       end                                                                                 "진료과"
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





/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/



                   select
                          -----------------------------------------------------------
                          -- 2010.10.01 센터관련 적용
                          -----------------------------------------------------------
                          case when med_dept in ('HPC1','HPC11') then 'HPC'
                               when med_dept = 'BCGS'            then 'GS'
                               when med_dept = 'BCOL'            then 'OL'
                               when med_dept = 'BCPS'            then 'PS'
                               when med_dept = 'BCDR'            then 'DR'

                               when med_dept = 'CVGS'            then 'GS'
                               when med_dept = 'CVIMC'           then 'IMC'
                               when med_dept = 'CVTS'            then 'TS'
                               when med_dept = 'DEIME'           then 'IME'
                               when med_dept = 'OGO2'            then 'OG'

                               when med_dept = 'RCIMR'           then 'IMR'
                               when med_dept = 'RCNP'            then 'NP'
                               when med_dept = 'RCTS'            then 'TS'

                               when med_dept = 'THDR'            then 'DR'
                               when med_dept = 'THGS'            then 'GS'
                               when med_dept = 'THIME'           then 'IME'
                               when med_dept = 'THNM'            then 'NM'
                               when med_dept = 'THOL'            then 'OL'
                               when med_dept = 'ONP'            then 'NP'

                               else med_dept
                          end                                                          med_dept
                         ,sum(
                              case :in_rep_typ
                                   when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                   when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                   else 0
                              end
                             )                                                         hapgae
                         ,sum(
                              case :in_rep_typ
                                   when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                   when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                   else 0
                              end
                             )                                                         hapgae1
                         ,sum(
                              case when pattype in ('B1','B2','B6','BB') then
                                        case :in_rep_typ
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         bohum
                         ,sum(
                              case when pattype in ('B1','B2','B6','BB') then
                                        case :in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         bohum1
                         ,sum(
                              case when pattype in ('E1','E2','E6')      then
                                        case :in_rep_typ
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         boho1
                         ,sum(
                              case when pattype in ('E1','E2','E6')      then
                                        case :in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
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
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         hangyer
                         ,sum(
                              case when pattype in ('E8')                then
                                        case :in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         hangyer1
                         ,sum(
                              case when pattype in ('SA','SB','SP')            then
                                        case :in_rep_typ
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         sanjae
                         ,sum(
                              case when pattype in ('SA','SB','SP')           then
                                        case :in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
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
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         general
                         ,sum(
                              case when pattype in ('AA')                then
                                        case :in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         general1
                         ,sum(
                              case when pattype in ('TA')                then
                                        case :in_rep_typ
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         traffic
                         ,sum(
                              case when pattype in ('TA')                then
                                        case :in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
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
                                             when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                             when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
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
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                             else 0
                                        end
                              end
                             )                                                         gita1
                         ,'1'                                                         gubun
                     from APSTATMT2
                    where med_dte in
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
                                                                        CASE WHEN TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD') < TRUNC(SYSDATE)-1  THEN
                                                                                  TO_DATE(:IN_FYYYYMM ||'0101','YYYYMMDD')
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '2' THEN
                                                                        CASE WHEN TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD') < TRUNC(SYSDATE)-1  THEN
                                                                                  TO_DATE(:IN_FYYYYMM ||'01','YYYYMMDD')
                                                                             ELSE
                                                                                  TRUNC(SYSDATE)-1
                                                                        END
                                                                   WHEN '3' THEN
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                                   ELSE
                                                                        TO_DATE(:IN_FYYYYMM ,'YYYYMMDD')
                                                              END
                                                          AND
                                                              CASE :IN_LOOK
                                                                   WHEN '1' THEN
                                                                        CASE WHEN LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD')) < TRUNC(SYSDATE)-1  THEN
                                                                                  LAST_DAY(TO_DATE(:IN_FYYYYMM ||'1201','YYYYMMDD'))
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
                                                                        TO_DATE(:IN_TYYYYMM ,'YYYYMMDD')
                                                              END

/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                      )
                      AND DTL_TYP = 'M01'
                      AND PATSITE = 'I'
                      AND WK_KEY  = '1'

                      /*  */
--                      AND WD_NO
--                                NOT IN
--                                       (CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'ER99'
--                                        END
--                                        ,
--                                        CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'OR99'
--                                        END
--                                        ,
--                                        CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'OGOB'
--                                        END
--                                        ,
--                                        CASE :IN_LOOK_TYP WHEN '1' THEN '*'
--                                                         ELSE 'NB'
--                                        END
--                                       )
--                      AND CASE WHEN :IN_AGE_TYP = '3' THEN
--                               '*'
--                               ELSE
--                                   CASE WHEN TO_NUMBER(AGE_TYP) >= 65 THEN
--                                             '1'
--                                        ELSE
--                                             '2'
--                                   END
--                          END  =  CASE WHEN :IN_AGE_TYP = '3' THEN
--                                            '*'
--                                       ELSE
--                                            :IN_AGE_TYP
--                                  END
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




/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                  )
             GROUP BY
                      ROLLUP(MED_DEPT)
             HAVING  SUM(HAPGAE) != 0
             ORDER BY
                      MED_DEPT
/* 4번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


;
EXEC :IN_REP_TYP := '7';
