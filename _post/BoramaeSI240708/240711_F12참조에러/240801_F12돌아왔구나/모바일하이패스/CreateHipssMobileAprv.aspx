<%@ Page Language="C#" AutoEventWireup="false"  CodeFile="CreateHipssMobileAprv.aspx.cs" Inherits="OCALS_CreateHipssMobileAprv" %>

    <!--***********************************
        HTML작성자 : 두미진 2009.07.10
     ***********************************-->   

<html>
    <head>
    <title><%=BIL_PAM_TITLE %>모바일 하이패스 승인</title> 
   	<%=BIL_SCRIPTS_BLOCK %>
	  <script type='text/javascript' language='javascript'  src='/BIL/SCRIPTS/Rexpert.js'></script>
	  <object id="KSNet_Dongle"  classid="CLSID:083E9506-4F78-4E7C-9A3C-F2A1CB8BC876" codebase="KSNet_Dongle.ocx"></object>      

        <script language="vbscript">
        
        Option Explicit
        
        Dim gsToday
        Dim gsDsvcUrl

        gsToday      = Left(fnGetSysDateTime(), 10)
        gsDsvcUrl    = "../CALS_DSVC.aspx"
        Dim gsSuccess, gsFail,gsGubun
        Dim oClient, sUrl
        Set oClient = CreateObject("IsrRap.CssIsrRap")

        '--Spread
        Const   HP_SEL          =   01  '-- 01.


        '==========================================================================================
        ' Function  명     : Form_Load()
        ' 내        용     : 페이지 로드시 이벤트 발생
        ' 작   성   자     : 오동현
        ' 최초  작성일     : 2009.05.27
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================

        Sub Form_Load()
        
            '모든 컨트롤 비활성화
            Call fnSetDisableControl(document.all)
            
            Call fnEnableControls(Array(TxtFromDte, BtnR_Search, Btn_Close, BtnFromDte, _
                                        TxtToDte, BtnToDte,ChkAprvY,ChkAprvN ,ChkAprvX,BtnClear))
            
            TxtFromDte.value = gsToday 
            TxtToDte.value   = gsToday 
   
            
            Call InitSpread()          

            Call fnDisableControls(Array(BtnATalk,BtnApproval,BtnCancle )) 

            ChkAprvY.checked = false
            ChkAprvN.checked = false
            ChkAprvX.checked = false

        End Sub
        
        
        
        '==========================================================================================
        ' Function  명     : Form_UnLoad()
        ' 내        용     : 페이지 종료시 이벤트 발생
        ' 작   성   자     : 오동현
        ' 최초  작성일     : 2009.05.27
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================        
        Sub Form_UnLoad()
        
        End Sub
	        
        '==========================================================================================
        ' Function  명     : InitSpread()
        ' 내        용     : 스프래드 초기화
        ' 작   성   자     : 오동현
        ' 최초  작성일     : 2009.06.12
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================	        
	    Sub InitSpread()
	    
	        Dim arrHeaders, arrColWidths, arrColTypes, arrHstyles ,arrTexts

            arrHeaders   = Array (" "          ,"신청일자"       ,"환자번호"   ,"환자명"           ,"주민번호"   ,"승인여부"    ,"환자급종"  ,"주민등록번호" ,"핸드폰번호" ,"토큰번호", _
                                  "시작일자"   ,"종료일자"       ,"카드회사"   ,"카드명의자"       ,"카드번호")
            arrColWidths = Array (   3         ,10               ,10           ,10                 ,12           ,   22         ,10          ,       0       ,   0         ,   0,       _
                                     10        ,10               ,15           ,10                 ,15) 
            arrColTypes  = Array (   10        ,5                ,5            ,5                  ,5            ,   5          ,5           ,        5      ,   5         ,   5,       _
                                     5         ,5                ,5            ,5                  ,5) 
            arrHStyles   = Array (   2         ,2                ,2            ,2                  ,2            ,   2          ,2           ,        2      ,   2         ,   2,       _
                                     2         ,2                ,2            ,2                  ,2)

                                               
            Call fnInitSpread(Spread, arrHeaders, arrColWidths, arrColTypes, arrHStyles, arrTexts , True, False, 0, 0, 0, False, True, False, 4, 9, 9, 14, 19, 1)
           
	       '스프레드 객체 생성
            Spread.ReDraw     = True
            Spread.Lock       = True

	    End Sub
	    

       
        '==========================================================================================
        ' Function  명     : Spread_DblClick(ByVal Col, ByVal Row)
        ' 내        용     : 스프레드 더블클릭 이벤트
        ' 작   성   자     : 김승기
        ' 최초  작성일     : 2007. 05. 21
        ' Input Parameter  :
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================     
       
        Sub Spread_DblClick(ByVal iCol, ByVal iRow)
            
            Dim sPatSite
            Dim sRcpYn ,sCheck
            Dim sPtNo
                
            If sCheck = "" Then
                sCheck = 1    
            ElseIf sCheck = 0 Then
                sCheck = 1
            Else
                sCheck = 0
            End If 
        
            
        End Sub
        '==========================================================================================
        ' Function  명     : Spread_Click(ByVal Col, ByVal Row)
        ' 내        용     : 스프레드 클릭 이벤트
        ' 작   성   자     : 김승기
        ' 최초  작성일     : 2007. 05. 21
        ' Input Parameter  :
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================

        Sub Spread_Click(ByVal Col, ByVal Row)
            
            Dim sCheck
            Dim sAprvyn
            Dim i
            
            If Spread.MaxRows = 0 then Exit Sub

            If Col <> HP_SEL then Exit Sub
            
            Call Spread.GetText(6, Spread.ActiveRow, sAprvyn)  '승인여부

            if sAprvyn ="N (모바일본인요청삭제)" then 
                Call fnShowXmlMessageBox("MPAM00000", "본인요청에 의해 삭제된 환자입니다.", MSG_TYPE_NONE) 
                sCheck = 0
                Exit Sub
            end if

            Call Spread.GetText(HP_SEL, Row, sCheck )
                        
            If sCheck = "" Then
                sCheck = 1    
            ElseIf sCheck = 0 Then
                sCheck = 1
            Else
                sCheck = 0
            End If        
         
                        
        End Sub
        

        Sub Btn_Close_OnClick()
    
            window.close()
                
        End Sub
        
        '==========================================================================================
        ' Function  명  : fnNvl(sValue)
        ' 내     용  : , 삭제Null -> 0  숫자형으로변환
        ' 작성자  : 오동현
        ' 최초작성일  : 2009. 09. 01
        ' Input Parameter  :
        ' Return Value     :
        ' 수정내역  :
        '==========================================================================================
        Function fnNvl(sValue)
            
            sValue = Replace(sValue, "," ,"")
            
            If Trim(sValue) = "" Then
                sValue = "0"
            End If
            
            fnNvl = CDbl(sValue)
            
        End Function



