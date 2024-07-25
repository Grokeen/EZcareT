procedure pc_sw_sel_swsupamt_ptlist ( in_from_dte                in  varchar2       --�Ŀ�����
                                        , in_to_dte                  in  varchar2       --�Ŀ�����  
                                        , in_pt_no                   in  varchar2       --ȯ�ڹ�ȣ 
                                        , out_cursor                 out returncursor)  -- ��ȯ�� DataSet
    is
        --��������
        wk_cursor                 returncursor ;
    begin
        begin
            --body
            open wk_cursor for

                 select c.pt_nm                                                                      pt_nm
                      , a.pt_no                                                                      pt_no
--                      , ft_sd_diss6(a.pt_no, to_char(b.acpt_dte,'yyyy-mm-dd'),b.pt_sect,b.dept_cd)  diss
                        ,  (select a.dz_cls_cd||'  '|| a.clnc_diag_nm
						      from mojsangt a
						         , medvocabulary b           
						     where a.pt_no          = in_pt_no
						       and a.a_acpt_dte     between to_date(in_from_dte ,'yyyy-mm-dd')
						                                and to_date(in_to_dte ,'yyyy-mm-dd')+0.99999
						       and nvl(mn_dz_yn,'N')    = 'Y'
						       and nvl(del_yn,'N')      = 'N'
						       and a.clnc_diag_cd       = b.vocabulary_id
						       and rownum = 1
 							) as diss
                 --     , FT_SR_DISS(a.pt_no)
--                      , ft_get_dept_nm(b.dept_cd)                                                    dept_cd
                      , FTB_CCDEPART_NM(b.dept_cd, 'Y')
                      , ft_d_name(b.juc_dr)  || '/' || ft_d_name(b.char_dr)                          dr
                      , ft_d_name(b.consult_id)                                                      consult_id
                      , to_char(a.from_dte,'yyyy-mm-dd')                                             from_dte
                      , to_char(a.to_dte,'yyyy-mm-dd')                                               to_dte
--                      , d.orgn_nm                                                                    orgn_nm  
                      , a.sup_no                                                                     orgn_nm
                      , a.sup_amt                                                                    sup_amt
                      , a.use_amt                                                                    use_amt
                      , to_char(a.pay_dte,'yyyy-mm-dd')												 pay_dte		
                      , a.bigo                                                                       bigo
                   from swsupamt a
                      , swintakt b
                      , appatbat c
--                      , swsuport d
                    where a.pay_dte between to_date(in_from_dte ,'yyyy-mm-dd')
                                        and to_date(in_to_dte   ,'yyyy-mm-dd')      		--'100202 by ��â�� ����.  �Ŀ��� ������������ �������� ��ȸ
                      and a.pt_no = b.pt_no
                      and a.talk_dte = b.talk_dte
                      and a.talk_seq = b.talk_seq
                      and a.pt_no = c.pt_no  
                      and a.pt_no = in_pt_no ;
--                      and a.sup_no = d.orgn_no;


                  out_cursor := wk_cursor ;

            --����ó��
          exception
	 			WHEN OTHERS THEN
					out_cursor := NULL;
        end ;

    end pc_sw_sel_swsupamt_ptlist ;