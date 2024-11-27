
exec :in_fromyymm :='';
exec :in_toyymm :='';
exec :in_sujinflag :='';
exec :in_look :='3';

SELECT T.MED_DEPT   "진료과"
       ,T.cnt_all      "합계"
       ,T.cnt_all_m      "소계(남)"
       ,T.cnt_all_f      "소계(여)"
       ,T.cnt_0_14      "14세이하(계)"
       ,T.cnt_0_14_m      "14세이하(남)"
       ,T.cnt_0_14_F      "14세이하(여)"
       ,T.cnt_15_19      "15세~19세(계)"
       ,T.cnt_15_19_m      "15세~19세(남)"
       ,T.cnt_15_19_F      "15세~19세(여)"
       ,T.cnt_20_29      "20세~29세(계)"
       ,T.cnt_20_29_M      "20세~29세(남)"
       ,T.cnt_20_29_F      "20세~29세(여)"
       ,T.cnt_30_39      "30세~39세(계)"
       ,T.cnt_30_39_m      "30세~39세(남)"
       ,T.cnt_30_39_f      "30세~39세(여)"
       ,T.cnt_40_49      "40세~49세(계)"
       ,T.cnt_40_49_M      "40세~49세(남)"
       ,T.cnt_40_49_F      "40세~49세(여)"
        ,T.cnt_50_59      "50세~59세(계)"
        ,T.cnt_50_59_m      "50세~59세(남)"
        ,T.cnt_50_59_f      "50세~59세(여)"
        ,T.cnt_60_64      "60세~64세(계)"
         ,T.cnt_60_64_M      "60세~64세(남)"
          ,T.cnt_60_64_f      "60세~64세(여)"
         ,T.cnt_65_hi      "65세이상(계)"
         ,T.cnt_65_hi_M      "65세이상(남)"
         ,T.cnt_65_hi_f      "65세이상(여)"
