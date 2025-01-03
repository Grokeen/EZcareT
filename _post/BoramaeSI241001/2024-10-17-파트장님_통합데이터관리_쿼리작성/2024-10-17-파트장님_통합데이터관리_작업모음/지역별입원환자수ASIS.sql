﻿    /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income021
        *    최초 작성일     : 2009.10.22
        *    최초 작성자     :
        *    Description     : 진료과별 환자종류별 연간입퇴원환자
        *    Input Parameter :
    *                      1.in_fyyyymm     =>시작일자 :  yyyy :년,  yyyymm :년월, yyyymmdd:년월일 ,  yyyymmdd:년월일
    *                      2.in_tyyyymm     =>종료일자 :  NULL    ,  NULL        , NULL            ,  yyyymmdd:년월일
    *                      3.in_look        =>열람구분 : '1' 연보,  '2' 월보    , '3' 일보       , else 기간
    *                      4.in_rep_typ     =>퇴원구분 : '1' 입원환자(실입원)
    *                                                    '2' 입원환자(실입원):과별배분
    *                                                    '3' 퇴원환자(실퇴원)
    *                                                    '4' 퇴원환자(실퇴원):과별배분
    *                                                    '5' 재원환자 (연입원)
    *                                                    '6' 총재원수 (연퇴원)
    *                                                    '7' 퇴원평균재원일
    *                                                    '8' 퇴원평균재원일:과별배분
    *                      5.in_age_typ     =>나이구분 : '1' 65세이상 , '2' 65세미만 ,'3' 전체
    *                      6.in_look_typ    =>제외병동 : '1' 포함 ,'2' 미포함   ;ER99,OR99,OGOB,NB
        *    페이지ID        :
        ***********************************************************************************/
        procedure pc_sel_pts02_income021 ( in_fyyyymm     in   varchar2
                                     , in_tyyyymm     in   varchar2
                                     , in_look        in   varchar2
                                         , in_rep_typ     in   varchar2
                                     , in_age_typ     in   varchar2
                                     , in_look_typ    in   varchar2
                                         , out_cursor    out  returncursor )


        is

                wk_cursor returncursor;

        begin

        if in_rep_typ in ('1','2','3','4','5','6') then

            open wk_cursor for