'        '====================================================================================
'        'Function 명        : BtnSmsTrs_OnClick()
'        '내       용        : SMS 발송
'        '작  성  자         : 이종원
'        '최초 작성일        : 2010.04
'        'Input Parameter    : 
'        'Return Value       : 
'        '수정 내역          : 
'        '====================================================================================
'        Sub BtnSmsTrs_OnClick()
'            
'            Dim sChk,sPtno,sPtnm,sAprvyn ,sSsn,sTelNo,sSmsMsg ,sConTelno

'                Call Spread.GetText(1, Spread.ActiveRow, sChk)     '체크여부
'                Call Spread.GetText(3, Spread.ActiveRow, sPtno)    '환자번호
'                Call Spread.GetText(4, Spread.ActiveRow, sPtnm)    '환자명
'                Call Spread.GetText(6, Spread.ActiveRow, sAprvyn)  '승인여부
'                Call Spread.GetText(8, Spread.ActiveRow, sSsn)     '주민번호 
'                Call Spread.GetText(9, Spread.ActiveRow, sTelNo)   '핸드폰번호
'                
'                if sChk = "1" then
'            
'                    sConTelno ="02-870-2742"  

'                    if sAprvyn = "Y" then 
'                         sSmsMsg  = "모바일 하이패스 가입 승인 되었습니다. 문의사항은 02-870-2742로 연락 주시기 바랍니다. 감사합니다."& vbcrlf & _ 
'"*모바일 하이패스 가입 기념품(치약, 칫솔 세트)을 증정하고 있으니, 희망관 1층 안내데스크에서 수령하여 주시기 바랍니다.-서울특별시 보라매병원-"     
'                    else
'                         sSmsMsg  = "모바일 하이패스 가입 미승인 되었습니다. 하이패스 가입은 건강보험환자만 가입이 가능합니다. 문의사항은 02-870-2742로 연락 주시기 바랍니다. 감사합니다. -서울특별시 보라매병원-"
'                    end if

'                    Call fnShowModalDialog( "/BIL/Acc/Ptrs/Oprsv/CreateSmsTrs.aspx?sParam="    & sPtno  & DLM_COL & _
'                                                                                                 sPtnm  & DLM_COL & _
'                                                                                                 sTelNo & DLM_COL & _
'                                                                                                 sSsn & DLM_COL & _
'                                                                                                 sSmsMsg & DLM_COL & _
'                                                                                                 Replace(sConTelno,"-","") & DLM_COL & _
'                                                                                                 "" & DLM_COL & _
'                                                                                                 "O" _  
'                                                                                , window _
'                                                                                , Array(500,400,750,124), gsModalFeatures)
'                end if
'            
'        End Sub
        '====================================================================================
        'Function 명        : BtnATalk_OnClick
        '내       용        : 알림톡 발송
        '작  성  자         : 김선화
        '최초 작성일        : 2023.03.06
        'Input Parameter    : 
        'Return Value       : 
        '수정 내역          : 
        '====================================================================================
        Sub BtnATalk_OnClick()

        
            Dim sChk,sPtno,sPtnm,sAprvyn ,sSsn,sTelNo,sSmsMsg ,sConTelno , sXml,sReturn ,sTmplCd ,sSubJect,sDate

                Call Spread.GetText(1, Spread.ActiveRow, sChk)     '체크여부
                Call Spread.GetText(3, Spread.ActiveRow, sPtno)    '환자번호
                Call Spread.GetText(4, Spread.ActiveRow, sPtnm)    '환자명
                Call Spread.GetText(6, Spread.ActiveRow, sAprvyn)  '승인여부
                Call Spread.GetText(8, Spread.ActiveRow, sSsn)     '주민번호 
                Call Spread.GetText(9, Spread.ActiveRow, sTelNo)   '핸드폰번호
                sDate = Left(Replace(Replace(Replace(fnGetSysDateTime,"-",""),":","")," ",""),12)
                if sChk = "1" then
