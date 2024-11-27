/***********************************************************************************
    *    서비스이름      : pc_sel_pts02_income916
    *    최초 작성일     : 2010-03-05
    *    최초 작성자     :
    *    Description     : 진료과별 일자별 외래/입원 환자현황
    *    Input Parameter :
    *    페이지ID        : /MIS/PTS/PTS/PTS/READCLCDAYOIPTRPT.ASPX
    ***********************************************************************************/
    procedure pc_sel_pts02_income916 (
            in_fromyymm      in   varchar2
        ,   in_io_gubun      in   varchar2      --      '1' 입원 ,'2' 외래   ,'3' 전체
        ,   out_cursor1      out  returncursor
        ,   out_cursor2      out  returncursor
        )
        is
        wk_cursor1 returncursor;
        wk_cursor2 returncursor;
    begin
        /*
            --M20210312 sjkang, 조회로직 수정
            전체 진료과가 출력 안되는 문제가 있어 기획과(이송미) 요청으로 수정한다.
            
            1) 현재는 진료과 추가의 경우 화면수정이 필요하기 때문에
               가로열과 세로열 헤더 출력을 바꿈
               가로 : 날짜(최대 31일), 세로 : 진료과명
            2) 기존 진료과 코드가 아닌 명칭으로 변경
               진료과 gropy by 조건은 진료과별 환자종류별 입원/외래환자수 와 동일하게 맞춤
               pkg_mis_pts_pts_pts02.pc_sel_pts02_income009
            
            exec    xgpts.pkg_mis_pts_pts_pts02.pc_sel_pts02_income916('201902', '1', :var_out1, :var_out2);
        */
        --  data
        open wk_cursor1 for
        
        
        
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/        
        select  (
                    select  x.dept_nm
                      from  ccdepart    x
                     where  x.dept_cd   =   a.med_dept
                )                   as  "진료과명"
             ,  sum(
                nvl(a.d01, 0) + nvl(a.d02, 0) + nvl(a.d03, 0) + nvl(a.d04, 0) + nvl(a.d05, 0)
             +  nvl(a.d06, 0) + nvl(a.d07, 0) + nvl(a.d08, 0) + nvl(a.d09, 0) + nvl(a.d10, 0)
             +  nvl(a.d11, 0) + nvl(a.d12, 0) + nvl(a.d13, 0) + nvl(a.d14, 0) + nvl(a.d15, 0)
             +  nvl(a.d16, 0) + nvl(a.d17, 0) + nvl(a.d18, 0) + nvl(a.d19, 0) + nvl(a.d20, 0)
             +  nvl(a.d21, 0) + nvl(a.d22, 0) + nvl(a.d23, 0) + nvl(a.d24, 0) + nvl(a.d25, 0)
             +  nvl(a.d26, 0) + nvl(a.d27, 0) + nvl(a.d28, 0) + nvl(a.d29, 0) + nvl(a.d30, 0)           
             +  nvl(a.d31, 0))      as  "진료과계"
             
             ,  sum(nvl(a.d01, 0))  as  "01 일"
             ,  sum(nvl(a.d02, 0))  as  "02 일"
             ,  sum(nvl(a.d03, 0))  as  "03 일"
             ,  sum(nvl(a.d04, 0))  as  "04 일"
             ,  sum(nvl(a.d05, 0))  as  "05 일"
             ,  sum(nvl(a.d06, 0))  as  "06 일"
             ,  sum(nvl(a.d07, 0))  as  "07 일"
             ,  sum(nvl(a.d08, 0))  as  "08 일"
             ,  sum(nvl(a.d09, 0))  as  "09 일"
             ,  sum(nvl(a.d10, 0))  as  "10 일"
             ,  sum(nvl(a.d11, 0))  as  "11 일"
             ,  sum(nvl(a.d12, 0))  as  "12 일"
             ,  sum(nvl(a.d13, 0))  as  "13 일"
             ,  sum(nvl(a.d14, 0))  as  "14 일"
             ,  sum(nvl(a.d15, 0))  as  "15 일"
             ,  sum(nvl(a.d16, 0))  as  "16 일"
             ,  sum(nvl(a.d17, 0))  as  "17 일"
             ,  sum(nvl(a.d18, 0))  as  "18 일"
             ,  sum(nvl(a.d19, 0))  as  "19 일"
             ,  sum(nvl(a.d20, 0))  as  "20 일"
             ,  sum(nvl(a.d21, 0))  as  "21 일"
             ,  sum(nvl(a.d22, 0))  as  "22 일"
             ,  sum(nvl(a.d23, 0))  as  "23 일"
             ,  sum(nvl(a.d24, 0))  as  "24 일"
             ,  sum(nvl(a.d25, 0))  as  "25 일"
             ,  sum(nvl(a.d26, 0))  as  "26 일"
             ,  sum(nvl(a.d27, 0))  as  "27 일"
             ,  sum(nvl(a.d28, 0))  as  "28 일"
             ,  sum(nvl(a.d29, 0))  as  "29 일"
             ,  sum(nvl(a.d30, 0))  as  "30 일"
             ,  sum(nvl(a.d31, 0))  as  "31 일"
          from  (     
          
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/          
                    select  a.med_dept
                         ,  nvl(a.d01, 0) + nvl(a.d02, 0) + nvl(a.d03, 0) + nvl(a.d04, 0) + nvl(a.d05, 0)
                         +  nvl(a.d06, 0) + nvl(a.d07, 0) + nvl(a.d08, 0) + nvl(a.d09, 0) + nvl(a.d10, 0)
                         +  nvl(a.d11, 0) + nvl(a.d12, 0) + nvl(a.d13, 0) + nvl(a.d14, 0) + nvl(a.d15, 0)
                         +  nvl(a.d16, 0) + nvl(a.d17, 0) + nvl(a.d18, 0) + nvl(a.d19, 0) + nvl(a.d20, 0)
                         +  nvl(a.d21, 0) + nvl(a.d22, 0) + nvl(a.d23, 0) + nvl(a.d24, 0) + nvl(a.d25, 0)
                         +  nvl(a.d26, 0) + nvl(a.d27, 0) + nvl(a.d28, 0) + nvl(a.d29, 0) + nvl(a.d30, 0)
                         +  nvl(a.d31, 0)   dept_sum
                         ,  nvl(a.d01, 0)   d01
                         ,  nvl(a.d02, 0)   d02
                         ,  nvl(a.d03, 0)   d03
                         ,  nvl(a.d04, 0)   d04
                         ,  nvl(a.d05, 0)   d05
                         ,  nvl(a.d06, 0)   d06
                         ,  nvl(a.d07, 0)   d07
                         ,  nvl(a.d08, 0)   d08
                         ,  nvl(a.d09, 0)   d09
                         ,  nvl(a.d10, 0)   d10
                         ,  nvl(a.d11, 0)   d11
                         ,  nvl(a.d12, 0)   d12
                         ,  nvl(a.d13, 0)   d13
                         ,  nvl(a.d14, 0)   d14
                         ,  nvl(a.d15, 0)   d15
                         ,  nvl(a.d16, 0)   d16
                         ,  nvl(a.d17, 0)   d17
                         ,  nvl(a.d18, 0)   d18
                         ,  nvl(a.d19, 0)   d19
                         ,  nvl(a.d20, 0)   d20
                         ,  nvl(a.d21, 0)   d21
                         ,  nvl(a.d22, 0)   d22
                         ,  nvl(a.d23, 0)   d23
                         ,  nvl(a.d24, 0)   d24
                         ,  nvl(a.d25, 0)   d25
                         ,  nvl(a.d26, 0)   d26
                         ,  nvl(a.d27, 0)   d27
                         ,  nvl(a.d28, 0)   d28
                         ,  nvl(a.d29, 0)   d29
                         ,  nvl(a.d30, 0)   d30
                         ,  nvl(a.d31, 0)   d31
                      from  (    
                      
                      
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                      
                                select  *
                                  from  (     
                                  
                                  
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                  
                                            --01. 외래
                                            select  to_char(y.med_dte, 'dd')        day_cls
                                                 ,  case
                                                        when y.med_dept in ('HPC1','HPC11') then 'HPC'
                                                        when y.med_dept = 'BCGS'            then 'GS'
                                                        when y.med_dept = 'BCOL'            then 'OL'
                                                        when y.med_dept = 'BCPS'            then 'PS'
                                                        when y.med_dept = 'BCDR'            then 'DR'
                                                        when y.med_dept = 'CVGS'            then 'GS'
                                                        when y.med_dept = 'CVIMC'           then 'IMC'
                                                        when y.med_dept = 'CVTS'            then 'TS'
                                                        when y.med_dept = 'DEIME'           then 'IME'
                                                        when y.med_dept = 'OGO2'            then 'OG'
                                                        when y.med_dept = 'RCIMR'           then 'IMR'
                                                        when y.med_dept = 'RCNP'            then 'NP'
                                                        when y.med_dept = 'RCTS'            then 'TS'
                                                        when y.med_dept = 'THDR'            then 'DR'
                                                        when y.med_dept = 'THGS'            then 'GS'
                                                        when y.med_dept = 'THIME'           then 'IME'
                                                        when y.med_dept = 'THNM'            then 'NM'
                                                        when y.med_dept = 'THOL'            then 'OL'
                                                        when y.med_dept = 'ONP'             then 'NP'
                                                        else y.med_dept
                                                    end                             med_dept
                                                 ,  sum(y.rsv_cnt + y.today_cnt)    tcnt
                                              from  apstatmt2   y
                                             where  y.med_dte   between to_date(in_fromyymm||'01','yyyymmdd')
                                                                    and case
                                                                            when last_day(to_date(in_fromyymm||'01','yyyymmdd')) < trunc(sysdate) - 1
                                                                            then last_day(to_date(in_fromyymm||'01','yyyymmdd'))
                                                                            else trunc(sysdate) - 1
                                                                        end
                                               and  y.dtl_typ   =   '06'
                                               and  y.patsite   in  ('O', 'E')
                                               and  case
                                                        when in_io_gubun = '1' then '1'
                                                        when in_io_gubun = '2' then '2'
                                                        else '3'
                                                    end         =   case
                                                                        when in_io_gubun = '1' then 'X'
                                                                        when in_io_gubun = '2' then '2'
                                                                        else '3'
                                                                    end
                                             group  by
                                                    to_char(y.med_dte, 'dd')
                                                 ,  case
                                                        when y.med_dept in ('HPC1','HPC11') then 'HPC'
                                                        when y.med_dept = 'BCGS'            then 'GS'
                                                        when y.med_dept = 'BCOL'            then 'OL'
                                                        when y.med_dept = 'BCPS'            then 'PS'
                                                        when y.med_dept = 'BCDR'            then 'DR'
                                                        when y.med_dept = 'CVGS'            then 'GS'
                                                        when y.med_dept = 'CVIMC'           then 'IMC'
                                                        when y.med_dept = 'CVTS'            then 'TS'
                                                        when y.med_dept = 'DEIME'           then 'IME'
                                                        when y.med_dept = 'OGO2'            then 'OG'
                                                        when y.med_dept = 'RCIMR'           then 'IMR'
                                                        when y.med_dept = 'RCNP'            then 'NP'
                                                        when y.med_dept = 'RCTS'            then 'TS'
                                                        when y.med_dept = 'THDR'            then 'DR'
                                                        when y.med_dept = 'THGS'            then 'GS'
                                                        when y.med_dept = 'THIME'           then 'IME'
                                                        when y.med_dept = 'THNM'            then 'NM'
                                                        when y.med_dept = 'THOL'            then 'OL'
                                                        when y.med_dept = 'ONP'             then 'NP'
                                                        else y.med_dept
                                                    end    
                                                    
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                                    
                                                    
                                            --02. 입원
                                             union  all   
                                             
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                             
                                             
                                            select  to_char(y.med_dte, 'dd')        day_cls
                                                 ,  y.med_dept
                                                 ,  sum(y.tcnt)                     tcnt
                                              from  (
                                                        select  y.med_dte
                                                             ,  case
                                                                    when y.med_dept in ('HPC1','HPC11') then 'HPC'
                                                                    when y.med_dept = 'BCGS'            then 'GS'
                                                                    when y.med_dept = 'BCOL'            then 'OL'
                                                                    when y.med_dept = 'BCPS'            then 'PS'
                                                                    when y.med_dept = 'BCDR'            then 'DR'
                                                                    when y.med_dept = 'CVGS'            then 'GS'
                                                                    when y.med_dept = 'CVIMC'           then 'IMC'
                                                                    when y.med_dept = 'CVTS'            then 'TS'
                                                                    when y.med_dept = 'DEIME'           then 'IME'
                                                                    when y.med_dept = 'OGO2'            then 'OG'
                                                                    when y.med_dept = 'RCIMR'           then 'IMR'
                                                                    when y.med_dept = 'RCNP'            then 'NP'
                                                                    when y.med_dept = 'RCTS'            then 'TS'
                                                                    when y.med_dept = 'THDR'            then 'DR'
                                                                    when y.med_dept = 'THGS'            then 'GS'
                                                                    when y.med_dept = 'THIME'           then 'IME'
                                                                    when y.med_dept = 'THNM'            then 'NM'
                                                                    when y.med_dept = 'THOL'            then 'OL'
                                                                    when y.med_dept = 'ONP'             then 'NP'
                                                                    else y.med_dept
                                                                end                             med_dept
                                                             ,  y.jespcrsv_cnt                  tcnt
                                                          from  apstatmt2   y
                                                         where  y.med_dte   between to_date(in_fromyymm||'01','yyyymmdd')
                                                                                and case
                                                                                        when last_day(to_date(in_fromyymm||'01','yyyymmdd')) < trunc(sysdate) - 1
                                                                                        then last_day(to_date(in_fromyymm||'01','yyyymmdd'))
                                                                                        else trunc(sysdate) - 1
                                                                                    end
                                                           and  y.dtl_typ   =   'M01'
                                                           and  y.patsite   =   'I'
                                                           and  y.wk_key    =   '1' 
                                                           
                                                           
                                                           
                                                     
                                                         union  all



                                                        select  y.med_dte + 1                   med_dte
                                                             ,  case
                                                                    when y.med_dept in ('HPC1','HPC11') then 'HPC'
                                                                    when y.med_dept = 'BCGS'            then 'GS'
                                                                    when y.med_dept = 'BCOL'            then 'OL'
                                                                    when y.med_dept = 'BCPS'            then 'PS'
                                                                    when y.med_dept = 'BCDR'            then 'DR'
                                                                    when y.med_dept = 'CVGS'            then 'GS'
                                                                    when y.med_dept = 'CVIMC'           then 'IMC'
                                                                    when y.med_dept = 'CVTS'            then 'TS'
                                                                    when y.med_dept = 'DEIME'           then 'IME'
                                                                    when y.med_dept = 'OGO2'            then 'OG'
                                                                    when y.med_dept = 'RCIMR'           then 'IMR'
                                                                    when y.med_dept = 'RCNP'            then 'NP'
                                                                    when y.med_dept = 'RCTS'            then 'TS'
                                                                    when y.med_dept = 'THDR'            then 'DR'
                                                                    when y.med_dept = 'THGS'            then 'GS'
                                                                    when y.med_dept = 'THIME'           then 'IME'
                                                                    when y.med_dept = 'THNM'            then 'NM'
                                                                    when y.med_dept = 'THOL'            then 'OL'
                                                                    when y.med_dept = 'ONP'             then 'NP'
                                                                    else y.med_dept
                                                                end                             med_dept
                                                             ,  y.jespcrsv_cnt * -1             tcnt
                                                          from  apstatmt2   y
                                                         where  y.med_dte   between to_date(in_fromyymm||'01','yyyymmdd')
                                                                                and case
                                                                                        when last_day(to_date(in_fromyymm||'01','yyyymmdd')) < trunc(sysdate) - 1
                                                                                        then last_day(to_date(in_fromyymm||'01','yyyymmdd')) - 1
                                                                                        else trunc(sysdate) - 2
                                                                                    end
                                                           and  y.dtl_typ   =   'M01'
                                                           and  y.patsite   =   'I'
                                                           and  y.wk_key    =   '1'   
                                                           
                                                           
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                                           
                                                    )   y
                                             where  case
                                                        when in_io_gubun = '1' then '1'
                                                        when in_io_gubun = '2' then '2'
                                                        else '3'
                                                    end         =   case
                                                                        when in_io_gubun = '1' then '1'
                                                                        when in_io_gubun = '2' then 'X'
                                                                        else '3'
                                                                    end

                                             group  by
                                                    to_char(y.med_dte, 'dd')
                                                 ,  y.med_dept

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


                                        )
                                 pivot  (
                                            sum(tcnt) for day_cls
                                                   in  ( '01' as "D01",'02' as "D02",'03' as "D03",'04' as "D04",'05' as "D05"
                                                        ,'06' as "D06",'07' as "D07",'08' as "D08",'09' as "D09",'10' as "D10"
                                                        ,'11' as "D11",'12' as "D12",'13' as "D13",'14' as "D14",'15' as "D15"
                                                        ,'16' as "D16",'17' as "D17",'18' as "D18",'19' as "D19",'20' as "D20"
                                                        ,'21' as "D21",'22' as "D22",'23' as "D23",'24' as "D24",'25' as "D25"
                                                        ,'26' as "D26",'27' as "D27",'28' as "D28",'29' as "D29",'30' as "D30"
                                                        ,'31' as "D31",'32' as "P01"
                                                       )
                                        )
                                        
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                                        
                                        
                                        
                            )   a

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

                )   a
         group  by
                rollup((a.med_dept))
         order  by
                a.med_dept 
                
                
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                
 
        open wk_cursor2 for  
        
        
        
        
        
        
        select  '진료과'    dept_hd
             ,  '계'        dept_sum
             ,  a.*
          from  (  
          
          
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/          
                    select  *
                      from  ( 
                      

/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
                                select  to_char(x.dte, 'dd')    day_cls
                                     ,  to_char(x.dte, 'dd') || ' 일'   col_hd
                                  from  ccdatemt    x
                                 where  x.dte       between to_date(in_fromyymm||'01','yyyymmdd')
                                                        and case
                                                                when last_day(to_date(in_fromyymm||'01','yyyymmdd')) < trunc(sysdate) - 1
                                                                then last_day(to_date(in_fromyymm||'01','yyyymmdd'))
                                                                else trunc(sysdate) - 1
                                                            end
                            )
                     pivot  (
                                max(col_hd) as col_hd
                                            for day_cls
                                            in  ('01' as "D01",'02' as "D02",'03' as "D03",'04' as "D04",'05' as "D05"
                                                ,'06' as "D06",'07' as "D07",'08' as "D08",'09' as "D09",'10' as "D10"
                                                ,'11' as "D11",'12' as "D12",'13' as "D13",'14' as "D14",'15' as "D15"
                                                ,'16' as "D16",'17' as "D17",'18' as "D18",'19' as "D19",'20' as "D20"
                                                ,'21' as "D21",'22' as "D22",'23' as "D23",'24' as "D24",'25' as "D25"
                                                ,'26' as "D26",'27' as "D27",'28' as "D28",'29' as "D29",'30' as "D30"
                                                ,'31' as "D31",'32' as "P01"
                                               )
                            )
                )   a
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/                       

                out_cursor1 := wk_cursor1;
                out_cursor2 := wk_cursor2;

                exception
                        when others then
                                raise_application_error(-20500,'pc_sel_pts02_income916 오류!' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);
        end pc_sel_pts02_income916;