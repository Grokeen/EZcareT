/***********************************************************************************
 *    서비스이름  : pc_ap_aponestt_create
 *    최초 작성일 : 2010.06.
 *    최초 작성자 : 이종원
 *    Description : one-stop 내역 등록
 ***********************************************************************************/
procedure pc_ap_aponestt_create(
                                       in_jobtype             in   varchar2
                                    ,  in_req_dte             in   varchar2
                                    ,  in_req_seq             in   varchar2
                                    ,  in_pt_no               in   varchar2
                                    ,  in_pt_nm               in   varchar2
                                    ,  in_ssn1                in   varchar2
                                    ,  in_ssn2                in   varchar2
                                    ,  in_patsite             in   varchar2
                                    ,  in_tel1                in   varchar2
                                    ,  in_tel3                in   varchar2
                                    ,  in_zip_no              in   varchar2
                                    ,  in_zip_seq             in   varchar2
                                    ,  in_addr                in   varchar2
                                    ,  in_med_dept            in   varchar2
                                    ,  in_er_kit_yn           in   varchar2
                                    ,  in_med_dte             in   varchar2
                                    ,  in_med_dtm             in   varchar2
                                    ,  in_meddr_id            in   varchar2
                                    ,  in_pattype             in   varchar2
                                    ,  in_type_cd             in   varchar2
                                    ,  in_med_type            in   varchar2
                                    ,  in_spc_dr_yn           in   varchar2
                                    ,  in_prt_gubn            in   varchar2
                                    ,  in_rmk                 in   varchar2
                                    ,  in_prt_cho_yn	      in   varchar2
                                    ,  in_prt_jae_yn	      in   varchar2
                                    ,  in_prt_jin_yn	      in   varchar2
                                    ,  in_prt_gum_yn	      in   varchar2
                                    ,  in_atk_gubn            in   varchar2    --2011-04-04 권욱주 추가                                                                                                                     
                                    ,  in_wk_id               in   varchar2)
is
    v_aponestt            aponestt%rowtype;
    v_req_seq             varchar2(10);           --진료의뢰서번호 
    v_check               varchar2(1);
