
        /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income917_new
        *    최초 작성일     : 2010.12.06
        *    최초 작성자     :
        *    Description     : 의사별 환자종류별 입퇴원 환자수
        *    Input Parameter :
    *                      1.in_fyyyymm     =>시작일자 :  yyyy :년,  yyyymm :년월, yyyymmdd:년월일 ,  yyyymmdd:년월일
    *                      2.in_tyyyymm     =>종료일자 :  NULL    ,  NULL        , NULL            ,  yyyymmdd:년월일
    *                      3.in_look        =>열람구분 : '1' 연보,  '2' 월보    , '3' 일보       , else 기간
    *                      4.in_rep_typ     =>퇴원구분 : '1' 입원실환자수    :등록최초과
    *                                                    '2' 재원연환자수    :전과반영
    *                                                    '3' 재원실환자수    :전과반영
    *                                                    '4' 퇴원실환자수    :최종과
    *                                                    '5' 퇴원실환자수    :전과반영
    *                                                    '6' 퇴원연환자수    :최종과
    *                                                    '7' 퇴원연환자수    :전과반영
    *                                                    '8' 퇴원평균재원일수:최종과  (퇴원연환자/퇴원실환자)
    *                                                    '9' 퇴원평균재원일수:전과반영(퇴원연환자/퇴원실환자)
    *                      5.in_age_typ     =>나이구분 : '1' 65세이상 , '2' 65세미만 ,'3' 전체
        *    페이지ID        : /MIS/PTS/PTS/PTS/READDTPTKDYYIRTHPTCT.ASPX
        ***********************************************************************************/
        procedure pc_sel_pts02_income917_new (
            in_fyyyymm     in   varchar2
        ,   in_tyyyymm     in   varchar2
        ,   in_look        in   varchar2
        ,   in_rep_typ     in   varchar2
        ,   in_age_typ     in   varchar2
        ,   in_look_typ    in   varchar2
        ,   out_cursor    out  returncursor
    )
    is
                wk_cursor returncursor;
        begin
        if in_rep_typ in ('1','2','3','4','5','6','7') then
            open wk_cursor for
                                                              

/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

            select
                   case when grouping(med_dept)||grouping(meddr_id) = '11' then
                            '합계'
                           else
                            (select
                                              dept_nm
                               from ccdepart a where dept_cd = med_dept)
                       end                                       "진료과"
                  ,case when grouping(med_dept)||grouping(meddr_id) = '00' then
                            (select wk_nm from ccusermt a where wk_id = meddr_id)
                        when grouping(med_dept)||grouping(meddr_id) = '11' then
                            '전체'
                           else
                            '소계'
                       end                                       "진료의"
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



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                   --------------------------------------------------------------------------------------
                   -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 추가함..
                   --------------------------------------------------------------------------------------
                   select
                          a.med_dept                                      med_dept
                         ,nvl(b.lst_wk_id,a.meddr_id)                     meddr_id
                         ,a.gubun                                         gubun
                         ,sum(a.hapgae  )                                 hapgae
                         ,sum(a.bohum   )                                 bohum
                         ,sum(a.boho1   )                                 boho1
                         ,sum(a.boho2   )                                 boho2
                         ,sum(a.hangyer )                                 hangyer
                         ,sum(a.sanjae  )                                 sanjae
                         ,sum(a.gongsang)                                 gongsang
                         ,sum(a.general )                                 general
                         ,sum(a.traffic )                                 traffic
                         ,sum(a.gita    )                                 gita
                     from (




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
                                 ,meddr_id
                                 ,sum(
                                      case in_rep_typ
                                           when '1' then day_cnt4           --입원실환자수    :등록최초과
                                           when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                           when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                           when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                           when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                           when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                           when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
                                           else 0
                                      end
                                     )                                                         hapgae
                                 ,sum(
                                      case when pattype in ('B1','B2','B6','BB') then
                                                case in_rep_typ
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         bohum
                                 ,sum(
                                      case when pattype in ('E1','E2','E6')                then
                                                case in_rep_typ
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
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
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         hangyer
                                 ,sum(
                                      case when pattype in ('SA','SB','SP')      then
                                                case in_rep_typ
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         sanjae
                                 ,0                                                           gongsang
                                 ,sum(
                                      case when pattype in ('AA')                then
                                                case in_rep_typ
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
                                                     else 0
                                                end
                                           else
                                                0
                                      end
                                     )                                                         general
                                 ,sum(
                                      case when pattype in ('TA')                then
                                                case in_rep_typ
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
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
                                                     when '1' then day_cnt4           --입원실환자수    :등록최초과
                                                     when '2' then jespcrsv_cnt       --재원연환자수    :전과반영
                                                     when '3' then chspcrsv_cnt       --재원실환자수    :전과반영
                                                     when '4' then shunspcrcp_cnt     --퇴원실환자수    :최종과
                                                     when '5' then chunspcrsv_cnt     --퇴원실환자수    :전과반영
                                                     when '6' then jeunspcrsv_cnt     --퇴원연환자수    :최종과
                                                     when '7' then shunspcrsv_cnt     --퇴원연환자수    :전과반영
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



/* 1번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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




/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                              )


/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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
                                 ,meddr_id



/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          )        a
                         ,ccusermt b
                    where b.wk_id(+) = nvl(a.meddr_id,'*')
                    group by
                          a.med_dept
                         ,nvl(b.lst_wk_id,a.meddr_id)
                         ,a.gubun



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                  )
             group by
                      rollup(med_dept,meddr_id)
             having  sum(hapgae) != 0
             order by
                     med_dept



/* 5번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                        ;
        elsif in_rep_typ in ('8','9') then

                        open wk_cursor for


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


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


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                   --------------------------------------------------------------------------------------
                   -- 2010.05.18 동일의사인 경우 최종사번으로 합쳐 나오게 하기 위해 추가함..
                   --------------------------------------------------------------------------------------
                   select
                          a.med_dept                                      med_dept
                         ,nvl(b.lst_wk_id,a.meddr_id)                     meddr_id
                         ,a.gubun                                         gubun
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
                     from (




/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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
                                  end                                                         med_dept
                                 ,meddr_id
                                 ,sum(
                                      case in_rep_typ
                                           when '8' then shunspcrcp_cnt   --퇴원실환자수 :최종과
                                           when '9' then chunspcrsv_cnt   --퇴원실환자수 :전과반영
                                           else 0
                                      end
                                     )                                                         hapgae
                                 ,sum(
                                      case in_rep_typ
                                           when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                           when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                           else 0
                                      end
                                     )                                                         hapgae1
                                 ,sum(
                                      case when pattype in ('B1','B2','B6','BB') then
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
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
                                                case in_rep_typ
                                                     when '8' then jeunspcrsv_cnt   --퇴원연환자수 :최종과
                                                     when '9' then shunspcrsv_cnt   --퇴원연환자수 :전과반영
                                                     else 0
                                                end
                                      end
                                     )                                                         gita1
                                 ,'1' gubun
                             from apstatmt2
                            where med_dte in
                                              (



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                               select  end_dte
                                                 from
                                                     (



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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




/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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
                                 ,meddr_id



/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                          )        a
                         ,ccusermt b
                    where b.wk_id(+) = nvl(a.meddr_id,'*')
                    group by
                          a.med_dept
                         ,nvl(b.lst_wk_id,a.meddr_id)
                         ,a.gubun


/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                  )
             group by
                      rollup(med_dept,meddr_id)
              having  sum(hapgae) != 0  or  sum(hapgae1) != 0
             order by
                      med_dept
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
