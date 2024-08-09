```SQL
/***********************************************************************************
 *    서비스이름  : pc_ap_apreqvat_multi_select
 *    최초 작성일 : 2009.08.19
 *    최초 작성자 : DF 문지훈
 *    Description : 행려환자내역 조회
 ***********************************************************************************/
procedure pc_ap_apreqvat_multi_select(  in_pt_no                   in   varchar2
                                      , in_from_dte                in   varchar2
                                      , in_to_dte                  in   varchar2
                                      , in_patsite                 in   varchar2
                                      , in_pt_nm                   in   varchar2    --2010-11-22 신원석 추가
                                      , out_cursor                 out  returncursor)

is
    wk_cursor returncursor;
begin

    open wk_cursor for
         select  /*+ pkg_bil_srimd.pc_ap_apreqvat_multi_select */
                 to_char(b.arv_dtm,'yyyy-mm-dd hh24:mi')       arv_dtm               --00.진료의뢰일시
              ,  a.pt_no                                       pt_no                 --01.환자번호
              ,  pkg_bil_common.FC_PtNmSel(a.pt_no)            pt_nm                 --02.환자이름
              ,  c.ssn1||'-'||substr(DEC_SSN2(c.ssn2),1,1)||'******'   pt_ssn                --03.환자주민번호
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.pattype
                      else                         --입원일때
                           g.pattype
                      end,a.pattype)                           pattype               --04.환자유형 
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.type_cd
                      else                         --입원일때
                           g.type_cd
                      end,a.type_cd)                           type_cd               --05.보조유형명
              ,  b.inhsp_path_typ                              inhsp_path_typ        --06.내원경로구분
              ,  pkg_bil_common.FC_CccodeNameSel('22A',b.inhsp_path_typ)
                                                               inhsp_path_typ_nm     --07.내원경로구분명
              ,  b.reqsite_orgn_nm                             reqsite_orgn_nm       --08.의뢰처
              ,  b.reqsite_dept_nm                             reqsite_dept_nm       --09.부서명
              ,  b.com_mng_no                                  com_mng_no            --10.전산관리번호
              ,  to_char(b.qu_req_dte,'yyyy-mm-dd')            qu_req_dte            --11.자격신청일자
              ,  to_char(b.qu_reply_dte,'yyyy-mm-dd')          qu_reply_dte          --12.자격회신일자
              ,  b.cr_orgn_cd                                  cr_orgn_cd            --13.보장기관기호
              ,  pkg_bil_common.FC_UnionNameSel('E',b.cr_orgn_cd)
                                                               cr_orgn_nm            --14.보장기관기호명
              ,  b.disapp_rsn_typ                              disapp_rsn_typ        --15.불가사유구분
              ,  pkg_bil_common.FC_CccodeNameSel('22B',b.disapp_rsn_typ)
                                                               disapp_rsn_typ_nm     --16.불가사유구분명
              --,  nvl(a.med_rslt,'진료중')                      med_rslt              --17.진료결과
              ,  b.med_rslt_typ                                med_rslt              --17.진료결과
              ,  e.csubcd_nm                                   med_rslt              --18.진료결과명
              ,  to_char(a.disrm_dtm,'yyyy-mm-dd')             disrm_dtm             --19.퇴실일자
              ,  d.wd_no||'-'||d.rm_no||'-'||d.bed_no          wd_no                 --20.병동병실
              ,  b.rmk                                         remark                --21.비고(행려)
              ,  to_char(b.edit_dtm,'yyyy-mm-dd hh24:mi')      eidt_dtm              --22.수정일시
              ,  b.edit_id                                     edit_id               --23.수정자ID
              ,  to_char(d.DSCH_DTM,'yyyy-mm-dd')              dsch_dtm              --24.퇴원일자
              ,  b.chk_list                                    chk_list              --25.체크리스트
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.tot_amt
                      else                         --입원일때
                           g.tot_amt
                      end,0)                                      tot_amt               --26.진료비총액
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.ins_amt
                      else                         --입원일때
                           g.ins_amt
                      end,0)                                      ins_amt               --27.급여금액
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.uin_amt + f.spc_med_amt
                      else                         --입원일때
                           g.uin_amt + g.spc_med_amt
                      end,0)                                      uin_amt               --28.비급여금액
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.oob_amt
                      else                         --입원일때
                           g.oob_amt
                      end,0)                                      oob_amt               --29.환자부담총액
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.unc_amt
                      else                         --입원일때
                           g.unc_amt
                      end,0)                                     unc_amt                --30.단체부담금
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.dc_amt
                      else                         --입원일때
                           g.dc_amt
                      end,0)                                      dc_amt                --31.단체금액
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.psn_unc_amt
                      else                         --입원일때
                           g.psn_unc_amt
                      end,0)                                      psn_unc_amt           --32.미수납액
              ,  nvl(case when a.adm_dte is null then  --외래일때
                           f.rcp_amt + f.bogj_rcp_amt
                      else                         --입원일때
                           g.rcp_amt + g.bogj_rcp_amt + g.out_adj_amt
                      end,0)                                      rcp_amt               --33.수납금액
              ,  case when a.adm_dte is null then  --외래일때
                           '응급외래'
                      else                         --입원일때
                           '응급입원'
                      end                                      gubn                     --34.구분  
              ,  case when a.adm_dte is null then --외래일때
                          nvl((select 'Y'
                                 from acopcalt 
                                where pt_no = f.pt_no
                                  and med_dte = f.med_dte
                                  and med_dept = f.med_dept
                                  and mn_patt_typ = f.mn_patt_typ
                                  and meddr_id = f.meddr_id
                                  and cncl_dte is null
                                  and req_dte  is not null
                                  and rownum = 1),'N')
                      else
                          nvl((select 'Y'
                                 from acipcatt
                                where pt_no = g.pt_no
                                  and adm_dte = g.adm_dte
                                  and mn_patt_typ = g.mn_patt_typ
                                  and cncl_dte is null
                                  and req_dte is not null
                                  and rownum = 1),'N')  
                      end                                      req_yn                   --35.청구여부  2013.11.26 신원석 추가 강성주과장님 확인함                        
              ,  h.cust_nm                                                              --36.계약처명  2016.03.10 신원석 추가 
              ,  b.rmk2                                        rmk2                     --37.비고2     2017.03.30 신원석 추가
              ,  b.rmk3                                        rmk3                     --38.비고3     2017.03.30 신원석 추가    
              ,  pkg_bil_common.FC_UserNameSel(b.edit_id)      edit_nm					--39.등록자명  2019.09.25 김선화 추가	
           from  apemgrct a
              ,  apreqvat b
              ,  appatbat c
              ,  apiplist d  -- ACPPRAAM
              ,  cccodest e
              ,  acoppayt f
              ,  acippayt g
              ,  apcustmt h              
          where  a.pt_no    = nvl(in_pt_no, a.pt_no)
            and  a.arv_dtm  between nvl(to_date(in_from_dte,'yyyymmdd'), a.arv_dtm)
                                and trunc(nvl(to_date(in_to_dte,'yyyymmdd'), a.arv_dtm)) + .99999
            and  b.pt_no    = a.pt_no
            and  c.pt_nm    = nvl(in_pt_nm,c.pt_nm)
            and  b.arv_dtm  = a.arv_dtm
            and  c.pt_no    = a.pt_no
            and  d.pt_no(+) = a.pt_no
            and  e.ccd_typ  = '987'
            and  e.c_cd     = nvl(b.med_rslt_typ,0)
            and  d.adm_dte(+) = a.adm_dte
            --2013.03.07신원석 추가 시작
            and  a.pt_no    = f.pt_no(+)
            and  a.arv_dtm  = f.med_dte(+)
            and  f.cncl_dte(+) is null
            and  a.pt_no    = g.pt_no(+)
            and  a.adm_dte  = g.adm_dte(+)
            and  g.cncl_dte(+) is null
            and  g.mn_patt_typ(+) = '0'  --주유형 건만
            and  a.cust_cd = h.cust_cd(+)
            --2013.03.07신원석 추가 끝 
      union all                        
         --2016.08.02 신원석 접수없이 등록할수 있는 기능 추가로 인한 조회 수정 
         select  /*+ pkg_bil_srimd.pc_ap_apreqvat_multi_select */
                 to_char(b.arv_dtm,'yyyy-mm-dd hh24:mi')       arv_dtm               --00.진료의뢰일시
              ,  b.pt_no                                       pt_no                 --01.환자번호
              ,  pkg_bil_common.FC_PtNmSel(b.pt_no)            pt_nm                 --02.환자이름
              ,  c.ssn1||'-'||substr(DEC_SSN2(c.ssn2),1,1)||'******'   pt_ssn                --03.환자주민번호
              ,  null                                          pattype               --04.환자유형
              ,  null                                          type_cd               --05.보조유형명
              ,  b.inhsp_path_typ                              inhsp_path_typ        --06.내원경로구분
              ,  pkg_bil_common.FC_CccodeNameSel('22A',b.inhsp_path_typ)
                                                               inhsp_path_typ_nm     --07.내원경로구분명
              ,  b.reqsite_orgn_nm                             reqsite_orgn_nm       --08.의뢰처
              ,  b.reqsite_dept_nm                             reqsite_dept_nm       --09.부서명
              ,  b.com_mng_no                                  com_mng_no            --10.전산관리번호
              ,  to_char(b.qu_req_dte,'yyyy-mm-dd')            qu_req_dte            --11.자격신청일자
              ,  to_char(b.qu_reply_dte,'yyyy-mm-dd')          qu_reply_dte          --12.자격회신일자
              ,  b.cr_orgn_cd                                  cr_orgn_cd            --13.보장기관기호
              ,  pkg_bil_common.FC_UnionNameSel('E',b.cr_orgn_cd)
                                                               cr_orgn_nm            --14.보장기관기호명
              ,  b.disapp_rsn_typ                              disapp_rsn_typ        --15.불가사유구분
              ,  pkg_bil_common.FC_CccodeNameSel('22B',b.disapp_rsn_typ)
                                                               disapp_rsn_typ_nm     --16.불가사유구분명
              --,  nvl(a.med_rslt,'진료중')                      med_rslt              --17.진료결과
              ,  b.med_rslt_typ                                med_rslt              --17.진료결과
              ,  e.csubcd_nm                                   med_rslt              --18.진료결과명
              ,  null                                          disrm_dtm             --19.퇴실일자
              ,  null                                          wd_no                 --20.병동병실
              ,  b.rmk                                         remark                --21.비고(행려)
              ,  to_char(b.edit_dtm,'yyyy-mm-dd hh24:mi')      eidt_dtm              --22.수정일시
              ,  b.edit_id                                     edit_id               --23.수정자ID
              ,  null                                          dsch_dtm              --24.퇴원일자
              ,  b.chk_list                                    chk_list              --25.체크리스트
              ,  null                                          tot_amt               --26.진료비총액
              ,  null                                          ins_amt               --27.급여금액
              ,  null                                          uin_amt               --28.비급여금액
              ,  null                                          oob_amt               --29.환자부담총액
              ,  null                                          unc_amt                --30.단체부담금
              ,  null                                          dc_amt                --31.단체금액
              ,  null                                          psn_unc_amt           --32.미수납액
              ,  null                                          rcp_amt               --33.수납금액
              ,  null                                          gubn                     --34.구분
              ,  null                                          req_yn                   --35.청구여부  2013.11.26 신원석 추가 강성주과장님 확인함
              ,  null                                          cust_nm                  --36.계약처명  2016.03.10 신원석 추가
              ,  b.rmk2                                        rmk2                     --37.비고2     2017.03.30 신원석 추가
              ,  b.rmk3                                        rmk3                     --38.비고3     2017.03.30 신원석 추가  
              ,  pkg_bil_common.FC_UserNameSel(b.edit_id)      edit_nm					--39.등록자명  2019.09.25 김선화 추가	            
           from  apreqvat b
              ,  appatbat c
              ,  cccodest e
          where  b.pt_no    = nvl(in_pt_no, b.pt_no)
            and  b.arv_dtm  between nvl(to_date(in_from_dte,'yyyymmdd'), b.arv_dtm)
                                and trunc(nvl(to_date(in_to_dte,'yyyymmdd'), b.arv_dtm)) + .99999
            and  b.pt_no    = c.pt_no
            and  c.pt_nm    = nvl('',c.pt_nm)
            and  e.ccd_typ  = '987'
            and  e.c_cd     = nvl(b.med_rslt_typ,0) 
            and  not exists (select 'Y'
                               from apemgrct
                              where pt_no = b.pt_no
                                and arv_dtm = b.arv_dtm)                                  
          order  by arv_dtm , pt_no desc;

    out_cursor := wk_cursor;

    exception
        when others then
            raise_application_error(-20500,'pc_ap_apreqvat_multi_select: select 하면서 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);

end pc_ap_apreqvat_multi_select;
```