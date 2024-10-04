```sql
/***********************************************************************************
 *    서비스이름  : pc_ap_appatbat_select
 *    최초 작성일 : 2009.06.20
 *    최초 작성자 : DF 문지훈
 *    Description : 환자기본정보 조회
 ***********************************************************************************/
procedure pc_ap_appatbat_select( in_pt_no        in   varchar2
                               , out_cursor      out  sys_refcursor 
is
    wk_cursor      sys_refcursor;
    wk_infect_msg  varchar2(200);
begin
    ---------------------------------------------------------------------
    -- 감염확산지역 거주자 알림메시지 2020.03.04 김태훈
    ---------------------------------------------------------------------
    declare
        sub_area_cd    varchar2(10);
    begin
        begin
            select z.area_cd
              into sub_area_cd
              from (select coalesce( (select area_cd from ccpostmt      x where x.zip_no = a.zip_no and x.zip_seq = a.zip_seq and rownum = 1)
                                   , (select area_cd from apmatcmt      x where x.bld_no = a.building_no                      and rownum = 1)
                                   , (select area_cd from apmatcmt_newt x where x.bld_no = a.building_no                      and rownum = 1)
                                   )    area_cd
                      from appatbat a
                     where pt_no  = in_pt_no
                   ) z
             where exists (select 1
                             from cccodest
                            where ccd_typ            = '260'
                              and c_cd               = z.area_cd
                              and nvl(old_c_cd, 'N') = 'Y'
                          )
            ;
        exception
            when others then
                sub_area_cd := null;
        end
        if  sub_area_cd is not null then
            declare
                sub_msg1   varchar2(50)  := null;
                sub_msg2   varchar2(200) := null;
            begin
                for cur in (
                    select old_csubcd_nm    infect_nm  --감염질병명
                         , csubcd_nm        area_nm    --감염확산지역명
                      from cccodest
                     where ccd_typ             = '260'
                       and nvl(old_c_cd, 'N')  = 'Y'
                       and rownum             <= 5
                     order by
                           c_cd
                )
                loop
                    if  sub_msg1 is null then
                        sub_msg1 := cur.infect_nm;
                    end if
                    sub_msg2 := sub_msg2 || ',' || cur.area_nm;
                end loop
                if  sub_msg2 is not null then
                    wk_infect_msg := sub_msg1 || ' 관련 해당지역(' || substr(sub_msg2, 2) || ' 등) 주민입니다. 확인바랍니다.';
                end if;
            end;
        end if;
    exception
        when others then
            wk_infect_msg := null;
    end;
    --------------------------------------------------------------------
     open wk_cursor for
        SELECT /*+ index(a appatbat_pk)  pkg_bil_ptinf.pc_ap_appatbat_select */
               A.PT_NM                                            --00. 환자명
             , TO_CHAR(A.BIRTHDAY,'YYYY-MM-DD')  BIRTHDAY         --01. 생년월일
             , A.SSN1                                             --02. 주민등록번호1
             , damo.dec_ssn2_pen(A.SSN2) SSN2                    --03. 주민등록번호2              
            -- , DEC_SSN2(A.SSN2)                                --03. 주민등록번호2 
             --나이 생년월일 베이스에서 주민 번호 베이스로 변경
             , FT_AGE(nvl(pkg_bil_common.FC_SsnDate(a.ssn1||DEC_SSN2(a.ssn2),A.BIRTHDAY,a.pt_no),A.BIRTHDAY))  -- 2010.06.28 이강준 수정
             --, FT_AGE(nvl(pkg_bil_common.FC_SsnDate(a.ssn1||a.ssn2),A.BIRTHDAY))
                                                 age              --04. 나이 
             , A.SEX                                              --05. 성별
             , A.TEL_NO                                           --06. 전화번호1
             , A.TEL2_NO                                          --07. 전화번호2
             , A.TEL3_NO                                          --08. 휴대번호
             , A.EMAIL_ADDR                                       --09. 이메일주소
             --, A.ZIP_NO                                           --10. 우편번호      (123-456)
             , decode(a.building_no,null,a.ZIP_NO
                                        ,pkg_bil_toemr_function.ft_NewZipCdSel(a.building_no,'1'))  zip_no
                                                                  --10. 우편번호      (123-456)
             --, B.ALL_ADDR                                       --11. 우편번호 주소 (서울시 마포구...)
             , decode(a.building_no,null,B.ALL_ADDR
                                        ,pkg_bil_toemr_function.ft_NewZipCdSel(a.building_no,'3')) ALL_ADDR
                                                                  --11. 우편번호 주소 (서울시 마포구...)
             , A.ADDR                                             --12. 상세 주소     (901호)
             , A.PATTYPE                                          --13. 급종코드
           --  , A.TYPE_CD                                          --14. 유형보조코드
             , CASE WHEN A.PATTYPE IN ('B1','B2','B6','E1','E2','E6' ) AND A.TYPE_CD  ='JD' THEN '00' ELSE  A.TYPE_CD END   TYPE_CD   --2015.10.20 차상위, 급여환자 중 만7세 이하 소아환자는 보조유형 JD 자동 세팅이 아닌 00 으로 자동세팅되도록 프로그램 수정요청.
             , A.CUST_CD                                          --15. 계약처코드
             , A.DC_CD                                            --16. 감면코드
             , TO_CHAR(A.REG_DTM,'YYYY-MM-DD')   REG_DTM          --17. 최초등록일
             , A.ZIP_SEQ                                          --18. 우편번호 seq
--             , a.patsite
             , FT_AP_PATSITE(A.PT_NO)                             --19. 내원형태 
             , TO_CHAR(A.BIRTHDAY2,'YYYY-MM-DD') BIRTHDAY2        --20. 음력 생년월일
--             , TO_CHAR(A.EDIT_DTM ,'YYYY-MM-DD HH24:MM') EDIT_DTE -- 21. 수정일자
			 , TO_CHAR(A.EDIT_DTM ,'YYYY-MM-DD HH24:MI') EDIT_DTE -- 21. 수정일자  2010-11-22 권욱주 : MM -> MI 분 변경 ...
             , A.EDIT_ID                                          --22. 수정자호
             , A.CASHRCP_TYP                                      --23. 현금영수증구분(사용안함)
             , A.CASHRCP_NO                                       --24. 현금영수증 번호(사용안함
             , a.nextup_no                                        --25. 다시서기수첩번호
             , a.holt_no                                          --26.홀트번호
             --, a.for_reg_no                                       --27.외국인 등록번호               
             , DEC_PASSPORT(a.passport_no)                        --27.여권번호          --2012.10.09 신원석 수정 외국인 등록번호 에서 여권번호로 수정
             , a.vir_ssn_yn                                       --28.가상주민번호 여부
             , c.guard_nm                                         --29.보호자명
             , DEC_SSN(c.guard_ssn)                               --30.보호자 주민번호
             , a.inord_cd                                         --31.예외환자코드
             , a.cashrcp_rcpcard                                  --32.현금영수증 카드
             , DEC_SSN(a.cashrcp_ssn)                             --33.현금영수증 주민등록번호
             , a.cashrcp_regnum                                   --34.현금영수증 사업자등로번호
             , a.cashrcp_phone                                    --35.현금영수증 핸드폰번호  
             , a.tel4_no                                          --36.핸드폰번호2 --2011-03-25 권욱주 추가
             , a.pat_memo                                         --37.환자메모    --2011-03-25 권욱주 추가 
             , TO_CHAR(a.reg_edit_dtm ,'YYYY-MM-DD HH24:MI') reg_edit_dtm --38.환자정보 수정일자
             , a.reg_edit_id                                              --39.환자정보 수정자  
             , decode(d.req_type, '1', '뇌병변장애','2','시각장애','3','청각장애'
                                , '4', '정신지체', '5', '신장', '6', '기타' || decode(trim(nvl(d.req_grade_etc, '')), '', '', '(' || d.req_grade_etc || ')'), '')  req_type    --40. 장애유형 --2011-06-14 권욱주 추가, 2011-06-22 김동연(정신지체, 신장, 기타 추가)
             , decode(d.req_grade, '1', '1/2등급', '2', '3등급이하', '')               req_garde   --41. 장애등급 --2011-06-14 권욱주 추가
             , a.trb_yn                                             --42.의료분쟁여부 2011.10.31 신원석추가                               
             , a.sms_yn                                             --43.SMS로만 전송 2012.04.26 silverstone              
             , a.tel3_rl_typ                                        --44. 휴대폰번호1 관계 (공통코드231) 2012.05.21 silvestone 
             , e.csubcd_nm                                          --45. 휴대폰번호1 관계 (공통코드231) 2012.05.21 silvestone 
             , a.tel4_rl_typ                                        --46. 휴대폰번호2 관계 (공통코드231) 2012.05.21 silvestone 
             , f.csubcd_nm                                          --47. 휴대폰번호2 관계 (공통코드231) 2012.05.21 silvestone 
             , a.tel4_add_sms_yn                                    --48. SMS 전송시 휴대폰번호2 전송여부
             , x.national                                           --49. 국적코드
             , g.csubcd_nm                                          --50. 국적명칭
             , (select 'Y' from apinfomt 
                 where pt_no = a.pt_no 
                   and req_yn != 'X')   pt_info_yn                  --51. 개인정보 동의 여부     2012.10.09 신원석 추가  
             , a.BUILDING_NO  
             , a.VIRTUAL_ACC_NO                                     -- 2013.08.13  52.가상계좌번호  
             ,  pkg_bil_common.ft_juso_chk(a.pt_no)					-- 2015.08.03 53.보라매병원 주소여부 
             ,  DEC_SSN(a.real_ssn)  real_ssn                       -- 2015.10.05 신원석 추가 실제 주민번호
             ,  eng_mms_yn                                          -- 2017.08.22 신원석 56.영문문자전송여부 추가 
             ,  stay_status                                         -- 2018.05.03 신원석 57.체류자격 
             ,  to_char(from_stay_dte,'yyyy-mm-dd') from_stay_dte   -- 2018.05.03 신원석 58.체류시작일자
             ,  to_char(to_stay_dte,'yyyy-mm-dd')   to_stay_dte     -- 2018.05.03 신원석 59.체류종료일자  
             ,  case when regexp_like(a.pt_nm2, '^[A-Z]') then a.pt_nm2
                                                          else regexp_replace(a.pt_nm2, '((\(동\))$|[A-Z]$)', '')
                end                                 pt_nm2          --60. 환자명2  2018.11.09 고훈선 추가
             ,  wk_infect_msg                       warn_area_msg   --61.감염확산지역 알림메시지 추가 2020.03.04 김태훈
             ,  (select old_csubcd_nm 
                   from aicodest 
                  where ccd_typ = 'NATIO' 
                    and c_cd    = x.national
                    and use_yn  = 'Y'
                    and rownum  = 1
                )                                   supp_gbn        --62.코로나 지원국가 구분 2020.09.08 김태훈
             ,  (select z.pt_no
                   from appatbat z
                  where z.ssn1  = a.ssn1
                    and z.ssn2  = a.ssn2
                    and z.pt_no <>a.pt_no
                    and rownum  =1)                   pt_no1        --63.폐기되지않은 환자번호                    
          FROM APPATBAT A
             , CCPOSTMT B
             , appatprt c 
             , (select * from appatjant where cncl_dte is null) d
             , cccodest e
             , cccodest f 
             , apihspat x
             , cccodest g
         where a.pt_no    = in_pt_no
           and a.zip_no   = b.zip_no(+)
           and a.zip_seq  = b.zip_seq(+)
           and c.pt_no(+) = a.pt_no
           --오동현 추가 : 보호인(2) 부모(3) 조건 추가
           and c.guard_typ(+) = '2'     -- 23i 
           and c.pt_rl_typ(+) = '3'     -- 203
           and a.pt_no = d.pt_no(+)
           and e.ccd_typ (+)= '203'
           and e.c_cd    (+)= a.tel3_rl_typ 
           and f.ccd_typ (+)= '203'
           and f.c_cd    (+)= a.tel4_rl_typ
           and x.pt_no   (+)= a.pt_no
           and g.ccd_typ (+)= '347'
           and g.c_cd    (+)= x.NATIONAL
           ;
    out_cursor := wk_cursor
    exception
        when others then
            raise_application_error(-20500,'pc_ap_appatbat_select: 환자기본정보 조회중 오류 발생하였습니다' || chr(13) || sqlcode || chr(13) || sqlerrm)
end pc_ap_appatbat_select;
```