begin

        v_aponestt.req_dte            := to_date(in_req_dte,'yyyy-mm-dd');
        v_aponestt.pt_no              := in_pt_no;
        v_aponestt.pt_nm              := in_pt_nm;
        v_aponestt.ssn1               := in_ssn1;
        v_aponestt.ssn2               := ENC_SSN2(in_ssn2);
        v_aponestt.patsite            := in_patsite;
        v_aponestt.tel_no             := in_tel1;
        v_aponestt.tel3_no            := in_tel3;
        v_aponestt.zip_no             := in_zip_no;
        v_aponestt.zip_seq            := in_zip_seq;
        v_aponestt.zip_no             := in_zip_no;
        v_aponestt.addr               := in_addr;
        v_aponestt.med_dept           := in_med_dept;
        v_aponestt.er_kit_yn          := in_er_kit_yn;
        v_aponestt.med_dte            := to_date(in_med_dte,'yyyy-mm-dd');
        v_aponestt.med_dtm            := to_date(in_med_dtm,'yyyy-mm-ddhh24mi');
        v_aponestt.meddr_id           := in_meddr_id;
        v_aponestt.pattype            := in_pattype;
        v_aponestt.type_cd            := in_type_cd;
        v_aponestt.med_type           := in_med_type;
        v_aponestt.spc_dr_yn          := in_spc_dr_yn;
        v_aponestt.prt_gubn           := in_prt_gubn;
        v_aponestt.rmk                := in_rmk;
        v_aponestt.edit_id            := in_wk_id;
        v_aponestt.prt_cho_yn         := in_prt_cho_yn;
        v_aponestt.prt_jae_yn         := in_prt_jae_yn;
        v_aponestt.prt_jin_yn         := in_prt_jin_yn;
        v_aponestt.prt_gum_yn         := in_prt_gum_yn;
        v_aponestt.edit_dtm           := sysdate;   
        v_aponestt.atk_gubn           := in_atk_gubn;  --2011-04-04 권욱주 추가 (1:성폭행, 2:가정폭력)

        --등록일경우
        if in_jobtype = 'I' or in_jobtype = 'U' Then
            --유효한 신청서 중에 동일한 날에 동일한 진료과, 의뢰타입 신청서가 있는지 조회
            begin
                   select 'Y'
                     into v_check
                     from aponestt
                    where req_dte         = to_date(in_req_dte,'yyyy-mm-dd')
                      and pt_no           = v_aponestt.pt_no
                      and ssn1            = v_aponestt.ssn1
                      and ssn2            = v_aponestt.ssn2
                      and patsite         = v_aponestt.patsite
                      and med_dept        = v_aponestt.med_dept  
                      and cncl_dte        is null               --2010-11-08 권욱주 추가
                      ;                       
            exception
                when no_data_found then
                    v_check := 'N';
            when others then
                raise_application_error(-20500,'pc_ap_aponestt_create: 진료의뢰서 중복 체크중 에러가 발생하였습니다. ' || chr(13) || sqlcode || chr(13) || sqlerrm);
            end;

            if in_jobtype = 'I' then 
            
                if v_check = 'Y' then
                    raise_application_error(-20999,'동일한 날짜에 동일한 진료과, 타입의 의뢰서 존재 합니다.|▒|');
                    return;
                end if;

                --진료의뢰서번호 채번
                begin
                    select nvl(max(req_seq),0)+1
                      into v_req_seq
                      from aponestt
                     where req_dte = to_date(in_req_dte,'yyyy-mm-dd');
                exception
                     when others then
                          raise_application_error(-20500,'pkg_bil_ptinf.pc_ap_aponestt_create : 진료의뢰내역 진료의뢰서 번호 채번중 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);
                end;

                begin
                    v_aponestt.req_seq      :=  v_req_seq;
                exception
                     when others then
                          raise_application_error(-20500,'pkg_bil_ptinf.pc_ap_aponestt_create : 진료의뢰내역 진료의뢰서 번호 변수 대입중 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);
                end;

                begin
                   insert into aponestt values v_aponestt;
                exception
                    when dup_val_on_index then
                        raise_application_error(-20500,'pc_ap_aponestt_create insert 중복Error: errcode = '|| sqlcode || sqlerrm);

                    when others then
                        raise_application_error(-20500,'pc_ap_aponestt_create: insert 하면서 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);
                end;
            elsif in_jobtype = 'U' then
                begin
                    update
                            aponestt
                       set  pt_no           = v_aponestt.pt_no    
                         ,  pt_nm           = v_aponestt.pt_nm    
                         ,  ssn1            = v_aponestt.ssn1     
                         ,  ssn2            = v_aponestt.ssn2     
                         ,  zip_no          = v_aponestt.zip_no   
                         ,  zip_seq         = v_aponestt.zip_seq  
                         ,  addr            = v_aponestt.addr     
                         ,  tel_no          = v_aponestt.tel_no   
                         ,  tel3_no         = v_aponestt.tel3_no  
                         ,  patsite         = v_aponestt.patsite  
                         ,  er_kit_yn       = v_aponestt.er_kit_yn
                         ,  med_dept        = v_aponestt.med_dept
                         ,  med_dte         = v_aponestt.med_dte
                         ,  med_dtm 		= v_aponestt.med_dtm	
                         ,  meddr_id        = v_aponestt.meddr_id
                         ,  pattype         = v_aponestt.pattype
                         ,  type_cd         = v_aponestt.type_cd
                         ,  med_type        = v_aponestt.med_type
                         ,  spc_dr_yn       = v_aponestt.spc_dr_yn
                         ,  prt_gubn        = v_aponestt.prt_gubn
                         ,  rmk             = v_aponestt.rmk
                         ,  edit_dtm        = v_aponestt.edit_dtm 
                         ,  edit_id         = v_aponestt.edit_id 
                         ,  prt_cho_yn      = v_aponestt.prt_cho_yn
                         ,  prt_jae_yn      = v_aponestt.prt_jae_yn
                         ,  prt_jin_yn      = v_aponestt.prt_jin_yn
                         ,  prt_gum_yn      = v_aponestt.prt_gum_yn   
                         ,  atk_gubn        = v_aponestt.atk_gubn                --2011-04-04 권욱주 추가 
                     where  req_dte         = to_date(in_req_dte,'yyyy-mm-dd')
                       and  req_seq         = in_req_seq
                            ;
                exception
                    when others then
                        raise_application_error(-20500,'pc_ap_aponestt_create: update 하면서 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);
                end;
            end if;
        elsif in_jobtype = 'D' then 
            begin
--                delete
--                        aponestt
--                 where  req_dte         = to_date(in_req_dte,'yyyy-mm-dd')
--                   and  req_seq         = in_req_seq
--                            ;
				--2010-11-08 권욱주 취소시 삭제에서 cncl_dte 로 전환
				    update aponestt
				       set cncl_dte = sysdate
				         , cncl_id  = in_wk_id
				    where  req_dte  = to_date(in_req_dte,'yyyy-mm-dd')
                      and  req_seq  = in_req_seq
                      ;
            exception
                 when others then
                    raise_application_error(-20500,'pc_ap_aponestt_create: delete 하면서 오류가 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm);
            end;
        end if;
end pc_ap_aponestt_create;