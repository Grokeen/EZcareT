





PROCEDURE pc_ap_HipssMobileAprvList (  in_from_dte 		in  varchar2
                                    ,  in_to_dte   		in  varchar2
                                    ,  in_gubun   		in  varchar2
	                                ,  out_cursor      	out sys_refcursor) 
is
    wk_cursor  	returncursor;
begin

	begin
		open wk_cursor for		
			select ''                                   chk
			      ,to_char(a.fstinst_dtm,'yyyy-mm-dd')  fstinst_dtm
			      ,a.pt_no
			      ,b.pt_nm  
                  ,b.ssn1  || '-' || substr(b.ssn2,1,1)|| '******' ssn        
                  
                                            
			      ,case when a.cncl_dte is not null and a.cncl_cd in ('07' ,'08','09' ) then 'N' ||' ('|| c.csubcd_nm  ||')'
			            when a.cncl_dte is null  then   'Y' end aprv_yn


                  ,(select /*+  NO_UNNEST index ( c APQUALMT_UK01)  */
					       c.pattype                                                             
					  from apqualmt c
					     , apinsurt_temp  d
					 where  c.pt_no        =  a.pt_no
					   and  c.pat_cap_typ  =  'A'
					   and  c.from_dte    <=  trunc(sysdate)
					   and  d.pt_no        =  c.pt_no
					   and  c.from_dte     = to_date(d.quacq_dte,'yyyymmdd')   
					   and  d.med_dte     <= trunc(sysdate)
					   and  substrb(c.pattype, 1, 1) = case when d.qu_typ  < 7 then 'B'
					                                        when d.qu_typ  < 9 then 'E'
					                                        else '' end
					   and  d.wk_dtm       = ( select max(e.wk_dtm) from apinsurt_temp e where e.pt_no  =  c.pt_no and e.med_dte <= trunc(sysdate)  )
	               ) pattype 
	               , b.ssn1 ||'-'|| DEC_SSN2(b.ssn2) ssn2 
	               , a.sms_tel
	               , a.token_no_skp	
                   , to_char(a.from_dte,'yyyy-mm-dd')from_dte
                   , to_char(a.to_dte,'yyyy-mm-dd')to_dte   
	               , a.card_comp 
	               , a.card_nm
	               , a.card_no              		            			           
			  from aphipassmt a
			      ,appatbat   b
			      ,cccodest   c
			 where a.fstinst_dtm            between to_date(in_from_dte ,'yyyymmdd')  and  to_date(in_to_dte ,'yyyymmdd')+.9999
			   and a.fstinst_id             ='C1EMR' 
			   and nvl(a.cncl_cd,'XX')      = decode(in_gubun ,'A' ,nvl(a.cncl_cd,'XX')    --전체 조회
			                                                  ,'N' ,'09'                   --원무과 취소  조회
			                                                  ,'X' ,'07'                   --미승인 조회
			                                                       ,'XX')                  --원무과 승인 조회
			   and a.pt_no                  = b.pt_no
			   and c.ccd_typ                (+)= '996'
			   and c.c_cd                   (+)= a.cncl_cd 
			 order by 2,3, 4; 
			      
		out_cursor := wk_cursor; 
				      	                         
	exception
		when others then
			raise_application_error(-20500,'모바일 하이패스 승인 내역 조회 select error!');
	end;	
end pc_ap_HipssMobileAprvList;