/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

            select
                   case when grouping(med_dept) = 0 then
                            (select
--                                    case when instr(dept_nm,'(') > 0 then
--                                              substr(dept_nm,1,instr(dept_nm,'(')-1)
--                                         else
                                              dept_nm
--                                    end
                               from ccdepart a
                              where dept_cd = med_dept)
                           else
                            '합계'
                       end                                       "진료과"
                  ,sum(hapgae)                               "합계"
                  ,sum(bohum)                                "보험"
                  ,sum(boho1)                                "보호1"
                  ,sum(boho2)                                "보호2"
                  ,sum(hangyer)                              "행여"
                  ,sum(sanjae)                               "산재"
                  ,sum(gongsang)                             "공상"
                  ,sum(general)                              "일반"
                  ,sum(traffic)                              "교통"
                  ,sum(gita)                                 "기타"
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
                          end                                                        med_dept
                         ,sum(
                              case in_rep_typ
                                   when '1' then shspcrcp_cnt
                                   when '2' then chspcrsv_cnt
                                   when '3' then shunspcrcp_cnt
                                   when '4' then chunspcrsv_cnt
                                   when '5' then jespcrsv_cnt
                                   when '6' then jeunspcrsv_cnt
                                   else 0
                              end
                             )                                                         hapgae
                         ,sum(
                              case when pattype in ('B1','B2','B6','BB') then
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         bohum
                         ,sum(
                              case when pattype in ('E1','E2','E6')       then
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         boho1
                         ,0                                                            boho2
                         ,sum(
                              case when pattype in ('E8')                then
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         hangyer
                         ,sum(
                              case when pattype in ('SA','SB','SP')           then
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         sanjae
                         ,0                                                            gongsang
                         ,sum(
                              case when pattype in ('AA')                then
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                         general
                         ,sum(
                              case when pattype in ('TA')                then
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                                   else
                                        0
                              end
                             )                                                        traffic
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
                                        case in_rep_typ
                                             when '1' then shspcrcp_cnt           --실환자(인원) 입원
                                             when '2' then chspcrsv_cnt           --실환자(과)   입원
                                             when '3' then shunspcrcp_cnt         --실환자(인원) 퇴원
                                             when '4' then chunspcrsv_cnt         --실환자(과)   퇴원
                                             when '5' then jespcrsv_cnt           --연환자(인원) 입원
                                             when '6' then jeunspcrsv_cnt         --연환자(인원) 퇴원
                                             else 0
                                        end
                              end
                             )                                                         gita
                         ,'1' gubun
                     from apstatmt2
                    where med_dte in
                                      (

/* 2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                       select  end_dte
                                         from
                                             (


/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                              select
                                                     distinct
                                                     case when in_look in ('1','2') then
                                                               case when last_day(to_date(substr(in_fyyyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd')) <= trunc(sysdate) -1  then
                                                                         last_day(to_date(substr(in_fyyyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd'))
                                                                    else
                                                                         trunc(sysdate) -1
                                                               end
                                                         else
                                                               to_date(in_fyyyymm,'yyyymmdd')
                                                     end       end_dte
                                                    ,row_number() over(partition by rownum order by rownum) rank
                                                from dict
                                               where rownum <= 12

/* 1번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                             )
                                        where end_dte between case in_look
                                                                   when '1' then
                                                                        case when last_day(to_date(in_fyyyymm||'0101','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_fyyyymm||'0101','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '2' then
                                                                        case when last_day(to_date(in_fyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_fyyyymm||'01','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '3' then
                                                                        to_date(in_fyyyymm,'yyyymmdd')
                                                                   else
                                                                        to_date(in_fyyyymm,'yyyymmdd')
                                                              end
                                                          and case in_look
                                                                   when '1' then
                                                                        case when last_day(to_date(in_fyyyymm||'1201','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_fyyyymm||'1201','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '2' then
                                                                        case when last_day(to_date(in_tyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_tyyyymm||'01','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '3' then
                                                                        to_date(in_fyyyymm,'yyyymmdd')
                                                                   else
                                                                        to_date(in_tyyyymm,'yyyymmdd')
                                                              end

/* 2번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                      )
                      and dtl_typ = 'M01'
                      and patsite = 'I'
                      and wk_key  = '1'
                      and wd_no
                                not in
                                       (case in_look_typ when '1' then '*'
                                                         else 'ER99'
                                        end
                                        ,
                                        case in_look_typ when '1' then '*'
                                                         else 'OR99'
                                        end
                                        ,
                                        case in_look_typ when '1' then '*'
                                                         else 'OGOB'
                                        end
                                        ,
                                        case in_look_typ when '1' then '*'
                                                         else 'NB'
                                        end
                                       )
                      and case when in_age_typ = '3' then
                               '*'
                               else
                                   case when to_number(age_typ) >= 65 then
                                             '1'
                                        else
                                             '2'
                                   end
                          end  =  case when in_age_typ = '3' then
                                            '*'
                                       else
                                            in_age_typ
                                  end
                    group by
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
                            end
                  )
             group by
                      rollup(med_dept)
             having  sum(hapgae) != 0
             order by
                      med_dept



/* 3번 끝----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


              ;

            out_cursor := wk_cursor;

        else











            open wk_cursor for










/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


            select
                   case when grouping(med_dept) = 0 then
                            (select
--                                    case when instr(dept_nm,'(') > 0 then
--                                              substr(dept_nm,1,instr(dept_nm,'(')-1)
--                                         else
                                              dept_nm
--                                    end
                               from ccdepart a
                              where dept_cd = med_dept)
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
                  
                  


/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                  
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
                              case in_rep_typ
                                   when '7' then shunspcrcp_cnt    --실환자(인원) 퇴원
                                   when '8' then chunspcrsv_cnt    --실환자(과)   퇴원
                                   else 0
                              end
                             )                                                         hapgae
                         ,sum(
                              case in_rep_typ
                                   when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                   when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                   else 0
                              end
                             )                                                         hapgae1
                         ,sum(
                              case when pattype in ('B1','B2','B6','BB') then
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
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
                                        case in_rep_typ
                                             when '7' then jeunspcrsv_cnt   --연환자수(퇴)
                                             when '8' then jeunspcrsv_cnt   --연환자수(퇴)
                                             else 0
                                        end
                              end
                             )                                                         gita1
                         ,'1' gubun
                     from apstatmt2
                    where med_dte in
                                      (               
                                      
                                      

/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                        
                                       select  end_dte
                                         from
                                             (


/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                              select
                                                     distinct
                                                     case when in_look in ('1','2') then
                                                               case when last_day(to_date(substr(in_fyyyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd')) <= trunc(sysdate) -1  then
                                                                         last_day(to_date(substr(in_fyyyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd'))
                                                                    else
                                                                         trunc(sysdate) -1
                                                               end
                                                         else
                                                               to_date(in_fyyyymm,'yyyymmdd')
                                                     end       end_dte
                                                    ,row_number() over(partition by rownum order by rownum) rank
                                                from dict
                                               where rownum <= 12    
                                               


/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                               
                                             )
                                        where end_dte between case in_look
                                                                   when '1' then
                                                                        case when last_day(to_date(in_fyyyymm||'0101','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_fyyyymm||'0101','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '2' then
                                                                        case when last_day(to_date(in_fyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_fyyyymm||'01','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '3' then
                                                                        to_date(in_fyyyymm,'yyyymmdd')
                                                                   else
                                                                        to_date(in_fyyyymm,'yyyymmdd')
                                                              end
                                                          and case in_look
                                                                   when '1' then
                                                                        case when last_day(to_date(in_fyyyymm||'1201','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_fyyyymm||'1201','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '2' then
                                                                        case when last_day(to_date(in_tyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                                  last_day(to_date(in_tyyyymm||'01','yyyymmdd'))
                                                                             else
                                                                                  trunc(sysdate)-1
                                                                        end
                                                                   when '3' then
                                                                        to_date(in_fyyyymm,'yyyymmdd')
                                                                   else
                                                                        to_date(in_tyyyymm,'yyyymmdd')
                                                              end   
                                                              
                                                              

/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/  

                                                              
                                      )
                      and dtl_typ = 'M01'
                      and patsite = 'I'
                      and wk_key  = '1'
                      and wd_no
                                not in
                                       (case in_look_typ when '1' then '*'
                                                         else 'ER99'
                                        end
                                        ,
                                        case in_look_typ when '1' then '*'
                                                         else 'OR99'
                                        end
                                        ,
                                        case in_look_typ when '1' then '*'
                                                         else 'OGOB'
                                        end
                                        ,
                                        case in_look_typ when '1' then '*'
                                                         else 'NB'
                                        end
                                       )
                      and case when in_age_typ = '3' then
                               '*'
                               else
                                   case when to_number(age_typ) >= 65 then
                                             '1'
                                        else
                                             '2'
                                   end
                          end  =  case when in_age_typ = '3' then
                                            '*'
                                       else
                                            in_age_typ
                                  end
                    group by
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
                            end    
                            
                            

/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                              
                  )
             group by
                      rollup(med_dept)
             having  sum(hapgae) != 0  or  sum(hapgae1) != 0
             order by
                      med_dept          
                      
                      
                      

/*1-2번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                        
             ;

            out_cursor := wk_cursor;

        end if;

        exception
            when others then
                raise_application_error(-20500,'pc_sel_pts02_income021 오류!' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);

    end pc_sel_pts02_income021;