'            
                    sConTelno ="02-870-2742"   
                    if sAprvyn = "Y" then 
                         sTmplCd  ="AP0122"
                         sSubJect = "모바일 하이패스 가입요청 승인 환자"
                         sSmsMsg  = "모바일 하이패스 가입이 승인되었습니다.가입 기념품(치약, 칫솔 세트)을 증정하고 있으니, 희망관 1층 안내데스크에서 수령하여 주시기를 바랍니다.감사합니다."     
                    else
                         sTmplCd  ="AP0121"
                         sSubJect = "모바일 하이패스 가입요청 미승인 환자"
                         sSmsMsg  = "모바일 하이패스 가입이 미승인 되었습니다.의료급여 환자 및 차상위 환자분은 실시간 공단 자격 확인을 위해 수납 창구 이용 부탁드립니다.문의 사항은 02-870-2742로 연락 주시기 바랍니다.감사합니다."
                    end if

                    sXml = sXml & fnMakeXml(Array( "pkg_bil_sms.pc_ap_atalk_msg_insert" _
                                                    , BIL_PKG _
                                                    , BIL_ID _
                                                    , EXE_TYPE_NONQUERY _
                                                    , sTmplCd _    
                                                    , "" _         
                                                    , sTelNo _     
                                                    , sSmsMsg _   
                                                    , sConTelno _  
                                                    , sDate _      
                                                    , sSubJect _   
                                                    , sSmsMsg _    
                                                    , sPtno _
                                                    , sPtnm _
                                                    , sSsn _
                                                    , C_WKPERS _
                                                    , "01"  )) 
                    sReturn = fnServiceCall(CALL_TYPE_NONECOMTX, "/BIL/ACC/PTRS/PTRS_DSVC.aspx", sXml, "", "", false, RET_TYPE_STR)

                    If gbErrorCatch Then
                        Exit Sub
                    End if

