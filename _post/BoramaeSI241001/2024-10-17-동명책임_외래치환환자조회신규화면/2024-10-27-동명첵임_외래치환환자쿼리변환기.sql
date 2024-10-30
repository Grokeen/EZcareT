





select 	  rownum    								                    	as NO		   	--00.No.
					, a.PT_NO              					                as PT_NO		--01.환자번호
					, b.PT_NM									                      as PT_NM		--02.환자명
					, to_char(c.ADS_DT, 'yyyy-mm-dd')			          as <<PACT_ID | ADS_DT>>		--03.입원일자
					, d.<<SUB_MED_DEPT_CD | MED_DEPT_CD>>						as <<SUB_MED_DEPT_CD | MED_DEPT_CD>>		--04.진료과    
					
					
					, pkg_bil_common.FC_UserNameSel(nvl(d.<<CHDR_SID | CHDR_STF_NO>>,<<NCDR_SID | NCDR_STF_NO>>))|| '(' ||nvl(d.<<CHDR_SID | CHDR_STF_NO>>,<<NCDR_SID | NCDR_STF_NO>>)||')'
																as med_dr		--05.진료의
					, decode(d.APCN_DTM, null, 'N', 'Y')		as cncl_yn		--06.취소상태
					, nvl(c.PRO_YN, 'N')					as emr_yn		--07.EMR작업완료여부
					, to_char(a.INPT_DT, 'yyyy-mm-dd')   		as INPT_DT 		--08.작업시작일시
					, to_char(a.<<CMPL_PRO_DTM | PRO_YN>>, 'yyyy-mm-dd')  		as <<CMPL_PRO_DTM | PRO_YN>>		--09.원무완료일시
					, pkg_bil_common.FC_UserNameSel(a.CMPL_PRO_STF_NO)  	as CMPL_PRO_STF_NO		--10.처리완료자
					, c.CTN_CNTE           							as CTN_CNTE			--11.비고
					, a.CTN_CNTE        					as CTN_CNTE	--12.체크리스트 내용 
					
					
				from  ACPPRRDE  a   --체크리스트
					, <<ACPPIYKD | PCTPCPTD | PCTPCPAM | PCTPCPAH | MSQSCPMD | MSELMCMD | MSCTDTRD | MRDDRGCM | MOMNMVID | BPMOTRAD | BPMOTDAD | BPMOTBDD | ACPPRGHH | ACPPRGHD | ACPPRDCD | ACPPRAAM | ACPPRAAH>> 	b   --환자기본정보
					, ACPPRRDE c   --입원취소외래치환
					, <<ACPPIYKD | MSTRHODM | MSQSCNSD | MSMRREOD | MSMRANDD | MSMRADCM | ACPPRTSD | ACPPRAAM>> 	d 	--입원접수       
					
					
				where a.PT_INSP_LIST_CLS_CD = '23' --체크유형(23 :입원->외래치환)
					and (
	                        (a.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>> = in_pt_no)
	                    or	(nvl(in_pt_no,'*') = '*')
	                    )
					and INPT_DT between v_from_dte and v_to_dte + .99999
					and a.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>> 	= b.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>>
					and c.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>> 	= a.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>>
					and c.pt_chk_no = a.pt_chk_no -- **환자체크번호
					and d.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>>		(+)= c.<<ADS_NOTM | <<<<PT_NO | PACT_ID>> | CTN_CNTE_TITL>>>>
					and d.<<PACT_ID | ADS_DT>>	(+)= c.<<PACT_ID | ADS_DT>>
					and (
	                        (in_endyn = 'Y' and a.<<CMPL_PRO_DTM | PRO_YN>>  is not null)
	                    or  (in_endyn = 'N' and a.<<CMPL_PRO_DTM | PRO_YN>>  is null)
	                    or  (nvl(in_endyn,'*') = '*')
	                    )
	                and (
	                        (nvl(c.PRO_YN, 'N') = in_emryn)
	                    or  (nvl(in_emryn,'*') = '*')
	                    )
	            order by a.INPT_DT
