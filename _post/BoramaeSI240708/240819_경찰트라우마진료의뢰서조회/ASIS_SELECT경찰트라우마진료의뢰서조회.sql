
EXEC :IN_FROM_DATE := '2023-12-01';
EXEC :IN_TO_DATE := '2024-08-19' ;


select /*+ pkg_bil_ptinf.pc_ap_appoltrt_select */
                to_char(a.req_dte,'yyyy-mm-dd')                 	req_dte
              , a.req_seq                                       	req_seq
              , a.pt_no                                         	pt_no
              , decode(nvl(a.pt_no,'*'),'*',a.pt_nm,c.pt_nm)    	pt_nm
--              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
--                || '-' ||decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)) ssn     --2020.11.23 주민번호 뒷자리 체크  
              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
                || '-' || substr(decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)),1,1) ||'******'  ssn    
              , decode(a.patsite,'O','외래','I','입원','응급')  	patsite
              , NULL         																			er_kit_yn
              , NULL																							ATK_GUBN
              , b.dept_nm                                       	dept_nm
              , a.rmk																							rmk
           from appoltrt a -- 경찰트라우마진료의뢰서
              , ccdepart b -- MRDDRITD 이미지템플릿정보(진료간호) / PDEDBMSM 부서기본
              , appatbat c -- 환자기본
          where a.req_dte between to_date(:in_from_dte,'yyyy-mm-dd')
                              and to_date(:in_to_dte,'yyyy-mm-dd')
            and a.med_dept = b.dept_cd (+)
            and a.pt_no    = c.pt_no   (+)
            and a.cncl_dte is null                  -- 2010-11-08 권욱주 추가 
          order by 1 desc,2;










/***********************************************************************************
 *    서비스이름  : pc_ap_appoltrt_select
 *    최초 작성일 : 2013.08.
 *    최초 작성자 : ezCareTech 신원석
 *    Description : 경찰트라우마 의뢰서 조회
 ***********************************************************************************/
procedure pc_ap_appoltrt_select(
                                  in_from_dte                in   varchar2
                               ,  in_to_dte                  in   varchar2
                               ,  out_cursor                 out  returncursor)
is
    wk_cursor returncursor;
begin
    open wk_cursor for
         select /*+ pkg_bil_ptinf.pc_ap_appoltrt_select */
                to_char(a.req_dte,'yyyy-mm-dd')                 	req_dte
              , a.req_seq                                       	req_seq
              , a.pt_no                                         	pt_no
              , decode(nvl(a.pt_no,'*'),'*',a.pt_nm,c.pt_nm)    	pt_nm
--              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
--                || '-' ||decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)) ssn     --2020.11.23 주민번호 뒷자리 체크  
              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
                || '-' || substr(decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)),1,1) ||'******'  ssn    
              , decode(a.patsite,'O','외래','I','입원','응급')  	patsite
              , NULL         																			er_kit_yn
              , NULL																							ATK_GUBN
              , b.dept_nm                                       	dept_nm
              , a.rmk																							rmk
           from appoltrt a
              , ccdepart b
              , appatbat c
          where a.req_dte between to_date(in_from_dte,'yyyy-mm-dd')
                              and to_date(in_to_dte,'yyyy-mm-dd')
            and a.med_dept = b.dept_cd (+)
            and a.pt_no    = c.pt_no   (+)
            and a.cncl_dte is null                  -- 2010-11-08 권욱주 추가 
          order by 1 desc,2;
            
              
    out_cursor := wk_cursor;

    exception
        when others then
            raise_application_error(-20500,'pc_ap_appoltrt_select: select 하면서 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);                                    
        
end pc_ap_appoltrt_select;