'            
                    Call fnShowXmlMessageBox ("MPAM00004", "전송완료", MSG_TYPE_AUTO)
           end if

        End Sub            

        '==========================================================================================
        ' Function  명     : BtnR_Search_OnClick()
        ' 내        용     : 모바일 하이패스 승인 조회
        ' 작   성   자     : 김선화
        ' 최초  작성일     : 2022.01.05
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================
                    
                
        Sub BtnR_Search_OnClick()
        
            Dim sXml,arrResult ,sAprvYn
            Dim i  

            Spread.MaxRows = 0


            Call fnDisableControls(Array(BtnATalk,BtnApproval,BtnCancle))   
            
            if ChkAprvY.checked =true and  ChkAprvN.checked = true and  ChkAprvX.checked = true  then 
                sAprvYn ="A"
            elseif ChkAprvY.checked =true and  ChkAprvN.checked = false and  ChkAprvX.checked = false   then 
                sAprvYn ="Y"
            elseif ChkAprvY.checked =false and  ChkAprvN.checked = true and  ChkAprvX.checked = false   then 
               sAprvYn ="N"
            elseif ChkAprvY.checked =false and  ChkAprvN.checked = false and  ChkAprvX.checked = true   then 
               sAprvYn ="X"
            else
                sAprvYn ="A"   
            end if

            sXml = fnMakeXml(Array("pkg_bil_ocals.pc_ap_HipssMobileAprvList",_
                                   BIL_PKG,_
                                   BIL_ID,_
                                   EXE_TYPE_FILL,_              
                                   Replace(TxtFromDte.value, "-", "") ,_
                                   Replace(TxtToDte.value, "-", "") ,_
                                   sAprvYn ,_
                                   ""))
            
                               
	        Call fnSetIECursor(True)                       
            arrResult = fnServiceCall(CALL_TYPE_GET, gsDsvcUrl, sXml, "", "", False, RET_TYPE_STR)
            Call fnSetIECursor(False)
            
            If gbErrorCatch Then : Exit Sub
            
            If Len(arrResult) = 0 Then
                Call fnShowXmlMessageBox("MPAM00115", "", MSG_TYPE_NONE)
                Exit Sub
            end if 

            arrResult = fnMakeArray(arrResult)
                
            If Ubound(arrResult) < 0 Then : Exit Sub

            With Spread
                
                For i = 0 To Ubound(arrResult(0))

                    .MaxRows = .MaxRows + 1
                        
                    .SetText   1, .MaxRows, arrResult(0)(i,  0)  '체크박스
                    .SetText   2, .MaxRows, arrResult(0)(i,  1)  '신청일자
                    .SetText   3, .MaxRows, arrResult(0)(i,  2)  '환자번호
                    .SetText   4, .MaxRows, arrResult(0)(i,  3)  '환자명
                    .SetText   5, .MaxRows, arrResult(0)(i,  4)  '주민번호
                    .SetText   6, .MaxRows, arrResult(0)(i,  5)  '승인여부
                    .SetText   7, .MaxRows, arrResult(0)(i,  6)  '환자급종
                    .SetText   8, .MaxRows, arrResult(0)(i,  7)  '주민번호
                    .SetText   9, .MaxRows, arrResult(0)(i,  8)  '핸드폰번호
                    .SetText   10, .MaxRows, arrResult(0)(i, 9)  '토큰번호
                    .SetText   11, .MaxRows, arrResult(0)(i, 10) '시작일자
                    .SetText   12, .MaxRows, arrResult(0)(i, 11) '종료일자
                    .SetText   13, .MaxRows, arrResult(0)(i, 12) '카드회사
                    .SetText   14, .MaxRows, arrResult(0)(i, 13) '카드명의자
                    .SetText   15, .MaxRows, arrResult(0)(i, 14) '카드번호

                    '공단자격조회 
                    Call ActSend_Search( arrResult(0)(i,  2), arrResult(0)(i,  3) , arrResult(0)(i,  6))

                Next
                
            End With    

             Call fnEnableControls(Array(BtnATalk, BtnApproval, BtnCancle, BtnExcel,BtnClear ))
        End Sub

        '==========================================================================================
        ' Function  명     : BtnApproval_OnClick()
        ' 내        용     : 모바일 하이패스 원무과 승인
        ' 작   성   자     : 김선화
        ' 최초  작성일     : 2022.01.05
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================
 
        Sub BtnApproval_OnClick()

            Dim sXml, sResponseText, arrResult

            Dim sChk,sPtno,sfstinstdte ,sToken_noskp

            Call Spread.GetText(1, Spread.ActiveRow, sChk)            '체크여부
            Call Spread.GetText(2, Spread.ActiveRow, sfstinstdte)     '신청일자
            Call Spread.GetText(3, Spread.ActiveRow, sPtno)           '환자번호
            Call Spread.GetText(10, Spread.ActiveRow, sToken_noskp)    '토큰번호

            if sChk = "1" then 
                If fnShowXmlMessageBox("MPAM00000", "하이패스 승인 하시겠습니다?", MSG_TYPE_YESNO) = 6 Then

                  sXml = fnMakeXml(Array("pkg_bil_ocals.pc_ap_HipssMobileAprv_Upd",_
			                               BIL_PKG           , _
			                               BIL_ID            , _
                                           EXE_TYPE_NONQUERY ,_
                                           "Y"               , _
                                           sPtno             , _
                                           sfstinstdte       , _
                                           sToken_noskp      , _
                                           C_WKPERS))
             
                    Call fnSetIECursor(True)                       
                    sResponseText = fnServiceCall(CALL_TYPE_SET, gsDsvcUrl, sXml, "", "", False, RET_TYPE_STR)
                    Call fnSetIECursor(False) 
                    Call fnShowXmlMessageBox("MPAM00000","하이패스 승인 완료 되었습니다.", MSG_TYPE_NONE)
                    If gbErrorCatch Then : Exit Sub
                end if
                call BtnR_Search_OnClick()
            end if


        End Sub

        '==========================================================================================
        ' Function  명     : BtnCancle_OnClick()
        ' 내        용     : 모바일 하이패스 원무과 승인취소
        ' 작   성   자     : 김선화
        ' 최초  작성일     : 2022.01.05
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================
 
        Sub BtnCancle_OnClick()

            Dim sXml, sResponseText, arrResult

            Dim sChk,sPtno,sfstinstdte ,sToken_noskp

            Call Spread.GetText(1, Spread.ActiveRow, sChk)            '체크여부
            Call Spread.GetText(2, Spread.ActiveRow, sfstinstdte)     '신청일자
            Call Spread.GetText(3, Spread.ActiveRow, sPtno)           '환자번호
            Call Spread.GetText(10, Spread.ActiveRow, sToken_noskp)    '토큰번호

            if sChk = "1" then 
                If fnShowXmlMessageBox("MPAM00000", "하이패스 승인 취소 하시겠습니다?", MSG_TYPE_YESNO) = 6 Then

                  sXml = fnMakeXml(Array("pkg_bil_ocals.pc_ap_HipssMobileAprv_Upd",_
			                               BIL_PKG           , _
			                               BIL_ID            , _
                                           EXE_TYPE_NONQUERY ,_
                                           "N"               , _
                                           sPtno             , _
                                           sfstinstdte       , _
                                           sToken_noskp      , _
                                           C_WKPERS))
             
                    Call fnSetIECursor(True)                       
                    sResponseText = fnServiceCall(CALL_TYPE_SET, gsDsvcUrl, sXml, "", "", False, RET_TYPE_STR)
                    Call fnSetIECursor(False) 
                    Call fnShowXmlMessageBox("MPAM00000","하이패스 승인 취소 완료되었습니다.", MSG_TYPE_NONE)
                    If gbErrorCatch Then : Exit Sub
                end if
                call BtnR_Search_OnClick()
            end if


        End Sub

        '==========================================================================================
        ' Function  명     : ActSend_Search()
        ' 내        용     : 심평원으로 부터 수진자의 자격 내역을 조회하는 함수
        ' 작   성   자     : 문지훈
        ' 최초  작성일     : 2009.07.23
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================
        function ActSend_Search(sPtno,sPtNm,sSsnNo)
            
            Dim sResult, arrResult,sXml,sResponseText, sFromDate, sToDate, sPat 

            Dim sDsvcUrl : sDsvcUrl = "../../PTRS/PTRS_DSVC.aspx" 

            '요양기간 자격 테스트 서버(차후 NHIC_HSP_REAL_URL 로변경)  NHIC_HSP_DEV_URL
            
            Call fnWkpersSSN()

            'sUrl = NHIC_HSP_DEV_URL     '개발기 꼭풀기
            sUrl = NHIC_HSP_REAL_URL    '운영기 
            sResult = oClient.ConFirm(sUrl, _
                                      "M1", _
                                      Replace(sSsnNo,"-",""), _
                                      NHIC_HSP_NO, sPtNm, _
                                      Replace(gsToday,"-",""), _
                                      "127.0.0.1", _
                                      NHIC_HSP_ID, _
                                      NHIC_HSP_PASSWORD, _
                                      gsToday, _
                                      C_SSN)    