FROM (select
               case when grouping(med_dept) = 0 then
                         (select
--                                 case when instr(dept_nm,'(') > 0 then
--                                           substr(dept_nm,1,instr(dept_nm,'(')-1)
--                                      else
                                           dept_nm
--                                 end
                            from PDEDBMSM
                           where dept_cd = med_dept)
                    else
                         '합계'
               end    med_dept
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_all     else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_all     end
                        else cnt_all
                   end
                  )   cnt_all
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_all_m   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_all_m   end
                        else cnt_all_m
                   end
                  )   cnt_all_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_all_f   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_all_f   end
                        else cnt_all_f
                   end
                  )   cnt_all_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_0_14    else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_0_14    end
                        else cnt_0_14
                   end
                  )   cnt_0_14
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_0_14_m  else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_0_14_m  end
                        else cnt_0_14_m
                   end
                  )   cnt_0_14_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_0_14_f  else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_0_14_f  end
                        else cnt_0_14_f
                   end
                  )   cnt_0_14_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_15_19   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_15_19   end
                        else cnt_15_19
                   end
                  )   cnt_15_19
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_15_19_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_15_19_m end
                        else cnt_15_19_m
                   end
                  )   cnt_15_19_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_15_19_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_15_19_f end
                        else cnt_15_19_f
                   end
                  )   cnt_15_19_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_20_29   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_20_29   end
                        else cnt_20_29
                   end
                  )   cnt_20_29
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_20_29_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_20_29_m end
                        else cnt_20_29_m
                   end
                  )   cnt_20_29_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_20_29_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_20_29_f end
                        else cnt_20_29_f
                   end
                  )   cnt_20_29_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_30_39   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_30_39   end
                        else cnt_30_39
                   end
                  )   cnt_30_39
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_30_39_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_30_39_m end
                        else cnt_30_39_m
                   end
                  )   cnt_30_39_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_30_39_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_30_39_f end
                        else cnt_30_39_f
                   end
                  )   cnt_30_39_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_40_49   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_40_49   end
                        else cnt_40_49
                   end
                  )   cnt_40_49
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_40_49_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_40_49_m end
                        else cnt_40_49_m
                   end
                  )   cnt_40_49_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_40_49_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_40_49_f end
                        else cnt_40_49_f
                   end
                  )   cnt_40_49_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_50_59   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_50_59   end
                        else cnt_50_59
                   end
                  )   cnt_50_59
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_50_59_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_50_59_m end
                        else cnt_50_59_m
                   end
                  )   cnt_50_59_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_50_59_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_50_59_f end
                        else cnt_50_59_f
                   end
                  )   cnt_50_59_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_60_64   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_60_64   end
                        else cnt_60_64
                   end
                  )   cnt_60_64
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_60_64_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_60_64_m end
                        else cnt_60_64_m
                   end
                  )   cnt_60_64_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_60_64_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_60_64_f end
                        else cnt_60_64_f
                   end
                  )   cnt_60_64_f
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_65_hi   else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_65_hi   end
                        else cnt_65_hi
                   end
                  )   cnt_65_hi
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_65_hi_m else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_65_hi_m end
                        else cnt_65_hi_m
                   end
                  )   cnt_65_hi_m
              ,sum(
                   case :in_sujinflag
                        when '1' then case when med_yn = 'Y' then cnt_65_hi_f else 0           end
                        when '2' then case when med_yn = 'Y' then 0           else cnt_65_hi_f end
                        else cnt_65_hi_f
                   end
                  )   cnt_65_hi_f
          from
              (
               select
--                      case when med_dept = 'BCGS' then
--                                'GS'
--                           when med_dept in ('HPC1','HPC11') then
--                                'HPC'
--                           else
--                                med_dept
--                      end                                                                                                         med_dept
                      med_dept
--                     ,wk_key                                                                                                      sex
                     ,sum(shunspcmed_cnt                                                                                        ) cnt_all
                     ,sum(case when wk_key in ('M','X') then shunspcmed_cnt else 0 end                                          ) cnt_all_m
                     ,sum(case when wk_key in ('F')     then shunspcmed_cnt else 0 end                                          ) cnt_all_f
                     ,sum(shspcmed_cnt+chspcrsv_cnt+chunspcrsv_cnt+jespcrsv_cnt                                                 ) cnt_0_14
                     ,sum(case when wk_key in ('M','X') then shspcmed_cnt+chspcrsv_cnt+chunspcrsv_cnt+jespcrsv_cnt else 0  end  ) cnt_0_14_m
                     ,sum(case when wk_key in ('F')     then shspcmed_cnt+chspcrsv_cnt+chunspcrsv_cnt+jespcrsv_cnt else 0  end  ) cnt_0_14_f
                     ,sum(jeunspcrsv_cnt                                                                                        ) cnt_15_19
                     ,sum(case when wk_key in ('M','X') then jeunspcrsv_cnt else 0 end                                          ) cnt_15_19_m
                     ,sum(case when wk_key in ('F')     then jeunspcrsv_cnt else 0 end                                          ) cnt_15_19_f
                     ,sum(shrsv_cnt+shunspcrsv_cnt                                                                              ) cnt_20_29
                     ,sum(case when wk_key in ('M','X') then shrsv_cnt+shunspcrsv_cnt else 0 end                                ) cnt_20_29_m
                     ,sum(case when wk_key in ('F')     then shrsv_cnt+shunspcrsv_cnt else 0 end                                ) cnt_20_29_f
                     ,sum(chspcrcp_cnt+chunspcrcp_cnt                                                                           ) cnt_30_39
                     ,sum(case when wk_key in ('M','X') then chspcrcp_cnt+chunspcrcp_cnt else 0 end                             ) cnt_30_39_m
                     ,sum(case when wk_key in ('F')     then chspcrcp_cnt+chunspcrcp_cnt else 0 end                             ) cnt_30_39_f
                     ,sum(jespcrcp_cnt+jeunspcrcp_cnt                                                                           ) cnt_40_49
                     ,sum(case when wk_key in ('M','X') then jespcrcp_cnt+jeunspcrcp_cnt else 0 end                             ) cnt_40_49_m
                     ,sum(case when wk_key in ('F')     then jespcrcp_cnt+jeunspcrcp_cnt else 0 end                             ) cnt_40_49_f
                     ,sum(shspcrcp_cnt+shunspcrcp_cnt                                                                           ) cnt_50_59
                     ,sum(case when wk_key in ('M','X') then shspcrcp_cnt+shunspcrcp_cnt else 0 end                             ) cnt_50_59_m
                     ,sum(case when wk_key in ('F')     then shspcrcp_cnt+shunspcrcp_cnt else 0 end                             ) cnt_50_59_f
                     ,sum(medchspc_cnt                                                                                          ) cnt_60_64
                     ,sum(case when wk_key in ('M','X') then medchspc_cnt else 0 end                                            ) cnt_60_64_m
                     ,sum(case when wk_key in ('F')     then medchspc_cnt else 0 end                                            ) cnt_60_64_f
                     ,sum(chunspcmed_cnt+jespcmed_cnt+jeunspcmed_cnt                                                            ) cnt_65_hi
                     ,sum(case when wk_key in ('M','X') then chunspcmed_cnt+jespcmed_cnt+jeunspcmed_cnt else 0 end              ) cnt_65_hi_m
                     ,sum(case when wk_key in ('F')     then chunspcmed_cnt+jespcmed_cnt+jeunspcmed_cnt else 0 end              ) cnt_65_hi_f
                     ,age_typ                                                                                                     med_yn
                 from apstatmt2
                     ,
                     (
                      select
                             to_date(:in_fromyymm||'01','yyyymmdd') star_dte
                            ,case when last_day(to_date(:in_toyymm||'01','yyyymmdd')) < trunc(sysdate) -1 then
                                       last_day(to_date(:in_toyymm||'01','yyyymmdd'))
                                  else
                                       trunc(sysdate) -1
                             end     end_dte
                        from dual
                     )
                where med_dte between star_dte and end_dte
                  and dtl_typ = '04'    -- 2010.05.20  dtl_typ 03 ==> 04 로 변경
                  and patsite in ('O','E')
                  and case when :in_look = '1' then '1'
                           when :in_look = '2' then '2'
                           else '3'
                      end
                          =
                            case when :in_look = '1' then 'X'
                                 when :in_look = '2' then '2'
                                 else '3'
                            end
               group by
--                        case when med_dept = 'BCGS' then
--                                  'GS'
--                             when med_dept in ('HPC1','HPC11') then
--                                  'HPC'
--                             else
--                                  med_dept
--                        end
                        med_dept
                       ,age_typ
               union all
               select
--                      case when med_dept = 'BCGS' then
--                                'GS'
--                           when med_dept in ('HPC1','HPC11') then
--                                'HPC'
--                           else
--                                med_dept
--                      end                                                                                  med_dept
                      med_dept
--                     ,patsite                                                                              sex
                     ,sum(jespcrsv_cnt                                                                   ) cnt_all
                     ,sum(case when patsite in ('M','X') then jespcrsv_cnt else 0 end                    ) cnt_all_m
                     ,sum(case when patsite in ('F')     then jespcrsv_cnt else 0 end                    ) cnt_all_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) <= 2 then jespcrsv_cnt else 0 end       ) cnt_0_14
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) <= 2 then jespcrsv_cnt else 0 end
                               else
                                    0
                          end
                         )                                                                                 cnt_0_14_m
                     ,sum(
                          case when patsite in ('F')     then
                                    case when trunc(to_number(age_typ)/ 5) <= 2 then jespcrsv_cnt else 0 end
                               else
                                    0
                          end
                         )                                                                                cnt_0_14_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) = 3 then jespcrsv_cnt else 0 end)        cnt_15_19
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) = 3 then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_15_19_m
                     ,sum(
                          case when patsite in ('F')     then
                                    case when trunc(to_number(age_typ)/ 5) = 3 then jespcrsv_cnt else 0 end
                               else
                                    0
                          end
                         )                                                                                cnt_15_19_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) in (4,5) then jespcrsv_cnt else 0 end)   cnt_20_29
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) in (4,5) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_20_29_m
                     ,sum(
                          case when patsite in ('F') then
                                    case when trunc(to_number(age_typ)/ 5) in (4,5) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_20_29_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) in (6,7) then jespcrsv_cnt else 0 end)   cnt_30_39
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) in (6,7) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_30_39_m
                     ,sum(
                          case when patsite in ('F') then
                                    case when trunc(to_number(age_typ)/ 5) in (6,7) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_30_39_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) in (8,9) then jespcrsv_cnt else 0 end)   cnt_40_49
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) in (8,9) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_40_49_m
                     ,sum(
                          case when patsite in ('F') then
                                    case when trunc(to_number(age_typ)/ 5) in (8,9) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_40_49_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) in (10,11) then jespcrsv_cnt else 0 end) cnt_50_59
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) in (10,11) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_50_59_m
                     ,sum(
                          case when patsite in ('F') then
                                    case when trunc(to_number(age_typ)/ 5) in (10,11) then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_50_59_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) = 12 then jespcrsv_cnt else 0 end      ) cnt_60_64
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) = 12 then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_60_64_m
                     ,sum(
                          case when patsite in ('F') then
                                    case when trunc(to_number(age_typ)/ 5) = 12 then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_60_64_f
                     ,sum(case when trunc(to_number(age_typ)/ 5) >= 13 then jespcrsv_cnt else 0 end     ) cnt_65_hi
                     ,sum(
                          case when patsite in ('M','X') then
                                    case when trunc(to_number(age_typ)/ 5) >= 13 then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_65_hi_m
                     ,sum(
                          case when patsite in ('F') then
                                    case when trunc(to_number(age_typ)/ 5) >= 13 then jespcrsv_cnt else 0 end
                               else 0
                          end
                         )                                                                                cnt_65_hi_f
                     ,'Y'                                                                                 med_yn
                 from apstatmt2
                where med_dte in
                                 (
                                  select  end_dte
                                    from
                                        (
                                         select
                                                distinct
                                                case when last_day(to_date(substr(:in_fromyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd')) <= trunc(sysdate) -1  then
                                                          last_day(to_date(substr(:in_fromyymm,1,4)||lpad(rownum,2,'0')||'01','yyyymmdd'))
                                                     else
                                                          trunc(sysdate) -1
                                                end     end_dte
                                               ,row_number() over(partition by rownum order by rownum) rank
                                               ,case when last_day(to_date(:in_fromyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                          last_day(to_date(:in_fromyymm||'01','yyyymmdd'))
                                                     else
                                                          trunc(sysdate)-1
                                                end                                from_dte
                                              ,case when last_day(to_date(:in_toyymm||'01','yyyymmdd')) < trunc(sysdate)-1  then
                                                         last_day(to_date(:in_toyymm||'01','yyyymmdd'))
                                                    else
                                                         trunc(sysdate)-1
                                               end                                 to_dte
                                           from dict
                                          where rownum <= 12
                                        )
                                   where end_dte between  from_dte and to_dte
                                 )
                  and dtl_typ = 'M02'
                  and wd_no not in ('*') --'OR99','OGOB','ER99','NB',
                  and case when :in_look = '1' then '1'
                           when :in_look = '2' then '2'
                           else '3'
                      end
                          =
                            case when :in_look = '1' then '1'
                                 when :in_look = '2' then 'X'
                                 else '3'
                            end
               group by
                        med_dept
                       ,trunc(to_number(age_typ)/ 5)
              )
         group by
                  rollup(med_dept)  )T

