
EXEC :IN_FROMYYMM  := '202410';
EXEC :IN_TOYYMM := '202410';
EXEC :IN_PATSITE := '3';
EXEC :IN_SUJINFLAG := '1';



 /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income009
        *    최초 작성일     : 2009.10.22
        *    최초 작성자     :
        *    Description     : 진료과별환자종류별환자수
        *    Input Parameter :
        *    페이지ID        : D:\WEB\MIS\PTS\PTS\INC\ReadClcDtGa2.aspx
        *
--     1.&in_fromyymm  => yyyymm :년월
--     2.&in_toyymm    => yyyymm :년월
--     3.&in_sujinflag => '1' : 수진, '2':미수진  else 전체
--     4.&in_patsite  => 1:입원 , 2:외래 3:전체
        ***********************************************************************************/
        procedure pc_sel_pts02_income009 ( in_fromyymm   in   varchar2
                                         , in_toyymm     in   varchar2
                                         , in_sujinflag  in   varchar2
                                         , in_patsite    in   varchar2
                                         , out_cursor    out  returncursor )
        is
                wk_cursor  returncursor;
                w_days     number := 0;
        begin
                open wk_cursor for



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

        select
               case when group_ing = '0' then
                         (select
--                                 case when instr(dept_nm,'(') > 0 then
--                                           substr(dept_nm,1,instr(dept_nm,'(')-1)
--                                      else
                                           dept_nm
--                                 end
                            from ccdepart where dept_cd = med_dept
                          )
                    else
                         '합계'
               end  med_dept
              ,tot_cnt
              -------------------------------------------------------------------
              -- 2010.11.29 이강준 보험(차상위포함) ==> 보험,차상위 분리
              -------------------------------------------------------------------
              --기존
              --,ins_cnt
              -------------------------------------------------------------------
              ,ins_cnt
              ,cha_cnt
              -------------------------------------------------------------------
              ,boho_cnt
              ,gen_cnt
              ,san_cnt
              ,car_cnt
              ,hang_cnt
              ,etc_cnt
              ,case when tot_cnt = 0 or day_cnt = 0 then
                         0
                    else
                         round(tot_cnt / day_cnt , 0)
               end                                   dayavr_cnt
              ,case when tot_cnt = 0 or total_cnt = 0 then
                         0
                    else
                         round(tot_cnt / total_cnt *100,1)
               end                                   yul
              ,spc_y_cnt
              ,spc_n_cnt
          from
              (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

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
                      end                                                     med_dept
                     ,sum(sincnt +  chocnt + jaecnt)                          tot_cnt
                     ------------------------------------------------------------
                     -- 2010.11.29 이강준 보험(차상위포함) ==> 보험,차상위 분리
                     ------------------------------------------------------------
                     --기존logic
                     --,sum(
                     --     case when pattype in ('B1','B2','B6','BB') then
                     --               sincnt + chocnt + jaecnt
                     --          else
                     --               0
                     --     end
                     --    )                                                    ins_cnt
                     ------------------------------------------------------------
                     ,sum(
                          case when pattype in ('BB') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    ins_cnt
                     ,sum(
                          case when pattype in ('B1','B2','B6') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    cha_cnt
                     ------------------------------------------------------------
                     ,sum(
                          case when pattype in ('E1','E2','E6') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    boho_cnt
                     ,sum(
                          case when pattype in ('AA') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    gen_cnt
                     ,sum(
                          case when pattype in ('SA','SB','SP') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    san_cnt
                     ,sum(
                          case when pattype in ('TA') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    car_cnt
                     ,sum(
                          case when pattype in ('E8') then
                                    sincnt + chocnt + jaecnt
                               else
                                    0
                          end
                         )                                                    hang_cnt
                     ,sum(
                          case when pattype in ( 'B1','B2','B6','BB'
                                                ,'E1','E2','E6'
                                                ,'AA'
                                                ,'SA','SB','SP'
                                                ,'TA'
                                                ,'E8'
                                               ) then
                                    0
                               else
                                    sincnt + chocnt + jaecnt
                          end
                         )                                                    etc_cnt
                     ,sum(spc_y_cnt) spc_y_cnt
                     ,sum(spc_n_cnt) spc_n_cnt
                     ,grouping(
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
                              )    group_ing
                 from
                     (




/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      select
                             med_dept
                            ,pattype
                            ,case in_sujinflag
                                  when '1' then shspcmed_cnt+shunspcmed_cnt
                                  when '2' then (shrsv_cnt+shunspcrsv_cnt) - (shspcmed_cnt+shunspcmed_cnt)
                                  else          shrsv_cnt+shunspcrsv_cnt
                             end   sincnt
                            ,case in_sujinflag
                                  when '1' then medchspc_cnt+chunspcmed_cnt
                                  when '2' then (chspcrsv_cnt+chunspcrsv_cnt) - (medchspc_cnt+chunspcmed_cnt)
                                  else          chspcrsv_cnt+chunspcrsv_cnt
                             end   chocnt
                            ,case in_sujinflag
                                  when '1' then jespcmed_cnt+jeunspcmed_cnt
                                  when '2' then (jespcrsv_cnt+jeunspcrsv_cnt) -(jespcmed_cnt+jeunspcmed_cnt)
                                  else          jespcrsv_cnt+jeunspcrsv_cnt
                             end   jaecnt
                            ,rsv_cnt+today_cnt tcnt
                            -------------------------------------------------------------------------------
                            -- 2010.12.03 이강준 지정,비지정 부분에는 수진,미수진이 적용이 안되어 있음..적용처리
                            -------------------------------------------------------------------------------
                            --기존logic
                            --,chspcrsv_cnt+jespcrsv_cnt+shrsv_cnt               spc_y_cnt
                            --,chunspcrsv_cnt+jeunspcrsv_cnt+shunspcrsv_cnt      spc_n_cnt
                            -------------------------------------------------------------------------------
                            ,case in_sujinflag
                                  when '1' then medchspc_cnt+jespcmed_cnt+shspcmed_cnt
                                  when '2' then (chspcrsv_cnt+jespcrsv_cnt+shrsv_cnt) - (medchspc_cnt+jespcmed_cnt+shspcmed_cnt)
                                  else          chspcrsv_cnt+jespcrsv_cnt+shrsv_cnt
                             end                                               spc_y_cnt

                            ,case in_sujinflag
                                  when '1' then chunspcmed_cnt+jeunspcmed_cnt+shunspcmed_cnt
                                  when '2' then (chunspcrsv_cnt+jeunspcrsv_cnt+shunspcrsv_cnt) - (chunspcmed_cnt+jeunspcmed_cnt+shunspcmed_cnt)
                                  else          chunspcrsv_cnt+jeunspcrsv_cnt+shunspcrsv_cnt
                             end                                               spc_n_cnt
                        from apstatmt2
                            ,
                            (



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                             select
                                    to_date(in_fromyymm||'01','yyyymmdd') star_dte
                                   ,case when last_day(to_date(in_toyymm||'01','yyyymmdd')) < trunc(sysdate) -1 then
                                              last_day(to_date(in_toyymm||'01','yyyymmdd'))
                                         else
                                              trunc(sysdate) -1
                                    end     end_dte
                               from dual


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )
                       where med_dte between star_dte and end_dte
                         and dtl_typ = '06'
                         and patsite in ('O','E')
                         and case when in_patsite = '1' then '1'
                                  when in_patsite = '2' then '2'
                                  else '3'
                             end
                                 =
                                   case when in_patsite = '1' then 'X'
                                        when in_patsite = '2' then '2'
                                        else '3'
                                   end


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      union all


/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      select
                             med_dept
                            ,pattype
                            ,0                   sincnt
                            ,0                   chocnt
                            ,case in_sujinflag
                                  when '1' then jespcrsv_cnt
                                  when '2' then jespcrsv_cnt - jespcrsv_cnt
                                  else          jespcrsv_cnt
                             end                 jaecnt
                            ,case in_sujinflag
                                  when '1' then jespcrsv_cnt
                                  when '2' then jespcrsv_cnt - jespcrsv_cnt
                                  else          jespcrsv_cnt
                             end                 t_cnt
                            ,case in_sujinflag
                                  when '1' then jespcrcp_cnt
                                  when '2' then jespcrcp_cnt - jespcrcp_cnt
                                  else          jespcrcp_cnt
                             end                 spc_y_cnt
                            ,case in_sujinflag
                                  when '1' then jeunspcrcp_cnt
                                  when '2' then jeunspcrcp_cnt - jeunspcrcp_cnt
                                  else          jeunspcrcp_cnt
                             end                spc_n_cnt
--                            ,jespcrsv_cnt        jaecnt
--                            ,jespcrsv_cnt        t_cnt
--                            ,jespcrcp_cnt        spc_y_cnt
--                            ,jeunspcrcp_cnt      spc_n_cnt
                        from apstatmt2
                       where med_dte in
                                        (

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                         select  end_dte
                                           from
                                               (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                select
                                                       distinct
                                                       case when last_day(to_date(substr(in_fromyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd')) <= trunc(sysdate) -1  then
                                                                 last_day(to_date(substr(in_fromyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd'))
                                                            else
                                                                 trunc(sysdate) -1
                                                       end     end_dte
                                                      ,row_number() over(partition by rownum order by rownum) rank
                                                      ,case when last_day(to_date(in_fromyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                 last_day(to_date(in_fromyymm||'01','yyyymmdd'))
                                                            else
                                                                 trunc(sysdate)-1
                                                       end                                from_dte
                                                     ,case when last_day(to_date(in_toyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                last_day(to_date(in_toyymm||'01','yyyymmdd'))
                                                           else
                                                                trunc(sysdate)-1
                                                      end                                 to_dte
                                                  from dict
                                                 where rownum <= 12


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                               )
                                          where end_dte between  from_dte and to_dte


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                        )
                         and dtl_typ = 'M01'
                         and patsite = 'I'
                         and wk_key  = '1'
--                         and wd_no not in ('ER99','OR99','OGOB','NB')
                         and (chunspcrsv_cnt != 0 or jespcrcp_cnt != 0  or jeunspcrcp_cnt != 0)
                         and case when in_patsite = '1' then '1'
                                  when in_patsite = '2' then '2'
                                  else '3'
                             end
                                 =
                                   case when in_patsite = '1' then '1'
                                        when in_patsite = '2' then 'X'
                                        else '3'
                                   end

/* 3번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                     )
               group by
                        rollup(
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


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


              )
              ,
              (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

               select sum(total_cnt) total_cnt
                 from
                     (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      select
                             nvl(sum(rsv_cnt+today_cnt),0) total_cnt
                        from apstatmt2
                            ,
                            (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                             select
                                    to_date(in_fromyymm||'01','yyyymmdd') star_dte
                                   ,case when last_day(to_date(in_toyymm||'01','yyyymmdd')) < trunc(sysdate) -1 then
                                              last_day(to_date(in_toyymm||'01','yyyymmdd'))
                                         else
                                              trunc(sysdate) -1
                                    end     end_dte
                               from dual


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                            )
                       where med_dte between star_dte and end_dte
                         and dtl_typ = '06'
                         and patsite in ('O','E')
                         and case when in_patsite = '1' then '1'
                                  when in_patsite = '2' then '2'
                                  else '3'
                             end
                                 =
                                   case when in_patsite = '1' then 'X'
                                        when in_patsite = '2' then '2'
                                        else '3'
                                   end


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      union all


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      select
                             sum(jespcrsv_cnt) total_cnt
                        from apstatmt2
                       where med_dte in
                                        (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                         select  end_dte
                                           from
                                               (



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                                select
                                                       distinct
                                                       case when last_day(to_date(substr(in_fromyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd')) <= trunc(sysdate) -1  then
                                                                 last_day(to_date(substr(in_fromyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd'))
                                                            else
                                                                 trunc(sysdate) -1
                                                       end     end_dte
                                                      ,row_number() over(partition by rownum order by rownum) rank
                                                      ,case when last_day(to_date(in_fromyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                 last_day(to_date(in_fromyymm||'01','yyyymmdd'))
                                                            else
                                                                 trunc(sysdate)-1
                                                       end                                from_dte
                                                     ,case when last_day(to_date(in_toyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                                last_day(to_date(in_toyymm||'01','yyyymmdd'))
                                                           else
                                                                trunc(sysdate)-1
                                                      end                                 to_dte
                                                  from dict
                                                 where rownum < 12



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                               )
                                          where end_dte between  from_dte and to_dte



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                                        )
                         and dtl_typ = 'M01'
                         and patsite = 'I'
                         and wk_key  = '1'
--                         and wd_no not in ('ER99','OR99','OGOB','NB')
                         and (chunspcrsv_cnt != 0 or jespcrcp_cnt != 0  or jeunspcrcp_cnt != 0)
                         and case when in_patsite = '1' then '1'
                                  when in_patsite = '2' then '2'
                                  else '3'
                             end
                                 =
                                   case when in_patsite = '1' then '1'
                                        when in_patsite = '2' then 'X'
                                        else '3'
                                   end


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                     )



/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

              )
              ,
              (

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

               select
                      star_dte
                     ,end_dte
                     ,case when in_patsite = '1'  then
                                ft_cnt_opday(star_dte,end_dte,'1')
                           when in_patsite = '2'  then
                                ft_cnt_opday(star_dte,end_dte,'3')
                           else
                                (ft_cnt_opday(star_dte,end_dte,'1')+ft_cnt_opday(star_dte,end_dte,'3')) / 2
                      end    day_cnt
                 from
                     (


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                      select
                             to_date(in_fromyymm||'01','yyyymmdd') star_dte
                            ,case when last_day(to_date(in_toyymm||'01','yyyymmdd')) < trunc(sysdate) -1 then
                                       last_day(to_date(in_toyymm||'01','yyyymmdd'))
                                  else
                                       trunc(sysdate) -1
                             end     end_dte
                        from dual


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                     )


/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

              )




         order by
                  to_number(group_ing)
                 ,med_dept
                ;

                out_cursor := wk_cursor;

                exception
                        when others then
                                raise_application_error(-20500,'pc_sel_pts02_income009 오류!' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);

        end pc_sel_pts02_income009;