'                                                                   
'            '=====================================================================================================================================================================================================================
'            ' 2008-11-07
'            ' 요양기관번호  : 38100509, ID  : csb5426 , PASSWORD    : dlaehddn1
'            '=====================================================================================================================================================================================================================
'            '                         URL   ??    주민등록번호                          요양기관번호  환자성명         기준일자(현재일자)      ip           ID           PASSWORD           현재일자 주민등록번호
'            '=====================================================================================================================================================================================================================
'            

            If Len(sResult) = 0 Then : Exit function
            If sResult = "Err : 송신에러" Then
'                fnShowMsgbox sResult, MSG_TYPE_NONE       '시간전약을 위해 메세지 안뿌려줌.
                gsFail = gsFail + 1
                Exit function
            End If
            
            sResult   = Replace(sResult,"|^|",DLM_TAB)
            sResult   = Replace(sResult,"|~|",DLM_ROW)
            sResult   = Replace(sResult,"|_|",DLM_COL)
            
            '환자번호 00045041 환자 알수 없는 "|~|" 구분자 있음....
            sResult   = Replace(sResult,DLM_ROW,"")
            
            
            arrResult = fnMakeArray(sResult)


            '--------------------------------------------------------------------
            ' 에러시 자격에 저장/업데이트 하지 않고, 최근 등록된 자격을 조회한다.
            ' 2010-10-18 권욱주 : 중간에 화상 자격 끼어들면서 증가
            ' 2011-07-01 권욱주 : 중간에 당뇨병 자격 끼어들면서 증가 33 -> 34
            ' 2011-08-01 김동연 : 중간에 동일성분 의약품 제한자 자격 끼어들면서 증가 34 -> 35
            ' 2012-07-01 김선화 : 중간에 노인틀니대상자 상악/하악 자격 끼어들면서 증가 35 -> 37
            ' 2015-01-01 김선화 : 중간에 산정특례(결핵)등록대상자 증가 42->43  
            ' 2015-10-01 김선화 : 중간에 장애여부추가 증가 43->44 
            ' 2015-12-16 김선화 : 중간에 당뇨병 요양비 대상자 유형추가 증가 44->45
            ' 2016-03-24 김선화 : 중간에 산정특례(극희귀)등록대상자 유형추가 증가 45->46
            ' 2016-03-24 김선화 : 중간에 산정특례(상세불명희귀)등록대상자 유형추가 증가 46->47
            ' 2017-02-07 김선화 : 중간에 조산아 유형추가 증가 47->48 
            ' 2017-07-03 김선화 : 요양기관별 산정특례(결핵)등록대상자 추가 48->49 
            ' 2017-07-03 김선화 : 산정특례(중복암)등록대상자2 추가  증가   49->50  
            ' 2017-07-03 김선화 : 산정특례(중복암)등록대상자3 추가  증가   50->51 
            ' 2017-07-03 김선화 : 산정특례(중복암)등록대상자4 추가  증가   51->52 
            ' 2017-07-03 김선화 : 산정특례(중복암)등록대상자5 추가  증가   52->53 
            ' 2017-10-10 신원석 : 산정특례(중증치매)등록대상자 추가        53->54 
            ' 2018-12-17 신원석 : 산정특례(중증난치)등록대상자 추가        54->55 
            ' 2018-12-17 신원석 : 산정특례(기타염색체)등록대상자 추가      55->56                                                        
            ' 2019.08.26 김선화 : 국적구분 추가                            56->57                                                        
            ' 2019.10.22 김선화 : 요양병원 입원여부 추가                   57->58   
            ' 2020.01.22 김선화 : 요양병원 기관기호 추가                   58->59
            ' 2021.06.22 김선화 : 산정특례(잠복결핵)등록대상자 추가        59->60
            '--------------------------------------------------------------------          
            If  Trim(arrResult(0)(0, 60)) = "IWS10001" Or Trim(arrResult(0)(0, 60)) = "IWS20002" Or Trim(arrResult(0)(0, 60)) = "IWS30003" Then 

		        ' 값에 이상이 없을 시
		        '2010-10-18 권욱주 : 화상환자 자격조회      arrResult(0)(0, 29) 삽입
		        '2011-07-01 권욱주 : 제1 당뇨병환자대상     arrResult(0)(0, 30) 삽입
		        '2011-08-01 김동연 : 동일성분 의약품 제한자 arrResult(0)(0, 31) 삽입
		        '2012-07-01 김선화 : 노인틀니대상자 상악    arrReturn(0)(0, 32) 삽입
		        '2012-07-01 김선화 : 노인틀니대상자 하악    arrReturn(0)(0, 33) 삽입
		        '2015-01-01 김선화 : 산정특례(결핵)등록대상자   arrReturn(0)(0, 39) 삽입
		        '2015-10-01 김선화 : 장애여부                   arrReturn(0)(0, 40) 삽입
		        '2015-12-16 김선화 : 당뇨병 요양비 대상자 유형  arrReturn(0)(0, 41) 삽입
		        '2016-03-24 김선화 : 산정특례(극희귀)등록대상자 유형  arrReturn(0)(0, 42) 삽입  
		        '2016-03-24 김선화 : 산정특례(상세불명희귀)등록대상자 유형  arrReturn(0)(0, 43) 삽입
		        ' 2017-02-07 김선화 : 중간에 조산아 유형추가 증가 47->48 
                '2017-07-03 김선화 : 요양기관별 산정특례(결핵)등록대상자  arrReturn(0)(0, 45) 삽입 
                '2017-07-03 김선화 : 산정특례(중복암)등록대상자2  arrReturn(0)(0, 46) 삽입 
                '2017-07-03 김선화 : 산정특례(중복암)등록대상자3  arrReturn(0)(0, 47) 삽입 
                '2017-07-03 김선화 : 산정특례(중복암)등록대상자4  arrReturn(0)(0, 48) 삽입 
                '2017-07-03 김선화 : 산정특례(중복암)등록대상자5  arrReturn(0)(0, 49) 삽입
                '2017-10-10 신원석 : 산정특례(중증치매)등록대상자 arrReturn(0)(0, 50) 삽입
                '2018-12-17 신원석 : 산정특례(중증난치)등록대상자 arrReturn(0)(0, 51) 삽입      
                '2018-12-17 신원석 : 산정특례(염색체)등록대상자   arrReturn(0)(0, 52) 삽입                		         		         	            			        
                '2019.08.26 김선화 : 국적구분 추가                arrReturn(0)(0, 53) 삽입            		         		         	            			        
                '2019.10.22 김선화 : 요양병원 입원여부 추가       arrReturn(0)(0, 54) 삽입 
                '2020.01.22 김선화 : 요양병원 기관기호 추가       arrReturn(0)(0, 55) 삽입
                '2021.06.22 김선화 : 산정특례(잠복결핵)등록대상자 arrReturn(0)(0, 56) 삽입
                sXml = fnMakeXml(Array ( "pkg_bil_srimd.pc_ap_insurance_dll" _
                                       , BIL_PKG _
                                       , BIL_ID _
                                       , EXE_TYPE_NONQUERY _
                                       , sPtno             _
                                       , arrResult(0)(0,  4) _
                                       , arrResult(0)(0,  6) _
                                       , arrResult(0)(0,  7) _
                                       , arrResult(0)(0,  8) _
                                       , arrResult(0)(0,  9) _
                                       , arrResult(0)(0, 10) _
                                       , arrResult(0)(0, 11) _
                                       , arrResult(0)(0, 12) _
                                       , arrResult(0)(0, 13) _
                                       , arrResult(0)(0, 14) _
                                       , arrResult(0)(0, 15) _
                                       , arrResult(0)(0, 16) _
                                       , arrResult(0)(0, 17) _
                                       , arrResult(0)(0, 18) _
                                       , arrResult(0)(0, 19) _
                                       , arrResult(0)(0, 20) _
                                       , arrResult(0)(0, 21) _
                                       , arrResult(0)(0, 22) _
                                       , arrResult(0)(0, 23) _
                                       , arrResult(0)(0, 24) _
                                       , arrResult(0)(0, 25) _
                                       , arrResult(0)(0, 26) _
                                       , arrResult(0)(0, 27) _
                                       , arrResult(0)(0, 28) _
                                       , arrResult(0)(0, 29) _
                                       , arrResult(0)(0, 30) _
                                       , arrResult(0)(0, 31) _
                                       , arrResult(0)(0, 32) _
                                       , arrResult(0)(0, 33) _
                                       , arrResult(0)(0, 34) _                                        
                                       , arrResult(0)(0, 35) _
                                       , arrResult(0)(0, 36) _   
                                       , arrResult(0)(0, 37) _
                                       , arrResult(0)(0, 38) _   
                                       , arrResult(0)(0, 39) _     
                                       , arrResult(0)(0, 40) _     
                                       , arrResult(0)(0, 41) _     
                                       , arrResult(0)(0, 42) _              <%//38.산정특례(극희귀)등록대상자%>            
                                       , arrResult(0)(0, 43) _              <%//39.산정특례(상세불명희귀)등록대상자%>
                                       , arrResult(0)(0, 44) _              <%//40.조산아등록대상자%>
                                       , arrResult(0)(0, 45) _              <%//41.요양기관별 산정특례(결핵)등록대상자%>
                                       , arrResult(0)(0, 46) _              <%//42.산정특례(중복암)등록대상자2%>
                                       , arrResult(0)(0, 47) _              <%//43.산정특례(중복암)등록대상자3%>
                                       , arrResult(0)(0, 48) _              <%//44.산정특례(중복암)등록대상자4%>
                                       , arrResult(0)(0, 49) _              <%//45.산정특례(중복암)등록대상자5%>                                                                                                                                  
                                       , arrResult(0)(0, 50) _              <%//46.산정특례(중증치매)등록대상자%>
                                       , arrResult(0)(0, 51) _              <%//47.산정특례(중증난치)등록대상자%>
                                       , arrResult(0)(0, 52) _              <%//48.산정특례(염색체)등록대상자%>
                                       , arrResult(0)(0, 53) _              <%//49.국적구분 추가 %>
                                       , arrResult(0)(0, 54) _              <%//50.요양병원 입원여부 추가 %>
                                       , arrResult(0)(0, 55) _              <%//51.요양병원 기관기호 추가 %>
                                       , arrResult(0)(0, 56) _              <%//52.산정특례(잠복결핵)등록대상자 %>
                                       , arrResult(0)(0, 58) _              <%//53.산전지원금잔액%>
                                       , arrResult(0)(0, 59) _              <%//54.데이터입력일시%>
                                       , ""                  _              <%//55.요양기관처리여부%>
                                       , arrResult(0)(0, 60) _              <%//56.결과메시지코드%>
                                       , arrResult(0)(0, 61) _              <%//57.결과메시지%>
                                       , arrResult(0)(0, 62) _              <%//58.메시지타입%>
                                       , arrResult(0)(0, 63) _              <%//59.화면클라이언트고유값%>
                                       , arrResult(0)(0, 64) _              <%//60.담당자주민등록번호%>
                                       , "" _                               <%//61.프로그램구분%>
                                       , "" _                               <%//62.DLL버젼%>
                                       , C_WKPERS _                         <%//63.작업자ID%>
                                       , "" _                               <%//64.급여자격번호%> 
                                       , Replace(gsToday,"-","") ))  'silverstone 20120515 자격조회
                
                sResponseText = fnServiceCall(CALL_TYPE_SET, sDsvcUrl, sXml, "", "", False, RET_TYPE_STR)
                
                If gbErrorCatch Then : Exit function
                
                gsSuccess = gsSuccess + 1
                
                If Len(sResponseText) = 0 Then : Exit function
                                       
            Else
                gsFail = gsFail + 1  
            End If


        End function
        
        Sub BtnFromDte_OnClick()
            Call fnOpenCalWithCtrl(TxtFromDte, "TxtFromDte")
            Call TxtFromDte_OnKeyUp()
        End Sub
        
        Sub TxtFromDte_OnKeyUp()
    
            ' ←↑→↓ Del BackSpace  통과
            If window.event.keyCode = LEFTKEY Or window.event.keyCode = UPKEY Or window.event.keyCode = RIGHTKEY Or window.event.keyCode = DOWNKEY Or window.event.keyCode = DELKEY Or window.event.keyCode = BACKSPACEKEY  Then : Exit Sub
            If Len(TxtFromDte.value) > 1 then
                Call fnMakeDate(TxtFromDte)
            End If    
           
        End Sub
        
        Sub TxtFromDte_OnKeyPress()
        
            If Len(TxtFromDte.value) > 1 then
                Call fnMakeDate(TxtFromDte)        '날짜형식으로 입력가능하게 한다 / 공통함수 / Common.vbs 참조
            End If
            
        End Sub
        
        Sub BtnToDte_OnClick()
            Call fnOpenCalWithCtrl(TxtToDte, "TxtToDte")
            Call TxtToDte_OnKeyUp()
        End Sub
        
        Sub TxtToDte_OnKeyUp()
    
            ' ←↑→↓ Del BackSpace  통과
            If window.event.keyCode = LEFTKEY Or window.event.keyCode = UPKEY Or window.event.keyCode = RIGHTKEY Or window.event.keyCode = DOWNKEY Or window.event.keyCode = DELKEY Or window.event.keyCode = BACKSPACEKEY  Then : Exit Sub
            
            If Len(TxtToDte.value) > 1 then
                Call fnMakeDate(TxtToDte)
                if  TxtToDte.value > gsToday  then
                     TxtToDte.value = gsToday 
                end if
            End If
            
        End Sub
        
        Sub TxtToDte_OnKeyPress()
        
            If Len(TxtToDte.value) > 1 then
                Call fnMakeDate(TxtToDte)        '날짜형식으로 입력가능하게 한다 / 공통함수 / Common.vbs 참조
                if  TxtToDte.value > gsToday then
                     TxtToDte.value = gsToday 
                end if
            End If    
            
        End Sub
        
   
                
         '==========================================================================================
         ' Function  명     : BtnClear_OnClick()
         ' 내        용     : 진료일정 등록 탭 초기화 버튼 클릭시 이벤트 발생
         ' 작   성   자     : DF 문 지 훈
         ' 최초  작성일     : 2009.06.03
         ' Input Parameter  : 
         ' Return Value     :
         ' 수 정  내 역     :
         '==========================================================================================
         Sub BtnClear_OnClick()

            Spread.MaxRows = 0

            Call fnDisableControls(Array(BtnATalk,BtnApproval,BtnCancle )) 

            TxtFromDte.value = gsToday 
            TxtToDte.value   = gsToday 

            Call fnEnableControls(Array(ChkAprvY,ChkAprvN ,ChkAprvX))

            ChkAprvY.checked = false
            ChkAprvN.checked = false
            ChkAprvX.checked = false


         End Sub

        '==========================================================================================
        ' Function  명     : BtnE_Excel_OnClick
        ' 내        용     : 엑셀버튼 클릭 이벤트
        ' 작   성   자     : 김승기
        ' 최초  작성일     : 2007. 05. 18
        ' Input Parameter  : 
        ' Return Value     :
        ' 수 정  내 역     :
        '==========================================================================================
        Sub BtnExcel_OnClick()
            arrCellFormat = Array( "", "", "", "", "", "", "", "",_
                                  "", "", "", "",_
                                  "", xlNFormatGeneral, "", "", "", "", "")
            Call fnMakeArrayForExcel(Spread, "", "", True)
        End Sub
    '==========================================================================================
    ' Function  명     : ChkAprvY_OnClick()
    ' 내        용     : 승인상태 승인 클릭시 
    ' 작   성   자     : 김선화
    ' 최초  작성일     : 2022.01.05
    ' Input Parameter  : 
    ' Return Value     :
    ' 수 정  내 역     :
    '==========================================================================================
    Sub ChkAprvY_OnClick()
 
        if ChkAprvY.checked  = true then

            Call fnDisableControls(Array(ChkAprvN,ChkAprvX )) 
            ChkAprvN.checked = false
            ChkAprvX.checked = false  
        else
            Call fnEnableControls(Array(ChkAprvY,ChkAprvN ,ChkAprvX))
        end if
            
    end sub

    '==========================================================================================
    ' Function  명     : ChkAprvN_OnClick()
    ' 내        용     : 취소상태 승인 클릭시 
    ' 작   성   자     : 김선화
    ' 최초  작성일     : 2022.01.05
    ' Input Parameter  : 
    ' Return Value     :
    ' 수 정  내 역     :
    '==========================================================================================
    Sub ChkAprvN_OnClick()
 
        if ChkAprvN.checked  = true then

            Call fnDisableControls(Array(ChkAprvY,ChkAprvX )) 
            ChkAprvY.checked = false
            ChkAprvX.checked = false  
        else
            Call fnEnableControls(Array(ChkAprvY,ChkAprvN ,ChkAprvX))
        end if
            
    end sub

   '==========================================================================================
    ' Function  명     : ChkAprvX_OnClick()
    ' 내        용     : 미승인상태 승인 클릭시 
    ' 작   성   자     : 김선화
    ' 최초  작성일     : 2022.01.05
    ' Input Parameter  : 
    ' Return Value     :
    ' 수 정  내 역     :
    '==========================================================================================
    Sub ChkAprvX_OnClick()
 
        if ChkAprvX.checked  = true then

            Call fnDisableControls(Array(ChkAprvY,ChkAprvN )) 
            ChkAprvY.checked = false
            ChkAprvN.checked = false  
        else
            Call fnEnableControls(Array(ChkAprvY,ChkAprvN ,ChkAprvX))
        end if
            
    end sub

        </script>
    </head>

