 /***********************************************************************************
        *    서비스이름      : pc_sel_pts02_income035
        *    최초 작성일     : 2010.12.06
        *    최초 작성자     : 이강준
        *    Description     : 지역별 입원환자수
        *    Input Parameter :
        *                      1.in_fyyyymm =>시작일자
        *                      2.in_tyyyymm =>종료일자
        *                      3.in_look    =>열람구분 '1':연보  '2':월보
        *                      4.in_gubun   =>구    분 '1':실입원  '2':연인원     2011.01월 추가함
        *    페이지ID        :
        ***********************************************************************************/

        procedure pc_sel_pts02_income035( in_fyyyymm	 in	varchar2
                                         ,in_tyyyymm	 in varchar2
        								 ,in_look        in varchar2
        								 ,in_gubun		 in varchar2
         		                         ,out_cursor	 out returncursor )
        is
            wk_cursor returncursor;
        begin
			if in_gubun = '1' then
				BEGIN
		            open wk_cursor for        ;;
		            
		            
		            
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/




	    	        select
	                   case when grouping(area_cd) = 0 then
	                             nvl((select csubcd_nm from cccodest where ccd_typ = '260'  and c_cd = area_cd),area_cd)
	                        else '합계'
	                   end                                                          "지역"
	                  ,sum(adm_hapgae  )                                            adm_hapgae
	                  ,sum(adm_bohum   )                                            adm_bohum
	                  ,sum(adm_boho    )                                            adm_boho
	                  ,0                                                            adm_boho2
	                  ,sum(adm_hangyer )                                            adm_hangyer
	                  ,sum(adm_sanjae  )                                            adm_sanjae
	                  ,0                                                            adm_sanjae2
	                  ,sum(adm_general )                                            adm_general
	                  ,sum(adm_traffic )                                            adm_traffic
	                  ,sum(adm_gita    )                                            adm_gita
	              from
	                  (  
	                  
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


	                  
	                   select
	                          wk_key                                                       area_cd
	                         ---------------------------------------------------------------------------
	                         -- 입원실환자수
	                         ---------------------------------------------------------------------------
	                         ,sum(day_cnt4)                                                adm_hapgae
	                         ,sum(
	                              case when pattype in ('B1','B2','B6','BB') then day_cnt4
	                                   else 0
	                              end
	                             )                                                         adm_bohum
	                         ,sum(
	                              case when pattype in ('E1','E2','E6')      then day_cnt4
	                                   else 0
	                              end
	                             )                                                         adm_boho
	                         ,sum(
	                              case when pattype in ('E8')                then day_cnt4
	                                   else 0
	                              end
	                             )                                                         adm_hangyer
	                         ,sum(
	                              case when pattype in ('SA','SB','SP')      then day_cnt4
	                                   else 0
	                              end
	                             )                                                         adm_sanjae
	                         ,sum(
	                              case when pattype in ('AA')                then day_cnt4
	                                   else 0
	                              end
	                             )                                                         adm_general
	                         ,sum(
	                              case when pattype in ('TA')                then day_cnt4
	                                   else 0
	                              end
	                             )                                                         adm_traffic
	                         ,sum(
	                              case when pattype in ( 'B1','B2','B6','BB'
	                                                    ,'E1','E2','E6'
	                                                    ,'E8'
	                                                    ,'SA','SB','SP'
	                                                    ,'AA'
	                                                    ,'TA'
	                                                   )                     then 0
	                                   else day_cnt4
	                              end
	                             )                                                         adm_gita
	                         ,'1'                                                          gubun
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
	                                               
	                                               
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	                                               
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
	                                     
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	                                     
	                                     
	                                      )
	                      and dtl_typ = 'M03'
	                      and patsite = 'I'
	                      and age_typ = '1'
	                    group by
	                             wk_key
	                  )
	             group by
	                      rollup(area_cd)
	             having  sum(adm_hapgae) != 0
	             order by
	                      area_cd; 
	                      
	                      
	                      
	                      
	                      
	            END;   
	            
	            
	            
	            
	            
	            
	            
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* 4번 시작----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
	            
	            
	            
	            
	            
	  		ELSE
	  			BEGIN
    		        open wk_cursor for
		            select
	                   case when grouping(area_cd) = 0 then
	                             nvl((select csubcd_nm from cccodest where ccd_typ = '260'  and c_cd = area_cd),area_cd)
	                        else '합계'
	                   end                                                          "지역"
	                  ---------------------------------------------------------------------------
	                  -- 재원연입원실환자수
	                  ---------------------------------------------------------------------------
	                  ,SUM(JAE_HAPGAE  )                                            JAE_HAPGAE
	                  ,SUM(JAE_BOHUM   )                                            JAE_BOHUM
	                  ,SUM(JAE_BOHO    )                                            JAE_BOHO
	                  ,0                                                            ADM_BOHO2
	                  ,SUM(JAE_HANGYER )                                            JAE_HANGYER
	                  ,SUM(JAE_SANJAE  )                                            JAE_SANJAE
	                  ,0                                                            JAE_SANJAE2
	                  ,SUM(JAE_GENERAL )                                            JAE_GENERAL
	                  ,SUM(JAE_TRAFFIC )                                            JAE_TRAFFIC
	                  ,SUM(JAE_GITA    )                                            JAE_GITA
	              from
	                  (
	                   select
	                          wk_key                                                       area_cd
	                         ---------------------------------------------------------------------------
	                         -- 재원연입원실환자수
	                         ---------------------------------------------------------------------------
	                         ,sum(jespcrsv_cnt)                                            jae_hapgae
	                         ,sum(
	                              case when pattype in ('B1','B2','B6','BB') then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_bohum
	                         ,sum(
	                              case when pattype in ('E1','E2','E6')      then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_boho
	                         ,sum(
	                              case when pattype in ('E8')                then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_hangyer
	                         ,sum(
	                              case when pattype in ('SA','SB','SP')      then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_sanjae
	                         ,sum(
	                              case when pattype in ('AA')                then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_general
	                         ,sum(
	                              case when pattype in ('TA')                then jespcrsv_cnt
	                                   else 0
	                              end
	                             )                                                         jae_traffic
	                         ,sum(
	                              case when pattype in ( 'B1','B2','B6','BB'
	                                                    ,'E1','E2','E6'
	                                                    ,'E8'
	                                                    ,'SA','SB','SP'
	                                                    ,'AA'
	                                                    ,'TA'
	                                                   )                     then 0
	                                   else jespcrsv_cnt
	                              end
	                             )                                                         jae_gita
	                         ---------------------------------------------------------------------------
	                         ,'1'                                                          gubun
	                     from apstatmt2
	                    where med_dte in
	                                      (
	                                       select  end_dte
	                                         from
	                                             (
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
	                                      )
	                      and dtl_typ = 'M03'
	                      and patsite = 'I'
	                      and age_typ = '1'
	                    group by
	                             wk_key
	                  )
	             group by
	                      rollup(area_cd)
	             having  sum(jae_hapgae) != 0
	             order by
	                      area_cd;        
	                      
	                      
	                      
	                      
	                      
	                      
	                      
	                      
	             END;
	  		END IF;

             out_cursor := wk_cursor;

        exception
               	when others then
                   	 raise_application_error(-20500,'pc_sel_pts02_income035 오류!' || chr(13) || 'err_cd = '|| sqlcode || chr(13) || ' ' || sqlerrm);
       	end pc_sel_pts02_income035;