﻿   /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income019_new
        *    최초 작성일     : 2010.12.06
        *    최초 작성자     :
        *    Description     : 진료과별 환자종류별 진료실적
        *    Input Parameter :
        *    페이지ID        :
        ***********************************************************************************/
        procedure pc_sel_pts02_income019_new ( in_fyyyymm   in   varchar2
                                             , in_tyyyymm   in   varchar2
                                             , in_Look      in   varchar2
                                             , out_cursor   out  returncursor)
        is
                wk_cursor returncursor;
        begin

        open wk_cursor for
        select
               nvl((select
                          -- case when instr(dept_nm,'(') > 0 then
                          --           substr(dept_nm,1,instr(dept_nm,'(')-1)
                          --      else
                                     dept_nm
                          -- end
                      from ccdepart a
                     where dept_cd = med_dept),'전체') "진료과"
              ,sum(tot_cnt)                       "환자수"
              ,sum(sin_cnt)                       "신환  "
              ,sum(cho_cnt)                       "초진  "
              ,sum(jae_cnt)                       "재진  "
              ,case when sum(tot_cnt) = 0 or op_day_cnt = 0 then
                         0
                    else
                         round(sum(tot_cnt)/op_day_cnt)
               end                                "일평균"
              ,sum(pt_rip_cnt)                    "입원실환자수(최종과)"
              ,sum(trip_cnt)                      "재원연환자수(전과반영)"
              ,case when sum(trip_cnt) = 0 or ip_day_cnt = 0 then
                         0
                    else
                         round(sum(trip_cnt)/ip_day_cnt)
               end                                "일평균(입)"
              ,sum(pt_tip_cnt )                   "퇴원실환자수(최종과)"
              ,sum(ttip_cnt)                      "퇴원연환자수(최종과)"
              ,case when sum(ttip_cnt) = 0 or ip_day_cnt = 0 then
                         0
                    else
                         round(sum(ttip_cnt)/ip_day_cnt)
               end                                "일평균(퇴)"
              ,case when sum(toe_dte) = 0 or sum(tip_cnt) = 0 then
                         0
                    else
                         round(sum(toe_dte)/sum(tip_cnt),1)
               end                                "평균재원일(전과반영)"
              ,case when sum(ttip_cnt) = 0 or sum(pt_tip_cnt) = 0 then
                         0
                    else
                         round(sum(ttip_cnt)/sum(pt_tip_cnt),1)
               end                                "평균재원일"
          from
              (
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
                     ,sum(rsv_cnt+today_cnt)                                       tot_cnt
                     ,sum(shrsv_cnt+shunspcrsv_cnt)                                sin_cnt
                     ,sum(chspcrsv_cnt+chunspcrsv_cnt)                             cho_cnt
                     ,sum(jespcrsv_cnt+jeunspcrsv_cnt)                             jae_cnt
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            pt_rip_cnt    --입원실환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            trip_cnt      --재원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            pt_tip_cnt    --퇴원실환자수(최종과)
                     ,0                                                            ttip_cnt      --퇴원연환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,0                                                            tip_cnt       --퇴원실환자수(전과반영)
                     ,0                                                            toe_dte       --퇴원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,'1' gubun
                 from apstatmt2
                     ,(
                        select to_date(in_fyyyymm||'01','yyyymmdd')  star_dte
                              ,case when last_day(to_date(in_tyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                       last_day(to_date(in_tyyyymm||'01','yyyymmdd'))
                                  else
                                       trunc(sysdate)-1
                               end end_dte
                          from dual
                      )
                where med_dte between star_dte  and  end_dte
                  and dtl_typ = '06'
                  and patsite in ('O','E')
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
               union all
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
                     ,0                                                            tot_cnt
                     ,0                                                            sin_cnt
                     ,0                                                            cho_cnt
                     ,0                                                            jae_cnt
                     -----------------------------------------------------------------------------------------------------
                     ,sum(day_cnt4)                                                pt_rip_cnt    --입원실환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,sum(jespcrsv_cnt)                                            trip_cnt      --재원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,sum(shunspcrcp_cnt)                                          pt_tip_cnt    --퇴원실환자수(최종과)
                     ,sum(jeunspcrsv_cnt)                                          ttip_cnt      --퇴원연환자수(최종과)
                     -----------------------------------------------------------------------------------------------------
                     ,sum(chunspcrsv_cnt)                                          tip_cnt       --퇴원실환자수(전과반영)
                     ,sum(shunspcrsv_cnt)                                          toe_dte       --퇴원연환자수(전과반영)
                     -----------------------------------------------------------------------------------------------------
                     ,'1'                                                          gubun
                 from apstatmt2
                where med_dte in
                                 (
                                  select end_dte
                                    from
                                        (
                                         select
                                                distinct
                                                case when last_day(to_date(substr(in_fyyyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd')) <= trunc(sysdate) -1  then
                                                          last_day(to_date(substr(in_fyyyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd'))
                                                     else
                                                          trunc(sysdate) -1
                                                end     end_dte
                                               ,row_number() over(partition by rownum order by rownum) rank
                                               ,case when last_day(to_date(in_fyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                          last_day(to_date(in_fyyyymm||'01','yyyymmdd'))
                                                     else
                                                          trunc(sysdate)-1
                                                end                                from_dte
                                              ,case when last_day(to_date(in_tyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                         last_day(to_date(in_tyyyymm||'01','yyyymmdd'))
                                                    else
                                                         trunc(sysdate)-1
                                               end                                 to_dte
                                           from dict
                                          where rownum <= 12
                                        )
                                   where end_dte between  from_dte and to_dte
                                 )
                   and dtl_typ = 'M01'
                   and patsite = 'I'
                   and wk_key  = '1'
                   and wd_no
                           not in
                                  (case in_Look when '1' then '*'
                                                 else 'ER99'
                                   end
                                   ,
                                   case in_Look when '1' then '*'
                                                 else 'OR99'
                                   end
                                   ,
                                   case in_Look when '1' then '*'
                                                 else 'OGOB'
                                   end
                                   ,
                                   case in_Look when '1' then '*'
                                                 else 'NB'
                                   end
                                  )
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
              ,
               (
                select ft_cnt_opday (star_dte,end_dte,'1') ip_day_cnt
                      ,ft_cnt_opday (star_dte,end_dte,'3') op_day_cnt
                 from
                     (
                      select to_date(in_fyyyymm||'01','yyyymmdd')  star_dte
                            ,case when last_day(to_date(in_tyyyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                       last_day(to_date(in_tyyyymm||'01','yyyymmdd'))
                                  else
                                       trunc(sysdate)-1
                             end      end_dte
                        from dual
                      )
               )
        group by
                 rollup(med_dept)
                                ;

                out_cursor := wk_cursor;

                exception
                        when others then
                                raise_application_error(-20500,'pc_sel_pts02_income019_new 오류!' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);


    end pc_sel_pts02_income019_new;