<body style="margin:0">
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
	<tr>
		<td>		
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="text01_b">
						<img src="../../../IMAGES/COMMON/IMAGES/img_01.gif" class="right_n">모바일 하이패스 승인
					</td>
				</tr>
				<tr>
					<td class="text01_s"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1"></td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td class="text02">
						<img src="../../../IMAGES/COMMON/IMAGES/img_02.gif" class="right_n">신청일자
						<input type="text" style="width:70px" class="t_left" id="TxtFromDte" maxlength="10">
						<img src="../../../IMAGES/COMMON/BTN/btn_com_05.gif" class="none" id="BtnFromDte" alt="수납일"> ~
						<input type="text" style="width:70px" class="t_left" id="TxtToDte"     maxlength="10">
						<img src="../../../IMAGES/COMMON/BTN/btn_com_05.gif" class="none" id="BtnToDte"   alt="수납일">
					</td>
					<td class="text02">
					    <img src="../../../IMAGES/COMMON/IMAGES/img_02.gif" class="right_n">승인상태
						    <input type="checkbox" class="f_c" id="ChkAprvY">승인 
						    <input type="checkbox" class="f_c" id="ChkAprvN">취소
                            <input type="checkbox" class="f_c" id="ChkAprvX">미승인 
					</td>
					<td class="text02_r">
						<img src="../../../IMAGES/COMMON/BTN/btn_com_03.gif" class="right" id="BtnR_Search" alt="조회">
					</td>

				</tr>
			</table>
		</td>
	</tr>
	<tr>
        <td class="ss" style="padding: 0px; height: 100%;" id="SpreadTd">
            <script language="vbscript" type="text/vbscript">
			Call PrintObject("SPREAD", "Spread", "WIDTH: 100%; COLOR: #666666; FONT-FAMILY: 굴림; HEIGHT:100%;", "")
            </script>
        </td>
    </tr>
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0">  
				<tr>

					<td class="bg05_r">
                        <img src="../../../IMAGES/ACC/BTN/btn_CreateHipssMobileAprv_01.gif" class="none" id="BtnApproval"   alt="모바일 하이패스 승인">
                        <img src="../../../IMAGES/ACC/BTN/btn_CreateHipssMobileAprv_02.gif" class="none" id="BtnCancle"   alt="모바일 하이패스 취소">
                        <img src="../../../IMAGES/ACC/BTN/btn_Atalk.gif" class="right" id="BtnATalk" alt="알림톡">
                        <img src="../../../IMAGES/COMMON/BTN/btn_com_10.gif" class="none" id="BtnExcel" alt="엑셀">
						<img src="../../../IMAGES/COMMON/BTN/btn_com_15.gif" class="none" id="BtnClear" alt="클리어">
						<img src="../../../IMAGES/COMMON/BTN/btn_com_04.gif" class="right" id="Btn_Close" alt="종료">
					</td>
					
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
</html>