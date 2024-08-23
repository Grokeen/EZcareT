/***********************************************************************************
 *    서비스이름  : pc_ap_aponestt_select
 *    최초 작성일 : 2010.06.
 *    최초 작성자 : 이종원
 *    Description : one-stop 내역 조회 
 ***********************************************************************************/
procedure pc_ap_aponestt_select(
                                  in_from_dte                in   varchar2
                               ,  in_to_dte                  in   varchar2
                               ,  out_cursor                 out  returncursor)
is
    wk_cursor returncursor;
begin
    open wk_cursor for
         select /*+ pkg_bil_ptinf.pc_ap_aponestt_select */
                to_char(a.req_dte,'yyyy-mm-dd')                 	req_dte
              , a.req_seq                                       	req_seq
              , a.pt_no                                         	pt_no


              , decode(nvl(a.pt_no,'*'),'*',a.pt_nm,c.pt_nm)    	pt_nm
--              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
--                || '-' ||decode(nvl(a.pt_no,'*'),'*',DEC_SSN2(a.ssn2),DEC_SSN2(c.ssn2)) ssn    



              , decode(nvl(a.pt_no,'*'),'*',a.ssn1,c.ssn1)
                || '-' || substr(decode(nvl(a.pt_no,'*'),'*',damo.dec_ssn2_pen(a.ssn2),damo.dec_ssn2_pen(c.ssn2)),1,1)||'******' ssn   --2020.11.23 김선화 주민번호 뒷자리 수정





              , decode(a.patsite,'O','외래','I','입원','응급')  	patsite
              , decode(a.er_kit_yn,'Y','사용','미사용')         	er_kit_yn
              , decode(a.ATK_GUBN, '1', '원스탑', '윈스탑(가정)')	ATK_GUBN	
              -- 원스탑 = 성폭력 1번
              -- 원스탑(가정) = 가정폭력 2번


              --2011-07-08 추가 : 적용구분



              , b.dept_nm                                       	dept_nm
              , a.rmk												rmk




           from aponestt a -- ONE-STOP 진료의뢰서
              , ccdepart b -- 공통부서마스타
              , appatbat c -- 환자기본
          where a.req_dte between to_date(in_from_dte,'yyyy-mm-dd')
                              and to_date(in_to_dte,'yyyy-mm-dd')
            and a.med_dept = b.dept_cd (+)
            and a.pt_no    = c.pt_no   (+)
            and a.cncl_dte is null                  -- 2010-11-08 권욱주 추가 
          order by 1 desc,2;
            
              







    out_cursor := wk_cursor;

    exception
        when others then
            raise_application_error(-20500,'pc_ap_aponestt_select: select 하면서 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);                                    
        
end pc_ap_aponestt_select;