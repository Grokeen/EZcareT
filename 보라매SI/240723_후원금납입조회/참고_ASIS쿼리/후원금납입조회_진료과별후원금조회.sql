



procedure pc_sw_sel_swsupamt_deptlist ( in_from_dte                in  varchar2       -- 후원일자
                                      , in_to_dte                  in  varchar2       -- 후원일자
                                      , in_dept_cd                 in  varchar2       -- 진료과   
                                      , in_pt_no                   in  varchar2       -- 환자번호 
                                      , out_cursor                 out returncursor)  -- 반환할 DataSet
    is
        --변수선언
        wk_cursor                 returncursor ;
    begin
        begin
            --body
            open wk_cursor for
                 select 
--                      ft_get_dept_nm(b.clinic_cd)                                                  clinic_cd
                        b.clinic_cd
--                    , ft_get_dept_nm(b.dept_cd)                                                    dept_cd
                      , FTB_CCDEPART_NM(b.dept_cd, 'Y') 
                      , ft_d_name(b.juc_dr)  || '/' || ft_d_name(b.char_dr)                          dr
                      , a.pt_no                                                                      pt_no
                      , c.pt_nm                                                                      pt_nm
--                    , d.orgn_nm                                                                    orgn_nm
                      , t.csubcd_nm                                                                  orgn_nm
                      , a.sup_no                                                                     sup_no
                      , to_char(a.from_dte,'yyyy-mm-dd')                                             from_dte
                      , to_char(a.to_dte,'yyyy-mm-dd')                                               to_dte
                      , a.sup_amt                                                                    sup_amt
                      , a.use_amt                                                                    use_amt
                      , ft_d_name(b.consult_id)                                                      consult_id
				      , to_char(a.pay_dte,'yyyy-mm-dd')                                              pay_dte
                   from swsupamt a
                      , swintakt b
                      , appatbat c   
                      , cccodest t
--                    , swsuport d
                    where a.pay_dte between to_date(in_from_dte,'yyyy-mm-dd')
                                        and to_date(in_to_dte  ,'yyyy-mm-dd') 			--'100202 by 박창열 수정.  후원금 지원결정일을 기준으로 조회
                      and b.clinic_cd like in_dept_cd || '%'
                      and a.pt_no = b.pt_no
                      and a.talk_dte = b.talk_dte
                      and a.talk_seq = b.talk_seq
                      and a.pt_no = c.pt_no 
                      and a.sup_grp(+) = t.c_cd
                      and t.ccd_typ(+)  = 'SW24'
                      and a.pt_no = in_pt_no ;
--                      and a.sup_no = d.orgn_no;

                  out_cursor := wk_cursor ;

            --예외처리
          exception
                when others then
                     raise_application_error(-20553, 'pc_sw_sel_swsupamt_deptlist' || ' err_cd = ' || sqlcode || sqlerrm) ;
        end ;

    end pc_sw_sel_swsupamt_deptlist ;
  
       
END pkg_bil_ocals_New;